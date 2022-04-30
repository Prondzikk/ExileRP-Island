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

local PlayerData				= {}
local FirstSpawn				= true
local IsDead					= false
local TimerThreadId	   = nil
local DistressThreadId	= nil
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}
local IsBusy					= false
local CurrentTask = {}
local Melee = { `WEAPON_UNARMED`, `WEAPON_KNUCKLE`, `WEAPON_BAT`, `WEAPON_FLASHLIGHT`, `WEAPON_HAMMER`, `WEAPON_CROWBAR`, `WEAPON_PIPEWRENCH`, `WEAPON_NIGHTSTICK`, `WEAPON_GOLFCLUB`, `WEAPON_WRENCH` }
local Knife = { `WEAPON_KNIFE`, `WEAPON_DAGGER`, `WEAPON_MACHETE`, `WEAPON_HATCHET`, `WEAPON_SWITCHBLADE`, `WEAPON_BATTLEAXE`, `WEAPON_BATTLEAXE`, `WEAPON_STONE_HATCHET` }
local Bullet = { `WEAPON_SNSPISTOL`, `WEAPON_SNSPISTOL_MK2`, `WEAPON_PISTOL50`, `WEAPON_VINTAGEPISTOL`, `WEAPON_PISTOL`, `WEAPON_MILITARYRIFLE`, `WEAPON_PISTOL_MK2`, `WEAPON_DOUBLEACTION`, `WEAPON_COMBATPISTOL`, `WEAPON_HEAVYPISTOL`, `WEAPON_DBSHOTGUN`, `WEAPON_SAWNOFFSHOTGUN`, `WEAPON_PUMPSHOTGUN`, `WEAPON_PUMPSHOTGUN_MK2`, `WEAPON_BULLPUPSHOTGUN`, `WEAPON_MICROSMG`, `WEAPON_SMG`, `WEAPON_SMG_MK2`, `WEAPON_ASSAULTSMG`, `WEAPON_COMBATPDW`, `WEAPON_GUSENBERG`, `WEAPON_COMPACTRIFLE`, `WEAPON_ASSAULTRIFLE`, `WEAPON_CARBINERIFLE`, `WEAPON_MARKSMANRIFLE`, `WEAPON_SNIPERRIFLE`, `WEAPON_1911PISTOL` }
local Electricity = { `WEAPON_STUNGUN` }
local Animal = { -100946242, 148160082 }
local FallDamage = { -842959696 }
local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local Gas = { -1600701090 }
local Burn = { 615608432, 883325847, -544306709 }
local Drown = { -10959621, 1936677264 }
local Car = { 133987706, -1553120962 }
local SamsBlip = {}
local tekst = 0
local isUsing = false
ESX								= nil

--[[function isDead()
	return IsDead
end]]

function getDeathStatus()
	return IsDead
end

function checkArray(array, val)
	for _, value in ipairs(array) do
		local v = value
		if type(v) == 'string' then
			v = GetHashKey(v)
		end

		if v == val then
			return true
		end
	end

	return false
end

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 255)
	SetTextOutline()

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 270
	DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
end

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


function cleanPlayer(playerPed)
	Citizen.InvokeNative(0xCEA04D83135264CC, playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	Citizen.InvokeNative(0x239528EACDC3E7DE,  ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, heading)
	TriggerEvent('esx:onPlayerSpawn', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
	ESX.UI.Menu.CloseAll()
	
	EndDeathCam()
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(_type)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)
	if _type == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth , math.floor(health + maxHealth/4))
		Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, playerPed, newHealth)
	elseif _type == 'big' then
		Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, playerPed, maxHealth)
	end
	
	ESX.ShowNotification(_U('healed'))
end)

RegisterNetEvent('esx_ambulancejob:healitem')
AddEventHandler('esx_ambulancejob:healitem', function(_type)
	local playerPed = PlayerPedId()
	local health = GetEntityHealth(playerPed)
	local maxHealth = GetEntityMaxHealth(playerPed)

	if not isUsing then
		if _type == 'bsmall' then
			if health <= 100 then 
				isUsing = true
				ESX.UI.Menu.CloseAll()
				local newHealth = health + 50
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, true)
				TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
				
				exports['ExileRP']:DrawProcent(300, function()
					Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, playerPed, newHealth)
					FreezeEntityPosition(playerPed, false)
					ClearPedTasks(playerPed)
					isUsing = false				
					ESX.ShowNotification(_U('healed'))
				end)
			else
				ESX.ShowNotification('Nie potrzebujesz bandażu.')
			end
		elseif _type == 'bmedium' then
			isUsing = true
			ESX.UI.Menu.CloseAll()
			ClearPedTasks(playerPed)
			FreezeEntityPosition(playerPed, true)
			TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
			
			exports['ExileRP']:DrawProcent(300, function()
				FreezeEntityPosition(playerPed, false)
				ClearPedTasks(playerPed)
				isUsing = false
				Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, playerPed, maxHealth)
				ESX.ShowNotification(_U('healed'))			
			end)
		end
	else
		ESX.ShowNotification('Juz sobie pomagasz')
	end
end)

function StartRespawnTimer()
    Citizen.SetTimeout(Config.RespawnDelayAfterRPDeath, function()
        if IsDead then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rp_dead', {
				title = _U('rp_dead'),
				align = 'center',
				elements = {
					{ label = _U('yes'), value = 'yes' },
					{ label = _U('no'), value = 'no' },
				}
			}, function (data, menu)
				if data.current.value == 'yes' then
					RemoveItemsAfterRPDeath()
				end
				menu.close()
			end, function (data, menu)
				menu.close()
				if data.current.value == 'no' and IsControlJustPressed(1, 178) then
					RemoveItemsAfterRPDeath()
				end
				menu.close()
			end)
        end
    end)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end
