local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local Config = {
	Identities = {
		{
			Position = { x = -1045.8291, y = -2751.5154, z = 20.4134 },
			Blip = {
				Sprite  = 307,
				Display = 4,
				Scale   = 0.7,
				Color   = 0,
				Label   = "Lotnisko"
			}
		},
		-- {
			-- Position = { x = 1775.6317, y = 2552.0938, z = 44.615 },
			-- Jail = true
		-- },
		-- {
			-- Position = { x = -1824.4376, y = 3290.0005, z = 31.8642 }
		-- },
	},
	Marker = {
		Type = 1,
		Distance = 10.0,
		Color = { r = 102, g = 0, b = 102 },
		Size = { x = 1.5, y = 1.5, z = 1.0 }
	}
}

local isInMarker   = false
local guiEnabled   = false
local hasIdentity  = false
local keepDecor    = false

ESX = nil
CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

CreateThread(function()
	for k, v in pairs(Config.Identities) do
		if v.Blip then
			local blip = AddBlipForCoord(v.Position.x, v.Position.y, v.Position.z)
			SetBlipSprite (blip, v.Blip.Sprite)
			SetBlipDisplay(blip, v.Blip.Display)
			SetBlipScale  (blip, v.Blip.Scale)
			SetBlipColour (blip, v.Blip.Color)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.Blip.Label)
			EndTextCommandSetBlipName(blip)
			Citizen.Wait(1)
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)
		sleep = true
		local inMarker, coords = false, GetEntityCoords(PlayerPedId())
		for k, v in pairs(Config.Identities) do
			local distance = #(coords - vec3(v.Position.x, v.Position.y, v.Position.z))
			if distance < Config.Marker.Distance and (not v.Jail or exports['esx_jail']:getJailStatus()) then
				sleep = false
				DrawMarker(1, v.Position.x, v.Position.y, v.Position.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 252, 0, 50, 100, false, true, 2, false, false, false, false)
				if distance < Config.Marker.Size.x then
					sleep = false
					inMarker  = true
				end
			end
		end

		if inMarker and not isInMarker then
		sleep = false
			isInMarker = true
		end
		
		if not inMarker and isInMarker then
			sleep = true
			isInMarker = false
			ESX.UI.Menu.CloseAll()
		end
		if sleep then
		Citizen.Wait(1000)
		end
	end
end)

local isLoading = false
CreateThread(function()
	while true do
		if isInMarker then
			Citizen.Wait(10)
			SetTextComponentFormat('STRING')
			AddTextComponentString('Naciśnij ~INPUT_CONTEXT~ aby oddać bilet kuzynowi')

			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, Keys['E']) and not isLoading then
				isLoading = true
				ESX.TriggerServerCallback('esx_identity:listcharacters', function(data, data2)
					local elements = {}
					
					if data.firstname1 ~= '' then
						if data2.firstname..' '..data2.lastname == data.firstname1 .. ' ' .. data.lastname1 then
							table.insert(elements, {label = data.firstname1 .. ' ' .. data.lastname1.. " [Aktualna]", value = 1, acctualy = true})
						else
							table.insert(elements, {label = data.firstname1 .. ' ' .. data.lastname1, value = 1, acctualy = false})
						end
						if data.firstname2 ~= '' then
							if data2.firstname..' '..data2.lastname == data.firstname2 .. ' ' .. data.lastname2 then
								table.insert(elements, {label = data.firstname2 .. ' ' .. data.lastname2.. " [Aktualna]", value = 2, acctualy = true})
							else
								table.insert(elements, {label = data.firstname2 .. ' ' .. data.lastname2, value = 2, acctualy = false})
							end
							if data.firstname3 ~= '' then
								if data2.firstname..' '..data2.lastname == data.firstname3 .. ' ' .. data.lastname3 then
									table.insert(elements, {label = data.firstname3 .. ' ' .. data.lastname3.. " [Aktualna]", value = 3, acctualy = true})
								else
									table.insert(elements, {label = data.firstname3 .. ' ' .. data.lastname3, value = 3, acctualy = false})
								end
							end
						end
					end

					isLoading = false
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'identities', {
						title = 'Rodzina',
						align = 'center',
						elements = elements
					}, function (data, menu)
						menu.close()
						if data.current.acctualy ~= true then
							TriggerServerEvent('saveIdentityBeforeChange')
							ESX.ShowNotification('~r~Wczytywanie postaci')
							Citizen.Wait(2500)
							TriggerServerEvent('esx_identity:CharacterChosen', data.current.value)
						else
							ESX.ShowNotification('~r~Nie możesz zmienić postaci na tą samą')
						end
					end, function (data, menu)
						menu.close()
					end)
				end)
			end
		else
			Citizen.Wait(200)
		end
	end
