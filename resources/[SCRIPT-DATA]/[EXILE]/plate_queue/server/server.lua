Points = {}

local players = {}
local waiting = {}
local charset = {}
local tempIdentity = {}
local connecting = {}
local prePoints = Config.Points;
local pCards = {}
local buttonCreate = {}
local playerCount = 0
local list = {}

local KolejkaStatus = true
local Ubwebhok = ''
local card_register_status = {}
local card_captcha_status = {}
local card_getbilet_status = {}
local captacha = {}
local card_captcha_registered = {}
local card_captcha_mathed = {}
local card_captcha_present_end = {}

for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end


function string.random(length)
  math.randomseed(os.time())

  if length > 0 then
    return string.random(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local IdentifierTables = {
    {table = "users", column = "identifier"},
    {table = "user_licenses", column = "owner"},
    {table = "characters", column = "identifier"},
    {table = "billing", column = "identifier"},
    {table = "rented_vehicles", column = "owner"},
    {table = "addon_account_data", column = "owner"},
    {table = "addon_inventory_items", column = "owner"},
    {table = "datastore_data", column = "owner"}, 
    {table = "owned_vehicles", column = "owner"}, 
    {table = "owned_properties", column = "owner"}, 
    {table = "phone_calls", column = "owner"}, 
    {table = "user_sim", column = "user"},
    {table = "user_sim", column = "identifier"},
}

function GetRocadePlayers()
	return #waiting 
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


AddEventHandler("playerConnecting", function(name, reject, def)
	local source	= source
	local steamID = GetSteamID(source)
    local licenseID = GetLicenseID(source)

	local src = source
    local passAuth = false
    def.defer()
    def.update("Sprawdzanie biletu...")

	if not KolejkaStatus then
		reject('Aktualnie kasa biletowa jest zamknięta, prosimy pobrać bilet później...')
		CancelEvent()
		return
	end

	if not steamID then
		reject("Aby otrzymać bilet na serwer musisz mieć włączonego Steam")
		CancelEvent()
		return
	end

    if not licenseID then
        reject('Aby otrzymać bilet na serwer musisz mieć włączonego Rockstar Launcher')
        CancelEvent()
        return
    end

    if playerCount >= 200 then
        setReason('Serwer aktualnie jest pełny (200/200)')
        CancelEvent()
    end

	if not Rocade(steamID, licenseID, def, source) then
		CancelEvent()
	end
end)

function Rocade(steamID, licenseID, def, source)
	def.defer()
	Citizen.Wait(20)
	
	AntiSpam(def)


	Purge(steamID)

	AddPlayer(steamID, source)

	table.insert(waiting, steamID)

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

			if sid == p[1] and p[1] == steamID and (GetPlayerPing(p[3]) == 0) then

				Purge(steamID)
				def.done("Wykryto niespodziwany błąd - Połącz się jeszcze raz.")

				return false
			end
		end
	end

	def.update(GetMessage(steamID))

	Citizen.Wait(1 * 1000)

	until stop
	local player = source
	local LastCharId = GetLastCharacter(licenseID)
	SetIdentifierToChar(licenseID, LastCharId)
	local steamid = licenseID
	local id = string.gsub(steamid, "steam:", "")
	pCards[steamid] = {}
	MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` LIKE '%"..id.."%'", {
	}, function(result)
		MySQL.Async.fetchAll("SELECT * FROM `user_lastcharacter` WHERE `license` = @license",  {
			['@license'] = steamid
		}, function(result2)
			if result2[1] ~= nil then
				return
			else
				MySQLAsyncExecute("INSERT INTO `user_lastcharacter` (`license`, `charid`, `limit`) VALUES ('"..GetPlayerIdentifiers(player)[1].."', 1, 1)")
			end
		end)
		if (result[1] ~= nil) then
			if #result[1] < 2 then
				MySQL.Async.execute('UPDATE `user_lastcharacter` SET `charid`= 1 WHERE `license` = @license',
				{
					['@license'] = licenseID
				})
			end
			local Characters = GetPlayerCharacters(licenseID)
			pCards[steamid] = {
				["type"] = "AdaptiveCard",
				["minHeight"] = "auto",
				["body"] = {
					{
						["type"] = "ColumnSet",
						["columns"] = {
							{
								["type"] = "Column",
								["items"] = {
									{
											["type"] = "TextBlock",
											["text"] = "Wybierz Obywatela",
											["size"] = "large",
											["horizontalAlignment"] = "left"
									},
									{
											["type"] = "Input.ChoiceSet",
											["choices"] = {},
											["style"] = "expanded",
											["id"] = "char_id",
											["value"] = "char1"
									}
								}
							},
						{
								["type"] = "Column",
								["items"] = {
									{
										["type"] = "TextBlock",
										["isMultiSelect"] = false,
										["text"] = "Wybierz Miejsce",
										["isVisible"] = true,                                        
										["id"] = "input4",
										["size"] = "large",
										["horizontalAlignment"] = "left",
									},
									{
										["type"] = "Input.ChoiceSet",
										["choices"] = {
												{
														["title"] = "Ostatnia lokalizacja",
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
			local limit = MySQLAsyncExecute("SELECT * FROM `user_lastcharacter` WHERE `license` = '"..GetPlayerIdentifiers(player)[1].."'")
			if limit[1].limit > 1 then
				if #result < 2 then
					buttonCreate = {
						{
							["type"] = "Action.Submit",
							["title"] = "Pobierz Bilet (AUTO WYBÓR 15S.)"
						},
						{
							["type"] = "Action.Submit",
							["title"] = "Wolny Slot (Stwórz postać)",
							["data"] = {
								["x"] = "setupChar"
							}
						},
					}
				else
					buttonCreate = {
						{
							["type"] = "Action.Submit",
							["title"] = "Pobierz Bilet (AUTO WYBÓR 15S.)"
						},
					}
				end
			else 
				buttonCreate = {
					{
							["type"] = "Action.Submit",
							["title"] = "Pobierz Bilet (AUTO WYBÓR 15S.)"
					},
				}
			end

			for k,v in ipairs(Characters) do
				card_getbilet_status[steamid] = true
				if result[k].firstname ~= '' then
					local data = {
							["title"] = result[k].firstname .. ' ' .. result[k].lastname,
							["value"] = "char"..k,
					}
					pCards[steamid].body[1].columns[1].items[2].choices[k] = data
				else
					local data = {
						["title"] = 'Wolny slot',
						["value"] = "char"..k,
					}
					pCards[steamid].body[1].columns[1].items[2].choices[k] = data
				end
			end
			pCards[steamid].actions = buttonCreate

			def.presentCard(pCards[steamid], function(submittedData, rawData)
				if submittedData.x ~= nil then
					def.presentCard(cardRegister, function(s, r)
						if s.x ~= nil then

							MySQL.Async.execute('INSERT INTO users (`identifier`, `accounts`, `group`, `hiddenjob`, `hiddenjob_grade`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`) VALUES (@identifier, @accounts, @group, @hiddenjob, @hiddenjob_grade, @firstname, @lastname, @dob, @sex, @height)', {
								['@identifier']  = string.gsub(steamid, "steam:", "Char2"),
								['@accounts'] = '{"bank":20000,"black_money":0,"money":5000}',
								['@group'] = 'user',
								['@hiddenjob'] = 'unemployed',
								['@hiddenjob_grade'] = 0,
								['@firstname'] = s.firstname,
								['@lastname'] = s.lastname,
								['@dob'] = s.dateofbirth,
								['@sex'] = s.sex,
								['@height'] = tonumber(s.height)
							})

							TriggerEvent("user_characters:chosen", player, '2')
							pCards[steamid] = 0
							SetIdentity(submittedData.spawnPoint, player)
							def.done()
						else
							def.done("Wystąpił błąd... Spróbuj jeszcze raz!")
						end
					end)
				else
					local char_id = submittedData.char_id
					local char = string.gsub(char_id, "char", "")
					TriggerEvent("user_characters:chosen", player, char)
					pCards[steamid] = 0
					SetIdentity(submittedData.spawnPoint, player)
					def.done()
				end
			end)
		else
			def.presentCard(cardRegister, function(s, r)
				if s.x ~= nil then
					local formattedFirstName = formatName(s.firstname)
					local formattedLastName = formatName(s.lastname)
					local formattedHeight = tonumber(s.height)
					tempIdentity[steamID] = {
							firstName   = formattedFirstName,
							lastName    = formattedLastName,
							dateOfBirth = s.dateofbirth,
							sex         = s.sex,
							height      = formattedHeight,
							registered  = false
					}
					card_register_status[steamid] = true
					RegisterIdentity(source, tempIdentity[steamID])
					def.done()
					charChoosen = true
				else
					def.done("Wystąpił błąd... Spróbuj jeszczer raz!")
				end
			end)
		end
		if card_getbilet_status[steamid] and not card_register_status[steamid] and not card_captcha_status[steamID] then
			Wait(14000)
			card_getbilet_status[steamid] = nil 
			card_captcha_mathed[steamID] = nil
			TriggerEvent("user_characters:chosen", player, '1')
			def.done()
		end
		if card_captcha_status[steamID] then
			Wait(10000)
			card_captcha_mathed[steamID] = nil
			card_captcha_status[steamID] = nil
			def.done("Twój czas na weryfikację minął - Spróbuj ponownie jeszcze raz!")
		end
	end)

	return true
