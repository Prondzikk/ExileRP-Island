ESX                           = nil
local PlayerData              = {}
local pCoords				  = nil
local notification = "Naciśnij ~INPUT_CONTEXT~ aby przejść"

CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
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

RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
    PlayerData.hiddenjob = hiddenjob
end)

CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		pCoords = GetEntityCoords(playerPed)
		Citizen.Wait(500)
	end
end)

local licenses = {
	'opium_transform',
	'exctasy_transform',
	'weapon'
}

local ownedLicenses = {}

CreateThread(function()
	while true do
		Citizen.Wait(3)
		for i=1, #licenses, 1 do
			ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
				if hasLicense then
					ownedLicenses[licenses[i]] = true
				else
					ownedLicenses[licenses[i]] = false
				end
			end, GetPlayerServerId(PlayerId()), licenses[i])
		end
		Citizen.Wait(120000)
	end
end)

CreateThread(function()
	while PlayerData.job == nil do
		Citizen.Wait(100)
	end
	while true do
		Citizen.Wait(3)
		local found = false
		for i=1, #Config.TeleportsLegs, 1 do
			local distance = GetDistanceBetweenCoords(pCoords, Config.TeleportsLegs[i].From, true)
			if distance < Config.DrawDistance then
				found = true
				if not Config.TeleportsLegs[i].Visible then
					DrawMarker(Config.MarkerLegs.type, Config.TeleportsLegs[i].From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerLegs.x, Config.MarkerLegs.y, Config.MarkerLegs.z, Config.MarkerLegs.r, Config.MarkerLegs.g, Config.MarkerLegs.b, Config.MarkerLegs.a, true, true, 2, Config.MarkerLegs.rotate, nil, nil, false)
					if distance < Config.MarkerLegs.x+0.5 then
						ESX.ShowHelpNotification(notification)
						if IsControlJustPressed(0, 38) then
							FastTravel(Config.TeleportsLegs[i].To, Config.TeleportsLegs[i].Heading)
						end
					end
				else
					if Config.TeleportsLegs[i].License then
						if ownedLicenses[Config.TeleportsLegs[i].License] == true then
							DrawMarker(Config.MarkerLegs.type, Config.TeleportsLegs[i].From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerLegs.x, Config.MarkerLegs.y, Config.MarkerLegs.z, Config.MarkerLegs.r, Config.MarkerLegs.g, Config.MarkerLegs.b, Config.MarkerLegs.a, true, true, 2, Config.MarkerLegs.rotate, nil, nil, false)
							if distance < Config.MarkerLegs.x+0.5 then
								ESX.ShowHelpNotification(notification)
								if IsControlJustPressed(0, 38) then
									FastTravel(Config.TeleportsLegs[i].To, Config.TeleportsLegs[i].Heading)
								end
							end
						end
					else
						for j=1, #Config.TeleportsLegs[i].Visible, 1 do
							if PlayerData.job.name == Config.TeleportsLegs[i].Visible[j] or PlayerData.hiddenjob.name == Config.TeleportsLegs[i].Visible[j] then
								DrawMarker(Config.MarkerLegs.type, Config.TeleportsLegs[i].From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerLegs.x, Config.MarkerLegs.y, Config.MarkerLegs.z, Config.MarkerLegs.r, Config.MarkerLegs.g, Config.MarkerLegs.b, Config.MarkerLegs.a, true, true, 2, Config.MarkerLegs.rotate, nil, nil, false)
								if distance < Config.MarkerLegs.x+0.5 then
									ESX.ShowHelpNotification(notification)
									if IsControlJustPressed(0, 38) then
										FastTravel(Config.TeleportsLegs[i].To, Config.TeleportsLegs[i].Heading)
									end
								end
							end
						end
					end
				end
			end
		end
		for i=1, #Config.TeleportsCars, 1 do
			local distance = GetDistanceBetweenCoords(pCoords, Config.TeleportsCars[i].From, true)
			if distance < Config.DrawDistance then
				found = true
				if not Config.TeleportsCars[i].Visible then
					DrawMarker(Config.MarkerCar.type, Config.TeleportsCars[i].From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerCar.x, Config.MarkerCar.y, Config.MarkerCar.z, Config.MarkerCar.r, Config.MarkerCar.g, Config.MarkerCar.b, Config.MarkerCar.a, false, true, 2, Config.MarkerCar.rotate, nil, nil, false)
					if distance < Config.MarkerCar.x+0.5 then
						ESX.ShowHelpNotification(notification)
						if IsControlJustPressed(0, 38) and IsPlay then
							if (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()) then
								CarTravel(Config.TeleportsCars[i].To, Config.TeleportsCars[i].Heading)
							end
						end
					end
				else
					for j=1, #Config.TeleportsCars[i].Visible, 1 do
						if PlayerData.job.name == Config.TeleportsCars[i].Visible[j] or PlayerData.hiddenjob.name == Config.TeleportsCars[i].Visible[j] then
							DrawMarker(Config.MarkerCar.type, Config.TeleportsCars[i].From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerCar.x, Config.MarkerCar.y, Config.MarkerCar.z, Config.MarkerCar.r, Config.MarkerCar.g, Config.MarkerCar.b, Config.MarkerCar.a, false, true, 2, Config.MarkerCar.rotate, nil, nil, false)
							if distance < Config.MarkerCar.x+0.5 then
								ESX.ShowHelpNotification(notification)
								if IsControlJustPressed(0, 38) then
									if (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()) then
										CarTravel(Config.TeleportsCars[i].To, Config.TeleportsCars[i].Heading)
									end
								end
							end
						end
					end
				end
			end
		end
		if not found then
			Citizen.Wait(2000)
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(3)
		for i=1, #Config.Lifts, 1 do
			local playerCoords, sleep = GetEntityCoords(PlayerPedId()), true
			for j=1, #Config.Lifts[i], 1 do
				if GetDistanceBetweenCoords(Config.Lifts[i][j].Coords,  playerCoords, true) < 15.0 then
					sleep = false
					if not Config.Lifts[i][j].Allow then
						DrawMarker(Config.MarkerLift.type, Config.Lifts[i][j].Coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerLegs.x, Config.MarkerLegs.y, Config.MarkerLegs.z, Config.MarkerLegs.r, Config.MarkerLegs.g, Config.MarkerLegs.b, Config.MarkerLegs.a, true, true, 2, Config.MarkerLegs.rotate, nil, nil, false)
						if GetDistanceBetweenCoords(Config.Lifts[i][j].Coords,  playerCoords, true) < 1.0 then
							ESX.ShowHelpNotification("Naciśnij ~INPUT_PICKUP~ aby użyc windy")
							if IsControlJustPressed(0, 38) then
								OpenLiftMenu(i, j)
							end
						end
					else
						if Config.Lifts[i][j].Allow[PlayerData.job.name] or Config.Lifts[i][j].Allow[PlayerData.hiddenjob.name] then
							DrawMarker(Config.MarkerLift.type, Config.Lifts[i][j].Coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerLegs.x, Config.MarkerLegs.y, Config.MarkerLegs.z, Config.MarkerLegs.r, Config.MarkerLegs.g, Config.MarkerLegs.b, Config.MarkerLegs.a, true, true, 2, Config.MarkerLegs.rotate, nil, nil, false)
							if GetDistanceBetweenCoords(Config.Lifts[i][j].Coords,  playerCoords, true) < 1.0 then
								sleep = false
								ESX.ShowHelpNotification("Naciśnij ~INPUT_PICKUP~ aby użyc windy")
								if IsControlJustPressed(0, 38) then
									OpenLiftMenu(i, j)
								end
							end
						end
					end
				end
			end
		end
		if sleep then
			Citizen.Wait(300)
		end
	end
end)