end)

RegisterNetEvent('esx_identity:identityCheck')
AddEventHandler('esx_identity:identityCheck', function(status)
	hasIdentity = status
end)

RegisterNetEvent('esx_identity:setClient')
AddEventHandler('esx_identity:setClient', function(loadout, inventory, accounts, job)
	ESX.SetPlayerData('loadout', loadout)
	ESX.SetPlayerData('inventory', inventory)
	ESX.SetPlayerData('accounts', accounts)
	ESX.SetPlayerData('job', job)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	isDead = false
end)

RegisterNUICallback('escape', function(data, cb)
	if hasIdentity then
		EnableGui(false)
	else
		TriggerEvent('chat:addMessage', { args = { '^1[AxivaRP]', '^1Musisz utworzyć postać aby móc grać!' } })
	end
end)

function StartRegister(ped)
	SetCanAttackFriendly(ped, false, false)
	DecorSetBool(ped, "Register", true)
	Citizen.InvokeNative(0x239528EACDC3E7DE, PlayerId(), true)
end

function FinishRegister()
	local ped = PlayerPedId()
	SetCanAttackFriendly(ped, true, false)

	keepDecor = false
	DecorRemove(ped, "Register")

	NetworkSetFriendlyFireOption(true)
	Citizen.InvokeNative(0x239528EACDC3E7DE, PlayerId(), false)
end

function EnableGui(state)
	local jd = nil	
	guiEnabled = state == true	
	guiEnabled = state
	if state == true then 
		NetworkSetFriendlyFireOption(false)
		jd = "enableui"
		exports['UI']:OpenRegisterMenu()
	elseif state ~= nil then
		FinishRegister()
		jd = "disableui" 
		exports['UI']:CloseRegisterMenu()
	end

	--[[SendNUIMessage({
		type = jd,
		enable = guiEnabled
	})
	SetNuiFocus(guiEnabled, guiEnabled)]]
end

RegisterNetEvent('updateIdentity')
AddEventHandler('updateIdentity', function(xPlayer, skin)	
	TriggerEvent('wybranopostac', true)
	Citizen.InvokeNative(0xCEA04D83135264CC, PlayerPedId(), 0)
	Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, PlayerPedId(), 200)
	--Update all
	TriggerServerEvent('country:Set')  
	--Sync
	Citizen.Wait(1000)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin) 					 
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
	TriggerServerEvent('esx_inventoryhud:getOwnedSim')
	TriggerServerEvent('esx_jailer:checkJail')	
	TriggerEvent('country:checkHospital')
end)

RegisterNetEvent('registerCharacter')
AddEventHandler('registerCharacter', function(identifier)			 												                    		 												
	TriggerServerEvent('country:SetNewChar')		

	--Sync
	Citizen.Wait(1500)
	TriggerServerEvent('esx_inventoryhud:getOwnedSim')
	TriggerServerEvent('esx_jailer:checkJail')
end)

RegisterNetEvent('esx_identity:showRegisterIdentity')
AddEventHandler('esx_identity:showRegisterIdentity', function(type)
	if type == 'custom' then
		TriggerServerEvent('saveIdentityBeforeChange')
		ESX.ShowNotification('~r~Zapisywanie i wczytywanie danych')
		Citizen.Wait(5000)
		EnableGui(true)
	else
		CreateThread(function()
			local status = 0
			while true do
				if status == 0 then
					status = 1
					TriggerEvent('country:load', function(result)
						if result == 3 then
							status = 2
						else
							status = 0
						end
					end)
				end

				Citizen.Wait(200)
				if status == 2 then
					break
				end
			end

			Citizen.Wait(2000)
			EnableGui(true)
		end)
	end
end)

