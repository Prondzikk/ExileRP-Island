ESX = nil
PlayerData = {}
OrganizationBlip = {}
local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local isUsing = false
local zoneName = nil
local HaveBagOnHead = false

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
		
		Citizen.Wait(250)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
	refreshBlip()
	
end)

if Config.EnableNPC then
  Citizen.CreateThread(function()
    Citizen.Wait(1)
    spawnDrugQuestNPC()
  end)
end

function spawnDrugQuestNPC()
	for k,v in pairs(Config.JobLocation) do
		local ped = GetHashKey(Config.JobPed)
		RequestModel(ped)
		while not HasModelLoaded(ped) do 
				Citizen.Wait(1)
		end
		npc = CreatePed(4, ped, v.x, v.y, v.z, v.h, false, true)
		SetEntityInvincible(npc, true)
		FreezeEntityPosition(npc, true)
		TaskSetBlockingOfNonTemporaryEvents(npc, true)
	end
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlip()
	refreshBlip()
end)

RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
	PlayerData.hiddenjob = hiddenjob
	deleteBlip()
	refreshBlip()
end)


function refreshBlip()
	if PlayerData.hiddenjob ~= nil and Config.Blips[PlayerData.hiddenjob.name] then
		local blip = AddBlipForCoord(Config.Blips[PlayerData.hiddenjob.name])
		SetBlipSprite (blip, 438)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 6)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Dom organizacji")
		EndTextCommandSetBlipName(blip)
		table.insert(OrganizationBlip, blip)
	end
end

function deleteBlip()
	if OrganizationBlip[1] ~= nil then
		for i=1, #OrganizationBlip, 1 do
			RemoveBlip(OrganizationBlip[i])
			table.remove(OrganizationBlip, i)
		end
	end
end

AddEventHandler('exile_organizations:hasEnteredMarker', function(zone)
	if zone == 'Cloakroom' then
		CurrentAction = 'cloakroom'
		CurrentActionMsg  = _U('cloakroom_menu', PlayerData.hiddenjob.label)
		CurrentActionData = {}
	elseif zone =='Inventory' then
		CurrentAction = 'inventory'
		CurrentActionMsg  = _U('inventory_menu', PlayerData.hiddenjob.label)
		CurrentActionData = {}
	-- elseif zone == 'Weapons' then
	-- 	CurrentAction = 'weapons'
	-- 	CurrentActionMsg  = _U('weapons_menu', PlayerData.hiddenjob.label)
	-- 	CurrentActionData = {}
	elseif zone == 'Licenses' then
		CurrentAction = 'licenses'
		CurrentActionMsg  = _U('licenses_menu', PlayerData.hiddenjob.label)
		CurrentActionData = {}
	--[[elseif zone == 'Shop' then
		CurrentAction = 'shop'
		CurrentActionMsg  = _U('shop_menu', PlayerData.hiddenjob.label)
		CurrentActionData = {}]]
	elseif zone == 'BossMenu' then
		CurrentAction = 'boss_menu'
		CurrentActionMsg  = _U('boss_menu', PlayerData.hiddenjob.label)
		CurrentActionData = {}
	elseif zone == 'OpiumMenu' then
		CurrentAction = 'opium_menu'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~, aby przekazać klucze do przeróbki opium"
		CurrentActionData = {}
	elseif zone == 'ExctasyMenu' then
		CurrentAction = 'exctasy_menu'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~, aby przekazać klucze do przeróbki ekstazy"
		CurrentActionData = {}
	elseif zone == 'Barabasz' then
		CurrentAction = 'barabasz_kurwa'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~, aby uleczyć się u medyka"
		CurrentActionData = {}
	elseif zone == 'FixMenu' then
		CurrentAction = 'FixMenu_ast'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~, aby skorzystać z mechanika"
		CurrentActionData = {}
	elseif zone == 'Blachy' then
		CurrentAction = 'Blachy'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~, aby wybić blachy w pojeździe"
		CurrentActionData = {}
	elseif zone == 'MainMenu' then
		CurrentAction = 'MainMenu'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~, aby otworzyć główne menu organizacji"
		CurrentActionData = {}
	end
end)