OpenLiftMenu = function(zone, currentFloor)
	ESX.UI.Menu.CloseAll()
	local elements = {}
	for i=1, #Config.Lifts[zone], 1 do
		local nextFloor = Config.Lifts[zone][i]
		if i ~= currentFloor then
			table.insert(elements, {label = nextFloor.Label, value = nextFloor.Coords, heading = nextFloor.Heading})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lift_menu',
	{
		title    = "Winda",
		align    = 'center',
		elements = elements
	}, function(data, menu)			
		menu.close()
		UseLift(data.current.value, data.current.heading)
	end, function(data, menu)
		menu.close()
	end)
end

UseLift = function(coords, heading)
	local x, y, z = coords.x, coords.y, coords.z
	z = z-0.9
	coords = vec3(x,y,z)
	TeleportFadeEffect(PlayerPedId(), coords, heading)
end

function CarTravel(coords, heading)
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	TeleportCarFadeEffect(vehicle, coords, heading)
end

function FastTravel(coords, heading)
	TeleportFadeEffect(PlayerPedId(), coords, heading)
end

function TeleportFadeEffect(entity, coords, heading)
	CreateThread(function()
        DoScreenFadeOut(100)
		while not IsScreenFadedOut() do
            Citizen.Wait(100)
		end
		Citizen.Wait(300)
        DoScreenFadeIn(100)
		ESX.Game.Teleport(entity, coords, function()
            DoScreenFadeOut(100)
            Citizen.Wait(100)
			if heading then
				SetEntityHeading(entity, heading)
			end
            DoScreenFadeIn(100)
			SetGameplayCamRelativeHeading(0.0)
		end)
	end)
end

function TeleportCarFadeEffect(vehicle, coords, heading)
	CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end
		Citizen.Wait(300)
		SetEntityCoordsNoOffset(vehicle, coords, 0, 0, 0)
		RequestCollisionAtCoord(coords)
		while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
			Citizen.Wait(0)
		end

		if heading then
			SetEntityHeading(vehicle, heading)
		end

		SetGameplayCamRelativeHeading(0.0)
		
		DoScreenFadeIn(800)
		while IsScreenFadingIn() do
			Citizen.Wait(0)
		end
		Citizen.InvokeNative(0x10D373323E5B9C0D)
	end)
end
