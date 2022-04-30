

ESX                       = nil
local job = {}

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

function getIdentity(source)
	local identifier = ESX.GetPlayerFromId(source).identifier
	local result = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			firstname = identity['firstname'],
			lastname = identity['lastname']
		}
	else
		return nil
	end
end

local gowno = {
	['best'] = {0, 0, 0},
	['superadmin'] = {255, 0, 0},
	['admin'] = {0, 191, 255},
	['modeartor'] = {132, 112, 255},
	['support'] = {255, 165, 0},
	['trialsupport'] = {255, 255, 0},
	['user'] = {128, 128, 128}
}



AddEventHandler('chatMessage', function(source, color, msg)
	cm = stringsplit(msg, " ")
	if msg ~= nil and cm ~= nil then
		if cm[1] == "/r" then
			local xPlayer = ESX.GetPlayerFromId(source)
			CancelEvent()
			if whisper[xPlayer.source] then
				local name = GetPlayerName(whisper[xPlayer.source])

				if name ~= nil then
					local textmsg = ""
					local names3 = GetPlayerName(source)
					for i=1, #cm do
						if i ~= 1 then
							textmsg = (textmsg .. " " .. tostring(cm[i]))
						end
					end
					TriggerClientEvent('chatMessage', xPlayer.source, "📥 ["..source.."] "..names3, gowno[xPlayer.group], textmsg)

				else
					TriggerClientEvent('chatMessage', source, "📥", {255, 102, 163}, "Nie ma takiego ID na serwerze")
				end
			else
				xPlayer.showNotification('~r~Nie posiadasz ostatnich wiadomości')
			end
		end

		if cm[1] == "/w" then
			local xPlayer = ESX.GetPlayerFromId(source)
			CancelEvent()
			if tablelength(cm) > 1 then
				local tPID = tonumber(cm[2])
				local names2 = GetPlayerName(tPID)
				local names3 = GetPlayerName(source)
				local textmsg = ""
				for i=1, #cm do
					if i ~= 1 and i ~=2 then
						textmsg = (textmsg .. " " .. tostring(cm[i]))
					end
				end

				local name = GetPlayerName(tPID)
				if name ~= nil then

					TriggerClientEvent('chat:addMessage1', source, "^*Wiadomość do ["..tPID.."] "..name, {121,230,39}, textmsg, "fas fa-envelope")
					TriggerClientEvent('chat:addMessage1', tPID, "^*Wiadomość od ["..source.."]: "..names3, {121,230,39}, textmsg, "fas fa-envelope")
			
				else
					TriggerClientEvent('chat:addMessage1', source, "^*Wiadomość", {255,0,0}, '^rNie wysłano, ponieważ gracz jest offline!', "fas fa-bell")
				end
			end
		end
	else
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("BŁĄD: ESX_EXILECHAT [404] NIE WYKRYTO MSG")
		print("")
		print("")
		print("")
		print("")
		print("")
		print("")
	end
end)




AddEventHandler('chatMessage', function(source, author, message)
	if string.sub(message, 1, string.len("/")) ~= "/" then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		TriggerClientEvent("sendProximityMessage", -1, xPlayer.name, _source, xPlayer.group, message)
	end
	CancelEvent()
end)


RegisterServerEvent('esx_rpchat:sendProximityMessageTaskS')
AddEventHandler('esx_rpchat:sendProximityMessageTaskS', function(message)
	local player = source
	TriggerClientEvent('esx_rpchat:sendProximityMessageTask', -1, player, message, { 36, 173, 228 })
end)

