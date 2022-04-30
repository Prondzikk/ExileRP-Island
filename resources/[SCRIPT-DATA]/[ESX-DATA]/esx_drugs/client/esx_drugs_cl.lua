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

ESX 			    			= nil
local cokeQTE       			= 0
local coke_poochQTE 			= 0
local weedQTE					= 0
local weed_poochQTE 			= 0
local methQTE					= 0
local meth_poochQTE 			= 0
local opiumQTE					= 0
local opium_poochQTE 			= 0
local mdp2pQTE					= 0
local exctasyQTE				= 0
local myJob 					= nil
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local isInZone                  = false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local drunk 					= 0
local cooldown = false

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
	Citizen.Wait(5000)
end)

AddEventHandler('esx_drugs:enteredMarker', function(zone)
	if myJob == 'police' or myJob == 'ambulance' or myJob == 'offpolice' or myJob == 'offambulance' then
		return
	end

	if IsPedInAnyVehicle(PlayerPedId(), false) then
		return
	end

	ESX.UI.Menu.CloseAll()

	if zone == 'exitMarker' then
		CurrentAction     = zone
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~ aby przerwać ~y~czynność~s~'
		CurrentActionData = {}
	end

	if zone == 'CokeField' then
		CurrentAction     = zone
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby zbierać narkotyk'
		CurrentActionData = {}
	end

	if zone == 'CokeProcessing' then
		if cokeQTE >= 2 then
			CurrentAction     = zone
			CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby przerabiać narkotyk'
			CurrentActionData = {}
		end
	end

	if zone == 'MethField' then
		CurrentAction     = zone
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby zbierać narkotyk'
		CurrentActionData = {}
	end

	if zone == 'MethProcessing' then
		if methQTE >= 2 then
			CurrentAction     = zone
			CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby przerabiać narkotyk'
			CurrentActionData = {}
		end
	end

	if zone == 'WeedField' then
	 	CurrentAction     = zone
	 	CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby zbierać narkotyk'
	 	CurrentActionData = {}
	end

	if zone == 'WeedProcessing' then
	 	if weedQTE >= 2 then
	 		CurrentAction     = zone
	 		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby przerabiać narkotyk'
	 		CurrentActionData = {}
		end
	end

	if zone == 'OpiumField' then
		CurrentAction     = zone
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby zbierać narkotyk'
		CurrentActionData = {}
	end

	if zone == 'OpiumProcessing' then
		if opiumQTE >= 2 then
			CurrentAction     = zone
			CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby przerabiać narkotyk'
			CurrentActionData = {}
		end
	end

	if zone == 'ExctasyField' then
		CurrentAction     = zone
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby zbierać narkotyk'
		CurrentActionData = {}
	end

	if zone == 'ExctasyProcessing' then
		if mdp2pQTE >= 2 then
			CurrentAction     = zone
			CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~, aby przerabiać narkotyk'
			CurrentActionData = {}
		end
	end
end)

AddEventHandler('esx_drugs:exitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent(GetCurrentResourceName() .. ':stopPickup', zone)
	TriggerServerEvent(GetCurrentResourceName() .. ':stopTransform', zone)
	
	cooldown = true
	Citizen.Wait(10000)
	cooldown = false
end)

function Normal()
  CreateThread(function()
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, -1)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		SetPedIsDrug(playerPed, false)
		SetPedMotionBlur(playerPed, false)
	end)
end

function overdose()
	CreateThread(function()
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, -1)
		Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, playerPed, 0)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0)
		SetPedIsDrug(playerPed, false)
		SetPedMotionBlur(playerPed, false)
	end)
end
-- Render markers
CreateThread(function()
	while Config.Zones == nil do
		Citizen.Wait(500)
	end

	while true do
		Citizen.Wait(1)
		sleep = true
		local coords = GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, -1))
		for k,v in pairs(Config.Zones) do
			local distance = #(coords - vec3(v.x, v.y, v.z))
			if(distance < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, true, 2, false, false, false, false)
				sleep = false
			end
		end
		if sleep then
			Wait(2000)
		end
	end
end)

