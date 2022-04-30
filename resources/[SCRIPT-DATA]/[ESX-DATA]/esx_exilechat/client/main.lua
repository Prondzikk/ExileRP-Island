local group 
local dontreport = false
local showkurwaid = true
kick = 1800
kickostrzezenie = true

ESX =					nil

local opisy = {}

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
		
		Citizen.Wait(250)
	end
	
    Citizen.Wait(5000)
    TriggerServerEvent('exile_chat:checkBlocklist')
	ESX.PlayerData = ESX.GetPlayerData()
	
	ESX.TriggerServerCallback('Misiaczek:getOpis', function(opis)
		opisy = opis
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setGroup')
AddEventHandler('esx:setGroup', function(group)
	ESX.PlayerData.group = group
end)

RegisterCommand("tpm", function(source)
    TeleportToWaypoint()
end)

TeleportToWaypoint = function()
	if ESX.PlayerData ~= nil and ESX.PlayerData.group == 'superadmin' then			
		local blip = GetFirstBlipInfoId(8)
		local playerPed = PlayerPedId()
		
		if blip ~= 0 then
			if IsPedInAnyVehicle(playerPed, false) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					playerPed = vehicle
				else
					playerPed = nil
				end
			end

			local coord = GetBlipCoords(blip)
			local unused, ground = GetGroundZFor_3dCoord(coord.x, coord.y, 99999.0, 0)
			
			if ground == 0 then
				SetEntityCoords(playerPed, coord.x, coord.y, 0)
				
				local tries = 0
				while ground == 0 and tries < 2000 do
					Citizen.Wait(100)
					unused, ground = GetGroundZFor_3dCoord(coord.x, coord.y, 99999.0, 0)
					tries = tries + 1
				end
				
				SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, ground + 2.0, true, true, true)
				RemoveBlip(blip)
			else
				SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, ground + 2.0, true, true, true)
				RemoveBlip(blip)
			end
		else
			ESX.ShowNotification('Nie zaznaczono znacznika na mapie')
		end	
	else
		ESX.ShowNotification("Nie możesz tego zrobić")
	end
end


CreateThread(function()
	while true do
		Citizen.Wait(1000)
		gracz = PlayerPedId()
		if gracz then
			pozycja = GetEntityCoords(gracz, true)
			local bw = exports['esx_ambulancejob']:getDeathStatus()
			local isJailed = exports['esx_jailer']:getJailStatus()
			if pozycja == starapozycja and not bw and not isJailed then
				if time > 0 then
					if kickostrzezenie and time == math.ceil(kick / 30) then
						--TriggerEvent("chatMessage", "UWAGA", {255, 0, 0}, "^1 Zostaniesz wyrzucony za " .. time .. " sekund za nieaktywność!")
						TriggerEvent('chat:addMessage1',"SYSTEM", {255, 0, 0}, "Zostaniesz wyrzucony za "..time .. " sekund za nieaktywność!", "fas fa-bell")
					end
					time = time - 1
				else
					TriggerServerEvent("wyjebzaafk")
				end
			else
				time = kick
			end
			starapozycja = pozycja
		end
	end
end)

RegisterCommand("adminoff", function(source)
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" then
            if dontreport == false then
                dontreport = true
                ESX.ShowNotification("Pomyślnie wyłączono reporty!")
            else
                dontreport = false
                ESX.ShowNotification("Pomyślnie włączono reporty!")
            end
        end
    end)
end)

RegisterCommand("adminidoff", function(source)
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if playerRank ~= "user" then
            if showkurwaid == true then
                showkurwaid = false
                ESX.ShowNotification("Pomyślnie wyłączono id!")
            else
                showkurwaid = true
                ESX.ShowNotification("Pomyślnie włączono id!")
            end
        end
    end)
