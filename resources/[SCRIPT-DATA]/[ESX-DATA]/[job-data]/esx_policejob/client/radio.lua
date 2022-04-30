local PlayerData = {}

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
		
		Citizen.Wait(250)
	end
	
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	if PlayerData and PlayerData.inventory then
		CreateThread(function()
			Citizen.Wait(100)
			PlayerData = ESX.GetPlayerData()

			if PlayerData.inventory ~= nil then
				local found = false
				for i = 1, #PlayerData.inventory, 1 do
					if PlayerData.inventory[i].name == item.name then
						PlayerData.inventory[i] = item
						found = true
						break
					end
				end
				
				if not found then
					ESX.TriggerServerCallback('esx:isValidItem', function(status)
						if status then
							table.insert(PlayerData.inventory, item)
						end
					end, item.name)			
				end
			end
		end)
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	if PlayerData and PlayerData.inventory then
		CreateThread(function()
			Citizen.Wait(100)
			PlayerData = ESX.GetPlayerData()

			if PlayerData.inventory ~= nil then
				local found = false
				for i = 1, #PlayerData.inventory, 1 do
					if PlayerData.inventory[i].name == item.name then
						PlayerData.inventory[i] = item
						found = true
						break
					end
				end
				
				if not found then
					ESX.TriggerServerCallback('esx:isValidItem', function(status)
						if status then
							table.insert(ESX.PlayerData.inventory, item)
						end
					end, item.name)
				end
			end
		end)
	end
end)

-- RADIO ANIMATIONS -- 


local speaking = false
CreateThread(function()
	RequestAnimDict("amb@code_human_police_investigate@idle_a")
	while not HasAnimDictLoaded("amb@code_human_police_investigate@idle_a") do		
		Citizen.Wait(1)
	end

	while true do
		Citizen.Wait(1)
		if not IsPauseMenuActive() and PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sheriff') then 
			local ped = PlayerPedId()
			if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsEntityInWater(ped) and IsEntityVisible(ped)then
				if IsControlJustReleased(0, 19) or IsDisabledControlJustReleased(0, 82) and not exports['esx_policejob']:IsCuffed() then
					 ESX.TriggerServerCallback('gcphone:getItemAmount', function(qtty)
						if qtty > 0 then
							TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 8.0, 'off', 0.05)
							ClearPedTasks(ped)
							speaking = false
							TriggerServerEvent("csskrouble:walkieTalkie", false)
						end
					end, 'radio')
				else
					if IsControlJustPressed(0, 19) or IsDisabledControlJustPressed(0, 82) or (IsControlPressed(0, 249) and IsDisabledControlJustPressed(0, 81)) and not exports['esx_policejob']:IsCuffed() then
						ESX.TriggerServerCallback('gcphone:getItemAmount', function(qtty)
							if qtty > 0 then
								TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 8.0, 'on', 0.05)
								--TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.5, -1, 49, 0, 0, 0, 0)
								TaskPlayAnim(ped, "amb@code_human_police_investigate@idle_a", "idle_b", 8.0, -8, -1, 49, 0, 0, 0, 0 )
								SetCurrentPedWeapon(ped, `GENERIC_RADIO_CHATTER`, true)
								speaking = true
								TriggerServerEvent("csskrouble:walkieTalkie", true)
							end
						end, 'radio')
					end 

					if speaking then
						DisableControlAction(1, 140, true)
						DisableControlAction(1, 141, true)
						DisableControlAction(1, 142, true)
						DisablePlayerFiring(ped, true) -- Disable weapon firing
					end
				end
			end
		else
			Citizen.Wait(200)
		end
	end
end)