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

ESX = nil
local IsDead = false
components = {
	silencieux = true,
	flashlight = true,
	grip = true,
	scope = true,
	scope2 = true,
}

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
        
		Citizen.Wait(250)
    end
end)

local Camera = false
CreateThread(function()
	while true do
		Citizen.Wait(500)		
		if ESX.PlayerData and ESX.PlayerData.inventory then
			local disableCamera = true
			for i = 1, #ESX.PlayerData.inventory, 1 do
				if ESX.PlayerData.inventory[i].name == 'camera' and ESX.PlayerData.inventory[i].count > 0 then
					disableCamera = false
					break
				end
			end
			
			if disableCamera then
				Camera = false
			end
		end
	end
end)

CreateThread(function()
    RequestStreamedTextureDict('mpleaderboard')
    while not HasStreamedTextureDictLoaded('mpleaderboard') do
        Citizen.Wait(1)
    end

	while true do
		Citizen.Wait(1)
		if Camera then
			DrawSprite('mpleaderboard', 'leaderboard_car_colour_bg', 0.99, 0.9805, 0.015, 0.0275, 0.0, 255, 0, 0, 255)
		end
	end
end)

RegisterNetEvent('esx_extraitems:camera')
AddEventHandler('esx_extraitems:camera', function()
	Camera = not Camera
	if Camera then
		ESX.ShowNotification('~g~Włączono~s~ nagrywanie')
	else
		ESX.ShowNotification('~r~Wyłączono~s~ nagrywanie')
	end
end)