local pos = {	
	--[[ On start serwera
	{x = -314.30, y = -1051.35, z = 75.93},
	{x = -125.5223, y = -1002.2869, z = 53.3126},
	{x = 257.9796, y = -690.2641, z = 84.818},
	{x = 378.2271, y = -711.3872, z = 84.6627},
	{x = -797.7172, y = -1185.5634, z = 50.198},
	
	{x = 15.274, y = -929.401, z = 122.1278},
	{x = 2471.4819, y = -421.1803, z = 108.5721},
	{x = 2471.0205, y = -409.1674, z = 108.5722},
	{x = 2469.5918, y = -386.5188, z = 108.6527},
	{x = 2524.4438, y = -319.4345, z = 113.135},
	{x = 2499.0793, y = -418.1416, z = 113.1374},
	]] 
}

RegisterNetEvent("esx_identity:registerCallback")
AddEventHandler('esx_identity:registerCallback', function(data)
--RegisterNUICallback('register', function(data, cb)
	local reason, identity = nil, {}
	for key, value in pairs(data) do
		identity[key] = value:match("^%s*(.-)%s*$")
		if key == "firstname" or key == "lastname" then
			reason = verifyName(value, key)
			if reason then
				break
			end
		elseif key == "dateofbirth" then
			if value == "invalid" then
				reason = "Niepoprawna data urodzenia!"
				break
			end
		elseif key == "height" then
			local height = tonumber(value)
			if not height then
				reason = "Niedopuszczalny wzrost!"
				break
			elseif height > 210 or height < 140 then
				reason = "Niedopuszczalny wzrost!"
				break
			end
		end
	end

	if not reason then
		TriggerServerEvent('esx_identity:setIdentity', identity)
		EnableGui(false)
		Citizen.Wait(300)
		DoScreenFadeOut(500)
		Citizen.Wait(2500)

		-- local coords = pos[math.random(1, #pos)]
		
		ESX.Game.Teleport(PlayerPedId(), {
			x = -1042.1007,
			y = -2745.0452,
			z = 20.4103 + 0.5,
			heading = 324.12,
		}, true, function()
				DoScreenFadeIn(500)
			ESX.Scaleform.ShowFreemodeMessage('~p~AxivaRP', 'Ustaw się w dogodnym miejscu, za 30 sekund uruchomi się menu tworzenia postaci.', 10)
     			  Wait(100)
       			ESX.Scaleform.ShowFreemodeMessage('~p~AxivaRP', 'Ustaw się w dogodnym miejscu, za 20 sekund uruchomi się menu tworzenia postaci.', 10)
      			  Wait(100)
       			 ESX.Scaleform.ShowFreemodeMessage('~p~AxivaRP', 'Ustaw się w dogodnym miejscu, za 10 sekund uruchomi się menu tworzenia postaci.', 10)
      			  Wait(100)
		
			
			TriggerEvent('skinchanger:loadDefaultModel', (identity['sex']:lower() == 'm'), function()
				keepDecor = true
				TriggerEvent('esx_skin:openSaveableRestrictedMenu', FinishRegister, FinishRegister, {
					'sex',
					'skin',
					'skin_2',
					'blend_skin',
					'face',
					'face_2',
					'blend_face',
					'skin_3',
					'face_3',
					'blend',
					'eye_color',
					'nose_1',
					'nose_2',
					'nose_3',
					'nose_4',
					'nose_5',
					'nose_6',
					'eyebrow_1',
					'eyebrow_2',
					'cheeks_1',
					'cheeks_2',
					'cheeks_3',
					'lips',
					'jaw_1',
					'jaw_2',
					'chimp_1',
					'chimp_2',
					'chimp_3',
					'chimp_4',
					'neck',
					'age_1',
					'age_2',
					'sun_1',
					'sun_2',
					'moles_1',
					'moles_2',
					'complexion_1',
					'complexion_2',
					'blemishes_1',
					'blemishes_2',
					'hair_1',
					'hair_2',
					'hair_3',
					'hair_color_1',
					'hair_color_2',
					'eyebrows_1',
					'eyebrows_2',
					'eyebrows_3',
					'eyebrows_4',
					'makeup_1',
					'makeup_2',
					'makeup_3',
					'makeup_4',
					'blush_1',
					'blush_2',
					'blush_3',
					'lipstick_1',
					'lipstick_2',
					'lipstick_3',
					'lipstick_4',
					'beard_1',
					'beard_2',
					'beard_3',
					'beard_4',
					'chest_1',
					'chest_2',
					'chest_3',
					'bodyb_1',
					'bodyb_2',
					'tshirt_1',
					'tshirt_2',
					'torso_1',
					'torso_2',
					'decals_1',
					'decals_2',
					'arms',
					'arms_2',
					'pants_1',
					'pants_2',
					'shoes_1',
					'shoes_2',
					'chain_1',
					'chain_2',
					'glasses_1',
					'glasses_2',
					'helmet_1',
					'helmet_2',
					'bags_1',
					'bags_2'
				})
				ESX.SetTimeout(2000, function()
					TriggerEvent('registerCharacter')
					TriggerEvent('skinchanger:save', function()
						TriggerEvent('esx:savePlayer')
					end)
				end)
			end)		
		end)
	else
		ESX.ShowNotification(reason)
	end
end)

local Registers = {}
CreateThread(function()
	if not DecorIsRegisteredAsType("Register", 2) then
		DecorRegister("Register", 2)
	end

	while true do
		Citizen.Wait(200)

		local pid = PlayerId()
		
		for _, player in ipairs(GetActivePlayers()) do
			if player ~= pid then
				local ped = Citizen.InvokeNative(0x239528EACDC3E7DE,  player)
				if ped ~= 0 then
					local sid = GetPlayerServerId(player)
					if DecorExistOn(ped, "Register") then
						Registers[sid] = true
						Citizen.InvokeNative(0xBBDF066252829606, player, true, false)
					elseif Registers[sid] then
						Registers[sid] = nil
						Citizen.InvokeNative(0xBBDF066252829606, player, false, false)
					end
				end
			end
		end
		
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)
		if guiEnabled then
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 21,  true) -- disable sprint
			DisableControlAction(0, 24,  true) -- disable attack
			DisableControlAction(0, 25,  true) -- disable aim
			DisableControlAction(0, 47,  true) -- disable weapon
			DisableControlAction(0, 58,  true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75,  true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
		elseif keepDecor then
			local ped = PlayerPedId()
			if not DecorExistOn(ped, "Register") then
				StartRegister(ped)
			end
		end
	end
end)

function verifyName(name, what)
	local whats = {
		['firstname'] = 'imię',
		['lastname'] = 'nazwisko'
	}
	local nameLength = string.len(name)
	if nameLength < 2 then
		return 'Twoje '..whats[what]..' jest zbyt krótkie'
	end
	
	if nameLength > 25 then
		return 'Twoje '..whats[what]..' jest zbyt długie'
	end

	local count = 0
	for i in name:gmatch('[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -]') do
		count = count + 1
	end
	if count ~= nameLength then
		return 'Twoje ' .. whats[what] .. ' zawiera niedopuszczalne znaki.'
	end

	local spacesInName    = 0
	local spacesWithUpper = 0
	for word in string.gmatch(name, '%S+') do

		if string.match(word, '%u') then
			spacesWithUpper = spacesWithUpper + 1
		end

		spacesInName = spacesInName + 1
	end
	
	if spacesInName > 1 then
		return 'Twoje '..whats[what]..' zawiera więcej niż jedną spacje'
	end

	if spacesWithUpper ~= spacesInName then
		return 'Twoje '..whats[what]..' musi zaczynać się od dużej litery'
	end
end