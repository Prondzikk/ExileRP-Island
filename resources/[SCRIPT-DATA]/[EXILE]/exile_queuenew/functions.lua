Config = {}
Config.AntiSpamTimer = 5
Config.TimerCheckPlaces = 3
Config.TimerRefreshClient = 3

Config.Points = {}

Config.NoSteam = "Nie wykryto Steam. Wyłącz FiveM oraz zresetuj/włącz Steam."
Config.Next = "Jesteś następny w kolejce!"
Config.Waiting = "W kolejce jest "
Config.Waiting2 = " graczy. Poczekaj na swoją kolej.\n"
Config.EmojiMsg = "Jeżeli emotki się zatrzymają, zrestartuj FiveM : "
Config.PleaseWait_1 = "Poczekaj jeszcze "
Config.PleaseWait_2 = " sekund. Weryfikujemy dane Twojego konta..."
Config.Accident = "Wykryto błąd połączenia."
Config.Error = "ERROR : Skontaktuj się z administratorem serwera."


Config.EmojiList = {
	'🐌', 
	'🐍',
	'🐎', 
	'🐑', 
	'🐒',
	'🐘', 
	'🐙', 
	'🐛',
	'🐜',
	'🐝',
	'🐞',
	'🐟',
	'🐠',
	'🐡',
	'🐢',
	'🐤',
	'🐦',
	'🐧',
	'🐩',
	'🐫',
	'🐬',
	'🐲',
	'🐳',
	'🐴',
	'🐅',
	'🐈',
	'🐉',
	'🐋',
	'🐀',
	'🐇',
	'🐏',
	'🐐',
	'🐓',
	'🐕',
	'🐖',
	'🐪',
	'🐆',
	'🐄',
	'🐃',
	'🐂',
	'🐁',
	'🔥'
}

local tempIdentity = {}
local pCards = {}
local totalChar = {}
local charLists = {}
local isMultiChar = {}
local isRestarting = false

function TurnRestart(state)
	isRestarting = state
end