AddEventHandler('exile_organizations:hasExitedMarker', function(zone)
	if isUsing then
		isUsing = false
		TriggerServerEvent('exile:setUsed', zoneName, 'society_'..PlayerData.hiddenjob.name, false)
	end
	zoneName = nil
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Display markers
CreateThread(function()
	while true do
		Citizen.Wait(3)
		if PlayerData.hiddenjob ~= nil then
			if Config.Zones[PlayerData.hiddenjob.name] then
				local coords, letSleep = GetEntityCoords(PlayerPedId()), true
				for k,v in pairs(Config.Zones[PlayerData.hiddenjob.name]) do
					if #(coords - v.coords) < Config.DrawDistance then
						letSleep = false
						ESX.DrawMarker(v.coords)
					end
				end
				if PlayerData.hiddenjob.name == Config.OpiumMenu.owner and PlayerData.hiddenjob.grade >= Config.OpiumMenu.from then
					if #(coords - Config.OpiumMenu.coords) < Config.DrawDistance then
						letSleep = false
						ESX.DrawMarker(Config.OpiumMenu.coords)
					end
				end
				if PlayerData.hiddenjob.name == Config.ExctasyMenu.owner and PlayerData.hiddenjob.grade >= Config.ExctasyMenu.from then
					if #(coords - Config.ExctasyMenu.coords) < Config.DrawDistance then
						letSleep = false
						ESX.DrawMarker(Config.ExctasyMenu.coords)
					end
				end
				if letSleep then
					Citizen.Wait(1000)
				end
			else
				Citizen.Wait(5000)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Enter / Exit marker events
CreateThread(function()
	while true do
		Citizen.Wait(2000)

		if PlayerData.hiddenjob ~= nil then
			if Config.Zones[PlayerData.hiddenjob.name] then
				local coords      = GetEntityCoords(PlayerPedId())
				local isInMarker  = false
				local currentZone = nil

				for k,v in pairs(Config.Zones[PlayerData.hiddenjob.name]) do
					if #(coords - v.coords) < 1.5 then
						isInMarker  = true
						currentZone = k
					end
				end
				
				if PlayerData.hiddenjob.name == Config.OpiumMenu.owner and PlayerData.hiddenjob.grade >= Config.OpiumMenu.from then
					if #(coords - Config.OpiumMenu.coords) < 1.5 then
						isInMarker  = true
						currentZone = 'OpiumMenu'
					end
				end
				if PlayerData.hiddenjob.name == Config.ExctasyMenu.owner and PlayerData.hiddenjob.grade >= Config.ExctasyMenu.from then
					if #(coords - Config.ExctasyMenu.coords) < 1.5 then
						isInMarker  = true
						currentZone = 'ExctasyMenu'
					end
				end

				if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
					HasAlreadyEnteredMarker = true
					LastZone                = currentZone
					TriggerEvent('exile_organizations:hasEnteredMarker', currentZone)
				end

				if not isInMarker and HasAlreadyEnteredMarker then
					HasAlreadyEnteredMarker = false
					TriggerEvent('exile_organizations:hasExitedMarker', LastZone)
				end
			else
				Citizen.Wait(5000)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Key Controls
CreateThread(function()
	while true do
		Citizen.Wait(3)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and PlayerData.hiddenjob and Config.Zones[PlayerData.hiddenjob.name] then

				if CurrentAction == 'cloakroom' then
					OpenCloakroomMenu('society_' .. PlayerData.hiddenjob.name)
				elseif CurrentAction == 'inventory' then
					ESX.TriggerServerCallback('exile_organizations:getLicenses', function(licenses)
						if licenses.items == 1 then
							ESX.TriggerServerCallback('exile:isUsed', function(isUsed)
								if not isUsed then
									isUsing = true
									TriggerServerEvent('exile:setUsed', 'Inventories', 'society_'..PlayerData.hiddenjob.name, true)
									zoneName = 'Inventories'
									OpenInventoryMenu('society_' .. PlayerData.hiddenjob.name)
								else
									ESX.ShowNotification("~r~Ktoś właśnie używa tej szafki")
								end
							end, 'Inventories', 'society_' .. PlayerData.hiddenjob.name)
						else
							ESX.ShowNotification('~r~Twoja organizacja nie ma wykupionego dostępu do szafki')
						end
					end, 'society_' .. PlayerData.hiddenjob.name)
				elseif CurrentAction == 'MainMenu' then
					OpenJakJaKurwaNieNawidzeJebanegoFalsiakaMenu(PlayerData.hiddenjob.name)
				elseif CurrentAction == 'licenses' then
					if PlayerData.hiddenjob.grade >= Config.Zones[PlayerData.hiddenjob.name].Licenses.from then
						OpenLicensesMenu('society_' .. PlayerData.hiddenjob.name)
					else
						ESX.ShowNotification("~r~Nie jesteś osobą, która może korzystać z licencji!")
					end
				elseif CurrentAction == 'boss_menu' then
					OpenBossMenu(PlayerData.hiddenjob.name, Config.Zones[PlayerData.hiddenjob.name].BossMenu.from)
				elseif CurrentAction == 'opium_menu' then
					OpenOpiumMenu()
				elseif CurrentAction == 'exctasy_menu' then
					OpenExctasyMenu()
				elseif CurrentAction == 'barabasz_kurwa' then
					BarabaszHeal()
				elseif CurrentAction == 'FixMenu_ast' then
					FixMenu()
				elseif CurrentAction == 'Blachy' then
					exports['ExileRP']:WybijBlachyMenu()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if PlayerData.hiddenjob and Config.Zones[PlayerData.hiddenjob.name] then
			if not IsPedInAnyVehicle(PlayerPedId()) then
				if IsControlJustReleased(0, 168) and not exports['esx_policejob']:IsCuffed() and GetEntityHealth(PlayerPedId()) >= 1 then
					ESX.TriggerServerCallback('exile_organizations:getLicenses', function(licenses)
						if licenses.menuf7 == 1 then
							OpenActionsMenu()
						else
							ESX.ShowNotification('~r~Twoja organizacja nie ma wykupionego dostępu do menu interakcji!')
						end
					end, 'society_' .. PlayerData.hiddenjob.name)
				end
			else
				Wait(500)
			end
		else
			Wait(500)
		end
	end
end)

function FixMenu()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanik_org_git',
		{
			title    = "Mechanik",
			align    = 'center',
			elements = {
				{label = "Naprawa mechaniczna", value = 1},
				{label = "Naprawa karoseri", value = 2},
			},
		}, function(data, menu)
			local r = data.current.value
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				if r == 1 then
					local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					if GetVehicleEngineHealth(vehicle) < 1000 then
						menu.close()
						TriggerServerEvent('__orgs:mechanik')
						for i=10,0,-1 do
							ESX.ShowHelpNotification('~y~Trwa naprawa...~s~ ' .. i .. '~b~ sekund')
							Citizen.Wait(1000)
						end
						FixMenu()
						SetVehicleEngineHealth(vehicle, 1000)
						SetVehicleEngineOn(vehicle, true, true )
						ESX.ShowNotification('~g~Naprawiono pojazd')
					else
						ESX.ShowNotification('~r~Pojazd nie wymaga naprawy')
					end
				elseif r == 2 then
					menu.close()
					local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					local health = GetVehicleEngineHealth(vehicle)
					TriggerServerEvent('__orgs:mechanik')
					for i=10,0,-1 do
						ESX.ShowHelpNotification('~y~Trwa naprawa...~s~ ' .. i .. '~b~ sekund')
						Citizen.Wait(1000)
					end
					SetVehicleFixed(vehicle)
					Citizen.Wait(300)
					SetVehicleEngineHealth(vehicle, health)
					SetVehicleEngineOn(vehicle, true, true )
					FixMenu()
					ESX.ShowNotification('~g~Naprawiono pojazd')
				end
			else
				menu.close()
			end
			
		end, function(data, menu)
			menu.close()
		end)
	else
		ESX.ShowNotification('~r~Musisz być w pojeździe')
	end
end

function BarabaszHeal()
	if not IsPedInAnyVehicle(PlayerPedId(), false) and GetEntityHealth(PlayerPedId()) < 200 then
		ESX.TriggerServerCallback('exile_organizations:hypexreviveblack', function (cb)
			if cb then
				DoScreenFadeOut(300)
				Citizen.Wait(1000)
				exports["exile_taskbar"]:taskBar(30000, "JESTEŚ OPATRYWANY", false, true)	
				TriggerEvent('hypex_ambulancejob:hypexreviveblack')
				Citizen.Wait(500)
				ExecuteCommand('e otrzepanie')
			end
		end)
	else
		ESX.ShowNotification('~r~Aby skorzystać z pomocy medycznej musisz mieć ~g~2000$ ~r~na koncie i być rannym.')
	end
end


function OpenOpiumMenu()
	local playerCoords = GetEntityCoords(PlayerPedId())
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'opium_menu',
	{
		title    = "Przeróbka kokainy - zarządzanie",
		align    = 'center',
		elements = {
			{label = "Rozdane klucze", value = 'used'},
			{label = "Przekaż klucz", value = 'give_key'},
		}
	}, function(data, menu)
		menu.close()
		if data.current.value == 'used' then
			ESX.TriggerServerCallback('exile_organizations:getOpiumPermissions', function(cb)
				if cb[1] ~= nil then
					local elements2 = {
						head = {'Imię', 'Nazwisko', 'Do kiedy', 'Akcje'},
						rows = {}
					}
					for i=1, #cb, 1 do
						table.insert(elements2.rows, {
							data = cb[i].owner,
							cols = {
								cb[i].firstname,
								cb[i].lastname,
								cb[i].endTime,
								'{{' .. "Odbierz dostęp" .. '|hire}}'
							}
						})
					end
					ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'opium_list', elements2, function(data2, menu2)
						if data2.value == 'hire' then
							menu2.close()
							TriggerServerEvent('exile_organizations:removeOpiumPermission', data2.data)
							Citizen.Wait(300)
							OpenOpiumMenu()
						end
					end, function(data2, menu2)
						menu2.close()
						OpenOpiumMenu()
					end)
				else
					ESX.ShowNotification("~b~Brak rozdanych kluczy do przeróbki")
				end
			end)
		elseif data.current.value == 'give_key' then
			local playersInArea = ESX.Game.GetPlayersInArea(playerCoords, 5.0)
			local elements      = {}
			for i=1, #playersInArea, 1 do
				if playersInArea[i] ~= PlayerId() then
					table.insert(elements, {label = GetPlayerServerId(playersInArea[i]), value = GetPlayerServerId(playersInArea[i])})
				end
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_key',
			{
				title    = "Osoby w pobliżu",
				align    = 'center',
				elements = elements,
			}, function(data2, menu2)
				menu2.close()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_key',
				{
					title    = "Czas",
					align    = 'center',
					elements = {
						{label = "1 dzień", value = 1},
						{label = "3 dni", value = 3},
						{label = "7 dni", value = 7}
					},
				}, function(data3, menu3)
					menu3.close()
					TriggerServerEvent('exile_organizations:opiumPermission', data2.current.value, data3.current.value)
				end, function(data3, menu3)
					menu3.close()
					OpenOpiumMenu()
				end)
			end, function(data2, menu2)
				menu2.close()
				OpenOpiumMenu()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenExctasyMenu()
	local playerCoords = GetEntityCoords(PlayerPedId())
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'exctasy_menu',
	{
		title    = "Przeróbka ekstazy - zarządzanie",
		align    = 'center',
		elements = {
			{label = "Rozdane klucze", value = 'used'},
			{label = "Przekaż klucz", value = 'give_key'},
		}
	}, function(data, menu)
		menu.close()
		if data.current.value == 'used' then
			ESX.TriggerServerCallback('exile_organizations:getExctasyPermissions', function(cb)
				if cb[1] ~= nil then
					local elements2 = {
						head = {'Imię', 'Nazwisko', 'Do kiedy', 'Akcje'},
						rows = {}
					}
					for i=1, #cb, 1 do
						table.insert(elements2.rows, {
							data = cb[i].owner,
							cols = {
								cb[i].firstname,
								cb[i].lastname,
								cb[i].endTime,
								'{{' .. "Odbierz dostęp" .. '|hire}}'
							}
						})
					end
					ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'exctasy_list', elements2, function(data2, menu2)
						if data2.value == 'hire' then
							menu2.close()
							TriggerServerEvent('exile_organizations:removeExctasyPermission', data2.data)	
							Citizen.Wait(300)	
							OpenExctasyMenu()
						end
					end, function(data2, menu2)
						menu2.close()
						OpenExctasyMenu()
					end)
				else
					ESX.ShowNotification("~b~Brak rozdanych kluczy do przeróbki")
				end
			end)
		elseif data.current.value == 'give_key' then
			local playersInArea = ESX.Game.GetPlayersInArea(playerCoords, 5.0)
			local elements      = {}
			for i=1, #playersInArea, 1 do
				if playersInArea[i] ~= PlayerId() then
					table.insert(elements, {label = GetPlayerServerId(playersInArea[i]), value = GetPlayerServerId(playersInArea[i])})
				end
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_key',
			{
				title    = "Osoby w pobliżu",
				align    = 'center',
				elements = elements,
			}, function(data2, menu2)
				menu2.close()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_key',
				{
					title    = "Czas",
					align    = 'center',
					elements = {
						{label = "1 dzień", value = 1},
						{label = "3 dni", value = 3},
						{label = "7 dni", value = 7}
					},
				}, function(data3, menu3)
					menu3.close()
					TriggerServerEvent('exile_organizations:ExctasyPermission', data2.current.value, data3.current.value)
				end, function(data3, menu3)
					menu3.close()
					OpenExctasyMenu()
				end)
			end, function(data2, menu2)
				menu2.close()
				OpenExctasyMenu()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

