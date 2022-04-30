Config = {
	GunshotAlert = true,
	MeleeAlert = false,

	GunshotOnlyCities = true,
	MeleeOnlyCities = true,

	AlertFade = 18, -- in seconds
	GunpowderTimer = 1, -- in minutes

	AllowedWeapons = {
		["WEAPON_STUNGUN"] = true,
		["WEAPON_SNOWBALL"] = true,
		["WEAPON_BALL"] = true,
		["WEAPON_FLARE"] = true,
		["WEAPON_STICKYBOMB"] = true,
		["WEAPON_FIREEXTINGUISHER"] = true,
		["WEAPON_PETROLCAN"] = true,
		["GADGET_PARACHUTE"] = true,
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_VINTAGEPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_PUMPSHOTGUN"] = "COMPONENT_AT_SR_SUPP",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SR_SUPP_03",
		["WEAPON_BULLPUPSHOTGUN"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_SMG"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_COMBATPDW"] = true,
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_MARKSMANRIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_SNIPERRIFLE"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_1911PISTOL"] = "COMPONENT_AT_PI_SUPP"
	}
}

local PlayerData = {}
local Blips = {}
local _in = Citizen.InvokeNative

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
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

RegisterNetEvent('esx_jb_outlawalert:notifyAccident')
AddEventHandler('esx_jb_outlawalert:notifyAccident', function(coords, text)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipPriority(blip, 4)
	SetBlipScale(blip, 0.9)
	SetBlipSprite(blip, 380)
	SetBlipColour(blip, 2)
	SetBlipAlpha(blip, 250)
	SetBlipAsShortRange(blip, false)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('# Wypadek/Kolizja')
	EndTextCommandSetBlipName(blip)
    TriggerEvent('chat:addMessage', {
        args = {"^0[^3Centrala^0] ", text, 0, 0, 0, 'fas fa-car-crash' }
    })
	--TriggerEvent("chatMessage", '^0[^3Centrala^0]', { 0, 0, 0 }, text)
	table.insert(Blips, blip)
	Citizen.CreateThread(function()
		local alpha = 250
		while alpha > 0 and DoesBlipExist(blip) do
			Citizen.Wait(Config.AlertFade * 4)
			SetBlipAlpha(blip, alpha)
			alpha = alpha - 1

			if alpha == 0 then
				RemoveBlip(blip)
				for i, b in ipairs(Blips) do
					if b == blip then
						table.remove(Blips, i)
						return
					end
				end

				break
			end
		end
	end)
end
end)

RegisterNetEvent('esx_jb_outlawalert:notifyThief')
AddEventHandler('esx_jb_outlawalert:notifyThief', function(coords, text)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipPriority(blip, 4)
	SetBlipScale(blip, 0.9)
	SetBlipSprite(blip, 229)
	SetBlipColour(blip, 5)
	SetBlipAlpha(blip, 250)
	SetBlipAsShortRange(blip, false)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('# Kradzież/Uprowadzenie pojazdu')
	EndTextCommandSetBlipName(blip)
    TriggerEvent('chat:addMessage', {
        args = {"^0[^3Centrala^0] ", text, 0, 0, 0, 'fas fa-user-secret' }
    })
	--TriggerEvent("chatMessage", '^0[^3Centrala^0]', { 0, 0, 0 }, text)
	table.insert(Blips, blip)
	Citizen.CreateThread(function()
		local alpha = 250
		while alpha > 0 and DoesBlipExist(blip) do
			Citizen.Wait(Config.AlertFade * 4)
			SetBlipAlpha(blip, alpha)
			alpha = alpha - 1

			if alpha == 0 then
				RemoveBlip(blip)
				for i, b in ipairs(Blips) do
					if b == blip then
						table.remove(Blips, i)
						return
					end
				end

				break
			end
		end
	end)
end
end)

RegisterNetEvent('esx_jb_outlawalert:notifyShots')
AddEventHandler('esx_jb_outlawalert:notifyShots', function(coords, text, isPolice)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipPriority(blip, 6)
	SetBlipScale(blip, 0.9)
	SetBlipSprite(blip, 432)
	SetBlipColour(blip, (isPolice and 3 or 76))
	SetBlipAlpha(blip, 250)
	SetBlipAsShortRange(blip, false)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('# Strzały ' .. (isPolice and "policyjne" or "cywilne"))
	EndTextCommandSetBlipName(blip)
    TriggerEvent('chat:addMessage', {
        args = {"^0[^3Centrala^0] ", text, 0, 0, 0, 'fas fa-crosshairs' }
    })
--	TriggerEvent("chatMessage", '^0[^3Centrala^0]', { 0, 0, 0 }, text)
	table.insert(Blips, blip)
	Citizen.CreateThread(function()
		local alpha = 250
		while alpha > 0 and DoesBlipExist(blip) do
			Citizen.Wait(Config.AlertFade * 4)
			SetBlipAlpha(blip, alpha)
			alpha = alpha - 1

			if alpha == 0 then
				RemoveBlip(blip)
				for i, b in ipairs(Blips) do
					if b == blip then
						table.remove(Blips, i)
						return
					end
				end

				break
			end
		end
	end)
end
end)