RegisterCommand('try', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local czy = math.random(1, 2)
	local kolor = nil

	local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end

	if #args < 2 then
		if czy == 1 then
			text = 'Tak'
			kolor = {43, 252, 148}
			kolor2 = {r = 43, g = 252, b = 148, alpha = 255}
		else
			kolor = {252, 25, 48}
			kolor2 = {r = 252, g = 25, b = 48, alpha = 255}
			text = 'Nie'
		end
	else
		local slowo = math.random(1, #args)
		kolor = {255, 94, 0}
		kolor2 = {r = 255, g = 94, b = 0, alpha = 255}
		text = args[slowo]
	end

	TriggerClientEvent("sendProximityMessageCzy", -1, source, source, table.concat(args, " "), czy)
end, false)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end


RegisterCommand('me', function(source, args, rawCommand)
    TriggerClientEvent("sendProximityMessageMe", -1, source, source, table.concat(args, " "))

	local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
	local color = {r = 164, g = 30, b = 191}
	TriggerClientEvent('esx_rpchat:triggerDisplay', -1, text, source, color)
end, false)


RegisterCommand('do', function(source, args, rawCommand)
    TriggerClientEvent("sendProximityMessageDo", -1, source, source, table.concat(args, " "))

	local text = '' -- edit here if you want to change the language : EN: the person / FR: la personne
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end

	TriggerClientEvent('esx_rpchat:triggerDisplay', -1, text, source, {255, 152, 247})
end, false)


RegisterCommand('lspd', function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
	local xPlayer = ESX.GetPlayerFromId(source)
	local grade = xPlayer.job.grade_name
	if xPlayer.job.name == 'police' then
		if grade == 'boss' then
			TriggerClientEvent('chatMessage', -1, "🚓 LSPD: ", {0, 8, 124}, msg)
		end
	end
end, false)


RegisterCommand('news', function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    local name = getIdentity(source)
	local amount = 15
	local _source = source
	imie = name.firstname .. " " .. name.lastname
	local xPlayer = ESX.GetPlayerFromId(_source)
	local quantity = xPlayer.getInventoryItem('phone').count
	local money2 = xPlayer.getAccount('bank').money
	if money2 > 25000 then
		if quantity > 0 then
 		   	fal = "📰^2" .. imie
  		  	TriggerClientEvent('chat:addMessage', -1, {
   		     	args = { fal, msg }
   		 	})
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~y~Pobrano opłatę ~r~$25000')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nie masz wystarczająco pieniędzy w banku')
		end
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nie możesz pisać ogłoszenia bez telefonu')
	end
end, false)

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

RegisterServerEvent('sendProximityMessageTweetServer')
AddEventHandler('sendProximityMessageTweetServer', function(message)
	local _source = source
    if CheckPhone(_source) <= 0 then
        TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz telefonu.')
        return
    end

	local xPlayer = ESX.GetPlayerFromId(_source)

	local mamhajsikbejbe33 = xPlayer.getAccount('bank').money
	local czas = os.date("%Y/%m/%d %X")

	if mamhajsikbejbe33 > 100 then
		xPlayer.removeAccountMoney('bank', 100)
		xPlayer.showNotification('~y~Pobrano opłatę~r~ $100')
		TriggerClientEvent('sendProximityMessageTweet', -1, xPlayer.character.firstname..' '..xPlayer.character.lastname, message, _source)
	else
		xPlayer.showNotification('Nie posiadasz wystarczająco gotówki')
	end
end)

