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

local isLoadoutLoaded, isPaused, isDead = false, false, false
local lastLoadout = {}

CreateThread(function()
	while true do
		Citizen.Wait(1)

		if Citizen.InvokeNative(0xB8DFD30D6973E135, PlayerId()) then
			TriggerServerEvent('esx:onPlayerJoined')
			break
		end
	end
end)

ESX.UI.HUD.DisplayTicket = function(position)
	-- puste
  end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	ESX.PlayerLoaded = true
	ESX.PlayerData = playerData
	local loadingPosition = (ESX.PlayerData.coords or {x = -1042.28, y = -2745.42, z = 20.40})
	ESX.UI.HUD.DisplayTicket(0)

	--PVP
	SetCanAttackFriendly(playerPed, true, false)
	NetworkSetFriendlyFireOption(true)
	
	--Wanted LVL
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned')
	TriggerServerEvent('esx_inventoryhud:getOwnedSim')
	isLoadoutLoaded = true
	DecorRegister('isSpawned', 2)
	TriggerEvent('esx:restoreLoadout')
	
	Citizen.Wait(2000)
	CreateThread(function()
		local status = 0
		while true do
			if status == 0 then
				status = 1
				TriggerEvent('misiaczek:load', function(result)
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
		Citizen.Wait(100)
		for k, v in ipairs(playerData.inventory) do
			if v.slot then
	
				SendNUIMessage({
					action = 'updateSlot',
					slot = v.slot,
					name = v.name
				})
			end
		end
	end)			
	SetWeaponsNoAutoswap(false)
	StartServerSyncLoops()
end)



AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerServerEvent('esx_inventoryhud:getOwnedSim')
	end
end)

AddEventHandler('esx:onPlayerSpawn', function() 
	isDead = false 
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true 
end)

AddEventHandler('skinchanger:loadDefaultModel', function() 
	isLoadoutLoaded = false 
end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(100)
	end

	TriggerEvent('esx:restoreLoadout')
end)

AddEventHandler('esx:restoreLoadout', function()
	local playerPed = PlayerPedId()
	local ammoTypes = {}
	
	Citizen.InvokeNative(0xF25DF915FA38C5F3, playerPed, true)

	for k,v in ipairs(ESX.PlayerData.loadout) do
		local weaponName = v.name
		local weaponHash = GetHashKey(weaponName)

		Citizen.InvokeNative(0xBF0FD6E56C964FCB, playerPed, weaponHash, 0, false, false)
		SetPedWeaponTintIndex(playerPed, weaponHash, v.tintIndex)

		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

		for k2,v2 in ipairs(v.components) do
			local componentHash = ESX.GetWeaponComponent(weaponName, v2).hash

			GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
		end

		if not ammoTypes[ammoType] then
			AddAmmoToPed(playerPed, weaponHash, v.ammo)
			ammoTypes[ammoType] = true
		end
	end

	isLoadoutLoaded = true
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for k,v in ipairs(ESX.PlayerData.accounts) do
		if v.name == account.name then
			ESX.PlayerData.accounts[k] = account
			break
		end
	end
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count, showNotification, weapon)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			ESX.UI.ShowInventoryItemNotification(true, v.label, count - v.count)
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
	
	-- ESX.TriggerServerCallback('esx:getPlayerData', function(value)
		-- if value ~= nil then
			-- ESX.PlayerData.loadout = value.loadout
		-- end
	-- end)
	
	if weapon ~= nil then
		ESX.PlayerData.loadout = weapon
	end

	if showNotification then
		ESX.UI.ShowInventoryItemNotification(true, item, count)
	end

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count, showNotification, weapon)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			if v.name == "pistol_ammo" then 
			else
				ESX.UI.ShowInventoryItemNotification(false, v.label, v.count - count)
			end
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
	
	-- ESX.TriggerServerCallback('esx:getPlayerData', function(value)
		-- if value ~= nil then
			-- ESX.PlayerData.loadout = value.loadout
		-- end
	-- end)
	
	if weapon ~= nil then
		ESX.PlayerData.loadout = weapon
	end

	if showNotification then
		if v.name == "pistol_ammo" then 
		else
			ESX.UI.ShowInventoryItemNotification(false, item, count)
		end
	end

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)