function StartDistressSignal()
	CreateThread(function()
		local timer = Config.RespawnDelayAfterRPDeath

		local signal = 0
		while IsDead do
			Citizen.Wait(0)
			
			if signal < GetGameTimer() then
				SetTextFont(4)
				SetTextProportional(1)
				SetTextScale(0.45, 0.45)
				SetTextColour(185, 185, 185, 255)
				SetTextDropShadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()

				BeginTextCommandDisplayText('STRING')
				AddTextComponentSubstringPlayerName(_U('distress_send'))
				EndTextCommandDisplayText(0.175, 0.805)		

				if IsDisabledControlPressed(0, Keys['G']) and not exports['esx_policejob']:IsCuffed() then
					SendDistressSignal()
					signal = GetGameTimer() + 90000 * 4
				end					
			end
		end
	end)
end

function SendDistressSignal()	
	ESX.TriggerServerCallback('gcphone:getItemAmount', function(qtty)
		if qtty > 0 then
			ESX.TriggerServerCallback('route68:getSimWczytana', function(sim)
				if sim == nil then
					ESX.ShowNotification('~r~Nie posiadasz podpiętej karty sim')
				else

					local year, month, day, hour, minute, second = GetLocalTime()
					local hour = hour+1
					local godzina = hour..":"..minute
					ESX.ShowNotification(_U('distress_sent'))
					
					local coords = GetEntityCoords(PlayerPedId())
					TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', 'Ranny obywatel o godzinie: '..godzina, {
						x = coords.x,
						y = coords.y,
						z = coords.z
					})				
				end
			end)
		end
	end, 'phone')
end


function ShowDeathTimer()
	if DistressThreadId then
		TerminateThread(DistressThreadId)
	end
	
	local respawnTimer = Config.RespawnDelayAfterRPDeath
	local allowRespawn = Config.RespawnDelayAfterRPDeath/2
	local fineAmount = Config.EarlyRespawnFineAmount
	local payFine = false

	if Config.EarlyRespawn and Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(finePayable)
			if finePayable then
				payFine = true
			else
				payFine = false
			end
		end)
	end

	CreateThread(function()
		while respawnTimer > 0 and IsDead do
			Citizen.Wait(0)

			raw_seconds = respawnTimer/1000
			raw_minutes = raw_seconds/60
			minutes = stringsplit(raw_minutes, ".")[1]
			seconds = stringsplit(raw_seconds-(minutes*60), ".")[1]

			SetTextFont(4)
			SetTextProportional(0)
			SetTextScale(0.0, 0.5)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 1, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()

			local text = _U('please_wait', minutes, seconds)

			if Config.EarlyRespawn then
				if not Config.EarlyRespawnFine and respawnTimer <= allowRespawn then
					text = text .. _U('press_respawn')
				elseif Config.EarlyRespawnFine and respawnTimer <= allowRespawn and payFine then
					text = text .. _U('respawn_now_fine', fineAmount)
				else
					text = text
				end
			end

			SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)

			if Config.EarlyRespawn then
				if not Config.EarlyRespawnFine then
					if IsControlPressed(0, 46) then
						RemoveItemsAfterRPDeath()
						break
					end
				elseif Config.EarlyRespawnFine then
					if respawnTimer <= allowRespawn and payFine then
						if IsControlPressed(0, 46) then
							PayFine()
							break
						end
					end
				end
			end
			respawnTimer = respawnTimer - 15
		end
	end)
end

function RemoveItemsAfterRPDeath()
	CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()			
			local hospital = string.upper(choosedHospital)
			ESX.SetPlayerData('lastPosition', Config["RespawnPlace"..hospital])
			TriggerServerEvent('esx:updateLastPosition', Config["RespawnPlace"..hospital])
			RespawnPed(PlayerPedId(), Config["RespawnPlace"..hospital])
			TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)
			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
			TriggerServerEvent('exile_logs:triggerLog', "Przeteleportował się na szpital: "..hospital, 'teleportszpital', false)
		end)
	end)
end

function PayFine()
	ESX.TriggerServerCallback('esx_ambulancejob:payFine', function()
	RemoveItemsAfterRPDeath()
	end)
end

function StartDeathTimer()
	if TimerThreadId then
		TerminateThread(TimerThreadId)
	end
	
	CreateThread(function()
		HasTimer = true
		TimerThreadId = GetIdOfThisThread()

		local timer = Config.RespawnToHospitalDelay
		while timer > 0 and IsDead do
			local tmp = GetGameTimer()

			local seconds = timer / 1000
			local minutes = tonumber(stringsplit(seconds / 60, ".")[1])
			seconds = tonumber(stringsplit(seconds - (minutes * 60), ".")[1])

			ESX.Scaleform.ShowFreemodeMessage('~r~Obezwładniony', '~b~'..minutes..' minut i '..seconds..' sekund~s~ do przyjazdu lokalnych medyków', 0.2)
			timer = timer - (GetGameTimer() - tmp)
		end

		HasTimer = false
		local pressStart = nil
		while IsDead do
			Citizen.Wait(0)

			SetTextFont(4)
			SetTextProportional(0)
			SetTextScale(0.0, 0.5)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextCentre(true)

			BeginTextCommandDisplayText("STRING")
			AddTextComponentSubstringPlayerName('Przytrzymaj [~b~E~s~] aby zostać transportowanym do szpitala')
			EndTextCommandDisplayText(0.5, 0.8)

			if IsControlPressed(0, Keys['E']) or IsDisabledControlPressed(0, Keys['E']) then
				if not pressStart then
					pressStart = GetGameTimer()
				end

				if GetGameTimer() - pressStart > 3000 then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rp_dead', {
						title = ('Wybierz szpital'),
						align = 'center',
						elements = {
							{ label = ('Los Santos'), value = 'ls' },
							{ label = ('Sandy Shores'), value = 'sandy' },
							{ label = ('Paleto Bay'),  value = 'paleto'},
						}
					}, function (data, menu)
						if data.current.value == 'ls' then
							choosedHospital = 'ls'
							RemoveItemsAfterRPDeath()
						elseif data.current.value == 'sandy' then
							choosedHospital = 'sandy'
							RemoveItemsAfterRPDeath()
						elseif data.current.value == 'paleto' then
							choosedHospital = 'paleto'
							RemoveItemsAfterRPDeath()
						end
						menu.close()
					end, function (data, menu)
						menu.close()
					end)
					pressStart = nil
					break
				end
			else
				pressStart = nil
			end
		end
	end)
