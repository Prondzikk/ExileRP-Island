oldVehicle = nil
oldDamage = 0


isBlackedOut = false
dzwonCalled = false

beltOn = false
beltStatus = true
beltCalled = false

AddEventHandler('exile_blackout:pasy', function(status)
	beltOn = status
end)

AddEventHandler('zlomus_dzwon:display', function(status)
	beltStatus = status
end)

function pasyState()
	return beltOn
end

RegisterNetEvent('exile_blackout:dzwon')
AddEventHandler('exile_blackout:dzwon', function(damage)
	isBlackedOut = true
	dzwonCalled = false
	Citizen.Wait(1000)
	isBlackedOut = false
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)

		local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			local exists = DoesEntityExist(vehicle)

			local driver
			if exists then
				driver = GetPedInVehicleSeat(vehicle, -1)
			end

			if (exists and (not driver or driver == 0 or driver == playerPed)) or (not exists and DoesEntityExist(oldVehicle)) then
				local fall = true
				if exists then
					oldVehicle = vehicle
					fall = false
				end

				if not GetPlayerInvincible(PlayerId()) and not dzwonCalled then
					if IsCar(oldVehicle, false) then
						local currentDamage = GetVehicleEngineHealth(oldVehicle)
						if not isBlackedOut then
							local speed, vehicleClass = math.floor(GetEntitySpeed(oldVehicle) * 3.6 + 0.5), GetVehicleClass(oldVehicle)
							if (currentDamage < oldDamage and (oldDamage - currentDamage) >= 150) or (fall and speed > (vehicleClass == 8 and 5 or 30)) then
								local damage
								if not fall then
									damage = math.floor((oldDamage - currentDamage) / 20 + 0.5)
								else
									damage = math.floor(speed / 10 + 0.5)
								end

								local list = {}
								if oldVehicle == vehicle and driver == playerPed then
									local tmp = {}
									for _, player in ipairs(GetActivePlayers()) do
										tmp[Citizen.InvokeNative(0x43A66C31C68491C0, player)] = GetPlayerServerId(player)
									end

									for i = 0, GetVehicleNumberOfPassengers(oldVehicle) do
										local ped = GetPedInVehicleSeat(oldVehicle, i)
										if ped and ped ~= 0 then
											table.insert(list, tmp[ped])
										end
									end
								end

								dzwonCalled = true
								TriggerServerEvent('exile_blackout:dzwon', list, damage)
							end
						end

						if not fall then
							oldDamage = currentDamage
						end
					end
				end

				if fall then
					oldVehicle = nil
					oldDamage = 0
				end
			else
				oldDamage = 0
			end
		else
			oldDamage = 0
		end
	end
end)

RegisterNetEvent('exile_blackout:impact')
AddEventHandler('exile_blackout:impact', function(speedBuffer, velocityBuffer)
	CreateThread(function()
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			local vehicle = GetVehiclePedIsIn(ped, false)

			local pass = nil
			if beltOn then
				local speed = math.floor(speedBuffer[2] * 3.6 + 0.5)
				if speed > 249 then
					local health = GetEntityHealth(ped)

					local newHealth = math.floor(math.max(99, (health - (speed - 250) / 1.5)) + 0.5)
					if newHealth > 99 then
						--Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, ped, newHealth)
					else
						pass = newHealth
					end
				end
			else
				pass = GetEntityHealth(ped)
			end
			
			if pass then
				local hr = GetEntityHeading(vehicle) + 90.0
				if hr < 0.0 then
					hr = 360.0 + hr
				end

				hr = hr * 0.0174533
				local forward = { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
				local coords = GetEntityCoords(ped)

				SetEntityCoords(ped, coords.x + forward.x, coords.y + forward.y, coords.z - 0.47, true, true, true)
				SetEntityVelocity(ped, velocityBuffer[2].x, velocityBuffer[2].y, velocityBuffer[2].z)
				Citizen.Wait(1)

				SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
				if not beltOn then
					local speed = math.floor(speedBuffer[2] * 3.6 + 0.5)
					if speed > 120 then
						Citizen.Wait(500)
						Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, ped, math.floor(math.max(99, (pass - (speed - 100))) + 0.5))
					end
				else
					Citizen.Wait(500)
					--Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, ped, pass)
				end
			end
		end

		beltCalled = false
	end)
end)

AddEventHandler('exile_blackout:belt', function(status)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		beltOn = status
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 6.0, (beltOn and 'belton' or 'beltoff'), 0.35)
	end
end)

CreateThread(function()
    RequestStreamedTextureDict('mpinventory')
    while not HasStreamedTextureDictLoaded('mpinventory') do
        Citizen.Wait(1)
    end

	local speedBuffer = {}
	local velocityBuffer = {}

	while true do
		Citizen.Wait(1)

		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			local vehicle = GetVehiclePedIsIn(ped, false)
			if vehicle ~= 0 and IsCar(vehicle, true) then
				if IsControlJustReleased(0, 29) then
					TriggerEvent('exile_blackout:belt', not beltOn)
				end

				if not beltStatus then
					--nil
				elseif beltOn then
					DisableControlAction(0, 75)		
				end

				if GetPedInVehicleSeat(vehicle, -1) == ped then
					speedBuffer[2] = speedBuffer[1]
					speedBuffer[1] = GetEntitySpeed(vehicle)
					if speedBuffer[2] ~= nil and not beltCalled and speedBuffer[2] > 27.77 and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.25) and not GetPlayerInvincible(PlayerId()) and GetEntitySpeedVector(vehicle, true).y > 1.0 then
						local tmp = {}
						for _, player in ipairs(GetActivePlayers()) do
							tmp[Citizen.InvokeNative(0x43A66C31C68491C0, player)] = GetPlayerServerId(player)
						end

						local list = {}
						for i = 0, GetVehicleNumberOfPassengers(vehicle) do
							local ped = GetPedInVehicleSeat(vehicle, i)
							if ped and ped ~= 0 then
								table.insert(list, tmp[ped])
							end
						end

						local str = "^2Wypadek lub kolizja"
						local coords = GetEntityCoords(ped, false)

						local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
						if s1 ~= 0 and s2 ~= 0 then
							str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1) .. "^2 na skrzyżowaniu z ^0" .. GetStreetNameFromHashKey(s2)
						elseif s1 ~= 0 then
							str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1)
						end

						TriggerServerEvent('esx_jb_outlawalert:notifyAccident', {x = coords.x, y = coords.y, z = coords.y}, str)
						
						dzwonCalled = true
						beltCalled = true

						TriggerServerEvent('exile_blackout:dzwon', list, 10)
						TriggerServerEvent('exile_blackout:impact', list, speedBuffer, velocityBuffer)
					end

					velocityBuffer[2] = velocityBuffer[1]
					velocityBuffer[1] = GetEntityVelocity(vehicle)
				else
					speedBuffer[1], speedBuffer[2], velocityBuffer[1], velocityBuffer[2] = 0.0, nil, 0.0, nil
				end
			else
				speedBuffer[1], speedBuffer[2], velocityBuffer[1], velocityBuffer[2] = 0.0, nil, 0.0, nil
			end
		else
		
			beltOn = false
			speedBuffer[1], speedBuffer[2], velocityBuffer[1], velocityBuffer[2] = 0.0, nil, 0.0, nil
		end
	end
end)

function IsCar(v, ignoreBikes)
	if ignoreBikes and IsThisModelABike(GetEntityModel(v)) then
		return false
	end

	local vc = GetVehicleClass(v)
	return (vc >= 0 and vc <= 12) or vc == 17 or vc == 18 or vc == 20 or vc == 15
end