end)

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(name, id, group, message)
	local pid = GetPlayerFromServerId(id)
	
	if pid == -1 then
		return
	end
	
	if pid ~= PlayerId() then
		local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
		if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(ped, true)) > 19.99 then
			return
		end
	end
	
	if Config.group[group] ~= nil then
		TriggerEvent('chat:addMessage1',"[" .. id .. "] ".. name, {26, 26, 26}, message, "fas fa-comment-dots", Config.group[group])
	else
		TriggerEvent('chat:addMessage1',"[" .. id .. "] ".. name, {26, 26, 26}, message, "fas fa-comment-dots")
	end
end)


RegisterNetEvent('sendProximityMessageDarkWeb')
AddEventHandler('sendProximityMessageDarkWeb', function(message, playerId)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name ~= 'police' and ESX.PlayerData.job.name ~= 'offpolice' then
		if ESX.PlayerData.group == 'trialsupport' or ESX.PlayerData.group == 'support' or ESX.PlayerData.group == 'moderator' or ESX.PlayerData.group == 'admin' or ESX.PlayerData.group == 'superadmin' and showkurwaid then
			TriggerEvent('chat:addMessage1','[' .. playerId .. '] ' .. "^*Darkweb", {115, 25, 25}, message, "fas fa-laptop")
		else
			TriggerEvent('chat:addMessage1',"^*Darkweb", {115, 25, 25}, message, "fas fa-laptop")
		end
	end
end)

RegisterNetEvent('sendProximityMessageTweet')
AddEventHandler('sendProximityMessageTweet', function(title, message, playerId)
	if ESX.PlayerData.group ~= nil and ESX.PlayerData.group == 'trialsupport' or ESX.PlayerData.group == 'support' or ESX.PlayerData.group == 'moderator' or ESX.PlayerData.group == 'admin' or ESX.PlayerData.group == 'superadmin' and showkurwaid then
		TriggerEvent('chat:addMessage1', '^*[' .. playerId .. '] ' .. title, {24, 133, 217}, message, "fab fa-twitter")
	else
		TriggerEvent('chat:addMessage1', "^*"..title, {24, 133, 217}, message, "fab fa-twitter")
	end
end)


RegisterCommand('twt', function(source, args, user)

	if exports['gcphone']:getMenuIsOpen() then
		TriggerServerEvent("sendProximityMessageTweetServer", table.concat(args, " "))
	else
		ESX.ShowNotification('Musisz wyciągnąć telefon żeby napisać wiadomość')
	end
end, false)

RegisterCommand('dw', function(source, args, user)	
	if exports['gcphone']:getMenuIsOpen() then
		TriggerServerEvent("sendProximityMessageDarkWebServer", table.concat(args, " "))
	else
		ESX.ShowNotification('Musisz wyciągnąć telefon żeby napisać wiadomość')
	end
end, false)
local font = 4 
local time = 6000 
local nbrDisplaying = 1

RegisterNetEvent('esx_rpchat:triggerDisplay')
AddEventHandler('esx_rpchat:triggerDisplay', function(text, source, color)
	local player = GetPlayerFromServerId(source)
    if player ~= -1 then
		local offset = 0 + (nbrDisplaying*0.14)
		Display(GetPlayerFromServerId(source), text, offset, color)
	end
end)

function Display(mePlayer, text, offset, color)
    local displaying = true
    CreateThread(function()
        Wait(time)
        displaying = false
    end)
    CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
			local ped = Citizen.InvokeNative(0x43A66C31C68491C0, mePlayer)
            local coordsMe = GetEntityCoords(ped, false)
            local coords = GetEntityCoords(PlayerPedId(), false)
			
			if #(coordsMe - coords) < 19.99 then
				if IsEntityVisible(Citizen.InvokeNative(0x43A66C31C68491C0, mePlayer)) then
					DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z'] + 0.75 + offset, text, color)
				end			
			end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text, color)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = #(vec3(px, py, pz) - vec3(x, y, z))

    local scale = (1/dist)*1.7
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextCentre(true)


        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55*scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
		DrawRect(_x+0.0011, _y+scale/50, width*1.1, height*1.2, color.r, color.g, color.b, 100)
    end