end

RegisterNetEvent('misiaczek:kill')
AddEventHandler('misiaczek:kill', function()
	local playerPed = PlayerPedId()
	Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, playerPed, 0)
end)

function OnPlayerDeath()
	IsDead = true
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', 1)
	
	StartDeathTimer()
	StartDistressSignal()

	Citizen.InvokeNative(0xAAA34F8A7CB32098, PlayerPedId())
	StartScreenEffect('DeathFailOut', 0, false)
	--StartDeathCam()
end

function TeleportFadeEffect(entity, coords)

	CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)
		end)
	end)
end

function WarpPedInClosestVehicle(ped)

	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle({
		x = coords.x,
		y = coords.y,
		z = coords.z
	})

	if distance ~= -1 and distance <= 5.0 then

		local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
		local freeSeat = nil

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat ~= nil then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end

	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end

function OpenAmbulanceActionsMenu()

	local elements = {
		{label = "Ubranie cywilne", value = 'citizen_wear'},
		{label = 'Służbowa garderoba', value = 'cloakroom'},
		{label = 'Prywatna garderoba', value = 'player_dressing' },
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title		= _U('ambulance'),
		align		= 'center',
		elements	= elements
	}, function(data, menu)
		if data.current.value == 'player_dressing' then
			ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
				local elements = {}
	
				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end
	
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
					title    = "Garderoba prywatna",
					align    = 'bottom-right',
					elements = elements
				}, function(data2, menu2)
					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('esx_property:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('esx_skin:setLastSkin', skin)
	
							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)
						end, data2.current.value)
					end)
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		elseif data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'cloakroom' then
			
			
			local elements2 = {
				{label = "Pielęgniarz", value = 'pielegniarz_wear'},
				{label = "Ratownik", value = 'ratownik_wear'},
				{label = "Lekarz", value = 'lekarz_wear'},
				{label = "Lekarz SORu", value = 'lekarzsoru_wear'},
				{label = "Lekarz Specjalista", value = 'lekarzspecjalista_wear'},
				{label = "Doktor", value = 'doktor_wear'},
				{label = "Chirurg", value = 'chirurg_wear'},
				{label = "Neurochirurg", value = 'neurochirurg_wear'},
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'alluniforms', {
				title    = "Szatnia - SAMS",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				setUniform(data2.current.value, playerPed)
			end, function(data2, menu2)
				menu2.close()
			end)
			
			--OpenCloakroomMenu()
		end
	end, function(data, menu)
		menu.close()

		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~, aby się przebrać"
		CurrentActionData	= {}
	end)
