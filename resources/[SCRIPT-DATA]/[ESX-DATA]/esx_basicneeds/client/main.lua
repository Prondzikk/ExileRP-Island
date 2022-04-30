ESX                = nil
local IsAnimated   = false
local EnergyThread = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 1800000)
	TriggerEvent('esx_status:set', 'thirst', 1800000)
end)

AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'hunger', 1800000, {255, 210, 0}, true, function(status)
		local t = 500
		status.remove(t)
		TriggerEvent('HUD:Update', {
			Hunger = status.getPercent()
		})
	end, function(status)
		TriggerEvent('HUD:Update', {
			Hunger = status.getPercent()
		})
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1800000, {0, 198, 255}, true, function(status)
		local t = 500
		status.remove(t)
		TriggerEvent('HUD:Update', {
			Water = status.getPercent()
		})
	end, function(status)
		TriggerEvent('HUD:Update', {
			Water = status.getPercent()
		})
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			if not GetPlayerInvincible(PlayerId()) then
				local playerPed  = PlayerPedId()
				local prevHealth = GetEntityHealth(playerPed)
				local health     = prevHealth

				TriggerEvent('esx_status:getStatus', 'hunger', function(status)
					if status.val == 0 then
						if prevHealth <= 50 then
							health = health - 5
						elseif prevHealth <= 150 then
							health = health - 3
						else
							health = health - 1
						end
					end
				end)

				TriggerEvent('esx_status:getStatus', 'thirst', function(status)
					if status.val == 0 then
						if prevHealth <= 50 then
							health = health - 5
						elseif prevHealth <= 150 then
							health = health - 3
						else
							health = health - 1
						end
					end
				end)

				if health ~= prevHealth then
					SetEntityHealth(playerPed, health)
					AnimpostfxPlay('MP_Celeb_Preload_Fade', 1000, false)
				end
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 3600000)
	TriggerEvent('esx_status:set', 'thirst', 3600000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

RegisterNetEvent('itemki-roza')
AddEventHandler('itemki-roza', function()
	local playerPed = PlayerPedId()
	local coords	= GetEntityCoords(playerPed)
	local boneIndex = GetPedBoneIndex(playerPed, 57005)
	
	RequestAnimDict('amb@code_human_wander_drinking@beer@male@base')
	while not HasAnimDictLoaded('amb@code_human_wander_drinking@beer@male@base') do
		Citizen.Wait(1)
	end
	
	ESX.Game.SpawnObject('p_single_rose_s', {
		x = coords.x,
		y = coords.y,
		z = coords.z + 2
	}, function(object)
		AttachEntityToEntity(object, playerPed, boneIndex, 0.10, 0, -0.001, 80.0, 150.0, 200.0, true, true, false, true, 1, true)
		TaskPlayAnim(playerPed, "amb@code_human_wander_drinking@beer@male@base", "static", 3.5, -8, -1, 49, 0, 0, 0, 0)
		Citizen.Wait(60000)
		DeleteObject(object)
		ClearPedSecondaryTask(playerPed)
	end)
end)


RegisterNetEvent('itemki-kocyk')
AddEventHandler('itemki-kocyk', function()
	local playerPed = PlayerPedId()
	local coords	= GetEntityCoords(playerPed)

	ESX.Game.SpawnObject('prop_yoga_mat_03',  {
		x = coords.x,
		y = coords.y,
		z = coords.z - 1
	}, function(object)
	end)
	ESX.Game.SpawnObject('prop_yoga_mat_03',  {
		x = coords.x,
		y = coords.y - 0.9,
		z = coords.z - 1
	}, function(object)
	end)
	ESX.Game.SpawnObject('prop_yoga_mat_03',  {
		x = coords.x,
		y = coords.y + 0.9,
		z = coords.z - 1
	}, function(object)
	end)
	ESX.Game.SpawnObject('prop_champset',  {
		x = coords.x,
		y = coords.y,
		z = coords.z - 1
	}, function(object)
	end)
end)


RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
    if not IsAnimated then
		local playerPed  = PlayerPedId()
    	IsAnimated = true

        RequestAnimDict('mp_player_inteat@burger')
        while not HasAnimDictLoaded('mp_player_inteat@burger') do
            Citizen.Wait(1)
        end

        TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8.0, -1, 48, 0.0, false, false, false)
        Citizen.Wait(8000)

        IsAnimated = false
        ClearPedSecondaryTask(playerPed)
	end
end)