RegisterNetEvent('esx:addToSlot')
AddEventHandler('esx:addToSlot', function(name, slot)
	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == name then
			SendNUIMessage({
				action = 'updateSlot',
				slot = ESX.PlayerData.inventory[i].slot,
				name = nil
			})
			ESX.PlayerData.inventory[i].slot = slot
			Citizen.Wait(20)
			SendNUIMessage({
				action = 'updateSlot',
				slot = slot,
				name = name
			})
			break
		end
	end

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:removeFromSlot')
AddEventHandler('esx:removeFromSlot', function(name)
	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == name then
			SendNUIMessage({
				action = 'updateSlot',
				slot = ESX.PlayerData.inventory[i].slot,
				name = nil
			})
			ESX.PlayerData.inventory[i].slot = false
			break
		end
	end

	local weapon = exports['esx_weaponsync']:IsWeapon(name)
	if weapon then
		local playerPed, weaponHash = PlayerPedId(), GetHashKey(weapon)
		if GetSelectedPedWeapon(playerPed) == weaponHash then
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
		end
	end

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
	ESX.PlayerData.hiddenjob = hiddenjob
end)


CreateThread(function()
	while true do
		Citizen.Wait(1)

		if IsControlJustReleased(0, 289) then
			if IsInputDisabled(0) and not isDead and not ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
				ESX.ShowInventory()
			end
		end
		
		if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
			if IsControlPressed(0, Keys['LEFTALT']) then
				local bind = nil
				for i, key in ipairs({157, 158, 160, 164, 165}) do
					DisableControlAction(0, key, true)
						if IsDisabledControlJustPressed(0, key) then
							bind = i
						break
					end
				end

				if bind then
					local menu = ESX.UI.Menu.GetOpened('default', 'es_extended', 'inventory')
					local elements = menu.data.elements
					local xddd = true
					for i=1, #elements, 1 do
						if elements[i].selected then
							if elements[i].usable or (tostring(elements[i].value) == tostring('pistol') or tostring(elements[i].value) == tostring('machete') or tostring(elements[i].value) == tostring('pistol_mk2') or tostring(elements[i].value) == tostring('combatpistol') or tostring(elements[i].value) == tostring('snspistol') or tostring(elements[i].value) == tostring('snspistol_mk2') or tostring(elements[i].value) == tostring('vintagepistol') or tostring(elements[i].value) == tostring('heavypistol') or tostring(elements[i].value) == tostring('stungun') or tostring(elements[i].value) == tostring('pistol50') or tostring(elements[i].value) == tostring('revolver_mk2') or tostring(elements[i].value) == tostring('knife') or tostring(elements[i].value) == tostring('nightstick') or tostring(elements[i].value) == tostring('appistol') or tostring(elements[i].value) == tostring('crowbar') or tostring(elements[i].value) == tostring('golfclub') or tostring(elements[i].value) == tostring('switchblade') or tostring(elements[i].value) == tostring('minismg') or tostring(elements[i].value) == tostring('combatpdw') or tostring(elements[i].value) == tostring('ceramicpistol') or tostring(elements[i].value) == tostring('smg_mk2') or tostring(elements[i].value) == tostring('hatchet') or tostring(elements[i].value) == tostring('bat') or tostring(elements[i].value) == tostring('assaultrifle') or tostring(elements[i].value) == tostring('carbinerifle') or tostring(elements[i].value) == tostring('smg') or tostring(elements[i].value) == tostring('hatchet') or tostring(elements[i].value) == tostring('compactrifle')) then
								ESX.ShowNotification('Ustawiono ~y~'..elements[i].label..'~s~ na pozycję ~o~'..bind)							
								TriggerServerEvent('esx:addToSlot', bind, elements[i].value)
								SendNUIMessage({
									action = 'updateSlot',
									slot = bind,
									name = elements[i].value
								})		
									ESX.ShowInventory()
								else
								ESX.ShowNotification('Nie możesz ustawić ~y~'..elements[i].label)
							end
						end
					end
				end
			end		
		end
	end
end)

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	if weaponHash == 0 then
		-- nil
	elseif not isDead then	
		Citizen.InvokeNative(0x14E56BC5B5DB6A19, playerPed, weaponHash, 0)
		Citizen.InvokeNative(0xBF0FD6E56C964FCB, playerPed, weaponHash, ammo, false, false)
	end
end)