local bagonhead = false
local enabled = false
local bag = nil
local isdead = false

function OpenActionsMenu()
	ESX.UI.Menu.CloseAll()
	local ped = PlayerPedId()
	local elements = {
		{label = "Kajdanki", value = 'handcuffs'},
		{label = "Napraw pojazd", value = 'repair'},
		{label = "Użyj wytrychu", value = 'wytrych'},
		{label = "Worek", value = 'worek'}
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'actions_menu',
	{
		title    = PlayerData.hiddenjob.label,
		align    = 'center',
		elements = elements
	}, function(data, menu)			
		if (data.current.value == 'handcuffs') then
			menu.close()
			TriggerEvent('Kajdanki')
		elseif (data.current.value == 'repair') then
			menu.close()
			TriggerServerEvent('exile:pay', 1000)
			TriggerEvent('esx_mechanikjob:onFixkit', 1000.0, 15000)
		elseif (data.current.value == 'wytrych') then
			TriggerServerEvent('exile:pay', 1500)
			menu.close()
			TriggerEvent('esx_mechanicjob:onHijack')
		elseif (data.current.value == 'worek') then
			menu.close()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'actions_menu',
			{
				title    = PlayerData.hiddenjob.label,
				align    = 'center',
				elements = {
					{label = "Załóż", value = 'puton'},
					{label = "Zdejmij", value = 'putoff'},
				}
			}, function(data2, menu2)
				if data2.current.value == 'puton' then
					ESX.TriggerServerCallback('org:getItemAmount', function(qtty)
						if qtty > 0 then
							local player, distance = ESX.Game.GetClosestPlayer()
							local idkurwy = GetPlayerServerId(GetPlayerIndex())
							if distance ~= -1 and distance <= 1.0 then
								if not IsPedSprinting(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedRunning(PlayerPedId()) then
									TriggerServerEvent('atlantisHeadbag:setbagon', GetPlayerServerId(player), idkurwy, 'puton')
								end
							else
								ESX.ShowNotification('Brak graczy w pobliżu.')
							end
						else
							ESX.ShowNotification('~r~Nie posiadasz przy sobie worka!')
						end
					end, 'worek')
				elseif data2.current.value == 'putoff' then
					local player, distance = ESX.Game.GetClosestPlayer()
					local idkurwy = GetPlayerServerId(GetPlayerIndex())
					if distance ~= -1 and distance <= 1.0 then
						if not IsPedSprinting(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedRunning(PlayerPedId()) then
							TriggerServerEvent('atlantisHeadbag:setbagon', GetPlayerServerId(player), idkurwy, 'putoff')
						end
					else
						ESX.ShowNotification('Brak graczy w pobliżu.')
					end
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end


RegisterNetEvent('atlantisHeadbag:setbag')
AddEventHandler('atlantisHeadbag:setbag', function(idkurwy, corobi)
	local _idkurwy = idkurwy
	if bagonhead and corobi == 'putoff' then
		bagonhead = false
		TriggerEvent('atlantisHeadbag:display', false)
		TriggerServerEvent('atlantisHeadbag:itemhuj', _idkurwy, 'give')
		TriggerServerEvent('atlantisHeadbag:woreknaleb', _idkurwy, 0)
	elseif not bagonhead and corobi == 'puton' then
		bagonhead = true
		TriggerEvent('atlantisHeadbag:display', true)
		TriggerServerEvent('atlantisHeadbag:itemhuj', _idkurwy, 'remove')
		TriggerServerEvent('atlantisHeadbag:woreknaleb', _idkurwy, 1)
	end
end)

RegisterNetEvent('atlantisHeadbag:kurwodajitem')
AddEventHandler('atlantisHeadbag:kurwodajitem', function(gowno)
	local co = gowno
	if co == 'give' then
		TriggerServerEvent('atlantisHeadbag:item', 'give')
	elseif co == 'remove' then
		TriggerServerEvent('atlantisHeadbag:item', 'remove')
	end
end)

RegisterNetEvent('atlantisHeadbag:display')
AddEventHandler('atlantisHeadbag:display', function(value)
	local ped = PlayerPedId()
	if value == true then
		SetPedComponentVariation(ped, 1, 69, 1, 1)
		enabled = true
	elseif value == false then
		bagonhead = false
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		enabled = false
	end
  SendNUIMessage({
    display = enabled
  })
end)

function IsWorek()
	return bagonhead
end

CreateThread(function()
	while true do
		Citizen.Wait(1500)
		if bagonhead then
			if IsPedSprinting(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			end
			if IsPedJumping(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			end
			if IsPedInMeleeCombat(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			end
			if IsPedHurt(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			end
		else
		Citizen.Wait(500)
		end
	end
end)

AddEventHandler('playerSpawned', function()
	bagonhead = false
	isdead = false
	DeleteEntity(bag)
	SetEntityAsNoLongerNeeded(bag)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isdead = true
	local ped = PlayerPedId()
	SetPedComponentVariation(ped, 1, 0, 0, 0)
	  SendNUIMessage({
    display = false
  })
end)

function OpenInventoryMenu(organization)
	local elements = {
		{label = "Włóż", value = 'deposit'},
		{label = "Włóż wszystko", value = 'depositall'}
	}
	if PlayerData.hiddenjob.grade >= Config.Zones[PlayerData.hiddenjob.name].Inventory.from then
		table.insert(elements, {label = "Wyciągnij", value = 'withdraw'})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory',
	{
		title    = 'Magazyn',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'withdraw' then
			TriggerEvent('exile:getInventoryItem', organization)
		elseif data.current.value == 'depositall' then
			TriggerEvent('exile:putInventoryItems', organization)
		else
			TriggerEvent('exile:putInventoryItem', organization)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenJakJaKurwaNieNawidzeJebanegoFalsiakaMenu(organization)
	local elements = {
		{label = "Magazyn", value = 'storage'},
		{label = "Zarządzanie", value = 'managment'},
	}
	if PlayerData.hiddenjob.grade >= Config.Zones[PlayerData.hiddenjob.name].Licenses.from then
		table.insert(elements, {label = "Abonamenty", value = 'licenses'})
	end
	table.insert(elements, {label = "Włóż wszystko", value = 'depositall'})
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mejn',
	{
		title    = 'Organizacja',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'storage' then
			OpenInventoryMenu('society_' .. PlayerData.hiddenjob.name)
		elseif data.current.value == 'managment' then
			OpenBossMenu(PlayerData.hiddenjob.name, Config.Zones[PlayerData.hiddenjob.name].MainMenu.from)
		elseif data.current.value == "licenses" then
			OpenLicensesMenu('society_' .. PlayerData.hiddenjob.name)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenLicensesMenu(society)
	ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('exile_organizations:getLicenses', function(licenses)
		local elements = {
			head = {'Poziom', 'Szafka', 'Szatnia Premium', 'Sejf', 'Interakcje', 'Akcje'},
			rows = {}
		}
		local level = tostring(licenses.level)
		local available = {}
		local items = nil
		if licenses.items == 0 then
			items = '❌'
			table.insert(available, {label = "Szafka", value = 'items', price = 500000})
		elseif licenses.items == 1 then
			items = '✔️ <br>'
		end
		local addoncloakroom = nil
		if licenses.addoncloakroom == 0 then
			addoncloakroom = '❌'
			table.insert(available, {label = "Szatnia Premium", value = 'addoncloakroom', price = 250000})
		elseif licenses.addoncloakroom == 1 then
			addoncloakroom = '✔️ <br>'
		end
		local safe = nil
		if licenses.safe == 0 then
			safe = '❌'
			table.insert(available, {label = "Sejf", value = 'safe', price = 500000})
		elseif licenses.safe == 1 then
			safe = '✔️ <br>'
		end
		local menuf7 = nil
		if licenses.menuf7 == 0 then
			menuf7 = '❌'
			table.insert(available, {label = "Menu interakcji", value = 'menuf7', price = 1000000})
		elseif licenses.menuf7 == 1 then
			menuf7 = '✔️ <br>'
		end
		table.insert(elements.rows, {
			data = tonumber(level),
			cols = {
				level .. " <br>" .. tonumber(level) * 5 .. " osób",
				items,
				addoncloakroom,
				safe,
				menuf7,
				'{{' .. "Podnieś poziom" .. '|upgrade}} {{' .. "Wykup dostęp" .. '|buy}}'
			}
		})
		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'organizations', elements, function(data, menu)
			if data.value == 'upgrade' then
				if data.data >= 20 then
					ESX.ShowNotification('~r~Osiągnąłeś już maksymalny poziom organizacji')
				else
					menu.close()
					local nextLevel = data.data + 1
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'nextlevel', {
						title    = 'Czy na pewno? ',
						align    = 'bottom-right',
						elements = {
							{label = 'Nie',  value = 'no'},
							{label = 'Tak (<span style="color:yellowgreen;">500 000$</span>)',  value = 'yes'},
						}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
							menu2.close()
							TriggerServerEvent('exile_organizations:upgradeOrganization', 'level', nextLevel, society, 500000)
						else
							menu2.close()
						end
					end, function(data2, menu2)
						menu2.close()
						OpenLicensesMenu(society)
					end)
				end
			elseif data.value == 'buy' then
				menu.close()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'upgrade', {
					title    = 'Co chcesz wykupić?',
					align    = 'bottom-right',
					elements = available
				}, function(data2, menu2)
					menu2.close()
					local price = ESX.Math.GroupDigits(data2.current.price)
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'yesorno', {
						title = "Czy na pewno?",
						align = 'bottom-right',
						elements = {
							{label = 'Nie',  value = 'no'},
							{label = 'Tak (<span style="color:yellowgreen;">'..price..'$</span>)',  value = 'yes'},
						}
					}, function(data3, menu3)
						if data3.current.value == 'yes' then
							menu3.close()
							TriggerServerEvent('exile_organizations:upgradeOrganization', data2.current.value, 1, society, data2.current.price)
						else
							menu3.close()
						end
					end, function(data3, menu3)
						menu3.close()
						OpenLicensesMenu(society)
					end)
				end, function(data2, menu2)
					menu2.close()
					OpenLicensesMenu(society)
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, society)
end

function OpenCloakroomMenu(organization)
	ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('exile_organizations:getLicenses', function(licenses)
		local elements = {
			{ label = 'Ubrania prywatne', value = 'player_dressing' },
			{ label = 'Skin Menu', value = 'skin_menu'}
		}
		if licenses.addoncloakroom == 1 then
			table.insert(elements, { label = 'Przeglądaj ubrania', value = 'przegladaj_ubrania' })
			if PlayerData.hiddenjob.grade >= 3 then
				table.insert(elements, {
					label = ('<span style="color:yellowgreen;">Dodaj ubranie</span>'),
					value = 'zapisz_ubranie' 
				})
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory',
		{
			title    = 'Garderoba',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			if data.current.value == 'przegladaj_ubrania' then
				ESX.TriggerServerCallback('exile_organizacje:getPlayerDressing', function(dressing)
					elements = nil
					local elements = {}
					for i=1, #dressing, 1 do
						table.insert(elements, {
							label = dressing[i],
							value = i
						})
					end
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wszystkie_ubrania', {
						title    = ('Ubrania'),
						align    = 'top',
						elements = elements
					}, function(data2, menu2)
					
						local elements2 = {
							{ label = ('Ubierz ubranie'), value = 'ubierz_sie' },
						}
						if PlayerData.hiddenjob.grade >= 3 then
							table.insert(elements2, {
								label = ('<span style="color:red;"><b>Usuń ubranie</b></span>'),
								value = 'usun_ubranie' 
							})
						end
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'edycja_ubran', {
						title    = ('Ubrania'),
						align    = 'top',
						elements = elements2
					}, function(data3, menu3)
							if data3.current.value == 'ubierz_sie' then
								menu3.close()
								TriggerEvent('skinchanger:getSkin', function(skin)
									ESX.TriggerServerCallback('exile_organizacje:getPlayerOutfit', function(clothes)
										TriggerEvent('skinchanger:loadClothes', skin, clothes)
										TriggerEvent('esx_skin:setLastSkin', skin)
										ESX.ShowNotification('~g~Pomyślnie zmieniłeś swój ubiór!')
										ClearPedBloodDamage(playerPed)
										ResetPedVisibleDamage(playerPed)
										ClearPedLastWeaponDamage(playerPed)
										ResetPedMovementClipset(playerPed, 0)
										TriggerEvent('skinchanger:getSkin', function(skin)
											TriggerServerEvent('esx_skin:save', skin)
										end)
									end, data2.current.value, organization)
								end)
							end
							if data3.current.value == 'usun_ubranie' then
								menu3.close()
								menu2.close()
								TriggerServerEvent('exile_organizacje:removeOutfit', data2.current.value, organization)
								ESX.ShowNotification('~r~Pomyślnie usunąłeś ubiór o nazwie: ~y~' .. data2.current.label)
							end
						end, function(data3, menu3)
							menu3.close()
						end)
						
					end, function(data2, menu2)
						menu2.close()
					end)
				end, organization)
			end
			if data.current.value == 'player_dressing' then
				ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
					local elements2 = {}
					for k,v in pairs(dressing) do
						table.insert(elements2, {label = v, value = k})
					end
					
					menu.close()
					
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dress_menu',{
						title    = 'Garderoba',
						align    = 'left',
						elements = elements2
					}, function(data2, menu2)	
						menu2.close()
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing_opts', {
							title = 'Wybierz ubranie - ' .. data2.current.label,
							align = 'center',
							elements = {
								{label = 'Ubierz', value = 'wear'},
								{label = 'Zmień nazwę', value = 'rename'},
								{label = 'Usuń ubranie', value = 'remove'}
							}
						}, function(data3, menu3)
							menu3.close()
							if data3.current.value == 'wear' then
								TriggerEvent('skinchanger:getSkin', function(skin)
									ESX.TriggerServerCallback('esx_property:getPlayerOutfit', function(clothes)
										TriggerEvent('skinchanger:loadClothes', skin, clothes)
										TriggerEvent('esx_skin:setLastSkin', skin)

										TriggerEvent('skinchanger:getSkin', function(skin)
											TriggerServerEvent('esx_skin:save', skin)
										end)
									end, data2.current.value)
								end)
								
								menu2.open()
							elseif data3.current.value == 'rename' then
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'player_dressing_rename', {
									title = 'Zmień nazwę - ' .. data2.current.label
								}, function(data4, menu4)
									menu4.close()
									menu.open()
									TriggerServerEvent('esx_property:renameOutfit', data2.current.value, data4.value)
									ESX.ShowNotification('Zmieniono nazwę ubrania!')
								end, function(data4, menu4)
									menu4.close()
									menu3.open()
								end)
							elseif data3.current.value == 'remove' then
								TriggerServerEvent('esx_property:removeOutfit', data2.current.value)
								ESX.ShowNotification('Ubranie usunięte z Twojej garderoby: ' .. data2.current.label)
								menu.open()
							end
						end, function(data3, menu3)
							menu3.close()
							menu2.open()
						end)		
					end, function(data2, menu2)
						menu2.close()
						menu.open()
					end)
				end)
			end
			if data.current.value == 'skin_menu' then
				TriggerEvent('exile_organizations:openSkinMenu')
			end
			if data.current.value == 'zapisz_ubranie' then
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'nazwa_ubioru', {
					title = ('Nazwa ubioru')
				}, function(data2, menu2)
					ESX.UI.Menu.CloseAll()
	
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('exile_organizacje:saveOutfit', data2.value, skin, organization)
						ESX.ShowNotification('~g~Pomyślnie zapisano ubiór o nazwie: ~y~' .. data2.value)
					end)
		
				end, function(data2, menu2)
					menu2.close()
					
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, organization)
end

