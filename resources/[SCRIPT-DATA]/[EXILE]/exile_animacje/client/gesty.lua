Keys = {
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

local crosshands = false
local handsUp = false
local PlayerData = {}
local mp_pointing = false
local keyPressed = false

--[[local function startPointing()
    local ped = PlayerPedId()

    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end]]

local function startPointing()
	local ped = GetPlayerPed(-1)
	RequestAnimDict("anim@mp_point")
	while not HasAnimDictLoaded("anim@mp_point") do
			Wait(0)
	end
	SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
	SetPedConfigFlag(ped, 36, 1)
	Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
	RemoveAnimDict("anim@mp_point")
end

--[[local function stopPointing()
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end]]

local function stopPointing()
	local ped = GetPlayerPed(-1)
	Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
	if not IsPedInjured(ped) then
			ClearPedSecondaryTask(ped)
	end
	if not IsPedInAnyVehicle(ped, 1) then
			SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
	end
	SetPedConfigFlag(ped, 36, 0)
	ClearPedSecondaryTask(PlayerPedId())
end


ESX = nil
CreateThread(function()
	while ESX == nil do
		TriggerEvent('hypex:getTwojStarySharedTwojaStaraObject', function(obj) 
			ESX = obj 
		end)
		
		Citizen.Wait(250)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
	allowed = (PlayerData.job and ((PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice') or (PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'offsheriff')))
	while handsUp do
		Citizen.Wait(3)
		DisableControlAction(2, 24, true) -- Attack
		DisableControlAction(2, 257, true) -- Attack 2
		DisableControlAction(2, 25, true) -- Aim
		DisableControlAction(2, 263, true) -- Melee Attack 1
		DisableControlAction(2, 45, true) -- Reload
		DisableControlAction(2, 37, true) -- Select Weapon
		DisableControlAction(2, 288, true) -- Disable phone
		DisableControlAction(2, 23, true) -- Also 'enter'?
		DisableControlAction(0, 47, true)  -- Disable weapon
		DisableControlAction(0, 264, true) -- Disable melee
		DisableControlAction(0, 257, true) -- Disable melee
		DisableControlAction(0, 140, true) -- Disable melee
		DisableControlAction(0, 141, true) -- Disable melee
		DisableControlAction(0, 142, true) -- Disable melee
		DisableControlAction(0, 143, true) -- Disable melee
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
	PlayerData.hiddenjob = hiddenjob
end)



RegisterCommand('receg', function(source, args, rawCommand)
	if Ped.Active then
		local status = true
		if Ped.Available and not Ped.InVehicle and Ped.Visible and Ped.Collection then
			status = false
			if not IsEntityPlayingAnim(Ped.Id, "amb@world_human_hang_out_street@female_arms_crossed@base", "base", 3) then
				crosshands = false
			end

			if IsControlJustPressed(1, Keys["G"]) then
				crosshands = not crosshands
				if not crosshands then
					ClearPedSecondaryTask(Ped.Id)
				else
					TaskPlayAnim(Ped.Id, "amb@world_human_hang_out_street@female_arms_crossed@enter", "enter", 8.0, 8.0, -1, 16, 0, false, false, false)
					Citizen.Wait(2000)
					TaskPlayAnim(Ped.Id, "amb@world_human_hang_out_street@female_arms_crossed@base", "base", 8.0, 8.0, -1, 49, 0, false, false, false)
				end
			end
		end
		if status and crosshands then
			crosshands = false
			if not Ped.Locked then
				ClearPedSecondaryTask(Ped.Id)
			end
		end
	elseif crosshands then
		crosshands = false
		if Ped.Available then
			ClearPedSecondaryTask(Ped.Id)
		end
	end
end, false)

RegisterCommand('rece', function()
	if Ped.Active then
		local status = true
		if Ped.Available and not Ped.InVehicle and Ped.Visible and Ped.Collection then
			status = false
			if not Ped.Locked then
				handsUp = not handsUp
				if not handsUp then
					ClearPedSecondaryTask(Ped.Id)
				else
					TaskPlayAnim(Ped.Id, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
				end
			end
		end
		if status and handsUp then
			handsUp = false
			if not Ped.Locked then
				ClearPedSecondaryTask(Ped.Id)
			end
		end
	elseif handsUp then
		handsUp = false
		if Ped.Available then
			ClearPedSecondaryTask(PlayerPedId())
		end
	end
end)
RegisterKeyMapping('rece', 'Ręce do góry','keyboard', 'OEM_3')
RegisterKeyMapping('receg', 'Załóż ręcę','keyboard', 'G')

Citizen.CreateThread(function()
    while true do
        Wait(3)
        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
		else
			if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end

        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
		
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = PlayerPedId()
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)