end

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
	local pid = GetPlayerFromServerId(id)

	if pid == -1 then
		return
	end
	
	if pid ~= PlayerId() then
		local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
		if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(ped, true)) > 19.99 then
			return
		end
	end
	
	local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
    if IsEntityVisible(ped) then	
			TriggerEvent('chat:addMessage1', "^*"..name, {201, 14, 189}, " ".." " .. message, "fas fa-comment-dots", {255, 255, 255})
	end
end)
RegisterNetEvent('sendProximityMessageZ')
AddEventHandler('sendProximityMessageZ', function(id, name, message)
	local pid = GetPlayerFromServerId(id)

	if pid == -1 then
		return
	end
	
	if pid ~= PlayerId() then
		local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
		if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(ped, true)) > 19.99 then
			return
		end
	end
	
	local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
    if IsEntityVisible(ped) then	
			TriggerEvent('chat:addMessage1', "^*"..name, {20, 20, 20}, " Rozgląda się uważnie", "fas fa-clipboard-list", {255, 255, 255})
	end
end)


RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
	local pid = GetPlayerFromServerId(id)

	if pid == -1 then
		return
	end
	
	if pid ~= PlayerId() then
		local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
		if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(ped, true)) > 19.99 then
			return
		end
	end
	
	local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
	if IsEntityVisible(ped) then	
		TriggerEvent('chat:addMessage1', "^*"..name, {224, 148, 219}, " ".." " .. message, "fas fa-comment-dots", {255, 255, 255})
	end
end)

RegisterNetEvent('sendProximityMessageCzy')
AddEventHandler('sendProximityMessageCzy', function(id, name, message, czy)
	local pid = GetPlayerFromServerId(id)
	
	if pid == -1 then
		return
	end
	
	if pid ~= PlayerId() then
		local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
		if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(ped, true)) > 19.99 then
			return
		end
	end

	local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
	if IsEntityVisible(ped) then
		if czy == 1 then
			--TriggerEvent('chatMessage',"^*🎲 Obywatel(TRY) [" .. name .. "] TAK", {256, 202, 247})
			TriggerEvent('chat:addMessage1', name, {44, 7, 56}, "Udane", "fas fa-dice", {255, 255, 255})
		elseif czy == 2 then
			--TriggerEvent('chatMessage',"^*🎲 Obywatel(TRY) [" .. name .. "] NIE", {256, 202, 247})
			TriggerEvent('chat:addMessage1', name, {44, 7, 56}, "Nieudane", "fas fa-dice", {255, 255, 255})
		end
	end	
end)

RegisterNetEvent('esx_exilechat:pokazOpisChat')
AddEventHandler('esx_exilechat:pokazOpisChat', function(id, text)
	local pid = GetPlayerFromServerId(id)
	
	if pid == -1 then
		return
	end
	
	if pid ~= PlayerId() then
		local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
		if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(ped, true)) > 19.99 then
			return
		end
	end
	
	local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
	if IsEntityVisible(ped) then	
		--TriggerEvent('chatMessage',"^*Obywatel[" .. id .. "] ", {240, 240, 240})
		TriggerEvent('chat:addMessage1', id, {240, 240, 240}, " "..text.." ", "fas fa-id-badge")
	end
end)

--------------------------
----- ME / DO / OPIS -----
--------------------------



local color = {r = 37, g = 175, b = 134, alpha = 255}
local color2 = {r = 37, g = 175, b = 134, alpha = 255}
local font = 0
local czasxd = 10000
local nbrDisplaying = 0

local displayOpisHeight = -0.1
local playerOpisDist = 20


RegisterNetEvent('ExileRP:opis')
AddEventHandler('ExileRP:opis', function(player, opis)
    local info = opis
    local ajdi = player
    opisy[ajdi] = info
end)