function CheckPhone(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    while xPlayer == nil do
        Citizen.Wait(100)
    end

    local items = xPlayer.getInventoryItem('phone')
    if items == nil then
        return(0)
    else
       return(items.count)
    end
end




ESX.RegisterServerCallback("esx_marker:fetchUserRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

RegisterServerEvent('wyjebzaafk')
AddEventHandler('wyjebzaafk', function()
	DropPlayer(source, "Byłeś/aś zbyt długo nieaktywny/a")
end)

RegisterCommand('ooc', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local czas = os.date("%Y/%m/%d %X")
	if xPlayer.group == 'superadmin' or xPlayer.group == 'admin' then
		local tekst = table.concat(args, " ")
		local niggername = GetPlayerName(source)

		TriggerClientEvent('chat:addMessage1', -1, niggername, gowno[xPlayer.group], tekst, "fas fa-shield-alt")
	else
		xPlayer.showNotification('Nie posiadasz permisji')
	end
end, false)

RegisterServerEvent('sendProximityMessageDarkWebServer')
AddEventHandler('sendProximityMessageDarkWebServer', function(message)
	local _source = source
    if CheckPhone(_source) <= 0 then
        TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz telefonu.')
        return
    end

	local xPlayer = ESX.GetPlayerFromId(_source)
	local czas = os.date("%Y/%m/%d %X")

	local mamhajsikbejbe = xPlayer.getAccount('bank').money
	if mamhajsikbejbe > 500 then
		TriggerClientEvent('sendProximityMessageDarkWeb', -1, message, _source)
		xPlayer.removeAccountMoney('bank', 500)
		xPlayer.showNotification('~y~Pobrano opłatę~r~ $500')
	else
		xPlayer.showNotification('Nie posiadasz wystarczająco gotówki')
	end
end)


RegisterCommand('opis', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	local name = getIdentity(source)
	local identifier = xPlayer.identifier
	if args[1] ~= nil then
		local text = table.concat(args, " ",1)
		if #text > 60 then
		TriggerClientEvent('esx:showNotification', source, '~r~Maksymalna długość opisu postaci wynosi ~h~60~h~ znaków!~w~')
		else
			TriggerClientEvent('ExileRP:opis', -1, xPlayer.source,text)
			MySQL.Sync.execute("UPDATE users SET description =@i WHERE identifier=@identifier",{['@identifier'] = identifier , ['@description'] = '' .. text .. ''})
			TriggerClientEvent("esx_exilechat:pokazOpisChat", -1, source, table.concat(args, " "))
			TriggerClientEvent('esx:showNotification', source, '~g~Ustawiono opis postaci~w~')
			local xPlayer = ESX.GetPlayerFromId(source)
			local steamid = xPlayer.identifier
			local name = GetPlayerName(source)
		end
	else
		TriggerClientEvent('ExileRP:opis', -1, source, '')
		MySQL.Sync.execute("UPDATE users SET description =@i WHERE identifier=@identifier",{['@identifier'] = identifier , ['@description'] = ''})
		TriggerClientEvent('esx:showNotification', source, '~r~Usunięto opis postaci~w~')
	end
end, false)

RegisterServerEvent('elfeedo_opis:DescriptionGet')
AddEventHandler('elfeedo_opis:DescriptionGet', function()
local xPlayer = ESX.GetPlayerFromId(source)
local identifier = xPlayer.identifier
local iSource = MySQL.Sync.fetchScalar("SELECT description FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	TriggerClientEvent('ExileRP:opis', -1, source, iSource)
	TriggerClientEvent('ExileRP:opisInnychGraczy', -1)
end)

RegisterServerEvent('ExileRP:opisInnychGraczyServer')
AddEventHandler('ExileRP:opisInnychGraczyServer', function(id, i)
TriggerClientEvent('ExileRP:opis', -1, id, i)
end)



function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			name = identity['name'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
			job = identity['job'],
			group = identity['group']
		}
	else
		return nil
	end
end


function loadExistingPlayers()
	TriggerEvent("es:getPlayers", function(curPlayers)
		for k,v in pairs(curPlayers)do
			TriggerClientEvent("reply:setGroup", v.get('source'), v.get('group'))
		end
	end)
end

loadExistingPlayers()

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('reply:setGroup', Source, user.getGroup())
end)

local blockReport = {}

AddEventHandler('chatMessage', function(source, color, msg)
	if source ~= nil and msg ~= nil then
		cm = stringsplit(msg, " ")
		if cm[1] == "/reply" or cm[1] == "/r" then
			CancelEvent()
			if tablelength(cm) > 1 then
				local tPID = tonumber(cm[2])
				local names2 = GetPlayerName(tPID)
				local names3 = GetPlayerName(source)
				local textmsg = ""
				for i=1, #cm do
					if i ~= 1 and i ~=2 then
						textmsg = (textmsg .. " " .. tostring(cm[i]))
					end
				end
				local grupos = getIdentity(source)
				if grupos.group ~= 'user' then
					TriggerClientEvent('textmsg', tPID, source, textmsg, names2, names3)
					TriggerClientEvent('textsent', source, tPID, names2)
				else
					TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insuficient Premissions!")
				end
			end
		end	
		
		if cm[1] == "/report" then
			CancelEvent()


			if blockReport[source] == nil then
				blockReport[source] = true
				if tablelength(cm) > 1 then
					local names1 = GetPlayerName(source)
					local textmsg = ""
					for i=1, #cm do
						if i ~= 1 then
							textmsg = (textmsg .. " " .. tostring(cm[i]))
						end
					end
					TriggerClientEvent("sendReport", -1, source, names1, textmsg, exports['esx_scoreboard']:CounterPlayers('admin'))
					Wait(30000)
					blockReport[source] = nil
				end
			else
				TriggerClientEvent('chat:addMessage1', source, "^*Report", {252, 123, 3}, " Odczekaj 30 sekund przed wysłaniem następnego zgłoszenia", "fas fa-flag")
			end
		end	
	end
end)