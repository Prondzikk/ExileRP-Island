ESX 			    			= nil
local untransformed_appleQTE    = 0
local appleQTE       			= 0
local myJob 					= nil
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local isInZone                  = false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(250)
	end
end)

CreateThread(function()
    Citizen.Wait(1000)
	for i=1, #Config.Blipy, 1 do
		local blip = AddBlipForCoord(Config.Blipy[i].Pos)

		SetBlipSprite (blip, Config.Blipy[i].Sprite)
		SetBlipDisplay(blip, Config.Blipy[i].Display)
		SetBlipScale  (blip, Config.Blipy[i].Scale)
		SetBlipColour (blip, Config.Blipy[i].Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Blipy[i].Label)
		EndTextCommandSetBlipName(blip)
	end
end)

AddEventHandler('exile_items:hasEnteredMarker', function(zone)
	if myJob == '' or myJob == '' then
		return
	end

	ESX.UI.Menu.CloseAll()
	
	if zone == 'exitedMarker' then
		CurrentAction     = zone
		CurrentActionMsg  = 'Aby zakończyć zbieranie wyjdź ze strefy zbierania'
		CurrentActionData = {}
	end
	
	if zone == 'JablkaField' then
		CurrentAction     = zone
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~ aby zbierać jabłka'
		CurrentActionData = {}
	end

	if zone == 'JablkaField2' then
		CurrentAction     = zone
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~ aby zbierać jabłka'
		CurrentActionData = {}
	end

	if zone == 'JablkaField3' then
		CurrentAction     = zone
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~ aby zbierać jabłka'
		CurrentActionData = {}
	end

	if zone == 'JablkaProcessing' then
		if untransformed_appleQTE >= 2 then
			CurrentAction     = zone
			CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~ aby przetworzyć jabłka'
			CurrentActionData = {}
		end
	end
end)

AddEventHandler('exile_items:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('exile_items:cancel')
end)

Citizen.CreateThread(function()
	while Config.Zones == nil do
		Citizen.Wait(500)
	end

	while true do
		Citizen.Wait(1)
		sleep = true
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				sleep = false
			end
		end
		if sleep then
			Wait(2000)
		end
	end
end)

RegisterNetEvent('exile_items:returnInventory')
AddEventHandler('exile_items:returnInventory', function(untransformed_appleNbr, appleNbr, jobName, currentZone)
	untransformed_appleQTE = untransformed_appleNbr
	appleQTE	   	= appleNbr
	myJob		 	= jobName
	TriggerEvent('exile_items:hasEnteredMarker', currentZone)
end)

Citizen.CreateThread(function()
	while Config.Zones == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(1000)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 2) then
				isInMarker  = true
				currentZone = k
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerServerEvent('exile_items:getInventory', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('exile_items:hasExitedMarker', lastZone)
		end

		if isInMarker and isInZone then
			TriggerEvent('exile_items:hasEnteredMarker', 'exitedMarker')
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, 38) then
				isInZone = true
				if CurrentAction == 'exitedMarker' then
					isInZone = false
					TriggerEvent('exile_items:hasExitedMarker', lastZone)
					Citizen.Wait(15000)
				elseif CurrentAction == 'JablkaField' then
					TriggerServerEvent('exile_items:startZbieranie')
				elseif CurrentAction == 'JablkaField2' then
					TriggerServerEvent('exile_items:startZbieranie')
				elseif CurrentAction == 'JablkaField3' then
					TriggerServerEvent('exile_items:startZbieranie')
				elseif CurrentAction == 'JablkaProcessing' then
					TriggerServerEvent('exile_items:startPrzetwarzanie')
				else
					isInZone = false
				end
				
				CurrentAction = nil
			end
		end
	end
end)