end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions',
	{
		title		= _U('ems_menu_title'),
		align		= 'center',
		elements	= {
			{label = ('Interakcje z cywilem'), value = 'citizen_interaction'},
			{label = ('Interakcje z pojazdem'), value = 'vehicle_interaction'},
			{label = ('Kajdanki'), value = 'Kajdanki'},
			{label = ('Tablet SAMS'), value = 'tablet'}
		}
	}, function(data, menu)
		if data.current.value == 'OpenRehabMenu' then					
			menu.close()
			OpenRehabMenu()
		elseif data.current.value == 'tablet' then
			menu.close()
			TriggerEvent('tabletmed')
		elseif data.current.value == 'Kajdanki' then
			menu.close()
			exports['esx_policejob']:HandcuffMenu()
		elseif data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title		= _U('ems_menu_title'),
				align		= 'center',
				elements	= {
					{label = ('Zbadaj pacjenta'), value = 'zbadaj'},
					{label = ('Ożywa obywatela'), value = 'revive'},
					{label = ('Ulecz małe rany'), value = 'small'},
					{label = ('Ulecz poważne rany'), value = 'big'},
					{label = ('Wsadz do pojazdu'), value = 'put_in_vehicle'},
					{label = ('Wyciągnij z pojazdu'), value = 'out_vehicle'},
					
				}
			}, function(data, menu)
				if IsBusy then 
					return 
				end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 1.0 then
					ESX.ShowNotification('~r~Brak graczy w pobliżu')
				else

					if data.current.value == 'revive' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = Citizen.InvokeNative(0x43A66C31C68491C0, closestPlayer)

								if IsPedDeadOrDying(closestPlayerPed, 1) then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('revive_inprogress'))

									local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

									for i=1, 15, 1 do
										Citizen.Wait(900)
								
										ESX.Streaming.RequestAnimDict(lib, function()
											TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
										end)
									end

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambvlancejob:revive', GetPlayerServerId(closestPlayer))
									IsBusy = false

									-- Show revive award?
									if Config.ReviveReward > 0 then
										ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
									else
										ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
									end
								else
									ESX.ShowNotification(_U('player_not_unconscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')
					
					elseif data.current.value == 'zbadaj' then
						if IsPlayerDead(closestPlayer) then
							menu.close()

							RequestAnimDict('amb@medic@standing@kneel@base')
							while not HasAnimDictLoaded('amb@medic@standing@kneel@base') do
								Citizen.Wait(0)
							end

							RequestAnimDict('anim@gangops@facility@servers@bodysearch@')
							while not HasAnimDictLoaded('anim@gangops@facility@servers@bodysearch@') do
								Citizen.Wait(0)
							end

							local closestPlayerPed = Citizen.InvokeNative(0x43A66C31C68491C0, closestPlayer)
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions_test', {
								title= 'SAMS - Badanie pacjetna',
								align= 'center',
								elements = {
									{label = 'Zbadaj przyczynę utraty przytomności', value = 'death'},
									{label = 'Zbadaj uszkodzenia ciała', value = 'damage'}
								}
							}, function(data2, menu2)
								menu2.close()

								local ac = data2.current.value
								if ac == 'damage' then
									local success, bone = GetPedLastDamageBone(closestPlayerPed)
									if success then
										local x, y, z = table.unpack(GetPedBoneCoords(closestPlayerPed, bone))

										local timestamp = GetGameTimer()
										while (timestamp + 10000) > GetGameTimer() do
											Citizen.Wait(0)
											DrawText3D(x, y, z, '~g~*', 0.6)
										end
									else
										ESX.ShowNotification('~r~Nie jesteś w stanie zbadać, gdzie pacjent doznał obrażeń')
									end
								elseif ac == 'death' then
									IsBusy = true
									ESX.ShowNotification('Rozpoczynasz ~y~badanie ~s~pacjenta')

									local playerPed = PlayerPedId()
									TaskPlayAnim(playerPed, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
									TaskPlayAnim(playerPed, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, -8.0, -1, 48, 0, false, false, false)

									Citizen.Wait(5000)
									Citizen.InvokeNative(0xAAA34F8A7CB32098, playerPed)
									IsBusy = false

									local d = GetPedCauseOfDeath(closestPlayerPed)
									if checkArray(Melee, d) then
										ESX.ShowNotification(_U('dc_hardmeele'))
									elseif checkArray(Bullet, d) then
										ESX.ShowNotification(_U('dc_bullet'))
									elseif checkArray(Knife, d) then
										ESX.ShowNotification(_U('dc_knifes'))
									elseif checkArray(Electricity, d) then
										ESX.ShowNotification(_U('dc_electricity'))
									elseif checkArray(Animal, d) then
										ESX.ShowNotification(_U('dc_bitten'))
									elseif checkArray(FallDamage, d) then
										ESX.ShowNotification(_U('dc_brokenlegs'))
									elseif checkArray(Explosion, d) then
										ESX.ShowNotification(_U('dc_explosive'))
									elseif checkArray(Gas, d) then
										ESX.ShowNotification(_U('dc_gas'))
									elseif checkArray(Burn, d) then
										ESX.ShowNotification(_U('dc_fire'))
									elseif checkArray(Drown, d) then
										ESX.ShowNotification(_U('dc_drown'))
									elseif checkArray(Car, d) then
										ESX.ShowNotification(_U('dc_caraccident'))
									else
										ESX.ShowNotification(_U('dc_unknown'))
									end
								end
							end, function(data2, menu2)
								menu2.close()
							end)
						else
							ESX.ShowNotification(_U('player_not_conscious'))
						end	
					elseif data.current.value == 'small' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = Citizen.InvokeNative(0x43A66C31C68491C0, closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = Citizen.InvokeNative(0x43A66C31C68491C0, closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif data.current.value == 'out_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					end

					
				end
			end, function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction',
			{
				title		= _U('ems_menu_title'),
				align		= 'center',
				elements	= {
					{label = ('Napraw pojazd'), value = 'repair'},
					{label = ('Odholuj pojazd'), value = 'impound_vehicle'},
					
				}
			}, function(data, menu)
				local vehicle = nil

				if IsPedInAnyVehicle(playerPed, false) then
					vehicle = GetVehiclePedIsIn(playerPed, false)
				else
					vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
				end
					
				if not IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
					ESX.ShowNotification('~r~Brak pojazdu w pobliżu')
				else

					if data.current.value == 'repair' then
						if(not IsPedInAnyVehicle(playerPed)) then
							TriggerEvent('esx_mechanikjob:onFixkit')
						end
					elseif data.current.value == 'impound_vehicle' then
						if(not IsPedInAnyVehicle(playerPed)) then
				

							local playerPed = PlayerPedId()
							local coords    = GetEntityCoords(playerPed)	 
							if CurrentTask.Busy then
								return
							end
					
							ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ żeby unieważnić ~y~zajęcie~s~')
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
					
							CurrentTask.Busy = true
							CurrentTask.Task = ESX.SetTimeout(10000, function()
								ClearPedTasks(playerPed)
								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
								ESX.Game.DeleteVehicle(vehicle)
					
								CurrentTask.Busy = false
								Citizen.Wait(100)
							end)
					
							-- keep track of that vehicle!
							CreateThread(function()
								while CurrentTask.Busy do
									Citizen.Wait(1000)
					
									vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
									if not DoesEntityExist(vehicle) and CurrentTask.Busy then
										ESX.ShowNotification(_U(action .. '_canceled_moved'))
										ESX.ClearTimeout(CurrentTask.Task)
					
										ClearPedTasks(playerPed)
										CurrentTask.Busy = false
										break
									end
								end
							end)

						end
					end

					
				end
			end, function(data, menu)
				menu.close()
			end)		
		end

	end, function(data, menu)
		menu.close()
	end)