--[[local winable_weapons = {
	[1] = 'WEAPON_PISTOL',
	[2] = 'WEAPON_PISTOL_MK2',
	[3] = 'WEAPON_SNSPISTOL_MK2',
	[4] = 'WEAPON_VINTAGEPISTOL',
	[5] = 'WEAPON_SNSPISTOL',
}
local label_weapons = {
	['WEAPON_PISTOL'] = 'Pistolet',
	['WEAPON_PISTOL_MK2'] = 'Pistolet MK2',
	['WEAPON_SNSPISTOL_MK2'] = 'SNS Pistol MK2',
	['WEAPON_VINTAGEPISTOL'] = 'Vintage pistol',
	['WEAPON_SNSPISTOL'] = 'Pistolet SNS',
}
function OpenShopMenu(organization)
	ESX.TriggerServerCallback('exile_organizations:getshopWeapon', function(result)
		local elements = {}

		if not result then
			table.insert(elements, {label = 'Wybierz nową broń (500.000$)', value = 'new'})
		else
			table.insert(elements, {label = 'Dostepna broń: ' .. label_weapons[result], value = result})
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_shop', {
			title    = "Sklep "..PlayerData.hiddenjob.label,
			align    = 'center',
			elements = elements,
		}, function(data, menu)
				local r = data.current.value
				if r == 'new' then
					local ananas = winable_weapons[math.random(1, #winable_weapons)]
					TriggerServerEvent('esx_organizations:newweapon', PlayerData.hiddenjob.name, ananas)
					menu.close()
				else
					TriggerServerEvent('esx_organizations:buyWeaponShop', PlayerData.hiddenjob.name, r)
				end
		  end,
		  function(data, menu)
				menu.close()
		  end
		)
	end, PlayerData.hiddenjob.name)
end]]