end

formatName = function(name)
	local loweredName = convertToLowerCase(name)
	local formattedName = convertFirstLetterToUpper(loweredName)
	return formattedName
end

convertToLowerCase = function(str)
	return string.lower(str)
end

convertFirstLetterToUpper = function(str)
	return str:gsub("^%l", string.upper)
end

RegisterIdentity = function(source, data)
	local identifiers = GetPlayerIdentifiers(source)
	local charid = 1
	local license = nil
	for k, v in pairs(identifiers) do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			license = v
			break
		end
	end
	MySQL.Async.execute('INSERT INTO users (`identifier`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`) VALUES (@identifier, @firstname, @lastname, @dob, @sex, @height)', {
		['@identifier']  = license,
		['@firstname'] = data.firstName,
		['@lastname'] = data.lastName,
		['@dob'] = data.dateOfBirth,
		['@sex'] = data.sex,
		['@height'] = data.height
	})
end

function GetRockstarID(src)
    local sid = GetPlayerIdentifiers(src)
	local license = nil
	for k,v in ipairs(sid) do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			license = v
			break
		end
	end

	return license
end

function SetIdentity(source, spawn)
    local source = source
    local pName = GetPlayerName(source)
    local position = '{"x":-1045.5000,"y":-2750.5000,"z":20.2000}'
    local licenseIDs = GetIdentifierWithoutSteam(GetLicenseID(source))
    if spawn == "airport" then
        MySQL.Async.execute("UPDATE `users` SET `position` = '"..position.."' WHERE `identifier` LIKE '%"..licenseIDs.."%'")
    end