RegisterNetEvent('esx:addWeaponComponent')
AddEventHandler('esx:addWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:setWeaponAmmo')
AddEventHandler('esx:setWeaponAmmo', function(weaponName, weaponAmmo)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	if weaponHash ~= 0 then
		Citizen.InvokeNative(0x14E56BC5B5DB6A19, playerPed, weaponHash, weaponAmmo)
	end
end)

RegisterNetEvent('esx:setWeaponTint')
AddEventHandler('esx:setWeaponTint', function(weaponName, weaponTintIndex)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	SetPedWeaponTintIndex(playerPed, weaponHash, weaponTintIndex)
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	
	if weaponHash == 0 then
	
	else
		Citizen.InvokeNative(0x4899CB088EDF59B8, playerPed, weaponHash)
	end
end)

RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(coords)
	local playerPed = PlayerPedId()

	-- ensure decmial number
	coords.x = coords.x + 0.0
	coords.y = coords.y + 0.0
	coords.z = coords.z + 0.0

	ESX.Game.Teleport(playerPed, coords)
end)

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(vehicleName)
	local model = (type(vehicleName) == 'number' and vehicleName or GetHashKey(vehicleName))

	if IsModelInCdimage(model) then
		local playerPed = PlayerPedId()
		local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)

		ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end)
	else
		TriggerEvent('chat:addMessage', {args = {'^1SYSTEM', 'Invalid vehicle model.'}})
	end
end)

RegisterNetEvent('esx:spawnObject')
AddEventHandler('esx:spawnObject', function(model, coords)
	ESX.Game.SpawnObject(model, coords)
end)

RegisterNetEvent('esx:registerSuggestions')
AddEventHandler('esx:registerSuggestions', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function(radius)
	local playerPed = PlayerPedId()

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
				ESX.Game.DeleteVehicle(entity)
			end
		end
	else
		local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(playerPed, true) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			ESX.Game.DeleteVehicle(vehicle)
		end
	end
end)

RegisterNetEvent('esx_weashop:clipcli')
AddEventHandler('esx_weashop:clipcli', function()
	local playerPed = PlayerPedId()
	local loadout = {}
	local countweapons = {}
	local currentweapon = nil
	for k,v in ipairs(ESX.PlayerData.loadout) do
		loadout[v.id] = {v.ammo, v.sellected, v.name} 
		
		if not countweapons[v.name] then
			countweapons[v.name] = 1
		else
			countweapons[v.name] = countweapons[v.name] + 1
		end
	end

	if DoesEntityExist(playerPed) then
		local status, weaponHash = GetCurrentPedWeapon(playerPed, true)
		local weapon = ESX.GetWeaponFromHash(weaponHash)
		if status == 1 then
			if weapon then
				local weapon = ESX.GetWeaponFromHash(weaponHash)
				if countweapons[weapon.name] then
					if countweapons[weapon.name] > 1 then
						local foundselected = false
						for k,v in pairs(loadout) do
							if v[2] == true and GetHashKey(v[3]) == weaponHash then
								foundselected = true
								currentweapon = {k, v[1], v[2], v[3]}
								if last == nil then
									last = v[1]
								end
								break
							end
						end
						
						if currentweapon ~= nil then
							local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)	
							for j,d in ipairs(ESX.PlayerData.loadout) do
								if d.id == currentweapon[1] then
									d.ammo = ammo + 32
								end
							end	

							TriggerServerEvent('esx_weashop:remove')							
						end								
					else
						for k,v in pairs(loadout) do
							if weaponHash == GetHashKey(v[3]) then
								foundselected = true
								currentweapon = {k, v[1], v[2], v[3]}
								if last == nil then
									last = v[1]
								end
								break							
							end
						end
						
						local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)	
						for j,d in ipairs(ESX.PlayerData.loadout) do
							if GetHashKey(d.name) == weaponHash then
								d.ammo = ammo + 32
							end
						end	

						TriggerServerEvent('esx_weashop:remove')							
					end
				end
			else
				ESX.ShowNotification("Nie posiadasz broni w ręce")
			end
		else
			ESX.ShowNotification("Nie posiadasz broni w ręce")
		end
	end		