RegisterNetEvent('esx_basicneeds:chipsy')
AddEventHandler('esx_basicneeds:chipsy', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex = GetPedBoneIndex(playerPed, 57005)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_cs_crisps_01', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
			while not HasAnimDictLoaded('amb@code_human_wander_eating_donut@male@idle_a') do
				Citizen.Wait(1)
			end

			TaskPlayAnim(playerPed, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", 3.5, -8.0, -1, 48, 0.0, false, false, false)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)
			Citizen.Wait(3000)

			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:apple')
AddEventHandler('esx_basicneeds:apple', function(prop_name)
    if not IsAnimated then
		local playerPed  = PlayerPedId()
    	IsAnimated = true

        RequestAnimDict('mp_player_inteat@burger')
        while not HasAnimDictLoaded('mp_player_inteat@burger') do
            Citizen.Wait(1)
        end

        TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8.0, -1, 48, 0.0, false, false, false)
        Citizen.Wait(8000)

        IsAnimated = false
        ClearPedSecondaryTask(playerPed)
	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_ld_flow_bottle', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(1)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(4000)

	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:milk')
AddEventHandler('esx_basicneeds:milk', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_cs_milk_01', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(1)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.09, -0.075, 0.055, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(4000)

	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkKawa')
AddEventHandler('esx_basicneeds:onDrinkKawa', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_ld_flow_bottle', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(1)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(3000)

	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
			
			local player = PlayerId()
			local timer = 0
			while timer < 900 do
				ResetPlayerStamina(player)
				SetRunSprintMultiplierForPlayer(player, 1.3)
				Citizen.Wait(2000)
				timer = timer + 2
				SetRunSprintMultiplierForPlayer(player, 1.0)
			end
		end)
	end
end)


RegisterNetEvent('esx_basicneeds:onDrinkKawa2')
AddEventHandler('esx_basicneeds:onDrinkKawa2', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_ld_flow_bottle', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(1)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(3000)

	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
			
			local player = PlayerId()
			local timer = 0
			while timer < 1500 do
				ResetPlayerStamina(player)
				Citizen.Wait(2000)
				timer = timer + 2
			end
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onEnergy')
AddEventHandler('esx_basicneeds:onEnergy', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_energy_drink', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(1)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, "mp_player_intdrink", "loop_bottle", 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(3000)

			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
			local player = PlayerId()
 
			SetRunSprintMultiplierForPlayer(player, 1.1)
			Citizen.Wait(10 * 60000)

			SetRunSprintMultiplierForPlayer(player, 1.0)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onEnergy2')
AddEventHandler('esx_basicneeds:onEnergy2', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_energy_drink', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(1)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, "mp_player_intdrink", "loop_bottle", 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(3000)

			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
			local player = PlayerId()
 
			SetRunSprintMultiplierForPlayer(player, 1.2)
			Citizen.Wait(10 * 60000)

			SetRunSprintMultiplierForPlayer(player, 1.0)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:donut')
AddEventHandler('esx_basicneeds:donut', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex = GetPedBoneIndex(playerPed, 57005)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_donut_02', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
			while not HasAnimDictLoaded('amb@code_human_wander_eating_donut@male@idle_a') do
				Citizen.Wait(1)
			end

			TaskPlayAnim(playerPed, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", 3.5, -8.0, -1, 48, 0.0, false, false, false)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)
			Citizen.Wait(8000)

			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:juice')
AddEventHandler('esx_basicneeds:juice', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_food_cb_juice01', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(1)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.04, -0.117, 0.100, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(4000)

	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:sandwich')
AddEventHandler('esx_basicneeds:sandwich', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex = GetPedBoneIndex(playerPed, 57005)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_sandwich_01', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
			while not HasAnimDictLoaded('amb@code_human_wander_eating_donut@male@idle_a') do
				Citizen.Wait(1)
			end

			TaskPlayAnim(playerPed, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", 3.5, -8.0, -1, 48, 0.0, false, false, false)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)
			Citizen.Wait(8000)

			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:hamburger')
AddEventHandler('esx_basicneeds:hamburger', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex = GetPedBoneIndex(playerPed, 57005)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_cs_burger_01', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
			while not HasAnimDictLoaded('amb@code_human_wander_eating_donut@male@idle_a') do
				Citizen.Wait(1)
			end

			TaskPlayAnim(playerPed, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", 3.5, -8.0, -1, 48, 0.0, false, false, false)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)
			Citizen.Wait(8000)

			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
		end)
	end
end)