local cardRegister = {
	["type"] = "AdaptiveCard",
	["body"] = {
		{
			["type"] = "TextBlock",
			["text"] = "> Stworz postac",
			["weight"] = "bolder",
			["size"] = "large",
			["horizontalAlignment"] = "center"
		},
		{
			["type"] = "ColumnSet",
			["columns"] = {
				{
					["type"] = "Column",
					["items"] = {
						{
							["type"] = "Input.Text",
							["placeholder"] = "Imie postaci (max. 15 znakow)",
							["id"] = "firstname"
						},
						{
							["type"] = "Input.Text",
							["placeholder"] = "Nazwisko postaci (max. 15 znakow)",
							["id"] = "lastname"
						},
						{
							["type"] = "Input.Text",
							["placeholder"] = "Wzrost (np. 190)",
							["id"] = "height"
						},
						{
							["type"] = "Input.Date",
							["id"] = "dateofbirth",
							["value"] = "dd/mm/rrrr"
						},
						{
							["type"] = "Input.ChoiceSet",
							["id"] = "sex",
							["style"] = "expanded",
							["isMultiSelect"] = "false",
							["value"] = "m",
							["choices"] = {
									{
											["title"] = "Mezczyzna",
											["value"] = "m"
									},
									{
											["title"] = "Kobieta",
											["value"] = "f"
									}
							}
						}
					},
					["width"] = "stretch"
				}
			}
		}
	},
	["actions"] = {
			{
					["title"] = "Stworz postać",
					["type"] = "Action.Submit",
					["data"] = {
							["x"] = "setupChar"
					}
			}
	},
	["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
	["version"] = "1.0"
}

Rocade = function(steamID, def, source)
	if isRestarting then
		def.done("Trwa zaćmienie. Poczekaj na bilet")
	end
	def.defer()
	print(def)

	AntiSpam(def)
	Purge(steamID)
		
	local findChars = ChooseCharacter(steamID, source, def)
	local autoconnect = 0
	local charChoosen = false

	while findChars == nil do
		Citizen.Wait(1000)
	end
	
	if findChars == "BRAK POSTACI" then
		charChoosen = true
	else
		def.presentCard(findChars, function(submittedData, rawData)
			if submittedData.char_id ~= nil then
				SetIdentity(source, submittedData.char_id, submittedData.spawnPoint)
			end
			pCards[steamID] = 0
			charChoosen = true
		end)
	end
	
	while charChoosen == false do
		Citizen.Wait(1000)
		
		autoconnect = autoconnect + 1
		
		if autoconnect > 15 then
			if charLists[steamID][1] ~= nil then
				SetIdentity(source, charLists[steamID][1], 'lastPosition')
			end
			pCards[steamID] = 0
			charChoosen = true
		end
	end
	
	AddPlayer(steamID, source)
	local initialPoints = GetInitialPoints(steamID, source)
	table.insert(waiting, {steamID, initialPoints})
	CheckDisconnected(steamID)
	CheckWasFirst(steamID)
	local stop = false
	repeat
		for i,p in ipairs(connecting) do
			if p == steamID then
				stop = true
				break
			end
		end

		for j,sid in ipairs(waiting) do
			for i,p in ipairs(players) do
				if sid[1] == p[1] and p[1] == steamID and (GetPlayerPing(p[3]) == 0) then
					if nextPlayer == steamID then
						table.insert(firstDisconnected, {steamID, (os.time() + 75)})
					end
					Purge(steamID)
					def.done(Config.Accident)

					return false
				end
			end
		end
		
		def.update(GetMessage(steamID))
		tick = tick + 1
		if tick == 4 then tick = 1 end

		Citizen.Wait(Config.TimerRefreshClient * 1000)

	until stop
	
	def.done()
	return true
end

CheckConnecting = function()
	for i,sid in ipairs(connecting) do
		for j,p in ipairs(players) do
			if p[1] == sid and (GetPlayerPing(p[3]) == 500) then
				table.remove(connecting, i)
				break
			end
		end
	end
end

FindNext = function()
	allTickets = {}
	if #waiting == 0 then return end
	if nextPlayer ~= nil then return end
	
	local wholeTickets = 0
	for k,v in pairs(waiting) do
		for j=1, v[2], 1 do
			wholeTickets = wholeTickets + 1
			table.insert(allTickets, {number = wholeTickets, steam = v[1]})
		end
	end
	
	local id = 1
	local randUser = math.random(1, #allTickets)
	local selectedUser = allTickets[randUser].steam
	nextPlayer = selectedUser
end

CheckWasFirst = function(steamID)
	for k,v in pairs(firstDisconnected) do
		if v[1] == steamID then
			table.remove(firstDisconnected, k)
			break
		end
	end
end

CheckDisconnected = function(steamID)
	local found = false
	for k,v in pairs(disconnected) do
		if v[1] == steamID then
			found = true
			break
		end
	end
	if found == true then
		ConnectNow(steamID)
	end
end

ConnectNow = function(steamID)
	for k, v in pairs(waiting) do
		if v[1] == steamID then
			table.remove(waiting, k)
			break
		end
	end
	table.insert(connecting, steamID)
	Citizen.Wait(2000)
	for k,v in pairs(disconnected) do
		if steamID == v[1] then
			table.remove(disconnected, k)
			break
		end
	end
end

ConnectFirst = function()
	if #waiting == 0 then return end
	if nextPlayer == nil then
		FindNext()
	end
	while nextPlayer == nil do
		Citizen.Wait(50)
	end
	
	local steamID = nextPlayer
	nextPlayer = nil
	for k,v in pairs(waiting) do
		if steamID == v[1] then
			table.remove(waiting, k)
			break
		end
	end
	table.insert(connecting, steamID)
end

GetPoints = function(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			return p[2]
		end
	end
end

GetTotalPoints = function()
	local collectedpoints = 0
	for i,p in ipairs(players) do
		collectedpoints = collectedpoints + p[2]
	end
	
	return collectedpoints
end

GetPlayerPriority = function(steamID)
	local found = 1

	return found
end
format = function(str)
    return (str:gsub("^%l", string.upper))
end
AddPlayer = function(steamID, source)
	for i,p in ipairs(players) do
		if steamID == p[1] then
			players[i] = {p[1], p[2], source}
			return
		end
	end

	local initialPoints = GetInitialPoints(steamID, source)
	table.insert(players, {steamID, initialPoints, source})
end

GetPlayerBackTicket = function(steamID)
	local found = 0

	return found
end

GetInitialPoints = function(steamID, source)
	local points = GetPlayerPriority(steamID)
	
	return points
end


function math.percent(percent, maxvalue)	
	
    if tonumber(percent) and tonumber(maxvalue) then
		return (percent / maxvalue) * 100
    end
    return false
end

function GetRocadePlayers()
	return #waiting
end

RegisterCommand('stats-queue', function(source, args, raw)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.group == 'zarzad' then
		if waiting then
			print(#waiting)
		else
			print('0')
		end
	end
end)

GetMessage = function(steamID)
	local msg = ""

	if GetPoints(steamID) ~= nil then
		
		if nextPlayer ~= nil and nextPlayer == steamID then
			msg = Config.Next .. "\n[ " .. Config.EmojiMsg
		else 
			if #waiting == 0 then
				msg = 'W kolejce jest 1 gracz. Poczekaj na swoją kolej.\n' .. '[Jeżeli emotki się zatrzymają, zrestartuj FiveM :'
			else
				msg = 'W kolejce jest ' .. #waiting .. ' graczy. Poczekaj na swoją kolej.\n' .. '[Jeżeli emotki się zatrzymają, zrestartuj FiveM :'
			end
		end
		local e1 = RandomEmojiList()
		local e2 = RandomEmojiList()
		local e3 = RandomEmojiList()
		local emojis = e1 .. e2 .. e3

		msg = msg .. emojis .. " ]"
	else
		msg = Config.Error
	end

	return msg
end

Purge = function(steamID)
	for n,sid in ipairs(connecting) do
		if sid == steamID then
			table.remove(connecting, n)
		end
	end

	for n,sid in ipairs(waiting) do
		if sid[1] == steamID then
			table.remove(waiting, n)
		end
	end
end

AntiSpam = function(def)
	for i=Config.AntiSpamTimer,0,-1 do
		def.update(Config.PleaseWait_1 .. i .. Config.PleaseWait_2)
		Citizen.Wait(1000)
	end
end

RandomEmojiList = function()
	randomEmoji = EmojiList[math.random(#EmojiList)]
	return randomEmoji
end

GetSteamID = function(src)
	local sid = GetPlayerIdentifiers(src)[1] or false

	if (sid == false or sid:sub(1,5) ~= "steam") then
		return false
	end

	return sid
end

				
SetIdentity = function(source, charid, spawnPoint)
	if charid ~= nil then
		local identifiers = GetPlayerIdentifiers(source)
		local license = nil
		for k, v in pairs(identifiers) do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
				license = v
				break
			end
		end
		
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = license
		}, function(data)
			if data[1] ~= nil then
				if data[1].charid == 'eloelo123' then
					MySQL.Async.execute('UPDATE `users` SET `charid` = @charid, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `status` = @status, `height` = @height, `skin` = @skin, `accounts` = @accounts, `inventory` = @inventory, `job` = @job, `job_grade` = @job_grade, `loadout` = @loadout, `isDead` = @isDead, `position` = @position, `last_property` = @last_property, `tattoos` = @tattoos, `kursy` = @kursy, `odznakakurwa` = @odznaka, `phone_number` = @phone_number, `animacje` = @animacje, `account_number` = @cardsnumber, `kawa` = @kawa AND charid = @charid', {
						['@identifier']					= license,
						['@charid']						= data[1].charid,
						['@firstname']					= data[1].firstname,
						['@lastname']					= data[1].lastname,
						['@dateofbirth']				= data[1].dateofbirth,
						['@sex']						= data[1].sex,
						['@status']						= data[1].status,
						['@height']						= data[1].height,
						['@accounts']					= data[1].accounts,
						['@skin']						= data[1].skin,
						['@inventory']					= data[1].inventory,
						['@job']						= data[1].job,
						['@job_grade']					= data[1].job_grade,
						['@loadout']					= data[1].loadout,
						['@isDead']						= data[1].isDead,
						['@tattoos']					= data[1].tattoos,
						['@odznaka']					= data[1].odznakakurwa,
						['@kursy']						= data[1].kursy,
						['@phone_number']				= data[1].phone_number,
						['@animacje']					= data[1].animacje,
						['@slot']						= data[1].slot,
				}, function(rowsChanged)
						if rowsChanged then

							MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier AND charid = @charid', {
								['@identifier'] = license,
								['@charid'] = charid
							}, function(data2)		
								if data2[1] ~= nil then
									MySQL.Async.execute('UPDATE users SET `charid` = @charid, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `status` = @status, `height` = @height, `skin` = @skin, `accounts` = @accounts, `inventory` = @inventory, `job` = @job, `job_grade` = @job_grade, `loadout` = @loadout, `isDead` = @isDead, `position` = @position, `last_property` = @last_property, `tattoos` = @tattoos, `kursy` = @kursy, `odznakakurwa` = @odznaka, `phone_number` = @phone_number, `animacje` = @animacje, `account_number` = @cardsnumber, `kawa` = @kawa, WHERE identifier = @identifier', {
										['@identifier']					= license,
										['@charid']						= data2[1].charid,
										['@firstname']					= data2[1].firstname,
										['@lastname']					= data2[1].lastname,
										['@dateofbirth']				= data2[1].dateofbirth,
										['@sex']						= data2[1].sex,
										['@status']						= data2[1].status,
										['@height']						= data2[1].height,
										['@skin']						= data2[1].skin,
										['@accounts']					= data2[1].accounts,
										['@inventory']					= data2[1].inventory,
										['@job']						= data2[1].job,
										['@job_grade']					= data2[1].job_grade,
										['@job_count']					= data2[1].job_count,
										['@loadout']					= data2[1].loadout,
										['@isDead']						= data2[1].isDead,
										['@position']					= spawnPoint == 'airport' and '{"z":21.36,"y":-2745.08,"x":-1042.26,"heading":11.11}' or data2[1].position,
										['@last_property']				= data2[1].last_property,

										['@tattoos']					= data2[1].tattoos,
								
										['@kursy']						= data2[1].kursy,
			
										['@odznaka']					= data2[1].odznakakurwa,
										['@phone_number']				= data2[1].phone_number,
										['@animacje']					= data2[1].animacje,
										['@cardsnumber']				= data2[1].cardsnumber,
	
										['@slot']						= data2[1].slot
									})
								end
							end)
						end
					end)
				else
					if spawnPoint == 'airport' then
						MySQL.Async.execute('UPDATE users SET position = @position WHERE identifier = @identifier', {
							['@identifier'] = license,
							['@position'] = '{"z":21.36,"y":-2745.08,"x":-1042.26,"heading":11.11}'
						})
					end			
				end
			end
		end)
	end
end

ChooseCharacter = function(steamID, source, def)
	local identifiers = GetPlayerIdentifiers(source)
	local license = nil
	for k,v in pairs(identifiers) do		
		if string.match(v, 'steam:') then
			license = v
			break
		end
	end
	
	MySQL.Async.fetchAll('SELECT charid, firstname, lastname FROM characters WHERE identifier = @identifier', {
		['@identifier'] = license
	}, function(result)
		if result[1] ~= nil then
			charLists[steamID] = {}
			totalChar[steamID] = 0
			pCards[steamID] = {
				["type"] = "AdaptiveCard",
				["minHeight"] = "185px",
				["body"] = {
						{
								["type"] = "Image",
								["url"] = image,
								["size"] = "medium",
								["horizontalAlignment"] = "center",
								["height"] = "80px"
						},
						{
								["type"] = "ColumnSet",
								["columns"] = {
										{
												["type"] = "Column",
												["items"] = {
													{
														["type"] = "TextBlock",
														["text"] = "Imię i nazwisko postaci",
														["size"] = "small",
														["horizontalAlignment"] = "left"
													},
													{
														["type"] = "Input.ChoiceSet",
														["choices"] = {},
														["style"] = "expanded",
														["id"] = "char_id",
														["value"] = result[1].charid
													}
												}
										},
										{
												["type"] = "Column",
												["items"] = {
													{
														["type"] = "TextBlock",
														["text"] = "Pozycja",
														["size"] = "small",
														["horizontalAlignment"] = "left"
													},
													{
														["type"] = "Input.ChoiceSet",
														["choices"] = {
																{
																		["title"] = "Ostatnia pozycja",
																		["value"] = "lastPosition"
																},
																{
																		["title"] = "Lotnisko",
																		["value"] = "airport"
																}
														},
														["style"] = "expanded",
														["id"] = "spawnPoint",
														["value"] = "lastPosition"
													}
												}
										}
								}
						}
				},
				["actions"] = {},
				["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
				["version"] = "1.0"
			}
			for k,v in ipairs(result) do
				charLists[steamID][k] = result[k].charid
				local data = {
					["title"] = result[k].firstname .. ' ' .. result[k].lastname,
					["value"] = "" .. result[k].charid .. ""
				}
				pCards[steamID].body[2].columns[1].items[2].choices[k] = data
				totalChar[steamID] = totalChar[steamID] + 1
			end
			
			local buttonCreate = {
				{
					["type"] = "Action.Submit",
					["title"] = "Pobierz bilet (Automatycznie po 15 sekundach)"
				}
			}
			pCards[steamID].actions = buttonCreate			

		else
			def.presentCard(cardRegister, function(s, r)
                if s.x == "setupChar" then
                    local formattedFirstName = format(s.firstname)
                    local formattedLastName = format(s.lastname)
                    local formattedHeight = tonumber(s.height)
                    tempIdentity[steamID] = {
                            firstName   = formattedFirstName,
                            lastName    = formattedLastName,
                            dateOfBirth = s.dateofbirth,
                            sex         = s.sex,
                            height      = formattedHeight,
                            registered  = false
                    }
					print(tempIdentity)
                    RegisterIdentity(source, tempIdentity[steamID])
					SetIdentity(source, '1', 'airport')
					pCards[steamID] = 0
					Rocade(GetPlayerIdentifiers(source)[1], def, source)
                    charChoosen = true
                end
		    end)
		end
	end)
	Citizen.Wait(500)
	
	return (pCards[steamID])
end



RegisterIdentity = function(source, data)
	local identifiers = GetPlayerIdentifiers(source)[1]
	local charid = 1
	local license = nil
	MySQL.Async.execute('INSERT INTO users (`identifier`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`) VALUES (@identifier, @firstname, @lastname, @dob, @sex, @height)', {
			['@identifier']  = identifiers,
			['@firstname'] = data.firstName,
			['@lastname'] = data.lastName,
			['@dob'] = data.dateOfBirth,
			['@sex'] = data.sex,
			['@height'] = data.height
			
	})
	MySQL.Async.execute('INSERT INTO characters (`identifier`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`) VALUES (@identifier, @firstname, @lastname, @dob, @sex, @height)', {
			['@identifier']  = identifiers,
			['@firstname'] = data.firstName,
			['@lastname'] = data.lastName,
			['@dob'] = data.dateOfBirth,
			['@sex'] = data.sex,
			['@height'] = data.height
	})
end