function OpenBossMenu(organization, grade)
	ESX.TriggerServerCallback('exile_organizations:getLicenses', function(licenses)
		if licenses.safe == 1 then
			if PlayerData.hiddenjob.grade >= grade then
				TriggerEvent('esx_society:openHiddenBossMenu', organization, licenses.level, function(data, menu)
					menu.close()
				end, { showmoney = true, withdraw = true, deposit = true, wash = false, employees = true })
			else
				TriggerEvent('esx_society:openHiddenBossMenu', organization, licenses.level, function(data, menu)
					menu.close()
				end, { showmoney = false, withdraw = false, deposit = true, wash = false, employees = false })
			end
		else
			ESX.ShowNotification('~y~Aby wpłacać lub wypłacać pieniądze z sejfu, pierw musisz go wykupić!')
			if PlayerData.hiddenjob.grade >= grade then
				TriggerEvent('esx_society:openHiddenBossMenu', organization, licenses.level, function(data, menu)
					menu.close()
				end, { showmoney = false, withdraw = false, deposit = false, wash = false, employees = true })
			else
				TriggerEvent('esx_society:openHiddenBossMenu', organization, licenses.level, function(data, menu)
					menu.close()
				end, { showmoney = false, withdraw = false, deposit = false, wash = false, employees = false })
			end
		end
	end, 'society_' .. organization)
