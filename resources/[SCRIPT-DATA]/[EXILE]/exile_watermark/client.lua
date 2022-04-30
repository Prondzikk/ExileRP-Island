ESX = nil

local isTalking = false
local giveID = false
local prox = 15.0
local allowProximityChange = true
local health_up = false
local armour_up = false
local forceDisable = false
local pressedRecently = false

function getPeople(what)
	if what == 'ambulance' then
		return ems
	elseif what == 'sheriff' then
		return sheriff
	elseif what == 'taxi' then
		return taxi
	elseif what == 'mechanic' then
		return mechanic
	elseif what == 'police' then
		return police
	elseif what == 'cardealer' then
		return cardealer
	elseif what == 'doj' then
		return doj
	elseif what == 'weazel' then
		return weazel
	elseif what == 'avocat' then
		return avocat
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	SendNUIMessage({
		action = 'setID',
		id_label = GetPlayerServerId(PlayerId())
	})
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		if isTalking == false then
			if NetworkIsPlayerTalking(PlayerId()) then
				isTalking = true
				SendNUIMessage({action = "setTalking", value = true})
			end
		else
			if NetworkIsPlayerTalking(PlayerId()) == false then
				isTalking = false
				SendNUIMessage({action = "setTalking", value = false})
			end
		end
		if not forceDisable then
			if IsPauseMenuActive() then
				SendNUIMessage({action = "toggle", show = false})
			else
				SendNUIMessage({action = "toggle", show = true})
			end
		end
	end
end)


exports('setProx', function(proxString)
	SendNUIMessage({action = "setProximity", value = proxString})
end)

local proximities = {
	{4.0, 'Whisper'},
	{15.0, 'Normal'},
	{40.0, 'Shouting'}
}
local proximity = 2

exports('getProx', function()
	return proximities[proximity]
end)

RegisterCommand('GGHudProximityCycle', function() 
	if allowProximityChange then
		proximity = proximity + 1
		if proximity > #proximities then
			proximity = 1
		end
		NetworkSetTalkerProximity(proximities[proximity][1])
		SendNUIMessage({action = "setProximity", value = proximities[proximity][2]})
	end
end)

RegisterKeyMapping('+GGHudZCheck', 'Informacje o graczach', 'keyboard', 'Z')
RegisterKeyMapping('GGHudProximityCycle', 'Zmiana głośności mówienia', 'keyboard', 'F5')


function getServerTime()
	local hours, minutes = GetClockHours(), GetClockMinutes()
    if hours >= 0 and hours <= 9 then
        hours = '0'..hours
    end

    if minutes >= 0 and minutes <= 9 then
        minutes = '0'..minutes
	end
	
	return tostring(hours..':'..minutes)
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1000)
		local playerCurrentHealth, health_check = GetEntityHealth(PlayerPedId()), 0
		local playerCurrentArmour = GetPedArmour(PlayerPedId())
		local Ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(Ped, false)

		if playerCurrentHealth < 100 then
			health_check = 0
		else 
			health_check = math.floor(playerCurrentHealth - 100)
		end
		
		if IsPedInAnyVehicle(Ped) then
			SendNUIMessage({action = "carHud", status = true})
		else
			SendNUIMessage({action = "carHud", status = false})
		end


		SendNUIMessage({action = "updateHealth", healthPrecent = math.floor(playerCurrentHealth - 100)})

		if armour_up == true then
			SendNUIMessage({action = "updateArmour", armourPrecent = playerCurrentArmour})
		end

		SendNUIMessage({action = "updateEnergy", energyPrecent = math.floor(100 - GetPlayerSprintStaminaRemaining(PlayerId()))})
	end
end)

RegisterNetEvent('ui:toggle')
AddEventHandler('ui:toggle', function(show)
	SendNUIMessage({action = "toggle", show = show})
end)

RegisterNetEvent('esx_customui:updateStatus')
AddEventHandler('esx_customui:updateStatus', function(status)
	SendNUIMessage({action = "updateStatus", status = status})
end)

RegisterNetEvent('adisexe_hud:updateConnectedPlayers')
AddEventHandler('adisexe_hud:updateConnectedPlayers', function(connectedPlayers)
	local lspd, ems, lsc, doj = 0, 0, 0, 0
	local pcount = 0

	for k,v in pairs(connectedPlayers) do
		if v.job == 'police' then
			lspd = lspd + 1			
		elseif v.job == 'ambulance' then
			ems = ems + 1
		elseif v.job == 'mechanic' then
			lsc = lsc + 1
		elseif v.job == 'doj' then
			doj = doj + 1
		elseif v.job == 'avocat' then
			doj = doj + 1
		end
		pcount = pcount + 1
	end

	SendNUIMessage({
		action = 'updateJobs',
		jobs = {lspd = lspd, ems = ems, lsc = lsc, doj = doj}
	})

	SendNUIMessage({
		action = 'updatepCount',
		count = pcount
	})
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		SendNUIMessage({
			action = 'setID',
			id_label = GetPlayerServerId(PlayerId())
		})
	end
end)