RegisterNetEvent('esx_jb_outlawalert:notifyCombat')
AddEventHandler('esx_jb_outlawalert:notifyCombat', function(coords, text)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipPriority(blip, 4)
	SetBlipScale(blip, 0.9)
	SetBlipSprite(blip, 468)
	SetBlipColour(blip, 6)
	SetBlipAlpha(blip, 250)
	SetBlipAsShortRange(blip, false)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('# Bójka')
	EndTextCommandSetBlipName(blip)
    TriggerEvent('chat:addMessage', {
        args = {"^0[^3Centrala^0] ", text, 0, 0, 0, 'fas fa-fist-raised' }
    })
	--TriggerEvent("chatMessage", '^0[^3Centrala^0]', { 0, 0, 0 }, text)
	table.insert(Blips, blip)
	Citizen.CreateThread(function()
		local alpha = 250
		while alpha > 0 and DoesBlipExist(blip) do
			Citizen.Wait(Config.AlertFade * 4)
			SetBlipAlpha(blip, alpha)
			alpha = alpha - 1

			if alpha == 0 then
				RemoveBlip(blip)
				for i, b in ipairs(Blips) do
					if b == blip then
						table.remove(Blips, i)
						return
					end
				end

				break
			end
		end
	end)
end
end)


RegisterNetEvent('drugPlace')
AddEventHandler('drugPlace', function(coords, photo, id, gender, alert, skin)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blip, 51)
		SetBlipColour(blip, 7)
		SetBlipAlpha(blip, 250)
		SetBlipAsShortRange(blip, 0)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('# Narkotyki')
		EndTextCommandSetBlipName(blip)
		
		CreateThread(function()
			local alpha = 250
			while true do
				Citizen.Wait(180 * 4)
				SetBlipAlpha(blip, alpha)

				alpha = alpha - 1
				if alpha == 0 then
					RemoveBlip(blip)
					break
				end
			end
		end)
		
		TriggerEvent('chat:addMessage1',"Centrala", {0, 0, 0}, alert, "fas fa-exclamation-circle")
		
		if photo then
			Citizen.CreateThreadNow(function()
				ESX.Game.Utils.RenderHeadshotInternal(GetEntityCoords(PlayerPedId(), false), skin, function(handle, txd)
					TriggerEvent("FeedM:showAdvancedNotification", 'Alarm policyjny', '~r~Narkotyki', (gender and 'Mężczyzna' or 'Kobieta') .. ' sprzedaje narkotyki.', txd, 5000, nil, function()
						UnregisterPedheadshot(handle)
					end)
				end)
			end)
		end
	end
end)


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000)
		if IsPedTryingToEnterALockedVehicle(GetPlayerPed(-1)) or IsPedJacking(GetPlayerPed(-1)) then
			Wait(5000)
			local str = "^3Uprowadzenie pojazdu" 
			if DoesEntityExist(vehicle) then
				vehicle = GetEntityModel(vehicle)

				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				TriggerEvent('esx_vehicleshop:getVehicles', function(base)
					local name = GetDisplayNameFromVehicleModel(vehicle)
					if name ~= 'CARNOTFOUND' then				
						local found = false
						for _, veh in ipairs(base) do
							if (veh.game:len() > 0 and veh.game == name) or veh.model == name then
								name = veh.name
								found = true
								break
							end
						end

						if not found then
							local label = GetLabelText(name)
							if label ~= "NULL" then
								name = label
							end
						end

						str = str .. ' ^0' .. name .. '^3'
					end

					local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
					if s1 ~= 0 and s2 ~= 0 then
						str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1) .. "^3 na skrzyżowaniu z ^0" .. GetStreetNameFromHashKey(s2)
					elseif s1 ~= 0 then
						str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1)
					end

					TriggerServerEvent('esx_jb_outlawalert:notifyThief', {x = coords.x, y = coords.y, z = coords.y}, str)
				end)
			else
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)

				local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
				if s1 ~= 0 and s2 ~= 0 then
					str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1) .. "^3 na skrzyżowaniu z ^0" .. GetStreetNameFromHashKey(s2)
				elseif s1 ~= 0 then
					str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1)
				end

				TriggerServerEvent('esx_jb_outlawalert:notifyThief', {x = coords.x, y = coords.y, z = coords.y}, str)
			end
		end
	end