end


-- function OpenCloakroomMenu()

-- 	ESX.UI.Menu.CloseAll()
-- 	local playerPed = PlayerPedId()
-- 	local grade = PlayerData.job.grade_name

-- 	local elements = {}
-- 	if PlayerData == nil then
-- 		return
-- 	end

-- 	table.insert(elements, {label = 'Stroje medyczne', value = 'alluniforms'})


-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
-- 	{
-- 		title    = _U('cloakroom'),
-- 		align    = 'right',
-- 		elements = elements
-- 	}, function(data, menu)

-- 		cleanPlayer(playerPed)

-- 		if data.current.value == 'ambulance_wear' then
-- 			menu.close()
-- 			setUniform('pielegniarz_wear', playerPed)
-- 		end
		
		-- if data.current.value == 'citizen_wear' then
		-- 	menu.close()
		-- 	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		-- 		TriggerEvent('skinchanger:loadSkin', skin)
		-- 	end)
		-- end

-- 		if data.current.value == 'alluniforms' then
-- 			local elements2 = {
-- 				{label = "Pielęgniarz", value = 'pielegniarz_wear'},
-- 				{label = "Ratownik", value = 'ratownik_wear'},
-- 				{label = "Lekarz", value = 'lekarz_wear'},
-- 				{label = "Lekarz SORu", value = 'lekarzsoru_wear'},
-- 				{label = "Lekarz Specjalista", value = 'lekarzspecjalista_wear'},
-- 				{label = "Doktor", value = 'doktor_wear'},
-- 				{label = "Chirurg", value = 'chirurg_wear'},
-- 				{label = "Neurochirurg", value = 'neurochirurg_wear'},
-- 			}

-- 			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'alluniforms', {
-- 				title    = "Szatnia - SAMS",
-- 				align    = 'right',
-- 				elements = elements2
-- 			}, function(data2, menu2)
-- 				setUniform(data2.current.value, playerPed)
-- 			end, function(data2, menu2)
-- 				menu2.close()
-- 			end)
-- 		end

-- 	if
-- 		data.current.value == 'pielegniarz_wear' or
-- 		data.current.value == 'ratownik_wear' or
-- 		data.current.value == 'lekarz_wear' or
-- 		data.current.value == 'lekarzsoru_wear' or
-- 		data.current.value == 'lekarzspecjalista_wear' or
-- 		data.current.value == 'doktor_wear' or
-- 		data.current.value == 'chirurg_wear' or
-- 		data.current.value == 'neurochirurg_wear'
-- 	then
-- 		setUniform(data.current.value, playerPed)
-- 	end

-- 	end, function(data, menu)
-- 		menu.close()
		
-- 		CurrentAction		= 'ambulance_actions_menu'
-- 		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~, aby się przebrać"
-- 		CurrentActionData	= {}

-- 	end)
-- end


function OpenVehicleSpawnerMenu(zoneNumber)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'vehicle_spawner',
	{
		title		= _U('veh_menu'),
		align		= 'center',
		elements	= Config.AuthorizedVehicles
	}, function(data, menu)
		menu.close()
		ESX.Game.SpawnVehicle(data.current.model, Config.Ambulance.Vehicles[zoneNumber].spawnPoint, Config.Ambulance.Vehicles[zoneNumber].heading, function(vehicle)
			local playerPed = PlayerPedId()
			local plate = "SAMS " .. math.random(100,999)
			SetVehicleNumberPlateText(vehicle, plate)
			local localVehPlate = GetVehicleNumberPlateText(vehicle)
			TriggerEvent("ls:newVehicle", vehicle, localVehPlate, false)
			TriggerServerEvent("ls:addOwner", localVehPlate)

			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end)
	end, function(data, menu)
		menu.close()
		CurrentAction		= 'vehicle_spawner_menu'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~, aby wyciągnąć pojazd"
		CurrentActionData	= {zoneNumber = zoneNumber}
	end
	)
end

function OpenHeliSpawnerMenu(zoneNumber)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'heli_spawner',
	{
		title		= "Helikoptery",
		align		= 'center',
		elements	= Config.AuthorizedHeli
	}, function(data, menu)
		menu.close()
		ESX.Game.SpawnVehicle(data.current.model, Config.Ambulance.Helicopters[zoneNumber].spawnPoint, Config.Ambulance.Helicopters[zoneNumber].heading, function(vehicle)
			local playerPed = PlayerPedId()
			local plate = "SAMS " .. math.random(100,999)
			SetVehicleNumberPlateText(vehicle, plate)
			local localVehPlate = GetVehicleNumberPlateText(vehicle)
			TriggerEvent("ls:newVehicle", vehicle, localVehPlate, false)
			TriggerServerEvent("ls:addOwner", localVehPlate)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end)
	end, function(data, menu)
		menu.close()
		CurrentAction		= 'heli_spawner_menu'
		CurrentActionMsg	= 'Naciśnij ~INPUT_CONTEXT~ aby wyciągnąć helikopter.'
		CurrentActionData	= {zoneNumber = zoneNumber}
	end
	)
end