end)

function StartServerSyncLoops()

	CreateThread(function()
		while true do
			Citizen.Wait(5000)
	
			local playerPed      = PlayerPedId()
			local loadout        = {}
			local loadoutChanged = false
	
			for k,v in ipairs(Config.Weapons) do
				local weaponName = v.name
				local weaponHash = GetHashKey(weaponName)
				local weaponComponents = {}
				local tint = 0
	
				if HasPedGotWeapon(playerPed, weaponHash, false) and weaponName ~= 'WEAPON_UNARMED' then
					local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
	
					for k2,v2 in ipairs(v.components) do
						if HasPedGotWeaponComponent(playerPed, weaponHash, v2.hash) then
							table.insert(weaponComponents, v2.name)
						end
					end

					if GetPedWeaponTintIndex(playerPed, weaponHash) > 0 then
						tint = GetPedWeaponTintIndex(playerPed, weaponHash)
					end
	
					if not lastLoadout[weaponName] or lastLoadout[weaponName] ~= ammo then
						loadoutChanged = true
					end
	
					lastLoadout[weaponName] = ammo
	
					table.insert(loadout, {
						name = weaponName,
						ammo = ammo,
						label = v.label,
						components = weaponComponents,
						tintIndex = tint
					})
				else
					if lastLoadout[weaponName] then
						loadoutChanged = true
					end
	
					lastLoadout[weaponName] = nil
				end
			end
	
			if loadoutChanged and isLoadoutLoaded then
				ESX.PlayerData.loadout = loadout
				TriggerServerEvent('esx:updateLoadout', loadout)
			end
		end
	end)

	CreateThread(function()
		local previousCoords = vector3(ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z)

		while true do
			Citizen.Wait(5000)
			local playerPed = PlayerPedId()

			if DoesEntityExist(playerPed) then
				local playerCoords = GetEntityCoords(playerPed)
				local distance = #(playerCoords - previousCoords)

				if distance > 5 then
					previousCoords = playerCoords
					local playerHeading = ESX.Math.Round(GetEntityHeading(playerPed), 1)
					local formattedCoords = {x = ESX.Math.Round(playerCoords.x, 1), y = ESX.Math.Round(playerCoords.y, 1), z = ESX.Math.Round(playerCoords.z, 1), heading = playerHeading}
					TriggerServerEvent('esx:updateCoords', formattedCoords)
				end
			end
		end
	end)
	
end

Citizen.CreateThread(function()
	for i = 1, 5 do
		RegisterCommand('+use_slot' .. i, function()
			local playerPed = PlayerPedId()

			if not exports['esx_policejob']:IsCuffed() and not IsPauseMenuActive() and not isDead and not IsControlPressed(0, 19) then
				if not IsDisabledControlPressed(0, 37) and not IsControlPressed(0, 37) then
					local item = ESX.GetItemFromSlot(i)
					if item then
						local weapon = exports['esx_weaponsync']:IsWeapon(item.name)
						if weapon then
							local weaponHash = GetHashKey(weapon)
							if GetSelectedPedWeapon(playerPed) == weaponHash then
								ESX.ShowNotification('Schowałeś/aś ~r~'..item.label)
								SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
							else
								ESX.ShowNotification('Wyciągnąłeś/aś ~g~'..item.label)
								SetCurrentPedWeapon(playerPed, weaponHash, true)
								SetPedCurrentWeaponVisible(playerPed, true, false, false, false)
							end
						else
							TriggerServerEvent('esx:useItem', item.name)
						end
					end
				end
			end
		end)
		
		RegisterKeyMapping('+use_slot' .. i, 'Użyj slota ' .. i, 'keyboard', tostring(i))
	end
end)