RegisterNetEvent('ExileRP:opisInnychGraczy')
AddEventHandler('ExileRP:opisInnychGraczy', function()
    local AjDi = GetPlayerServerId(PlayerId())
    local MojOpis = opisy[AjDi]
    TriggerServerEvent('ExileRP:opisInnychGraczyServer', AjDi, MojOpis)
end)

CreateThread(function()
    while true do
        Citizen.Wait(1)
		
        for _, player in ipairs(GetActivePlayers()) do
			local ajdi = GetPlayerServerId(player)
            if (opisy[ajdi] ~= nil and tostring(opisy[ajdi]) ~= '') then

				local ped = Citizen.InvokeNative(0x43A66C31C68491C0, player)
				local playerCoords = GetEntityCoords(PlayerPedId(), true)
				local targetCoords = GetEntityCoords(ped, true)
				local distance2 = #(playerCoords - targetCoords)
				
				if distance2 < 20 and not IsPedInAnyVehicle(ped, false) and IsEntityVisible(ped) then
					red = 230
					green = 255
					blue = 255
					local tekst = tostring(opisy[ajdi])
					local words = {}
					for word in tekst:gmatch("%w+") do table.insert(words, word) end
					if #tekst > 40 then
						local part1 = ''
						local part2 = ''
						local srodek = math.floor(#words * 0.5)
						local srodek2 = srodek + 1
						for i=1, srodek do
							part1 = part1..words[i]..' '
						end
						for i=srodek+1, #words do
							if i ~= #words then
								part2 = part2..words[i]..' '
							elseif i ==  #words then
								part2 = part2..words[i]
							end
						end
						
						DrawText3DOpis(targetCoords.x, targetCoords.y, targetCoords.z + displayOpisHeight, ''..part1..'~n~'..part2..'')
					else
						DrawText3DOpis(targetCoords.x, targetCoords.y, targetCoords.z + displayOpisHeight, tekst)
					end
				end
			end
        end
    end
end)


function DrawText3DOpis(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vec3(px, py, pz) - vec3(x, y, z))

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov*0.6

    if onScreen then
        SetTextScale(0.30, 0.30)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

------------------
----- REPORT -----
------------------

RegisterNetEvent("textsent")
AddEventHandler('textsent', function(tPID, names2)
	ESX.ShowNotification('~w~Odpowiedź wysłana do [~o~'..tPID.."~w~] ~o~"..names2)
end)

RegisterNetEvent("textmsg")
AddEventHandler('textmsg', function(source, textmsg, names2, names3 )
	TriggerEvent('chat:addMessage1', "["..source.."] "..names3, {252, 123, 3}, textmsg, "fas fa-user-shield")
end)

RegisterNetEvent('sendReport')
AddEventHandler('sendReport', function(id, name, message, admins)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if ESX ~= nil then
		if pid == myId then
			if admins == 0 then
				TriggerEvent('chat:addMessage1', "^*Report", {252, 123, 3}, " Obecnie nie ma administracji na serwerze!", "fas fa-flag")
			elseif admins == 1 then
				TriggerEvent('chat:addMessage1', "^*Report", {252, 123, 3}, " Wysłano do "..admins.. " administratora", "fas fa-flag")
			else
				TriggerEvent('chat:addMessage1', "^*Report", {252, 123, 3}, " Wysłano do "..admins.. " administratorów", "fas fa-flag")
			end
		elseif (ESX.PlayerData ~= nil and ESX.PlayerData.group == 'trialsupport' or ESX.PlayerData.group == 'support' or ESX.PlayerData.group == 'moderator' or ESX.PlayerData.group == 'admin' or ESX.PlayerData.group == 'superadmin') and pid ~= myId and not dontreport then
			TriggerEvent('chat:addMessage1', "[".. id .."] ^*"..name, {252, 123, 3}, " "..message, "fas fa-flag")
		end
	end
end)