-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('esx_drugs:returnInventory')
AddEventHandler('esx_drugs:returnInventory', function(count, itemName, itemRequired, jobName, currentZone)
	if itemName == 'coke' then
		cokeQTE	   	  = count
	elseif itemName == 'coke_pooch' then
		cokeQTE = itemRequired
		coke_poochQTE = count
	elseif itemName == 'meth' then
		methQTE = count
	elseif itemName == 'meth_pooch' then
		methQTE = itemRequired
		meth_poochQTE = count
	elseif itemName == 'weed' then
		weedQTE = count
	elseif itemName == 'weed_pooch' then
		weedQTE = itemRequired
		weed_poochQTE = count
	elseif itemName == 'opium' then
		opiumQTE = count
	elseif itemName == 'opium_pooch' then
		opiumQTE = itemRequired
		opium_poochQTE = count
	elseif itemName == 'mdp2p' then
		mdp2pQTE = count
	elseif itemName == 'exctasy_pooch' then
		mdp2pQTE = itemRequired
		exctasyQTE = count
	end
	myJob		 = jobName
	TriggerEvent('esx_drugs:enteredMarker', currentZone)
end)

-- Activate menu when player is inside marker
CreateThread(function()
	while Config.Zones == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(400)

		local coords      = GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, -1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			local distance = #(coords - vec3(v.x, v.y, v.z))
			if(distance <= Config.ZoneSize.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerServerEvent('esx_drugs:getInventory', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_drugs:exitedMarker', lastZone)
		end

		if isInMarker and isInZone then
			TriggerEvent('esx_drugs:enteredMarker', 'exitMarker')
		end
	end
end)

-- Key Controls
CreateThread(function()
	while true do
		Citizen.Wait(2)
		if CurrentAction ~= nil then
			if cooldown == false then
				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(PlayerPedId(), false) then
					isInZone = true
					if CurrentAction == 'exitMarker' then
						isInZone = false
						TriggerEvent('esx_drugs:freeze', false)
						TriggerEvent('esx_drugs:exitedMarker', lastZone)
						Citizen.Wait(2500)
					elseif CurrentAction == 'CokeField' then
						TriggerServerEvent(GetCurrentResourceName() .. ':pickup', 'coke')
					elseif CurrentAction == 'CokeProcessing' then
						TriggerServerEvent(GetCurrentResourceName() .. ':transform', 'coke', 'coke')
					elseif CurrentAction == 'MethField' then
						TriggerServerEvent(GetCurrentResourceName() .. ':pickup', 'meth')
					elseif CurrentAction == 'MethProcessing' then
						TriggerServerEvent(GetCurrentResourceName() .. ':transform', 'meth', 'meth')
					elseif CurrentAction == 'WeedField' then
						TriggerServerEvent(GetCurrentResourceName() .. ':pickup', 'weed')
					elseif CurrentAction == 'WeedProcessing' then
						TriggerServerEvent(GetCurrentResourceName() .. ':transform', 'weed', 'weed')
					elseif CurrentAction == 'OpiumField' then
						TriggerServerEvent(GetCurrentResourceName() .. ':pickup', 'opium')
					elseif CurrentAction == 'OpiumProcessing' then
						TriggerServerEvent(GetCurrentResourceName() .. ':transform', 'opium', 'opium')
					elseif CurrentAction == 'ExctasyField' then
						TriggerServerEvent(GetCurrentResourceName() .. ':pickup', 'exctasy')
					elseif CurrentAction == 'ExctasyProcessing' then
						TriggerServerEvent(GetCurrentResourceName() .. ':transform', 'exctasy', 'exctasy')
					else
						isInZone = false
					end

					if isInZone then
						TriggerEvent('esx_drugs:freeze', true)
					end

					CurrentAction = nil
				end
			else
				SetTextComponentFormat('STRING')
				AddTextComponentString("~r~Jesteś na cooldownie!")
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		else
			Wait(200)
		end
	end
end)

RegisterNetEvent('esx_drugs:freeze')
AddEventHandler('esx_drugs:freeze', function(freeze)
	FreezeEntityPosition(Citizen.InvokeNative(0x43A66C31C68491C0, -1), freeze)
end)

RegisterNetEvent('xlem0n_drugs:cigarette')
AddEventHandler('xlem0n_drugs:cigarette', function()
	local playerPed = PlayerPedId()
	
	CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)
	end)
end)