end
CreateThread(function()
	local maxServerSlots = GetConvarInt('sv_maxclients', 200)
	
	while true do
		Citizen.Wait(3 * 1000)

		CheckConnecting()

        if #waiting > 0 and #connecting + #ESX.GetPlayers() < maxServerSlots then
			ConnectFirst()
		end
	end
end)

RegisterServerEvent('hardcap:playerActivated')
AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

CreateThread(function()
	while true do
		Citizen.Wait(5000)
		SetHttpHandler(function(req, res)
			local path = req.path
			if req.path == '/count' then
				res.send(json.encode({
					count = #waiting
				}))
				return
			end
		end)
	end
end)

CreateThread(function()
	while true do
		UpdatePoints()
		Citizen.Wait(2 * 1000)
	end
end)

RegisterServerEvent("rocademption:playerKicked")
AddEventHandler("rocademption:playerKicked", function(src, points)
	local sid = GetSteamID(src)
	Purge(sid)
	for i,p in ipairs(prePoints) do
		if p[1] == sid then
			p[2] = p[2] - points
			return
		end
	end

	local initialPoints = GetInitialPoints(sid)
	table.insert(prePoints, {sid, initialPoints - points})
end)

RegisterServerEvent("exile_queue:playerConnected")
AddEventHandler("exile_queue:playerConnected", function()
    local _source = source
	local sid = GetSteamID(_source)
	Purge(sid)
end)

AddEventHandler("playerDropped", function(reason)
	local steamID = GetSteamID(source)
	Purge(steamID)
	if list[source] then
		playerCount = playerCount - 1
		list[source] = nil
	end
end)

function CheckConnecting()
	for i,sid in ipairs(connecting) do
		for j,p in ipairs(players) do
			if p[1] == sid and (GetPlayerPing(p[3]) == 500) then
				table.remove(connecting, i)
				break
			end
		end
	end
end