function OpenBoatSpawnerMenu(zoneNumber)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_spawner',
	{
		title		= "Garaż łodzi",
		align		= 'center',
		elements	= Config.AuthorizedBoats
	}, function(data, menu)
		menu.close()

		ESX.Game.SpawnVehicle(data.current.model, Config.Ambulance.Boats[zoneNumber].spawnPoint, Config.Ambulance.Boats[zoneNumber].heading, function(vehicle)
			local playerPed = PlayerPedId()
			local plate = "SAMS " .. math.random(100,999)
			SetVehicleNumberPlateText(vehicle, plate)
			local localVehPlate = string.lower(GetVehicleNumberPlateText(vehicle))
			TriggerEvent('ls:dodajklucze2', localVehPlate)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end)
	end, function(data, menu)
		menu.close()
		CurrentAction		= 'boat_spawner_menu'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~ aby wyciągnąć łódź"
		CurrentActionData	= {zoneNumber = zoneNumber}
	end)
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'pharmacy',
	{
		title		= _U('pharmacy_menu_title'),
		align		= 'center',
		elements = {
			{label = _U('pharmacy_take') .. ' ' .. _('medikit'), value = 'medikit'},
			{label = _U('pharmacy_take') .. ' ' .. _('bandage'), value = 'bandage'},
			{label = _U('pharmacy_take') .. ' ' .. "GPS", value = 'gps', count = 1},
			{label = _U('pharmacy_take') .. ' ' .. "BodyCam", value = 'bodycam', count = 1},
			{label = _U('pharmacy_take') .. ' ' .. "Radio", value = 'radio', count = 1},
		},
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value, data.current.count)

	end, function(data, menu)
		menu.close()
		CurrentAction		= 'pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	end
	)
end

AddEventHandler('playerSpawned', function()
	IsDead = false

	if FirstSpawn then
		FirstSpawn = false
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
			TriggerServerEvent('esx_ambulancejob:firstSpawn')
			exports.spawnmanager:setAutoSpawn(false)
		end)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlip()
	refreshBlip()
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)

	local specialContact = {
	name		= 'Ambulance',
	number		= 'ambulance',
	base64Icon	= 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

AddEventHandler('esx:onPlayerDeath', function(reason)
	OnPlayerDeath()
end)


RegisterNetEvent('esx_healthnarmour:set')
AddEventHandler('esx_healthnarmour:set', function(health, armour)
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
	SetEntityHealth(PlayerPedId(), tonumber(health))
	SetPedArmour(PlayerPedId(), tonumber(armour))
	if tonumber(health) == 0 then
		ESX.ShowNotification('~r~Jesteś nieprzytomny/a, ponieważ przed wyjściem z serwera Twoja postać miała BW')
	end
end)



RegisterNetEvent('esx_ambvlancejob:revive')
AddEventHandler('esx_ambvlancejob:revive', function()
	local playerPed = PlayerPedId()
	local coords	= GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)

	CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		ESX.SetPlayerData('lastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		TriggerServerEvent('esx:updateLastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		RespawnPed(playerPed, {
			x = coords.x,
			y = coords.y,
			z = coords.z,
			heading = 0.0
		})

		StopScreenEffect('DeathFailOut')

		DoScreenFadeIn(800)
	end)

end)

CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsDead then
			DisableControlAction(0, 288, true)
			DisableControlAction(0, 170, true)
			DisableControlAction(0, 56, true)
			exports["pma-voice"]:SetMumbleProperty("radioEnabled", false)
		else
			Citizen.Wait(500)
			exports["pma-voice"]:SetMumbleProperty("radioEnabled", true)
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(zone, number)
	local ped = PlayerPedId()

	if zone == 'Cloakrooms' then
		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~, aby się przebrać"
		CurrentActionData	= {}
	end

	if zone == 'Vehicles' then
		CurrentAction		= 'vehicle_spawner_menu'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~, aby wyciągnąć pojazd"
		CurrentActionData	= {zoneNumber = number}
	end

	if zone == 'Boats' then
		CurrentAction		= 'boat_spawner_menu'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~ aby wyciągnąć łódź"
		CurrentActionData	= {zoneNumber = number}
	end

	if zone == 'Pharmacies' then
		CurrentAction		= 'pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	end

	if zone == 'SkinMenu' then
		CurrentAction		= 'skinkuwko'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~ aby się przebrać"
		CurrentActionData	= {}
	end

	if zone == 'Helicopters' then
		CurrentAction		= 'heli_spawner_menu'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~ aby wyciągnąć helikopter."
		CurrentActionData	= {zoneNumber = number}
	end
	
	if zone == 'Inventories' then
		CurrentAction		= 'items_menu'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~ aby otworzyć szafkę"
		CurrentActionData	= {}
	end
	
	if zone == 'BossActions' then
		CurrentAction		= 'boss_actions'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~ aby otworzyć menu zarządzania"
		CurrentActionData	= {}
	end

	if zone == 'VehicleDeleters' then
		if IsPedInAnyVehicle(ped, false) then
			local coords	= GetEntityCoords(ped, true)
	  
			local vehicle, distance = ESX.Game.GetClosestVehicle({
			  x = coords.x,
			  y = coords.y,
			  z = coords.z
			})
			if distance ~= -1 and distance <= 1.0 then
				CurrentAction	 = 'delete_vehicle'
				CurrentActionMsg  = _U('store_veh')
				CurrentActionData = {vehicle = vehicle}
			end
		end
	end
end)

function FastTravel(pos)
		TeleportFadeEffect(PlayerPedId(), pos)
end

function FastTravelCar(x, y, z)
		etPedCoordsKeepVehicle(PlayerPedId(), pos)
