local holdingUp = false
local store = ""
local blipRobbery = nil
ESX = nil
local PlayerData                = {}
local dualjob = nil

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

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
		
		Citizen.Wait(250)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_holdup:currentlyRobbing')
AddEventHandler('esx_holdup:currentlyRobbing', function(currentStore)
	holdingUp, store = true, currentStore
end)

RegisterNetEvent('esx_holdup:killBlip')
AddEventHandler('esx_holdup:killBlip', function()
	if blipRobbery ~= nil then
		RemoveBlip(blipRobbery)
	end
end)

RegisterNetEvent('esx_holdup:setBlip')
AddEventHandler('esx_holdup:setBlip', function(position, alert)
	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(blipRobbery, 161)
	SetBlipScale(blipRobbery, 2.0)
	SetBlipColour(blipRobbery, 3)

	PulseBlip(blipRobbery)

	TriggerEvent('chat:addMessage1',"^0[^3Centrala^0]", {0, 0, 0}, alert, "fas fa-laptop")
end)

RegisterNetEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function()
	holdingUp, store = false, ''
	ESX.ShowNotification(_U('robbery_cancelled'))
end)

RegisterNetEvent('esx_holdup:robberyComplete')
AddEventHandler('esx_holdup:robberyComplete', function(award)
	holdingUp, store = false, ''
	Citizen.InvokeNative(0xAAA34F8A7CB32098, PlayerPedId())
	ESX.ShowNotification(_U('robbery_complete', award))
end)

RegisterNetEvent('esx_holdup:animation')
AddEventHandler('esx_holdup:animation', function(code)
	local ped = PlayerPedId()
	ClearPedTasks(ped)
		
	if code.scenario then
		SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, 1)
		Citizen.Wait(2000)
		TaskStartScenarioInPlace(ped, code.scenariotick, 0, true)		
	else
		RequestAnimDict(code.dict)
		while not HasAnimDictLoaded(code.dict) do
			Citizen.Wait(100)
		end		
		
		TaskPlayAnim(PlayerPedId(), code.dict, code.tick, 1.0, -8.0, 200000, 1, 1, true, false, true)
	end
end)

RegisterNetEvent('esx_holdup:startTimer')
AddEventHandler('esx_holdup:startTimer', function(timer)
	CreateThread(function()
		while timer > 0 and holdingUp do
			Citizen.Wait(1000)
			
			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	CreateThread(function()
		while holdingUp do
			Citizen.Wait(1)
			DisableControlAction(0, Keys['F1'], true)
			DisableControlAction(0, Keys['G'], true)
			DisableControlAction(0, Keys['X'], true)
			DisableControlAction(0, Keys['F3'], true)
			DisableControlAction(0, Keys['K'], true)
			DisableControlAction(0, Keys['TAB'], true)
			DisableControlAction(0, Keys['1'], true)
			DisableControlAction(0, Keys['2'], true)
			DisableControlAction(0, Keys['3'], true)
			DisableControlAction(0, Keys['4'], true)
			DisableControlAction(0, Keys['5'], true)
			DisableControlAction(0, Keys['6'], true)
			DisableControlAction(0, Keys['7'], true)
			DisableControlAction(0, Keys['8'], true)
			DisableControlAction(0, Keys['9'], true)
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, _U('robbery_timer', timer), 255, 255, 255, 255)
		end
	end)
end)

CreateThread(function()
	for k,v in pairs(Stores) do
		local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
		SetBlipSprite(blip, v.blip.id)
		SetBlipScale(blip, v.blip.scale)
		SetBlipColour(blip, v.blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.blip.label)
		EndTextCommandSetBlipName(blip)
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPos, sleep = GetEntityCoords(PlayerPedId(), true), true

		for k,v in pairs(Stores) do
			local storePos = v.position
			local distance = #(playerPos - vec3(storePos.x, storePos.y, storePos.z))

			if distance < 10 then
				sleep = false
				if not holdingUp then
					ESX.DrawMarker(vec3(storePos.x, storePos.y, storePos.z - 0.9))
					
					if distance < 2 then
						ESX.ShowFloatingHelpNotification('~b~ NAPAD NA ~s~[~b~'..v.name..'~s~]', vec3(storePos.x, storePos.y, storePos.z + 0.1))
					end
					
					if distance < 1.5 then
						ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby rozpocząć ~r~napad~s~')
						if IsControlJustReleased(0, Keys['E']) then
							if IsPedArmed(PlayerPedId(), 4) then
								TriggerServerEvent('esx_holdup:robberyStarted', k)
							else
								ESX.ShowNotification(_U('no_threat'))
							end
						end
					end
					
				end
			end
		end

		if holdingUp then
			local storePos = Stores[store].position
			local taki = Stores[store].name
			if Vdist(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z) > Config.MaxDistance then
				sleep = false
				TriggerServerEvent('esx_holdup:tooFar', store)
				Citizen.Wait(1000)
			end
		end
		
		if sleep then
			Citizen.Wait(500)
		end
	end
end)