function ConnectFirst()
	if #waiting == 0 then return end

	local maxPoint = 0
	local maxSid = waiting[1][1]
	local maxWaitId = 1

	for i,sid in ipairs(waiting) do
		local points = GetPoints(sid)
		if points > maxPoint then
			maxPoint = points
			maxSid = sid
			maxWaitId = i
		end
	end
	
	table.remove(waiting, maxWaitId)
	table.insert(connecting, maxSid)
end

function GetPoints(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			return p[2]
		end
	end
end

function UpdatePoints()
	for i,p in ipairs(players) do

		local found = false

		for j,sid in ipairs(waiting) do
			if p[1] == sid then
				p[2] = p[2] + Config.AddPoints
				found = true
				break
			end
		end

		if not found then
			for j,sid in ipairs(connecting) do
				if p[1] == sid then
					found = true
					break
				end
			end
		
			if not found then
				p[2] = p[2] - Config.RemovePoints
				if p[2] < GetInitialPoints(p[1]) - Config.RemovePoints then
					Purge(p[1])
					table.remove(players, i)
				end
			end
		end

	end
end

function AddPlayer(steamID, source)
	for i,p in ipairs(players) do
		if steamID == p[1] then
			players[i] = {p[1], p[2], source}
			return
		end
	end

	local initialPoints = GetInitialPoints(steamID)
	
	table.insert(players, {steamID, initialPoints, source})
end

function GetInitialPoints(steamID)
	local points = Config.RemovePoints + 1

	for n,p in ipairs(prePoints) do
		if p[1] == steamID then
			points = p[2]
			break
		end
	end

	return points
end

function GetPlace(steamID)
	local points = GetPoints(steamID)
	local place = 1

	for i,sid in ipairs(waiting) do
		for j,p in ipairs(players) do
			if p[1] == sid and p[2] > points then
				place = place + 1
			end
		end
	end
	
	return place
end

function GetMessage(steamID)
	local msg = ""
	local bilet = "Rodzaj Biletu: "
	if GetPoints(steamID) ~= nil then
		if GetPoints(steamID) == 200 then
			bilet = bilet.."Srebrny Bilet"
		elseif GetPoints(steamID) == 400 then
			bilet = bilet.."Złoty Bilet"
		elseif GetPoints(steamID) == 600 then
			bilet = bilet.."Diamentowy Bilet"
		elseif GetPoints(steamID) == 800 then
			bilet = bilet.."Platynowy Bilet"
		elseif GetPoints(steamID) == 1000 then
			bilet = bilet.."Partnerski"
		elseif GetPoints(steamID) == 1500 then
			bilet = bilet.."Administracyjny"
		elseif GetPoints(steamID) > 2000 then
			bilet = bilet.."Owner"
		else
			bilet = bilet.."Standardowy"
		end

		msg = "\n\xE2\x8F\xB3 Jesteś " .. GetPlace(steamID) .. "/".. #waiting .. "  w kolejce.\n\xF0\x9F\x90\x8C "..bilet
        if #waiting == 0 then
            msg = "\n\xE2\x8F\xB3 Jesteś pierwszy  w kolejce.\n\xF0\x9F\x90\x8C "..bilet
        end
	else
		msg = "Wystąpił problem z załadowaniem twojej postaci lub z kolejką. Zrestartuj RockStar Launcher, Steam, Fivem i spróbuj ponownie."
	end

	return msg
end

function Purge(steamID)
	for n,sid in ipairs(connecting) do
		if sid == steamID then
			table.remove(connecting, n)
		end
	end

	for n,sid in ipairs(waiting) do
		if sid == steamID then
			table.remove(waiting, n)
		end
	end
end

function AntiSpam(def)
	for i=5,0,-1 do
		def.update("Trwa weryfikacja, proszę czekać: "..i.." sekund.")
		Citizen.Wait(1000)
	end
end

function GetSteamID(src)
    local sid
	for k,v in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(v, 'steam') then
            sid = v
            break
        end
    end

	return sid
end

RegisterServerEvent("user_characters:chosen")
AddEventHandler("user_characters:chosen", function(source, charid)
    local _source = source
    local licka = GetLicenseID(_source)
    SetLastCharacter(licka, charid)
    SetCharToIdentifier(licka, tonumber(charid))
end)

function GetPlayerCharacters(identifierr)
  local identifier = GetIdentifierWithoutSteam(identifierr)
  local Chars = MySQLAsyncExecute("SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."%'")
  return Chars
end

function GetLastCharacter(identifier)
    local licka = identifier
    local LastChar = MySQLAsyncExecute("SELECT `charid` FROM `user_lastcharacter` WHERE `license` = '"..licka.."'")
    if LastChar[1] ~= nil and LastChar[1].charid ~= nil then
        return tonumber(LastChar[1].charid)
    else
        MySQLAsyncExecute("INSERT INTO `user_lastcharacter` (`license`, `charid`, `limit`) VALUES('"..licka.."', 1, 1)")
        return 1
    end
end

function SetLastCharacter(licka, charid)
    MySQLAsyncExecute("UPDATE `user_lastcharacter` SET `charid` = '"..charid.."' WHERE `license` = '"..licka.."'")
end

function SetIdentifierToChar(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."' WHERE `"..itable.column.."` = '"..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function SetCharToIdentifier(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = '"..GetIdentifierWithoutSteam(identifier).."' WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function DeleteCharacter(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("DELETE FROM `"..itable.table.."` WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function GetIdentifierWithoutSteam(Identifier)
    return string.gsub(Identifier, "steam:", "")
end

function MySQLAsyncExecute(query)
    local IsBusy = true
    local result = nil
    MySQL.Async.fetchAll(query, {}, function(data)
        result = data
        IsBusy = false
    end)
    while IsBusy do
        Citizen.Wait(1)
    end
    return result
end

function CheckUser(identifier)
    local Chars = MySQLAsyncExecute("SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."%'")
    for i = 1, #Chars, 1 do
        print(Chars[i].identifier)
    end
end

function DeleteHex(identifier)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("DELETE FROM `"..itable.table.."` WHERE `"..itable.column.."` LIKE '%"..identifier.."%'")
    end
end

function UpdateChars(license, limit)
    MySQL.Async.fetchAll('SELECT * FROM `user_lastcharacter` WHERE `license` = @license',
    {
        ['@license'] = license,
    }, function(result)
        if result[1] ~= nil then
            MySQL.Async.fetchAll('UPDATE `user_lastcharacter` SET `limit`= @limit WHERE `license`= @license',
            {
                ['@license'] = license,
                ['@limit'] = limit
            }, function(result2)
                print('Ustawiono liimt postaci na: ' .. limit)
            end)
        else
            print("Osoba o podanej licencji nie posiada utworzonej postaci!")
        end
    end)
end

RegisterCommand("deletechar", function(source, args, rawCommand)
    if (source > 0) then
        return
    else
        if args[1] ~= nil then
            if args[2] ~= nil then
                DeleteCharacter(args[1], args[2])
            end
        end
    end
end)

RegisterCommand("deletesteam", function(source, args, rawCommand)
    if (source > 0) then
        return
    else
        if args[1] ~= nil then
            if string.find(args[1], "steam:") or string.find(args[1], ":") then
                DeleteHex(args[1])
            else
                print('Wpisz hex podajac steam:')
            end
        end
    end
end)

RegisterCommand("checkuser", function(source, args, rawCommand)
    if (source > 0) then
        return
    else
        if args[1] ~= nil then
            if string.find(args[1], "steam:") or string.find(args[1], ":") then
                print('Wprowadź licencję gracza nie używając przedrostka steam:')
            else
                CheckUser(args[1])
            end
        end
    end
end)

-- RegisterCommand("setlimit", function(source, args, rawCommand)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local canUse = false
--     if xPlayer then
--         if xPlayer.group == 'superadmin' or xPlayer.group == 'admin' then
--             canUse = true
--             xPlayer.showNotification('~o~[PlayerManager] ~w~Zmieniono limit na ~o~'..args[2]..'~w~ dla ~o~'..args[1])
--         end
--     elseif source > 0 then
--         canUse = true
--     end
--     if canUse then
--         if args[1] ~= nil then
--             if tonumber(args[2]) ~= nil and tonumber(args[2]) == 3 or tonumber(args[2]) == 2 or tonumber(args[2]) == 1 then
--                 UpdateChars(args[1], args[2])
--             else
--                 print('Maksyamlna ilosc postaci to 3!')
--             end
--         end
--     else
--         return
--     end
-- end)

GetLicenseID = function(src)
    local sid = GetPlayerIdentifiers(src)
    local license = 'Brak'
    for k,v in ipairs(sid)do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            license = v
            break
        end
    end

    return license
end