end

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create blips
function refreshBlip()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
		for _, ez in ipairs(Config.OnlySamsBlip) do
			local blip = AddBlipForCoord(ez.Pos.x, ez.Pos.y, ez.Pos.z)
			SetBlipSprite (blip, ez.Sprite)
			SetBlipDisplay(blip, ez.Display)
			SetBlipScale  (blip, ez.Scale)
			SetBlipColour (blip, ez.Colour)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Łodzie - SAMS")
			EndTextCommandSetBlipName(blip)
			Citizen.Wait(0)
			table.insert(SamsBlip, blip)
		end
	end
end

function deleteBlip()
	if SamsBlip[1] ~= nil then
		for i=1, #SamsBlip, 1 do
			RemoveBlip(SamsBlip[i])
		end
		SamsBlip = {}
	end
end

CreateThread(function()
	Citizen.Wait(5000)
	for i=1, #Config.Blips, 1 do
		local cBlip = Config.Blips[i]
		local blip = AddBlipForCoord(cBlip.coords)

		SetBlipSprite(blip, Config.Sprite)
		SetBlipDisplay(blip, Config.Display)
		SetBlipScale(blip, Config.Scale)
		SetBlipColour(blip, Config.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Szpital")
		EndTextCommandSetBlipName(blip)
	end
end)

-- Display markers
CreateThread(function()
	while PlayerData.job == nil do
		Citizen.Wait(1000)
	end
	
	while true do
		Citizen.Wait(3)
		if PlayerData.job ~= nil and (PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance') then
			local found = false
			local coords = GetEntityCoords(PlayerPedId())
			for k,v in pairs(Config.Ambulance) do
				for i=1, #v, 1 do
					if k == 'VehicleDeleters' then
						if #(coords - v[i].coords) < Config.DrawDistance then
							found = true
							DrawMarker(27, v[i].coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 3.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 175, false, true, 2, true, false, false, false)
						end
					elseif k == 'Cloakrooms' and (PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance') then
						if #(coords - v[i].coords) < Config.DrawDistance then
							found = true
							ESX.DrawMarker(v[i].coords)
						end					
					end
					if k ~= 'VehicleDeleters' and k ~= 'Cloakrooms' and PlayerData.job.name == 'ambulance' then
						if #(coords - v[i].coords) < Config.DrawDistance then
							found = true
							ESX.DrawMarker(v[i].coords)
						end
					end
				end
			end
			
			if not found then
				Citizen.Wait(2000)
			end
		else
			Citizen.Wait(2000)
		end
	end
end)

-- Activate menu when player is inside marker
CreateThread(function()
	while true do
		Citizen.Wait(60)

		local coords, sleep		= GetEntityCoords(PlayerPedId()), true
		local isInMarker	= false
		local currentZone	= nil
		local zoneNumber 	= nil
		
		for k,v in pairs(Config.Ambulance) do
			if PlayerData.job ~= nil and (PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance') then
				for i=1, #v, 1 do
					if k == 'VehicleDeleters' then
					
						if #(coords - v[i].coords) < 3.0 then
							sleep = false
							isInMarker	= true
							currentZone = k
							zoneNumber = i
						end
					elseif k == 'Cloakrooms' and (PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance') then						
						if #(coords - v[i].coords) < Config.MarkerSize.x then
							sleep = false
							isInMarker	= true
							currentZone = k
							zoneNumber = i
						end
					end
					if k ~= 'VehicleDeleters' and k ~= 'Cloakrooms' and PlayerData.job.name == 'ambulance' then
						if #(coords - v[i].coords) < Config.MarkerSize.x then
							sleep = false
							isInMarker	= true
							currentZone = k
							zoneNumber = i
						end
					end
				end
			end
		end
		
		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentZone, zoneNumber)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', lastZone)
		end
		
		if sleep then
			Citizen.Wait(250)
		end
	end
end)

function OpenInventoryMenu()
	ESX.UI.Menu.CloseAll()

	local elements = {}
	if PlayerData == nil then
		return
	end

	if PlayerData.job.name == 'ambulance' and PlayerData.job.grade >= 5 then
		table.insert(elements, {label = 'Wyciągnij ekwipunek', value = 'get'})
	end

	table.insert(elements, {label = 'Zdeponuj ekwipunek', value = 'put'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'items', {
		title    = 'Szafka',
		align    = 'center',
		elements = elements
	}, function(data,menu)
		menu.close()
		if data.current.value == 'get' then
			TriggerEvent('exile:getInventoryItem', 'society_ambulance')
		elseif data.current.value == 'put' then
			TriggerEvent('exile:putInventoryItem', 'society_ambulance')
		end
	end, function(data, menu)
		menu.close()
		CurrentAction		= 'items_menu'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~ aby otworzyć szafkę"
		CurrentActionData	= {}
	end)
end

-- Key Controls
CreateThread(function()
	while true do

		Citizen.Wait(10)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, 46) then
				if PlayerData.job ~= nil and (PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance') then

					if CurrentAction == 'ambulance_actions_menu' then
						OpenAmbulanceActionsMenu()
					end

					if CurrentAction == 'vehicle_spawner_menu' then
						OpenVehicleSpawnerMenu(CurrentActionData.zoneNumber)
					end

					if CurrentAction == 'heli_spawner_menu' then
						OpenHeliSpawnerMenu(CurrentActionData.zoneNumber)
					end

					if CurrentAction == 'boat_spawner_menu' then
						OpenBoatSpawnerMenu(CurrentActionData.zoneNumber)
					end

					if CurrentAction == 'pharmacy' then
						OpenPharmacyMenu()
					end

					if CurrentAction == 'skinkuwko' then
						TriggerEvent('esx_skin:openSaveableMenu')
					end

					if CurrentAction == 'items_menu' then
						OpenInventoryMenu()
					end

					if CurrentAction == 'boss_actions' then
						ESX.UI.Menu.CloseAll()
						if PlayerData.job.grade >= 8 then
							TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
								menu.close()
							end, { showmoney = true, withdraw = true, deposit = true, wash = false, employees = true, badges = true})
						else
							TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
								menu.close()
							end, { showmoney = false, withdraw = false, deposit = true, wash = false, employees = false, badges = true})
						end
					end

					if CurrentAction == 'fast_travel_goto_top' or CurrentAction == 'fast_travel_goto_bottom' then
						FastTravel(CurrentActionData.pos)
					end

					if CurrentAction == 'delete_vehicle' then
						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					end
				end
				
				CurrentAction = nil	
			end
		
		else
			Citizen.Wait(500)
		end
	end
end)

CreateThread(function()
	local timer = GetGameTimer()
	
	while true do

		Citizen.Wait(10)
		if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
		
			if IsControlJustReleased(0, 38) and CurrentTask.busy and timer < GetGameTimer() then
				ESX.ShowNotification('Unieważniasz zajęcie')
				ESX.ClearTimeout(CurrentTask.task)
				ClearPedTasks(PlayerPedId())

				CurrentTask.busy = false
				
				timer = GetGameTimer() + 500
			end	
		
			if IsControlJustReleased(0, Keys['F6']) and not IsDead and timer < GetGameTimer() then
				OpenMobileAmbulanceActionsMenu()
				
				timer = GetGameTimer() + 500
			end
		
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:requestDeath')
AddEventHandler('esx_ambulancejob:requestDeath', function()
	if Config.AntiCombatLog then
		Citizen.Wait(2000)
		local playerPed = PlayerPedId()
		Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, playerPed, 0)
		ESX.ShowNotification('~r~Jesteś nieprzytomny/a, ponieważ przed wyjściem z serwera Twoja postać miała BW')
	end
end)

-- String string
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

local cam = nil

local angleY = 0.0
local angleZ = 0.0

CreateThread(function()
    while true do
        Citizen.Wait(1)
        
        if (cam and IsDead) then
			ProcessCamControls()
		else
			Citizen.Wait(200)
        end
    end
end)

--------------------------------------------------
------------------- FUNCTIONS --------------------
--------------------------------------------------

local cam = nil

local isDead = false

local angleY = 0.0
local angleZ = 0.0

CreateThread(function()
    while true do
        Citizen.Wait(1)
        if (cam and isDead) then
            ProcessCamControls()
		else
			Citizen.Wait(500)
		end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(500)
        
        if (not isDead and NetworkIsPlayerActive(PlayerId()) and IsPedFatallyInjured(PlayerPedId())) then
            isDead = true
            
            StartDeathCam()
        elseif (isDead and NetworkIsPlayerActive(PlayerId()) and not IsPedFatallyInjured(PlayerPedId())) then
            isDead = false
            
            EndDeathCam()
        end
    end
end)

-- initialize camera
function StartDeathCam()
    ClearFocus()

    local playerPed = PlayerPedId()
    
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, GetGameplayCamFov())

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, false)
end

-- destroy camera
function EndDeathCam()
    ClearFocus()

    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
    
    cam = nil
end
-- process camera controls
function ProcessCamControls()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    -- disable 1st person as the 1st person camera can cause some glitches
    DisableFirstPersonCamThisFrame()
    
    -- calculate new position
    local newPos = ProcessNewPosition()

    -- focus cam area
    SetFocusArea(newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0)
    
    -- set coords of cam
    SetCamCoord(cam, newPos.x, newPos.y, newPos.z)
    
    -- set rotation
    PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
end

function ProcessNewPosition()
    local mouseX = 0.0
    local mouseY = 0.0
    
    -- keyboard
    if (IsInputDisabled(0)) then
        -- rotation
        mouseX = GetDisabledControlNormal(1, 1) * 8.0
        mouseY = GetDisabledControlNormal(1, 2) * 8.0
        
    -- controller
    else
        -- rotation
        mouseX = GetDisabledControlNormal(1, 1) * 1.5
        mouseY = GetDisabledControlNormal(1, 2) * 1.5
    end

    angleZ = angleZ - mouseX -- around Z axis (left / right)
    angleY = angleY + mouseY -- up / down
    -- limit up / down angle to 90°
    if (angleY > 89.0) then angleY = 89.0 elseif (angleY < -89.0) then angleY = -89.0 end
    
    local pCoords = GetEntityCoords(PlayerPedId())
    
    local behindCam = {
        x = pCoords.x + ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * (3.5 + 0.5),
        y = pCoords.y + ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * (3.5 + 0.5),
        z = pCoords.z + ((Sin(angleY))) * (3.5 + 0.5)
    }
    local rayHandle = StartShapeTestRay(pCoords.x, pCoords.y, pCoords.z + 0.5, behindCam.x, behindCam.y, behindCam.z, -1, PlayerPedId(), 0)
    local a, hitBool, hitCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    
    local maxRadius = 3.5
    if (hitBool and Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords) < 3.5 + 0.5) then
        maxRadius = Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords)
    end
    
    local offset = {
        x = ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * maxRadius,
        y = ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * maxRadius,
        z = ((Sin(angleY))) * maxRadius
    }
    
    local pos = {
        x = pCoords.x + offset.x,
        y = pCoords.y + offset.y,
        z = pCoords.z + offset.z
    }
    
    return pos
end