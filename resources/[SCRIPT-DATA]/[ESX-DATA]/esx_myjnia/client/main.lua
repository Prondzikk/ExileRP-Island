ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

playerPed = PlayerPedId()
coords = vector3(0,0,0)

CreateThread(function()
    while true do
        Citizen.Wait(1000)
		playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
    end
end)

CreateThread(function()
	for i=1, #Config.Locations, 1 do
		carWashLocation = Config.Locations[i]

		local blip = AddBlipForCoord(carWashLocation)
		SetBlipSprite(blip, 100)
		SetBlipColour(blip, 11)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(_U('blip_carwash'))
		EndTextCommandSetBlipName(blip)
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)
		local canSleep = true

		if CanWashVehicle() then

			for i=1, #Config.Locations, 1 do
				local carWashLocation = Config.Locations[i]
				local distance = GetDistanceBetweenCoords(coords, carWashLocation, true)

				if distance < 50 then
					DrawMarker(1, carWashLocation, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, false, false, 2, false, false, false, false)
					canSleep = false
				end

				if distance < 5 then
					canSleep = false

					if Config.EnablePrice then
						ESX.ShowHelpNotification(_U('prompt_wash_paid', ESX.Math.GroupDigits(Config.Price)))
					else
						ESX.ShowHelpNotification(_U('prompt_wash'))
					end

					if IsControlJustReleased(0, 38) then
						local vehicle = GetVehiclePedIsIn(playerPed, false)

						if GetVehicleDirtLevel(vehicle) > 2 then
							WashVehicle()
						else
							ESX.ShowNotification(_U('wash_failed_clean'))
						end
					end
				end
			end

			if canSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

function CanWashVehicle()
	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			return true
		end
	end

	return false
end

function WashVehicle()
	ESX.TriggerServerCallback('esx_myjnia:canAfford', function(canAfford)
		if canAfford then
			local vehicle = GetVehiclePedIsIn(playerPed)
			SetVehicleDirtLevel(vehicle, 0.1)

			if Config.EnablePrice then
				ESX.ShowNotification(_U('wash_successful_paid', ESX.Math.GroupDigits(Config.Price)))
			else
				ESX.ShowNotification(_U('wash_successful'))
			end
			Citizen.Wait(5000)
		else
			ESX.ShowNotification(_U('wash_failed'))
			Citizen.Wait(5000)
		end
	end)
end