end)

local shotTimer = 0
CreateThread(function()
	while true do
		Citizen.Wait(100)
		if shotTimer > 0 and not IsPedDeadOrDying(PlayerPedId()) then
			shotTimer = shotTimer - 100
			if shotTimer <= 0 then
				DecorSetBool(PlayerPedId(), "Gunpowder", false)
				shotTimer = 0
			end
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)

		local ped = PlayerPedId()
		if DoesEntityExist(ped) then
			if not DecorIsRegisteredAsType("Gunpowder", 2) then
				DecorRegister("Gunpowder", 2)
				DecorSetBool(ped, "Gunpowder", false)
			end

			if IsPedShooting(ped) then
				if shotTimer == 0 then
					DecorSetBool(ped, "Gunpowder", true)
				end

				local weapon, supress = GetSelectedPedWeapon(ped), nil
				for w, c in pairs(Config.AllowedWeapons) do
					if weapon == GetHashKey(w) then
						if c == true or HasPedGotWeaponComponent(ped, GetHashKey(w), GetHashKey(c)) then
							supress = (c == true)
							break
						end
					end
				end
	
	
				if supress ~= true then
					shotTimer = Config.GunpowderTimer * 60000
					if Config.GunshotAlert then
						local coords = GetEntityCoords(ped)
						if CheckArea(coords, Config.GunshotOnlyCities, (supress == false and 0 or 120)) then
							local isPolice = PlayerData.job and (PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff')
							local str = "^" .. (isPolice and "4" or "8") .. "Uwaga, strzały" .. (isPolice and " policyjne" or "")

							local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
							if s1 ~= 0 and s2 ~= 0 then
								str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1) .. "^" .. (isPolice and "4" or "8") .. " na skrzyżowaniu z ^0" .. GetStreetNameFromHashKey(s2)
							elseif s1 ~= 0 then
								str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1)
							end

							TriggerServerEvent('esx_jb_outlawalert:notifyShots', {x = coords.x, y = coords.y, z = coords.z}, str, isPolice)
							Citizen.Wait(5000)
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000)

		local ped = PlayerPedId()
		if DoesEntityExist(ped) and IsPedInMeleeCombat(ped) then 
			local coords = GetEntityCoords(ped)
			if CheckArea(coords, Config.MeleeOnlyCities, 30) then
				Citizen.Wait(5000)
				if DoesEntityExist(ped) and IsPedInMeleeCombat(ped) then
					local str = "^1Uwaga, bójka"

					local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
					if s1 ~= 0 and s2 ~= 0 then
						str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1) .. "^1 na skrzyżowaniu z ^0" .. GetStreetNameFromHashKey(s2)
					elseif s1 ~= 0 then
						str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1)
					end

					TriggerServerEvent('esx_jb_outlawalert:notifyCombat', {x = coords.x, y = coords.y, z = coords.y}, str)
					Citizen.Wait(10000)
				end
			end
		end
	end
end)

local list = {}
Citizen.CreateThread(function()
	local bigMode = false
	while true do
		Citizen.Wait(1000)
		if PlayerData.job and PlayerData.job.name == 'police' then
			local b = IsBigmapActive()
			if not bigMode and b then
				for _, blip in pairs(Blips) do
					SetBlipAsShortRange(blip, false)
				end
			elseif bigMode and not b then
				for _, blip in pairs(Blips) do
					SetBlipAsShortRange(blip, false)
				end
			end

			bigMode = b
		else
			for _, blip in pairs(Blips) do
				RemoveBlip(blip)
			end

			Blips = {}
		end

		list = {}
		for _, pid in ipairs(GetActivePlayers()) do
			table.insert(list, GetPlayerPed(pid))
		end
	end
end)

function CheckArea(coords, should, dist)
	if not should then
		return true
	end

	local found = false
	for _, ped in ipairs(ESX.Game.GetPeds(list)) do
		local pedType = GetPedType(ped)
		if pedType ~= 28 and pedType ~= 27 and pedType ~= 6 then
			if #(coords - GetEntityCoords(ped)) < dist then
				return true
			end
		end
	end

	return false
end