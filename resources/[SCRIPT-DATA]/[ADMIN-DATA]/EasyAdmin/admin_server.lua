Citizen.CreateThread(function()
	while true do 
		Wait(20000)
		for i, player in pairs(CachedPlayers) do 
			if player.droppedTime and (os.time() > player.droppedTime+600) then
				CachedPlayers[i]=nil
			end
		end
	end
end)
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(50)
	end
end)

function sendRandomReminder()
	reminderTime = GetConvarInt("ea_chatReminderTime", 0)
	if reminderTime ~= 0 and #ChatReminders > 0 then
		local reminder = ChatReminders[ math.random( #ChatReminders ) ]
		local adminNames = ""
		local t = {}
		for i,_ in pairs(OnlineAdmins) do
			table.insert(t, getName(i))
		end
		for i,n in ipairs(t) do 
			if i == 1 then
				adminNames = n
			elseif i == #t then
				adminNames = adminNames.." "..n
			else
				adminNames = adminNames.." "..n..","
			end
		end
		t=nil

		if adminNames == "" then adminNames = "@admins" end
		reminder = string.gsub(reminder, "@admins", adminNames)
		reminder = string.gsub(reminder, "@bancount", #blacklist)
		reminder = string.gsub(reminder, "@time", os.date("%X", os.time()))
		reminder = string.gsub(reminder, "@date", os.date("%x", os.time()))
		TriggerClientEvent("chat:addMessage", -1, { args = { "EasyAdmin", reminder } })
	end
end

RegisterServerEvent("SavellPlayer")
AddEventHandler("SavellPlayer", function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	ESX.SavePlayers(cb)
		print('[EasyAdmin]> Synchronizacja graczy przy użyciu narzędzia EasyAdmin gotowa.')
end)

RegisterServerEvent("SavellPlayerAuto")
AddEventHandler("SavellPlayerAuto", function()
	ESX.SavePlayers(cb)
	print('[EasyAdmin]> Auto Synchronizacja graczy gotowa.')
end)

Citizen.CreateThread(function()
	reminderTime = GetConvarInt("ea_chatReminderTime", 0)
	if reminderTime ~= 0 then
		while true do 
			Wait(reminderTime*60000)
			sendRandomReminder()
		end
	else
		while true do
			Wait(20000)
			sendRandomReminder()
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		local backupInfos = LoadResourceFile(GetCurrentResourceName(), "backups/_backups.json")
		if backupInfos == nil then 
			lastBackupTime = 0
		else
			backupInfos = json.decode(backupInfos)
			lastBackupTime = backupInfos.lastBackup
		end
		if (GetConvarInt("ea_backupFrequency", 72) ~= 0) and (lastBackupTime+(GetConvarInt("ea_backupFrequency", 72)*3600) < os.time()) then
			createBackup()
		end
		Wait(120000)
	end
end)

function loadBackupName(name)
	local backup = LoadResourceFile(GetCurrentResourceName(), "backups/"..name)
	if backup then
		local backupJson = json.decode(backup)
		if backupJson then
			print("Loading Backup..")
			for i,ban in pairs(blacklist) do
				UnbanId(ban.banid)
				PrintDebugMessage("removing ban "..ban.banid)
				Wait(50)
			end

			for i,ban in pairs(backupJson) do
				addBan(ban)
				PrintDebugMessage("adding ban "..ban.banid)
				TriggerEvent("ea_data:addBan", ban)
				Wait(50)
			end
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
			updateBlacklist()
			print("Backup should be loaded!")
		else
			print("^1EasyAdmin:^7 Backup Could not be loaded, in most cases this comes from there being a formatting error, please use a JSON Validator on the file and fix the errors!")
		end
	else
		print("^1EasyAdmin:^7 Backup Name Invalid or missing from Backups.")
	end
end

function createBackup()
	local backupTime = os.time()
	local backupDate = os.date("%H_%M_%d_%m_%Y")
	local backupName = "banlist_"..backupDate..".json"
	PrintDebugMessage("Creating Banlist Backup to "..backupName)

	SaveResourceFile(GetCurrentResourceName(), "backups/"..backupName, json.encode(blacklist, {indent = true}), -1)

	local backupInfos = LoadResourceFile(GetCurrentResourceName(), "backups/_backups.json")
	if backupInfos then
		backupInfos = json.decode(backupInfos)
		table.insert(backupInfos.backups, {id = getNewBackupid(backupInfos), backupFile = backupName, backupTimestamp = backupTime, backupDate = backupDate})

		if #backupInfos.backups > GetConvarInt("ea_maxBackupCount", 10) then
			deleteBackup(backupInfos,1)
		end
		backupInfos.lastBackup = backupTime
		SaveResourceFile(GetCurrentResourceName(), "backups/_backups.json", json.encode(backupInfos, {indent = true}))

	else
		local backupInfos = {lastBackup = backupTime, backups = {}}
		table.insert(backupInfos.backups, {id = getNewBackupid(backupInfos), backupFile = backupName, backupTimestamp = backupTime, backupDate = backupDate})
		SaveResourceFile(GetCurrentResourceName(), "backups/_backups.json", json.encode(backupInfos, {indent = true}))
	end

	return id,timestamp
end

function deleteBackup(backupInfos,id)
	local expiredBackup = backupInfos.backups[id]
	table.remove(backupInfos.backups, id)

	local backupFileName = expiredBackup.backupFile

	local fullResourcePath = GetResourcePath(GetCurrentResourceName())
	os.remove(fullResourcePath.."/backups/"..backupFileName)
	PrintDebugMessage("Removed Backup "..backupFileName)

end

function getNewBackupid(backupInfos)
	if backupInfos then
		local lastBackup = backupInfos.lastbackup
		local backups = backupInfos.backups
		return #backups+1
	else
		return 0
	end
end



AddEventHandler("EasyAdmin:amiadmin", function()
	if not CachedPlayers[source] then
		CachedPlayers[source] = {id = source, name = GetPlayerName(source), identifiers = GetPlayerIdentifiers(source), immune = DoesPlayerHavePermission(source,"easyadmin.immune")}
	end
end)


RegisterServerEvent("EasyAdmin:requestCachedPlayers")
AddEventHandler('EasyAdmin:requestCachedPlayers', function(playerId)
	local src = source
	if DoesPlayerHavePermission(source,"easyadmin.trialsupport") then
		TriggerClientEvent("EasyAdmin:fillCachedPlayers", src, CachedPlayers)
		PrintDebugMessage("Cached Players requested by "..getName(src,true))
	end
end)

AddEventHandler('playerDropped', function (reason)
	if CachedPlayers[source] then
		CachedPlayers[source].droppedTime = os.time()
	end
	if OnlineAdmins[source] then
		OnlineAdmins[source] = nil
	end
end)

RegisterServerEvent("EasyAdmin:GetPlayerList")
AddEventHandler("EasyAdmin:GetPlayerList", function()
	if IsPlayerAdmin(source) then
		local l = {}
		local players = GetPlayers()
		for i, player in pairs(players) do
			if CachedPlayers[player] then
				table.insert(l, CachedPlayers[player])
			end
		end
		TriggerClientEvent("EasyAdmin:GetPlayerList", source, l) 
	end
end)

RegisterServerEvent("EasyAdmin:GetInfinityPlayerList")
AddEventHandler("EasyAdmin:GetInfinityPlayerList", function()
	if IsPlayerAdmin(source) then
		local l = {}
		local players = GetPlayers()

		for i, player in pairs(players) do
			local player = tonumber(player)
			for i, cached in pairs(CachedPlayers) do
				if (cached.id == player) then
					table.insert(l, CachedPlayers[i])
				end
			end
		end
		TriggerClientEvent("EasyAdmin:GetInfinityPlayerList", source, l) 
	end
end)

function GetOnlineAdmins()
	return OnlineAdmins
end

function IsPlayerAdmin(pid)
	return OnlineAdmins[pid]
end


function DoesPlayerHavePermission(player, object)
	local haspermission = false
	if (player == 0 or player == "") then
		return true
	end
	
	if IsPlayerAceAllowed(player,object) then
		haspermission = true
	else
		haspermission = false
	end
	
	if not haspermission then
		local numIds = GetPlayerIdentifiers(player)
		for i,admin in pairs(admins) do
			for i,theId in pairs(numIds) do
				if admin == theId then
					haspermission = true
				end
			end
		end
	end
	return haspermission
end

RegisterCommand('kick', function(source, args, user)
    if source == 0 then 
		if args[1] ~= nil then
			local reason = ""
			for i,theArg in pairs(args) do
				if i ~= 1 then -- make sure we are not adding the kicked player as a reason
					reason = reason.." "..theArg
				end
			end
			if reason == "" or reason == nil then
				reason = "Nie podano przyczyny"
			end
			DropPlayer(args[1], 'Zostałeś wyrzucony przez: cmd \nPowod: ' .. reason)
		end
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.group ~= 'user' and xPlayer.group ~= 'trialsupport' then
			if args[1] ~= nil then
				local reason = ""
				for i,theArg in pairs(args) do
					if i ~= 1 then 
						reason = reason.." "..theArg
					end
				end
				if reason == "" or reason == nil then
					reason = "Nie podano przyczyny"
				end
				DropPlayer(args[1], 'Zostałeś wyrzucony przez: '..GetPlayerName(source)..' \nPowod: ' .. reason)
			end
		end
	end
end)

Citizen.CreateThread(function()
	if GetConvar("gamename", "not-rdr3") == "rdr3" then 
		RedM = true
	else
		RedM = false
	end
	
	local resourcemeta = LoadResourceFile(GetCurrentResourceName(), "__resource.lua")
	if resourcemeta then
		os.remove(GetResourcePath(GetCurrentResourceName()).."/__resource.lua")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		print("^1EasyAdmin^7: You didn't follow the Updating Instructions! I fixed it myself this time, please restart me using the 'ensure EasyAdmin' command.")
		print("^1EasyAdmin^7: For the next time, please read the update instructions and remove the __resource.lua!!")
		print("^1EasyAdmin^7: If this message does not dissapear after typing the ensure command, please manually remove the __resource.lua from my Folder.")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
	end

	AnonymousAdmins = {}

	local strfile = LoadResourceFile(GetCurrentResourceName(), "language/"..GetConvar("ea_LanguageName", "en")..".json")
	if strfile then
		strings = json.decode(strfile)[1]
	else
		strings = {language=GetConvar("ea_LanguageName", "en")}
	end
	
	moderationNotification = GetConvar("ea_moderationNotification", "false")
	if GetConvar("ea_enableDebugging", "false") == "true" then
		enableDebugging = true
		PrintDebugMessage("^1Debug Messages Enabled, Anonymous Admins may not be anonymous!")
	else
		enableDebugging = false
	end
	minimumMatchingIdentifierCount = GetConvarInt("ea_minIdentifierMatches", 2)
	
	RegisterServerEvent('EasyAdmin:amiadmin')
	AddEventHandler('EasyAdmin:amiadmin', function()
		
		local identifiers = GetPlayerIdentifiers(source)
		for perm,val in pairs(permissions) do
			local thisPerm = DoesPlayerHavePermission(source,"easyadmin."..perm)
			if perm == "screenshot" and not screenshots then
				thisPerm = false
			end
			if thisPerm == true then
				OnlineAdmins[source] = true 
			end
			TriggerClientEvent("EasyAdmin:adminresponse", source, perm,thisPerm)
			PrintDebugMessage("Processed Perm "..perm.." for "..getName(source)..", result: "..tostring(thisPerm))
		end
		
		if DoesPlayerHavePermission(source,"easyadmin.trialsupport") then
			TriggerClientEvent('chat:addSuggestion', source, '/spectate', GetLocalisedText("chatsuggestionspectate"), { {name='player id', help="the player's server id"} })
		end
		if DoesPlayerHavePermission(source,"easyadmin.moderator") then
			TriggerClientEvent('chat:addSuggestion', source, '/teleport', GetLocalisedText("chatsuggestionteleport"), { {name='player id', help="the player's server id"} })
		end
		if DoesPlayerHavePermission(source,"easyadmin.superadmin") then
			TriggerClientEvent('chat:addSuggestion', source, '/setgametype', GetLocalisedText("chatsuggestiongametype"), { {name='game type', help="the game type"} })
			TriggerClientEvent('chat:addSuggestion', source, '/setmapname', GetLocalisedText("chatsuggestionmapname"), { {name='map name', help="the map name"} })
		end
				
		if DoesPlayerHavePermission(source,"easyadmin.admin") then
			TriggerClientEvent('chat:addSuggestion', source, '/freeze', GetLocalisedText("chatsuggestionfreeze"), { {name='player id', help="the player's server id"},{name='toggle', help="either true or false"} })
		end
		
		local key = GetConvar("ea_MenuButton", 289)
		if RedM then
			key = GetConvar("ea_MenuButton", "PhotoModePc")
		end
		TriggerClientEvent("EasyAdmin:SetSetting", source, "button", key)
		if GetConvar("ea_alwaysShowButtons", "false") == "true" then
			TriggerClientEvent("EasyAdmin:SetSetting", source, "forceShowGUIButtons", true)
		else
			TriggerClientEvent("EasyAdmin:SetSetting", source, "forceShowGUIButtons", false)
		end
		
		TriggerClientEvent("EasyAdmin:SetLanguage", source, strings)
		
	end)

	RegisterServerEvent("EasyAdmin:requestSpectate")
	AddEventHandler('EasyAdmin:requestSpectate', function(playerId)
		if DoesPlayerHavePermission(source,"easyadmin.trialsupport") then
			local tgtCoords = GetEntityCoords(GetPlayerPed(playerId))
			TriggerClientEvent("EasyAdmin:requestSpectate", source, playerId, tgtCoords)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:SetGameType")
	AddEventHandler('EasyAdmin:SetGameType', function(text)
		if DoesPlayerHavePermission(source,"easyadmin.superadmin") then
			PrintDebugMessage("Player "..getName(source,true).." set Gametype to "..text)
			SetGameType(text)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:SetMapName")
	AddEventHandler('EasyAdmin:SetMapName', function(text)
		if DoesPlayerHavePermission(source,"easyadmin.superadmin") then
			PrintDebugMessage("Player "..getName(source,true).." set Map Name to "..text)
			SetMapName(text)
		end
	end)
	

	ESX.RegisterServerCallback('zlomus:isAdmin', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.group == 'superadmin' or xPlayer.group == 'admin' or xPlayer.group == 'moderator' or xPlayer.group == 'support' or xPlayer.group == 'trialsupport' then
			IsAdmin = true
			cb(IsAdmin)
		else
			IsAdmin = false
			cb(IsAdmin)
		end
	end)


	local Groups = {
		['superadmin'] = true,
		['admin'] = true,
		['moderator'] = true,
		['support'] = true,
		['trialsupport'] = true
	}
	
	local AdminsCount = 0
	
	RegisterServerEvent("EasyAdmin:TeleportPlayerToCoords")
	AddEventHandler('EasyAdmin:TeleportPlayerToCoords', function(playerId,tgtCoords)
		if DoesPlayerHavePermission(source,"easyadmin.moderator") then
			PrintDebugMessage("Player "..getName(source,true).." requsted teleport to "..tgtCoords.x..", "..tgtCoords.y..", "..tgtCoords.z)
			TriggerClientEvent("EasyAdmin:TeleportRequest", playerId, false, tgtCoords)
		end
	end)

	RegisterServerEvent("EasyAdmin:TeleportAdminToPlayer")
	AddEventHandler("EasyAdmin:TeleportAdminToPlayer", function(id)
		if GetPlayerName(id) then
			local tgtPed = GetPlayerPed(id)
			local tgtCoords = GetEntityCoords(tgtPed)
			
			TriggerClientEvent('EasyAdmin:TeleportRequest', source, id,tgtCoords)
		else
			print('EASYADMIN FAILED TO TELEPORT'..source..' TO ID: '..id)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:FreezePlayer")
	AddEventHandler('EasyAdmin:FreezePlayer', function(playerId,toggle)
		if DoesPlayerHavePermission(source,"easyadmin.admin") then
			TriggerClientEvent("EasyAdmin:FreezePlayer", playerId, toggle)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:TookScreenshot")
	

	
	blacklist = {}
	
	function GetFreshBanId()
		if blacklist[#blacklist] then 
			return blacklist[#blacklist].banid+1
		else
			return 1
		end
	end
	function updateAdmins(addItem)
		admins = {}
		local content = LoadResourceFile(GetCurrentResourceName(), "admins.txt")
		if not content then
			return
		end
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^3The following SteamIDs are added to your admins.txt file, this method is **OUTDATED** and **DOES NOT WORK**^7\n")
		Citizen.Trace("Add these admins using ACE:\n")
		for index,value in ipairs(string.split(content, "\n")) do
			Citizen.Trace(value.."\n")
		end
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
	end

	
	function getName(src,anonymousdisabled)
		if (src == 0 or src == "") then
			return "Console"
		else
			if AnonymousAdmins[src] and not anonymousdisabled then
				return GetLocalisedText("anonymous")
			elseif CachedPlayers[src] and CachedPlayers[src].name then
				return CachedPlayers[src].name
			elseif (GetPlayerName(src)) then
				return GetPlayerName(src)
			else
				return "Unknown - " .. src
			end
		end
	end
	
	function updateBan(id,newData)
		if id and newData and newData.identifiers and newData.banid and newData.reason and newData.expire then 
			blacklist[id] = newData
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
			if GetConvar("ea_custombanlist", "false") == "true" then 
				TriggerEvent("ea_data:updateBan", newData)
			end
		end
	end

	function addBan(data)
		if data then
			table.insert(blacklist, data)
		end
	end

	function updateBlacklist(data,remove, forceChange)
		-- life is pain, if you think this code sucks, SUCK MY DICK and make it better
		local change= (forceChange or false) --mark if file was changed to save up on disk writes.
		if GetConvar("ea_custombanlist", "false") == "true" then 
			
			if data and not remove then
				addBan(data)
				TriggerEvent("ea_data:addBan", data)
				
			elseif data and remove then
				UnbanId(data.banid)
			elseif not data then
				TriggerEvent('ea_data:retrieveBanlist', function(banlist)
					blacklist = banlist
					PrintDebugMessage("updated banlist custom banlist")
					for i,theBan in ipairs(blacklist) do
						if theBan.expire < os.time() then
							table.remove(blacklist,i)
							PrintDebugMessage("removing old ban custom banlist")
							TriggerEvent("ea_data:removeBan", theBan)
						end
					end
				end)
			end
			return
		end
		
		local content = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
		if not content then
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode({}), -1)
			content = json.encode({})
		end
		blacklist = json.decode(content)

		PrintDebugMessage("updated banlist")
		if not blacklist then
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
			print("EasyAdmin: ^1Failed^7 to load Banlist!\n")
			print("EasyAdmin: Please check your banlist file for errors, ^1Bans *will not* work!^7\n")
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
		end
		
		performBanlistUpgrades(blacklist)
		
		if data and not remove then
			addBan(data)
			change=true
		elseif not data then
			for i,theBan in ipairs(blacklist) do
				theBan.id = nil
				if not theBan.banid then
					if i==1 then 
						theBan.banid = 1
					else
						theBan.banid = blacklist[i].banid or i
					end
					change=true
				end
				if not theBan.expire then 
					table.remove(blacklist,i)
					change=true
				elseif not theBan.identifiers then
					table.remove(blacklist,i)
					change=true
				elseif not theBan.identifiers[1] then 
					table.remove(blacklist,i)
					change=true
				elseif theBan.expire < os.time() then
					table.remove(blacklist,i)
					PrintDebugMessage("removing old ban no custom banlist")
					change=true
				elseif theBan.expire == 1924300800 then
					blacklist[i].expire = 10444633200
					change=true
				end
			end
		end
		if data and remove then
			UnbanId(data.banid)
			change = true
		end
		if change then
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
		end
	end

	function BanIdentifier(identifier,reason)
		updateBlacklist( {identifiers = {identifier} , banner = "Unknown", reason = reason, expire = 10444633200} )
	end
	
	function BanIdentifiers(identifier,reason)
		updateBlacklist( {identifiers = identifier , banner = "Unknown", reason = reason, expire = 10444633200} )
	end
	
	function UnbanIdentifier(identifier)
		if identifier then
			for i,ban in ipairs(blacklist) do
				for index,id in ipairs(ban.identifiers) do
					if identifier == id then
						table.remove(blacklist,i)
						if GetConvar("ea_custombanlist", "false") == "true" then 
							TriggerEvent("ea_data:removeBan", ban)
						end
						PrintDebugMessage("removed ban as per unbanidentifier func")
						return
					end 
				end
			end
		end
	end

	function UnbanId(id)
		for i,ban in ipairs(blacklist) do
			if ban.banid == id then
				table.remove(blacklist,i)
				if GetConvar("ea_custombanlist", "false") == "true" then 
					TriggerEvent("ea_data:removeBan", ban)
				end
			end
		end
	end

	function performBanlistUpgrades()
		for i,ban in ipairs(blacklist) do
			if ban.identifiers then
				for k, identifier in pairs(ban.identifiers) do
					if identifier == "" then
						ban.identifiers[k] = nil
						change = true 
					end
				end
			end
		end
		if blacklist[1] and (blacklist[1].identifier or blacklist[1].steam or blacklist[1].discord) then -- more compat
			Citizen.Trace("Upgrading Banlist...\n")
			for i,ban in ipairs(blacklist) do
				if not ban.identifiers then
					ban.identifiers = {}
					change=true
				end
				if ban.identifier then
					table.insert(ban.identifiers, ban.identifier)
					ban.identifier = nil
					change=true
				end
				if ban.steam then
					table.insert(ban.identifiers, ban.steam)
					ban.steam = nil
					change=true
				end
				if ban.discord and ban.discord ~= "" then
					table.insert(ban.identifiers, ban.discord)
					ban.discord = nil
					change=true
				end
			end
			Citizen.Trace("Banlist Upgraded! No Further Action is necesarry.\n")
		end
	end

	function IsIdentifierBanned(theIndentifier)
		local identifierfound = false
		for index,value in ipairs(blacklist) do
			for i,identifier in ipairs(value.identifiers) do
				if theIndentifier == identifier then
					identifierfound = true
				end
			end
		end
		return identifierfound
	end

	AddEventHandler("EasyAdmin:GetVersion", function(cb)
		local verFile = LoadResourceFile(GetCurrentResourceName(), "version.json")
		local verContent = json.decode(verFile)
		print(verContent.fivem.version)
		cb(verContent.fivem.version)
	end)
	
	AddEventHandler('playerConnecting', function(playerName, setKickReason)
		local numIds = GetPlayerIdentifiers(source)
		local matchingIdentifierCount = 0
		local matchingIdentifiers = {}
		if not blacklist then
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
			print("EasyAdmin: ^1Failed^7 to load Banlist!\n")
			print("EasyAdmin: Please check this error soon, ^1Bans *will not* work!^7\n")
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
		 	return
		end
		for bi,blacklisted in ipairs(blacklist) do
			for i,theId in ipairs(numIds) do
				for ci,identifier in ipairs(blacklisted.identifiers) do
					if identifier == theId and matchingIdentifiers[theId] ~= true then
						matchingIdentifierCount = matchingIdentifierCount+1
						matchingIdentifiers[theId] = true
						PrintDebugMessage("IDENTIFIER MATCH! "..identifier.." Required: "..matchingIdentifierCount.."/"..minimumMatchingIdentifierCount)
						if matchingIdentifierCount >= minimumMatchingIdentifierCount then
							setKickReason(string.format( GetLocalisedText("bannedjoin"), blacklist[bi].reason, os.date('%d/%m/%Y 	%H:%M:%S', blacklist[bi].expire )))
							PrintDebugMessage("EasyAdmin: Connection of "..GetPlayerName(source).." Declined, Banned for "..blacklist[bi].reason.." \n")
							CancelEvent()
							return
						end
					end
				end
			end
		end
	end)

	AddEventHandler('chatMessage', function(Source, Name, Msg)
		if MutedPlayers[Source] then
			CancelEvent()
			TriggerClientEvent("chat:addMessage", Source, { args = { "EasyAdmin", GetLocalisedText("playermute") } })
		end
	end)
		
	local verFile = LoadResourceFile(GetCurrentResourceName(), "version.json")
	local verContent = json.decode(verFile)
	if RedM then
		curVersion = verContent.redm.version
	else
		curVersion = verContent.fivem.version
	end
	local updatePath = "/Blumlaut/EasyAdmin"
	local resourceName = "EasyAdmin ("..GetCurrentResourceName()..")"
	function checkVersion(err,response, headers)
		if err == 200 then
			local data = json.decode(response)
			local remoteVersion = data.fivem.version
			local changelog = data.fivem.changelog
			if RedM then
				remoteVersion = data.redm.version
				changelog = data.redm.changelog
			end
		end
		if GetResourceState("screenshot-basic") == "missing" then 
			print("\nEasyAdmin: screenshot-basic is not installed on this Server, screenshots unavailable")
		else
			StartResource("screenshot-basic")
			screenshots = true
		end
		local onesync = GetConvar("onesync", "off")
		if (onesync ~= "off" and onesync ~= "legacy") then 
			infinity = true
		end
		
		SetTimeout(3600000, checkVersionHTTPRequest)
	end
	
	function checkVersionHTTPRequest()
		PerformHttpRequest("https://raw.githubusercontent.com/"..updatePath.."/master/version.json", checkVersion, "GET")
	end
	
	function loopUpdateBlacklist()
		updateBlacklist()
		SetTimeout(300000, loopUpdateBlacklist)
	end

	loopUpdateBlacklist()
	updateAdmins()
	checkVersionHTTPRequest()
end)

admins = {}
MutedPlayers = {}
CachedPlayers = {}
OnlineAdmins = {}
ChatReminders = {}

local savedCoords   = {}

RegisterCommand("info", function(source, args, rawCommand)
	isPlayerOnline = false
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if source == 0 then
		local xAll = ESX.GetPlayers()
		print("^2Online: "..#xAll)
		for i=1, #xAll, 1 do
			local xPlayer = ESX.GetPlayerFromId(xAll[i])
			print("^3ID: "..xPlayer.source.." | NICK: "..xPlayer.getName().." | GRUPA: "..xPlayer.getGroup().." \n")
			isPlayerOnline = true
		end
		if not isPlayerOnline then
			print("^3Brak graczy Online")
		end
	end
end, false)

RegisterCommand("bring", function(source, args, rawCommand)
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.group == 'superadmin' or xPlayer.group == 'admin' or xPlayer.group == 'moderator' or xPlayer.group == 'support' then
	    	if args[1] and tonumber(args[1]) then
	      		local targetId = tonumber(args[1])
	      		local xTarget = ESX.GetPlayerFromId(targetId)
	      		if xTarget then
	        		local targetCoords = xTarget.getCoords()
	        		local playerCoords = xPlayer.getCoords()
	        		savedCoords[targetId] = targetCoords
	        		xTarget.setCoords(playerCoords)
						TriggerClientEvent('FeedM:showNotification', '~o~ Teleportujesz do siebie: ' ..args[1])
	      		else
					TriggerClientEvent('FeedM:showNotification', '~o~Gracz jest offline')
	      		end
	    	else
				TriggerClientEvent('FeedM:showNotification', '~o~Źle wpisana komenda')
	    	end
		else
			TriggerClientEvent('FeedM:showNotification', '~o~Nie masz permisji')
	  	end
	end
end, false)

RegisterCommand("goto", function(source, args, rawCommand)
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.group == 'superadmin' or xPlayer.group == 'admin' or xPlayer.group == 'moderator' then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			local targetCoords = xTarget.getCoords()
        			local playerCoords = xPlayer.getCoords()
        			savedCoords[source] = playerCoords
        			xPlayer.setCoords(targetCoords)
					TriggerClientEvent('FeedM:showNotification', '~o~ Teleportujesz sie do : ' ..args[1])
      			else
					TriggerClientEvent('FeedM:showNotification', '~o~Gracz jest offline')
      			end
    		else
				TriggerClientEvent('FeedM:showNotification', '~o~Źle wpisana komenda')
    		end
  		end
	end
end, false)