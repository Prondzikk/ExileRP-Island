-- KNOCKOUT

local knockedOut = false
local wait = 30

CreateThread(function()
	while true do
		Citizen.Wait(0)
        local myPed = PlayerPedId()
		if HasEntityBeenDamagedByWeapon(myPed, `WEAPON_UNARMED`, 0) or HasEntityBeenDamagedByWeapon(myPed, `WEAPON_NIGHTSTICK`, 0) then
			ClearEntityLastDamageEntity(myPed)
			Citizen.Wait(1000)
			if IsEntityDead(myPed) then
				ClearPedTasks(myPed)
				SetPlayerInvincible(PlayerId(), true)
				wait = 30
				knockedOut = true
				exports["exile_taskbar"]:taskBar(30000, "Jesteś poturbowany", false, true)
				knockedOut = false
				SetEntityHealth(myPed, 120)
				RespawnPed(myPed, GetEntityCoords(myPed), 0.0)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

local inveh = nil

CreateThread(function()
	while true do
		Citizen.Wait(500)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			inveh = true
		else
			inveh = false
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(0)
        local myPed = PlayerPedId()
		if HasEntityBeenDamagedByWeapon(myPed, `WEAPON_RUN_OVER_BY_CAR`, 0) then
			ClearEntityLastDamageEntity(myPed)
			Citizen.Wait(1000)
			if IsEntityDead(myPed) and not inveh then
				ClearPedTasks(myPed)
				SetPlayerInvincible(PlayerId(), true)
				wait = 30
				knockedOut = true
				exports["exile_taskbar"]:taskBar(30000, "Jesteś poturbowany", false, true)
				knockedOut = false
				SetEntityHealth(myPed, 150)
				RespawnPed(myPed, GetEntityCoords(myPed), 0.0)
			end
		else
			Citizen.Wait(400)
		end
	end
end)

CreateThread(function()
	local lastHealth = GetEntityHealth(PlayerPedId())
	while true do
		Citizen.Wait(1000)
		local myPed = PlayerPedId()
		local health = GetEntityHealth(myPed)
		if HasEntityBeenDamagedByWeapon(myPed, `WEAPON_RAMMED_BY_CAR`, 0) then
			ClearEntityLastDamageEntity(myPed)
			if (health ~= lastHealth) then
				SetEntityHealth(myPed, lastHealth)
			end
		end
		lastHealth = health
	end
end)

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
	while true do
		Citizen.Wait(1000)
		if knockedOut then
			wait = wait-1
			if wait <= 0 then
				knockedOut = false
				SetTimecycleModifier("")
				SetTransitionTimecycleModifier("")		
				SetPlayerInvincible(PlayerId(), false)
			end
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(0)
		if knockedOut then
			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(PlayerPedId())
			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
			DisableControlAction(2, Keys['Q'], true) -- Cover
			DisableControlAction(2, Keys['~'], true) -- Hands up
			DisableControlAction(2, Keys['X'], true) -- Cancel Animation
			DisableControlAction(2, Keys['Y'], true) -- Turn off vehicle
			DisableControlAction(2, Keys['PAGEDOWN'], true) -- Crawling
			DisableControlAction(2, Keys['B'], true) -- Pointing
			DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(2, Keys['F1'], true) -- Disable phone
			DisableControlAction(2, Keys['F2'], true) -- Inventory
			DisableControlAction(2, Keys['F3'], true) -- Animations
			DisableControlAction(2, Keys['F6'], true) -- Fraction actions
			DisableControlAction(2, Keys['V'], true) -- Disable changing view
      		DisableControlAction(2, Keys['P'], true) -- Disable pause screen
      		DisableControlAction(2, Keys['U'], true) -- Disable zamykanie auta
			DisableControlAction(2, 59, true) -- Disable steering in vehicle
			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
		else
			Citizen.Wait(500)
		end
	end
end)

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	TriggerEvent("esx:onPlayerSpawn")

	ESX.UI.Menu.CloseAll()
end