local SilencerWeapons = {
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
	["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_SUPP_02",
	["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_SUPP_02",
	["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_SUPP",
	["WEAPON_MARKSMANRIFLE"] = "COMPONENT_AT_AR_SUPP",
	["WEAPON_SNIPERRIFLE"] = "COMPONENT_AT_AR_SUPP_02",
	["WEAPON_1911PISTOL"] = "COMPONENT_AT_PI_SUPP",
	["WEAPON_CERAMICPISTOL"] = "COMPONENT_CERAMICPISTOL_SUPP",
}

local FlashLightWeapons = {
	["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_03",
	["WEAPON_PISTOL"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_02",
	["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_HEAVYPISTOL"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_PUMPSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_BULLPUPSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_MICROSMG"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_SMG"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_SMG_MK2"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_COMBATPDW"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_MARKSMANRIFLE"] = "COMPONENT_AT_AR_FLSH"
}

local GripWeapons = {
	["WEAPON_BULLPUPSHOTGUN"] = "COMPONENT_AT_AR_AFGRIP",
	["WEAPON_COMBATPDW"] = "COMPONENT_AT_AR_AFGRIP",
	["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_AFGRIP",
	["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_AFGRIP",
	["WEAPON_MARKSMANRIFLE"] = "COMPONENT_AT_AR_AFGRIP"
}

local ExtendedMagazineWeapons = {
	["WEAPON_SNSPISTOL"] = "COMPONENT_SNSPISTOL_CLIP_02",
	["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_SNSPISTOL_MK2_CLIP_02",
	["WEAPON_VINTAGEPISTOL"] = "COMPONENT_VINTAGEPISTOL_CLIP_02",
	["WEAPON_PISTOL"] = "COMPONENT_PISTOL_CLIP_02",
	["WEAPON_PISTOL_MK2"] = "COMPONENT_PISTOL_MK2_CLIP_02",
	["WEAPON_COMBATPISTOL"] = "COMPONENT_COMBATPISTOL_CLIP_02",
	["WEAPON_HEAVYPISTOL"] = "COMPONENT_HEAVYPISTOL_CLIP_02",
	["WEAPON_MICROSMG"] = "COMPONENT_MICROSMG_CLIP_02",
	["WEAPON_SMG"] = "COMPONENT_SMG_CLIP_02",
	["WEAPON_SMG_MK2"] = "COMPONENT_SMG_MK2_CLIP_02",
	["WEAPON_ASSAULTSMG"] = "COMPONENT_ASSAULTSMG_CLIP_02",
	["WEAPON_COMBATPDW"] = "COMPONENT_COMBATPDW_CLIP_02",
	["WEAPON_GUSENBERG"] = "COMPONENT_GUSENBERG_CLIP_02",
	["WEAPON_COMPACTRIFLE"] = "COMPONENT_COMPACTRIFLE_CLIP_02",
	["WEAPON_ASSAULTRIFLE"] = "COMPONENT_ASSAULTRIFLE_CLIP_02",
	["WEAPON_CARBINERIFLE"] = "COMPONENT_CARBINERIFLE_CLIP_02",
	["WEAPON_MARKSMANRIFLE"] = "COMPONENT_MARKSMANRIFLE_CLIP_02",
	["WEAPON_1911PISTOL"] = "COMPONENT_1911PISTOL_CLIP_02",
	["WEAPON_CERAMICPISTOL"] = "COMPONENT_CERAMICPISTOL_CLIP_02"
}

local VeryExtendedMagazineWeapons = {
	["WEAPON_SMG"] = "COMPONENT_SMG_CLIP_03",
	["WEAPON_COMBATPDW"] = "COMPONENT_COMBATPDW_CLIP_03",
	["WEAPON_COMPACTRIFLE"] = "COMPONENT_COMPACTRIFLE_CLIP_03",
	["WEAPON_ASSAULTRIFLE"] = "COMPONENT_ASSAULTRIFLE_CLIP_03",
	["WEAPON_CARBINERIFLE"] = "COMPONENT_CARBINERIFLE_CLIP_03"
}

local ScopeWeapons = {
	["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_RAIL_02",
	["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_RAIL",
	["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SCOPE_MACRO_MK2",
	["WEAPON_MICROSMG"] = "COMPONENT_AT_SCOPE_MACRO",
	["WEAPON_SMG"] = "COMPONENT_AT_SCOPE_MACRO_02",
	["WEAPON_SMG_MK2"] = "COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
	["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_SCOPE_MACRO",
	["WEAPON_COMBATPDW"] = "COMPONENT_AT_SCOPE_SMALL",
	["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_SCOPE_MACRO",
	["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_SCOPE_MEDIUM",
	["WEAPON_MARKSMANRIFLE"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
	["WEAPON_SNIPERRIFLE"] = "COMPONENT_AT_SCOPE_LARGE"
}

local AdvancedScopeWeapons = {
	["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SCOPE_SMALL_MK2",
	["WEAPON_SMG_MK2"] = "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
	["WEAPON_MARKSMANRIFLE"] = "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2",
	["WEAPON_SNIPERRIFLE"] = "COMPONENT_AT_SCOPE_MAX"
}

RegisterNetEvent('exile_accessories:equipSilencer')
AddEventHandler('exile_accessories:equipSilencer', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	
	local Equip = false
	for weapon, component in pairs(SilencerWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			GiveWeaponComponentToPed(PlayerPed, GetHashKey(weapon), GetHashKey(component))
			Equip = true
			ESX.ShowNotification('Zamontowano tłumik')
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)	
		end
	end
	
	if not Equip then
		ESX.ShowNotification('Nie możesz założyć tłumika do tej broń')
	end
end)

RegisterNetEvent('exile_accessories:unequipSilencer')
AddEventHandler('exile_accessories:unequipSilencer', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	
	local Equip = false
	for weapon, component in pairs(SilencerWeapons) do
		if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(component)) then
			RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(component))
			Equip = true
			ESX.ShowNotification('Zdemontowano tłumik')
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
		end
	end
	
	if not Equip then
		ESX.ShowNotification("Ta broń nie posiada tego dodatku")
	end
end)

RegisterNetEvent('exile_accessories:equipFlashlight')
AddEventHandler('exile_accessories:equipFlashlight', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(FlashLightWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			GiveWeaponComponentToPed(PlayerPed, GetHashKey(weapon), GetHashKey(component))
			Equip = true
			ESX.ShowNotification('Zamontowano latarkę taktyczną')
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
		end
	end

	if not Equip then
		ESX.ShowNotification('Nie możesz założyć latarki taktycznej do tej broń')
	end
end)

RegisterNetEvent('exile_accessories:unequipFlashlight')
AddEventHandler('exile_accessories:unequipFlashlight', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(FlashLightWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(component)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(component))
				ESX.ShowNotification('Zdemontowano latarkę taktyczną')
				local Equip = true
				PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
			end
		end
	end
	
	if not Equip then
		ESX.ShowNotification('Ta broń nie posiada tego dodatku')
	end
end)

RegisterNetEvent('exile_accessories:equipGrip')
AddEventHandler('exile_accessories:equipGrip', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(GripWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			GiveWeaponComponentToPed(PlayerPed, GetHashKey(weapon), GetHashKey(component))
			Equip = true
			ESX.ShowNotification('Zamontowano chwyt')
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
		end
	end

	if not Equip then
		ESX.ShowNotification('Nie możesz założyć chwytu do tej broni')
	end
end)

RegisterNetEvent('exile_accessories:unequipGrip')
AddEventHandler('exile_accessories:unequipGrip', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(GripWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(component)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(component))
				ESX.ShowNotification('Zdemontowano chwyt')
				Equip = true
				PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
			else
				ESX.ShowNotification('Ta broń nie posiada tego dodatku')
			end
		end
	end
	
	if not Equip then
		ESX.ShowNotification('Ta broń nie posiada tego dodatku')
	end
end)

RegisterNetEvent('exile_accessories:equipExtendedMag')
AddEventHandler('exile_accessories:equipExtendedMag', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(ExtendedMagazineWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			GiveWeaponComponentToPed(PlayerPed, GetHashKey(weapon), GetHashKey(component))
			Equip = true
			ESX.ShowNotification('Zamontowano powiększony magazynek')
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
		end
	end

	if not Equip then
		ESX.ShowNotification('Nie możesz założyć powiększonego magazynku do tej broni')
	end
end)

RegisterNetEvent('exile_accessories:unequipEmag')
AddEventHandler('exile_accessories:unequipEmag', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(ExtendedMagazineWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(component)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(component))
				Equip = true
				ESX.ShowNotification('Zdemontowano powiększony magazynek')
				PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
			end
		end
	end
	
	if not Equip then
		ESX.ShowNotification('Ta broń nie posiada tego dodatku')
	end
end)

RegisterNetEvent('exile_accessories:equipVeryExtendedMag')
AddEventHandler('exile_accessories:equipVeryExtendedMag', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(VeryExtendedMagazineWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			GiveWeaponComponentToPed(PlayerPed, GetHashKey(weapon), GetHashKey(component))
			Equip = true
			ESX.ShowNotification('Zamontowano magazynek bębnowy')
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
		end
	end

	if not Equip then
		ESX.ShowNotification('Nie możesz założyć magazynku bębnowego do tej broni')
	end
end)

RegisterNetEvent('exile_accessories:unequipVEmag')
AddEventHandler('exile_accessories:unequipVEmag', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(VeryExtendedMagazineWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(component)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(component))
				ESX.ShowNotification('Zdemontowano magazynek bębnowy')
				Equip = true
				PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
			end
		end
	end
	
	if not Equip then
		ESX.ShowNotification('Ta broń nie posiada tego dodatku')
	end
end)

RegisterNetEvent('exile_accessories:equipScope')
AddEventHandler('exile_accessories:equipScope', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(ScopeWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			GiveWeaponComponentToPed(PlayerPed, GetHashKey(weapon), GetHashKey(component))
			Equip = true
			ESX.ShowNotification('Zamontowano celownik')
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
		end
	end

	if not Equip then
		ESX.ShowNotification('Nie możesz założyć celownika do tej broni')
	end
end)

RegisterNetEvent('exile_accessories:unequipScope')
AddEventHandler('exile_accessories:unequipScope', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(ScopeWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(component)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(component))
				Equip = true
				ESX.ShowNotification('Zdemontowano celownik')
				PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
			end
		end
	end
	
	if not Equip then
		ESX.ShowNotification('Ta broń nie posiada tego dodatku')
	end
end)

RegisterNetEvent('exile_accessories:equipAdvancedScope')
AddEventHandler('exile_accessories:equipAdvancedScope', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(AdvancedScopeWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			GiveWeaponComponentToPed(PlayerPed, GetHashKey(weapon), GetHashKey(component))
			Equip = true
			ESX.ShowNotification('Zamontowano zaawansowany celownik')
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
		end
	end

	if not Equip then
		ESX.ShowNotification('Nie możesz założyć zaawansowanego celownika do tej broni')
	end
end)

RegisterNetEvent('exile_accessories:unequipAdvancedScope')
AddEventHandler('exile_accessories:unequipAdvancedcope', function()
	local PlayerPed = PlayerPedId()
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)

	local Equip = false
	for weapon, component in pairs(AdvancedScopeWeapons) do
		if GetHashKey(weapon) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(component)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(component))
				ESX.ShowNotification('Zdemontowano zaawansowany celownik')
				Equip = true
				PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
			end
		end
	end
	
	if not Equip then
		ESX.ShowNotification('Ta broń nie posiada tego dodatku')
	end
end)

RegisterNetEvent('exile_accessories:looseComponent')
AddEventHandler('exile_accessories:looseComponent', function(component)
	local playerPed, any = PlayerPedId(), false
	
	if component == "silencieux" then
		for k, v in pairs(SilencerWeapons) do
			if HasPedGotWeapon(playerPed, GetHashKey(k), false) and HasPedGotWeaponComponent(playerPed, GetHashKey(k), GetHashKey(v)) then
				RemoveWeaponComponentFromPed(playerPed, GetHashKey(k), GetHashKey(v))				
				if not any then
					any = true
				end
			end
		end
	elseif component == "flashlight" then
		for k, v in pairs(FlashLightWeapons) do
			if HasPedGotWeapon(playerPed, GetHashKey(k), false) and HasPedGotWeaponComponent(playerPed, GetHashKey(k), GetHashKey(v)) then
				RemoveWeaponComponentFromPed(playerPed, GetHashKey(k), GetHashKey(v))
				if not any then
					any = true
				end
			end
		end
	elseif component == "grip" then
		for k, v in pairs(GripWeapons) do
			if HasPedGotWeapon(playerPed, GetHashKey(k), false) and HasPedGotWeaponComponent(playerPed, GetHashKey(k), GetHashKey(v)) then
				RemoveWeaponComponentFromPed(playerPed, GetHashKey(k), GetHashKey(v))
				if not any then
					any = true
				end
			end
		end
	elseif component == "bron_magazynek" then
		for k, v in pairs(ExtendedMagazineWeapons) do
			if HasPedGotWeapon(playerPed, GetHashKey(k), false) and HasPedGotWeaponComponent(playerPed, GetHashKey(k), GetHashKey(v)) then
				RemoveWeaponComponentFromPed(playerPed, GetHashKey(k), GetHashKey(v))
				if not any then
					any = true
				end
			end
		end
	elseif component == "bron_magazynek_powiekszony" then
		for k, v in pairs(VeryExtendedMagazineWeapons) do
			if HasPedGotWeapon(playerPed, GetHashKey(k), false) and HasPedGotWeaponComponent(playerPed, GetHashKey(k), GetHashKey(v)) then
				RemoveWeaponComponentFromPed(playerPed, GetHashKey(k), GetHashKey(v))
				if not any then
					any = true
				end
			end
		end
	elseif component == "scope" then
		for k, v in pairs(ScopeWeapons) do
			if HasPedGotWeapon(playerPed, GetHashKey(k), false) and HasPedGotWeaponComponent(playerPed, GetHashKey(k), GetHashKey(v)) then
				RemoveWeaponComponentFromPed(playerPed, GetHashKey(k), GetHashKey(v))
				if not any then
					any = true
				end
			end
		end
	elseif component == "scope2" then
		for k, v in pairs(AdvancedScopeWeapons) do
			if HasPedGotWeapon(playerPed, GetHashKey(k), false) and HasPedGotWeaponComponent(playerPed, GetHashKey(k), GetHashKey(v)) then
				RemoveWeaponComponentFromPed(playerPed, GetHashKey(k), GetHashKey(v))
				if not any then
					any = true
				end
			end
		end
	end

	if any then
		PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
	end
end)


RegisterNetEvent('exile_kamza')
AddEventHandler('exile_kamza', function(typ)
	local playerPed = PlayerPedId()
	if typ == 'small' then
        Citizen.InvokeNative(0xCEA04D83135264CC, playerPed, 25)
		ESX.PlayAnim('clothingshirt', 'try_shirt_neutral_c', 8.0, -1, 0)
		Wait(1000)
		SetPedComponentVariation(playerPed, 9, 27, 9, 2)
	elseif typ == 'big' then
        Citizen.InvokeNative(0xCEA04D83135264CC, playerPed, 50)
		ESX.PlayAnim('clothingshirt', 'try_shirt_neutral_c', 8.0, -1, 0)
		Wait(1000)
		SetPedComponentVariation(playerPed, 9, 15, 2, 2)
    elseif typ == 'skarpetka' then
		ESX.PlayAnim('clothingshirt', 'try_shirt_neutral_c', 8.0, -1, 0)
		Wait(1000)
		SetPedComponentVariation(playerPed, 1, 32, 0, 0)
	end
end)