end

local WeaponsList = {
	['pistolmk2'] = 'WEAPON_PISTOL_MK2',
	['pistol'] = 'WEAPON_PISTOL',
	['snspistol'] = 'WEAPON_SNSPISTOL',
	['snspistolmk2'] = 'WEAPON_SNSPISTOL_MK2',
	['vintagepistol'] = 'WEAPON_VINTAGEPISTOL',
}

RegisterNetEvent('exile_organizations:checkSelectedWeapon')
AddEventHandler('exile_organizations:checkSelectedWeapon', function()
	local ped = PlayerPedId()
	local currentWeaponHash = GetSelectedPedWeapon(ped)
	local ammo = GetAmmoInPedWeapon(playerPed, currentWeaponHash)
	local foundWeapon = nil
	local foundItem = nil
	local found = false
	if currentWeaponHash ~= `WEAPON_UNARMED` then
		for k,v in pairs(WeaponsList) do
			if GetHashKey(v) == currentWeaponHash then
				if ammo >= 100 then
					found = true
					foundWeapon = k
					foundItem = v
					break
				else
					ESX.ShowNotification('~r~Potrzebujesz 100 amunicji, aby zapakować tą broń do walizki')
				end
			end
		end
		if found then
			TriggerServerEvent('exile_organizations:spawnWalizka', foundWeapon, foundItem)
		else
			ESX.ShowNotification('~r~Nie możesz zapakować tej broni do walizki')
		end
	else
		ESX.ShowNotification('~r~Nie wybrałeś broni, którą chcesz schować')
	end
end)

RegisterNetEvent("exile_organizations:openSkinMenu")
AddEventHandler("exile_organizations:openSkinMenu", function()
	ESX.TriggerServerCallback('exile_organizations:checkmoneyforskin', function(hasEnoughMoney)
		if hasEnoughMoney then
			TriggerEvent('esx_skin:openSaveableMenu')
			ESX.ShowNotification('Pobrano ~r~1500$ ~w~za przebranie')
		else
			ESX.ShowNotification('~r~Nie posiadasz wystarczająco gotówki')
		end
	end)
end)