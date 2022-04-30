-- GLOBALNE
ESX = nil
playerPed = PlayerPedId()
playerid = PlayerId()
playercoords = GetEntityCoords(playerPed)
hudEnabled = true
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

CreateThread(function ()
	while true do
	  if IsControlJustPressed(0, 204) then
		  hudEnabled = not hudEnabled
		  ESX.UI.HUD.SetDisplay((hudEnabled and 1.0) or 0.0)
	  end
	  Citizen.Wait(1)
	end
end)

CreateThread( function()
    while true do
        playerPed = PlayerPedId()
        playerid = PlayerId()
        Citizen.Wait(500)
    end
end)

CreateThread( function()
    while true do
        playercoords = GetEntityCoords(playerPed)
        Citizen.Wait(250)
    end
end)

CreateThread(function()
    while ESX == nil do
        Wait(100)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)


-- Anti kask
CreateThread( function()
	SetPlayerCanDoDriveBy(PlayerId(), false)
    while true do
        Citizen.Wait(0)
        local PlayerVeh = GetVehiclePedIsUsing(playerPed)
        if PlayerVeh ~= 0 then
            SetPedConfigFlag(playerPed, 35, false)
		else
			Citizen.Wait(250)
        end
    end
end)



-- blips
local BLIP_INFO_DATA = {}

function ensureBlipInfo(blip)
    if blip == nil then blip = 0 end
    SetBlipAsMissionCreatorBlip(blip, true)
    if not BLIP_INFO_DATA[blip] then BLIP_INFO_DATA[blip] = {} end
    if not BLIP_INFO_DATA[blip].title then BLIP_INFO_DATA[blip].title = "" end
    if not BLIP_INFO_DATA[blip].rockstarVerified then BLIP_INFO_DATA[blip].rockstarVerified = false end
    if not BLIP_INFO_DATA[blip].info then BLIP_INFO_DATA[blip].info = {} end
    if not BLIP_INFO_DATA[blip].money then BLIP_INFO_DATA[blip].money = "" end
    if not BLIP_INFO_DATA[blip].rp then BLIP_INFO_DATA[blip].rp = "" end
    if not BLIP_INFO_DATA[blip].dict then BLIP_INFO_DATA[blip].dict = "" end
    if not BLIP_INFO_DATA[blip].tex then BLIP_INFO_DATA[blip].tex = "" end
    return BLIP_INFO_DATA[blip]
end

function ResetBlipUni(blip)
    BLIP_INFO_DATA[blip] = nil
end

function SetBlipInfoTitle(blip, title, rockstarVerified)
    local data = ensureBlipInfo(blip)
    data.title = title or ""
    data.rockstarVerified = rockstarVerified or false
end

function SetBlipInfoImage(blip, dict, tex)
    local data = ensureBlipInfo(blip)
    data.dict = dict or ""
    data.tex = tex or ""
end

function SetBlipInfoEconomy(blip, rp, money)
    local data = ensureBlipInfo(blip)
    data.money = tostring(money) or ""
    data.rp = tostring(rp) or ""
end

function SetBlipInfo(blip, info)
    local data = ensureBlipInfo(blip)
    data.info = info
end

function AddBlipInfoText(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    if rightText then
        table.insert(data.info, {1, leftText or "", rightText or ""})
    else
        table.insert(data.info, {5, leftText or "", ""})
    end
end

function AddBlipInfoName(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {3, leftText or "", rightText or ""})
end

function AddBlipInfoHeader(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {4, leftText or "", rightText or ""})
end

function AddBlipInfoIcon(blip, leftText, rightText, iconId, iconColor, checked)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {2, leftText or "", rightText or "", iconId or 0, iconColor or 0, checked or false})
end

local Display = 1
function UpdateDisplay()
    if PushScaleformMovieFunctionN("DISPLAY_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PopScaleformMovieFunctionVoid()
    end
end

function SetColumnState(column, state)
    if PushScaleformMovieFunctionN("SHOW_COLUMN") then
        PushScaleformMovieFunctionParameterInt(column)
        PushScaleformMovieFunctionParameterBool(state)
        PopScaleformMovieFunctionVoid()
    end
end

function ShowDisplay(show)
    SetColumnState(Display, show)
end

function func_36(fParam0)
    BeginTextCommandScaleformString(fParam0)
    EndTextCommandScaleformString()
end

function SetIcon(index, title, text, icon, iconColor, completed)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(1)
        func_36(title)
        func_36(text)
        PushScaleformMovieFunctionParameterInt(icon)
        PushScaleformMovieFunctionParameterInt(iconColor)
        PushScaleformMovieFunctionParameterBool(completed)
        PopScaleformMovieFunctionVoid()
    end
end

function SetText(index, title, text, textType)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(textType or 0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        func_36(title)
        func_36(text)
        PopScaleformMovieFunctionVoid()
    end
end

local _labels = 0
local _entries = 0
function ClearDisplay()
    if PushScaleformMovieFunctionN("SET_DATA_SLOT_EMPTY") then
        PushScaleformMovieFunctionParameterInt(Display)
    end
    PopScaleformMovieFunctionVoid()
    _labels = 0
    _entries = 0
end

function _label(text)
    local lbl = "LBL" .. _labels
    AddTextEntry(lbl, text)
    _labels = _labels + 1
    return lbl
end

function SetTitle(title, rockstarVerified, rp, money, dict, tex)
    if PushScaleformMovieFunctionN("SET_COLUMN_TITLE") then
        PushScaleformMovieFunctionParameterInt(Display)
        func_36("")
        func_36(_label(title))
        PushScaleformMovieFunctionParameterInt(rockstarVerified)
        PushScaleformMovieFunctionParameterString(dict)
        PushScaleformMovieFunctionParameterString(tex)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)

        if rp == "" then
            PushScaleformMovieFunctionParameterBool(0)
        else
            func_36(_label(rp))
        end

        if money == "" then
            PushScaleformMovieFunctionParameterBool(0)
        else
            func_36(_label(money))
        end
    end

    PopScaleformMovieFunctionVoid()
end

function AddText(title, desc, style)
    SetText(_entries, _label(title), _label(desc), style or 1)
    _entries = _entries + 1
end

function AddIcon(title, desc, icon, color, checked)
    SetIcon(_entries, _label(title), _label(desc), icon, color, checked)
    _entries = _entries + 1
end

CreateThread(function()
    local current = nil
    while true do
        Citizen.Wait(0)
        if N_0x3bab9a4e4f2ff5c7() then
            local blip = DisableBlipNameForVar()
            if N_0x4167efe0527d706e() then
                if DoesBlipExist(blip) then
                    if current ~= blip then
                        current = blip
                        if BLIP_INFO_DATA[blip] then
                            local data = ensureBlipInfo(blip)
                            N_0xec9264727eec0f28()
                            ClearDisplay()

                            SetTitle(data.title, data.rockstarVerified, data.rp, data.money, data.dict, data.tex)
                            for _, info in next, data.info do
                                if info[1] == 2 then
                                    AddIcon(info[2], info[3], info[4], info[5], info[6])
                                else
                                    AddText(info[2], info[3], info[1])
                                end
                            end

                            ShowDisplay(true)
                            UpdateDisplay()
                            N_0x14621bb1df14e2b2()
                        else
                            ShowDisplay(false)
                        end
                    end
                end
            else
                if current then
                    current = nil
                    ShowDisplay(false)
                end
            end
        else
            Wait(250)
        end
    end
end)

RegisterCommand("bwrefresh", function(source, args, rawCommand)
    local zakutybyl = false
    if moze then
        if IsEntityDead(playerPed) then

            if IsPedCuffed(playerPed) then
                zakutybyl = true
            end
            moze = false
            NetworkResurrectLocalPlayer(playercoords, true, true, false)
            SetPlayerInvincible(playerPed, false)

            SetEntityHealth(playerPed, 0) -- slay

            if zakutybyl then
                TriggerServerEvent('esx_policejob:handcuffhype', GetPlayerServerId(PlayerId(-1)))
            end
        else
            ESX.ShowNotification("Nie jesteś martwy")
        end
    else
        ESX.ShowNotification("Musisz poczekać aby tego użyć")
    end

    Citizen.Wait(120*1000)
    moze = true
end, false)

local strike = 0
local newPlayer = false
 
Config = {
	FirstPersonShoot = true,
	
	AdjustDensity = true,
	Density = {
		CitizenDefault = 0.1,
		CitizenDriver = 0.02,
		CitizenPassengers = 0.02,
		VehicleDefault = 0.1,
		VehicleDriver = 0.02,
		VehiclePassengers = 0.02
	},
	
	DisplayCrosshair = {
		'WEAPON_SNIPERRIFLE',
		'WEAPON_HEAVYSNIPER',
		'WEAPON_HEAVYSNIPER_MK2',
		'WEAPON_MARKSMANRIFLE',
		'WEAPON_MARKSMANRIFLE_MK2'
	},
	
	Pumps = {
		"WEAPON_DBSHOTGUN",
		"WEAPON_SAWNOFFSHOTGUN",
		"WEAPON_PUMPSHOTGUN_MK2",
		"WEAPON_PUMPSHOTGUN"
	},
	
	SUPPRESSED_MODELS = {
		"SHAMAL", 
		"LUXOR", 
		"LUXOR2", 
		"JET",
		"LAZER",
		"TITAN",
		"BARRACKS", 
		"BARRACKS2", 
		"CRUSADER",
		"AIRTUG", 
		"RIPLEY",
	},
	
    SCENARIO_TYPES = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", 
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
    },
	
    SCENARIO_GROUPS = {
        2017590552,
        2141866469, 
        1409640232, 
        "ng_planes", 
    },
	
	StashWeapons = {
		{name = 'WEAPON_ASSAULTSMG', label = 'Assault smg', instash=true},
		{name = 'WEAPON_COMBATPDW', label = 'Combat pdw', instash=true},
		{name = 'WEAPON_ASSAULTRIFLE', label = 'Assault rifle', instash=true},
		{name = 'WEAPON_ASSAULTRIFLE_MK2', label = 'Assault rifle MK2', instash=true},
		{name = 'WEAPON_HEAVYRIFLE', label = 'Heavy rifle', instash=true},
		{name = 'WEAPON_FERTILIZERCAN', label = 'Fertilizer Can', instash=true},
		{name = 'WEAPON_EMPLAUNCHER', label = 'EMP Launcher', instash=true},
		{name = 'WEAPON_PIPEBOMB', label = 'Pipe Bomb', instash=true},
		{name = 'WEAPON_CARBINERIFLE', label = 'Carbine rifle', instash=true},
		{name = 'WEAPON_REVOLVER_MK2', label= 'Revolver MK2', instash=true},
		{name = 'WEAPON_ADVANCEDRIFLE', label= 'Zaawansowany Karabin', instash=true},
		{name = 'WEAPON_SPECIALCARBINE', label= 'Special carbine', instash=true},
		{name = 'WEAPON_BULLPUPRIFLE', label='Bullpup Rifle', instash=true},
		{name = 'WEAPON_COMPACTRIFLE', label= 'Compactrifle', instash=true},
		{name = 'WEAPON_PUMPSHOTGUN', label='Pumpshotgun', instash=true},
		{name = 'WEAPON_BULLPUPSHOTGUN', label='Bullpup shotgun', instash=true},
		{name = 'WEAPON_ASSAULTSHOTGUN', label='Assaut shotgun', instash=true},
		{name = 'WEAPON_HEAVYSHOTGUN', label='Heavy shotgun', instash=true},
		{name = 'WEAPON_SAWNOFFSHOTGUN', label='Sawoff shotgun', instash=true},
		{name = 'WEAPON_MILITARYRIFLE', label='Military Rifle', instash=true},
		{name = 'WEAPON_MUSKET', label='Musket', instash=true},
		{name = 'WEAPON_DBSHOTGUN', label='DB shotgun', instash=true},
		{name = 'WEAPON_AUTOSHOTGUN', label='Auto shotgun', instash=true},
		{name = 'WEAPON_COMBATMG', label='Combat smg', instash=true},
		{name = 'WEAPON_MG', label='Mg', instash=true},
		{name = 'WEAPON_SMG', label='SMG', instash=true},
		{name = 'WEAPON_GUSENBERG', label='Gunseberg', instash=true},
		{name = 'WEAPON_HEAVYSNIPER', label='Heavy Sniper', instash=true},
		{name = 'WEAPON_HEAVYSNIPER_MK2', label='Heavy Sniper MK2', instash=true},
		{name = 'WEAPON_HOMINGLAUNCHER', label='Homing Launcher', instash=true},
		{name = 'WEAPON_COMPACTLAUNCHER', label='Compact Launcher', instash=true},
		{name = 'WEAPON_MINISMG', label='MINISMG', instash=true},
	},

	Weapons = {
		[`WEAPON_ADVANCEDRIFLE`] = 1.0,-- 4 hitów advancedrifle
		[`WEAPON_MILITARYRIFLE`] = 1.3,-- 3 hitów militaryrifle
		[`WEAPON_COMBATPDW`] = 0.8,--6 hitów combatpdw
		[`WEAPON_SPECIALCARBINE`] = 0.9,-- 4 hitów specialcarbine
		[`WEAPON_GUSENBERG`] = 1.0,-- 4 hitów gusenberg
		[`WEAPON_COMPACTRIFLE`] = 0.7,-- 5 hitów compactrifle
		[`WEAPON_CARBINERIFLE`] = 1.1,-- 5 hitów carbinerifle
		[`WEAPON_CARBINERIFLE_MK2`] = 1.0,-- 4 hitów carbinerifle_mk2
		[`WEAPON_HEAVYRIFLE`] = 1.25,-- 3 hitów heavyrifle
		[`WEAPON_COMPACTLAUNCHER`] = 2.0,-- 1 hitów rakietnica
		[`WEAPON_HOMINGLAUNCHER`] = 4.0,-- 1 hitów rakietnica
		[`WEAPON_EMPLAUNCHER`] = 0.0,-- 0 hitów
		[`WEAPON_DBSHOTGUN`] = 8.0,-- 1 hitów pompa
		[`WEAPON_SAWNOFFSHOTGUN`] = 3.5,-- 1 hitów pompa
		[`WEAPON_PUMPSHOTGUN`] = 3.5,-- 1 hitów pompa
		[`WEAPON_BULLPUPSHOTGUN`] = 8.0,-- 1 hitów pompa
		[`WEAPON_SMOKEGRENADE`] = 0.0,-- 0 hitów granat
		[`WEAPON_MINIGUN`] = 15.0,-- 1 hitów minigun
		[`WEAPON_MUSKET`] = 5.0,-- 1 hitów muszkiet
		[`WEAPON_SMG`] = 0.9,--6 hitów smg 
		[`WEAPON_MINISMG`] = 0.8,-- 7 hitów minismg
		[`WEAPON_MICROSMG`] = 0.8,-- 7 hitów microsmg
		[`WEAPON_ASSAULTRIFLE`] = 1.2,-- 3 hitów assualtrifle 
		[`WEAPON_ASSAULTRIFLE_MK2`] = 1.2,-- 3 hitów assualtrifle_mk2
		[`WEAPON_GADGETPISTOL`] = 0.2,-- 3 hitów gadgetpistol
		[`WEAPON_HEAVYPISTOL`] = 1.6,-- 4 hitów heavypistol 
		[`WEAPON_REVOLVER`] = 0.8,-- 2 hitów revolver
		[`WEAPON_DOUBLEACTION`] = 1.0,-- 3 hitów double action revolver
		[`WEAPON_MACHINEPISTOL`] = 0.55,-- 7 hitów machinepistol
	},

	Melees = {
		[`WEAPON_NIGHTSTICK`] = 0.4,
		[`WEAPON_UNARMED`] = 0.1,
		[`WEAPON_GOLFCLUB`] = 0.4,
		[`WEAPON_FLASHLIGHT`] = 0.2,
		[`WEAPON_KNUCKLE`] = 0.7,
		[`WEAPON_BAT`] = 0.7,
		[`WEAPON_CROWBAR`] = 0.4,
		[`WEAPON_HAMMER`] = 0.4,
		[`WEAPON_WRENCH`] = 0.4,
		[`WEAPON_DAGGER`] = 1.0,
		[`WEAPON_MACHETE`] = 1.0,
		[`WEAPON_STONE_HATCHET`] = 1.0,
		[`WEAPON_SWITCHBLADE`] = 1.0,
		[`WEAPON_BATTLEAXE`] = 1.0,
		[`WEAPON_HATCHET`] = 1.0,
		[`WEAPON_KNIFE`] = 1.0
	},
	
	WeaponWhitelistEnabled = true,
	WeaponWhitelist = {
		`WEAPON_UNARMED`,
		`GADGET_PARACHUTE`,
		`GADGET_NIGHTVISION`,
		`WEAPON_BALL`,
		`WEAPON_SNOWBALL`,

		`WEAPON_HEAVYSNIPER`,
		`WEAPON_HEAVYSNIPER_MK2`,

		`WEAPON_HOMINGLAUNCHER`,
		`WEAPON_COMPACTLAUNCHER`,

		`WEAPON_FLARE`,
		`WEAPON_FLASHLIGHT`,
		`WEAPON_KNUCKLE`,
		`WEAPON_BAT`,
		`WEAPON_PISTOL_MK2`,
		`WEAPON_GADGETPISTOL`,

		`WEAPON_SWITCHBLADE`,
		`WEAPON_DAGGER`,
		`WEAPON_MACHETE`,
		`WEAPON_BATTLEAXE`,
		`WEAPON_SNSPISTOL`,
		`WEAPON_SNSPISTOL_MK2`,
		`WEAPON_VINTAGEPISTOL`,
		`WEAPON_PISTOL`,
		`WEAPON_DOUBLEACTION`,
		`WEAPON_DBSHOTGUN`,
		`WEAPON_SAWNOFFSHOTGUN`,
		`WEAPON_PUMPSHOTGUN`,
		`WEAPON_PUMPSHOTGUN_MK2`,
		`WEAPON_MICROSMG`,
		`WEAPON_SMG`,
		`WEAPON_MINISMG`,
		`WEAPON_SMG_MK2`,
		`WEAPON_GUSENBERG`,
		`WEAPON_COMPACTRIFLE`,
		`WEAPON_ASSAULTRIFLE`,
		`WEAPON_STUNGUN_MP`,
		`WEAPON_FERTILIZERCAN`,
		`WEAPON_PROXMINE`,
		`WEAPON_HEAVYRIFLE`,
		`WEAPON_EMPLAUNCHER`,
		`WEAPON_RPG`,
		`WEAPON_MARKSMANRIFLE`,
		`WEAPON_MOLOTOV`,
		`WEAPON_STICKYBOMB`,
		`WEAPON_MG`,
		`WEAPON_CERAMICPISTOL`,
		`WEAPON_MACHINEPISTOL`,

		`WEAPON_STICKYBOMB`,
		`WEAPON_BZGAS`,
		`WEAPON_SMOKEGRENADE`,
		`WEAPON_REVOLVER`,

		`WEAPON_STUNGUN`,
		`WEAPON_NIGHTSTICK`,
		`WEAPON_KNIFE`,
		`WEAPON_FLAREGUN`,
		`WEAPON_COMBATPISTOL`,
		`WEAPON_HEAVYPISTOL`,
		`WEAPON_COMBATPDW`,
		`WEAPON_ASSAULTSMG`,
		`WEAPON_BULLPUPSHOTGUN`,
		`WEAPON_CARBINERIFLE`,
		`WEAPON_SNIPERRIFLE`,
		`WEAPON_FLASHBANG`,
		`WEAPON_SPECIALCARBINE`,
		`WEAPON_SPECIALCARBINE_MK2`,
		`WEAPON_ASSAULTRIFLE_MK2`,
		`WEAPON_ADVANCEDRIFLE`,
		`WEAPON_PIPEBOMB`,
		`WEAPON_REVOLVER_MK2`,
		`weapon_militaryrifle`,
		`WEAPON_FLASHBANG`,
		`WEAPON_CARBINERIFLE_MK2`,
		
		`WEAPON_FIREEXTINGUISHER`,
		`WEAPON_CROWBAR`,
		`WEAPON_HATCHET`,

		`WEAPON_HAMMER`,
		`WEAPON_WRENCH`,

		`WEAPON_PETROLCAN`,
		`WEAPON_STONE_HATCHET`,
		`WEAPON_GOLFCLUB`,
		`WEAPON_FIREWORK`,
		`WEAPON_MUSKET`,
		`WEAPON_PISTOL50`,

		`WEAPON_NAVYREVOLVER`,
		`weapon_minigun`,
	},
	
	Strefy = {
		{
			Pos = vector3(-725.46, -863.49, 26.78),
			Radius = 60.0,
			Colour = 4
		},
		{
			Pos = vector3(-94.0637, -1790.0352, 28.0442),
			Radius = 60.0,
			Colour = 7
		},
		{
			Pos = vector3(333.2, -2038.74, 21.05),
			Radius = 50.0,
			Colour = 5
		},
		{
			Pos = vector3(-217.8278, -1496.7012, 30.2871),
			Radius = 70.0,
			Colour = 2
		},
		{
			Pos = vector3(972.63, -122.37, 74.34),
			Radius = 50.0,
			Colour = 72
		},
		{
			Pos = vector3(1377.49, -1552.52, 56.58),
			Radius = 70.0,
			Colour = 3
		},
		{
			Pos = vector3(-1555.9609, -401.6158, 41.0377),
			Radius = 70.0,
			Colour = 1
		},
		{
			Pos = vector3(449.031, -1894.219, 25.8005),
			Radius = 65.0,
			Colour = 29
		},
		{
			Pos = vector3(1378.9091, -2078.6506, 51.0489),
			Radius = 80.0,
			Colour = 40
		},
		{
			Pos = vector3(-1152.9735, -1526.145, 3.2986),
			Radius = 60.0,
			Colour = 40
		},
	},

	Zones = {
		['AIRP'] = 'Los Santos International Airport',
		['ALAMO'] = 'Alamo Sea',
		['ALTA'] = 'Alta',
		['ARMYB'] = 'Fort Zancudo',
		['BANHAMC'] = 'Banham Canyon Dr',
		['BANNING'] = 'Banning',
		['BEACH'] = 'Vespucci Beach',
		['BHAMCA'] = 'Banham Canyon',
		['BRADP'] = 'Braddock Pass',
		['BRADT'] = 'Braddock Tunnel',
		['BURTON'] = 'Burton',
		['CALAFB'] = 'Calafia Bridge',
		['CANNY'] = 'Raton Canyon',
		['CCREAK'] = 'Cassidy Creek',
		['CHAMH'] = 'Chamberlain Hills',
		['CHIL'] = 'Vinewood Hills',
		['CHU'] = 'Chumash',
		['CMSW'] = 'Chiliad Mountain State Wilderness',
		['CYPRE'] = 'Cypress Flats',
		['DAVIS'] = 'Davis',
		['DELBE'] = 'Del Perro Beach',
		['DELPE'] = 'Del Perro',
		['DELSOL'] = 'La Puerta',
		['DESRT'] = 'Grand Senora Desert',
		['DOWNT'] = 'Downtown',
		['DTVINE'] = 'Downtown Vinewood',
		['EAST_V'] = 'East Vinewood',
		['EBURO'] = 'El Burro Heights',
		['ELGORL'] = 'El Gordo Lighthouse',
		['ELYSIAN'] = 'Elysian Island',
		['GALFISH'] = 'Galilee',
		['GOLF'] = 'GWC and Golfing Society',
		['GRAPES'] = 'Grapeseed',
		['GREATC'] = 'Great Chaparral',
		['HARMO'] = 'Harmony',
		['HAWICK'] = 'Hawick',
		['HORS'] = 'Vinewood Racetrack',
		['HUMLAB'] = 'Humane Labs and Research',
		['JAIL'] = 'Bolingbroke Penitentiary',
		['KOREAT'] = 'Little Seoul',
		['LACT'] = 'Land Act Reservoir',
		['LAGO'] = 'Lago Zancudo',
		['LDAM'] = 'Land Act Dam',
		['LEGSQU'] = 'Legion Square',
		['LMESA'] = 'La Mesa',
		['LOSPUER'] = 'La Puerta',
		['MIRR'] = 'Mirror Park',
		['MORN'] = 'Morningwood',
		['MOVIE'] = 'Richards Majestic',
		['MTCHIL'] = 'Mount Chiliad',
		['MTGORDO'] = 'Mount Gordo',
		['MTJOSE'] = 'Mount Josiah',
		['MURRI'] = 'Murrieta Heights',
		['NCHU'] = 'North Chumash',
		['NOOSE'] = 'N.O.O.S.E',
		['OCEANA'] = 'Pacific Ocean',
		['PALCOV'] = 'Paleto Cove',
		['PALETO'] = 'Paleto Bay',
		['PALFOR'] = 'Paleto Forest',
		['PALHIGH'] = 'Palomino Highlands',
		['PALMPOW'] = 'Palmer-Taylor Power Station',
		['PBLUFF'] = 'Pacific Bluffs',
		['PBOX'] = 'Pillbox Hill',
		['PROCOB'] = 'Procopio Beach',
		['RANCHO'] = 'Rancho',
		['RGLEN'] = 'Richman Glen',
		['RICHM'] = 'Richman',
		['ROCKF'] = 'Rockford Hills',
		['RTRAK'] = 'Redwood Lights Track',
		['SANAND'] = 'San Andreas',
		['SANCHIA'] = 'San Chianski Mountain Range',
		['SANDY'] = 'Sandy Shores',
		['SKID'] = 'Mission Row',
		['SLAB'] = 'Stab City',
		['STAD'] = 'Maze Bank Arena',
		['STRAW'] = 'Strawberry',
		['TATAMO'] = 'Tataviam Mountains',
		['TERMINA'] = 'Terminal',
		['TEXTI'] = 'Textile City',
		['TONGVAH'] = 'Tongva Hills',
		['TONGVAV'] = 'Tongva Valley',
		['VCANA'] = 'Vespucci Canals',
		['VESP'] = 'Vespucci',
		['VINE'] = 'Vinewood',
		['WINDF'] = 'Ron Alternates Wind Farm',
		['WVINE'] = 'West Vinewood',
		['ZANCUDO'] = 'Zancudo River',
		['ZP_ORT'] = 'Port of South Los Santos',
		['ZQ_UAR'] = 'Davis Quartz'
	},

	
	Directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N' },
	
	CustomStreets = {
		{ start_x = 296.66, start_y = -237.64, end_x = 354.17, end_y = -182.28, name = 'Urzędnicza Street' }
	},

Visuals = {
		--["heightReflect.width"] = 140.0,
		["heightReflect.width"] = 10.0,
		--["heightReflect.height"] = 225.0,
		["heightReflect.height"] = 22.0,
		["rain.NumberParticles"] = 128.0,
		["rain.UseLitShader"] = 0.0,
		["heightReflect.specularoffset"] = 0.05,
		--["sky.cloudInscatteringRange"] = 0.78,
		["sky.cloudInscatteringRange"] = 0.0,
		--["sky.cloudEdgeSmooth"] = 0.99,
		["sky.cloudEdgeSmooth"] = 0.0,
		["sky.GameCloudSpeed"] = 0.5,
		--["shadows.cloudtexture.rangemax"] = 2.0,
		["shadows.cloudtexture.rangemax"] = 0.0,
		["car.interiorlight.color.blue"] = 5.7,
		["car.interiorlight.intensity"] = 2.5,
		["car.platelight.color.blue"] = 5.0,
		["car.platelight.intensity"] = 1.5,
		["car.dashlight.color.blue"] = 3.6,
		["car.doorlight.color.blue"] = 6.95,
		["car.taxi.intensity"] = 1.0,
		["car.headlights.global.HeadlightIntensityMult"] = 3.55,
		["car.headlights.global.HeadlightDistMult"] = 3.8,
		["car.headlights.fullbeam.DistMult"] = 3.5,
		["car.headlights.fullbeam.CoronaIntensityMult"] = 1.9,
		["car.headlights.fullbeam.CoronaSizeMult"] = 1.8,
		["car.headlights.player.intensitymult"] = 1.1,
		["car.headlights.player.distmult"] = 0.45,
		["car.headlights.useDynamicShadows"] = 1.0,
		["car.coronas.CutoffStart"] = 280.0,
		["car.sirens.ShadowFade"] = 35.0,
		["car.sirens.intensity"] = 75.0,
		["car.sirens.radius"] = 50.0,
		["plane.luxe2.cabin.useDynamicShadows"] = 1.0,
		["heli.swift2.cabin.useDynamicShadows"] = 1.0,
		["sub.lightOne.color.red"] = 1.0,
		["sub.lightOne.color.green"] = 1.0,
		["sub.lightOne.intensity"] = 0.0,
		["sub.lightOne.radius"] = 1.0,
		["sub.lightOne.outerConeAngle"] = 45.0,
		["sub.lightTwo.color.red"] = 1.0,
		["sub.lightTwo.color.blue"] = 1.0,
		["sub.lightTwo.intensity"] = 0.0,
		["sub.lightTwo.radius"] = 1.0,
		["sub.lightTwo.outerConeAngle"] = 45.0,
		["train.light.fadelength"] = 20.0,
		["car.headlight.day.emissive.on"] = 208.0,
		["car.headlight.night.emissive.on"] = 109.0,
		["car.headlight.day.emissive.off"] = 0.001,
		["car.headlight.night.emissive.off"] = 0.001,
		["car.taillight.day.emissive.on"] = 65.0,
		["car.taillight.night.emissive.on"] = 65.0,
		["car.taillight.day.emissive.off"] = 0.001,
		["car.taillight.night.emissive.off"] = 0.001,
		["car.indicator.day.emissive.on"] = 135.0,
		["car.indicator.night.emissive.on"] = 116.0,
		["car.indicator.day.emissive.off"] = 0.001,
		["car.indicator.night.emissive.off"] = 0.001,
		["car.reversinglight.day.emissive.on"] = 19.0,
		["car.reversinglight.night.emissive.on"] = 9.0,
		["car.reversinglight.day.emissive.off"] = 0.001,
		["car.reversinglight.night.emissive.off"] = 0.001,
		["car.brakelight.day.emissive.on"] = 150.0,
		["car.brakelight.night.emissive.on"] = 135.0,
		["car.brakelight.day.emissive.off"] = 0.001,
		["car.brakelight.night.emissive.off"] = 0.001,
		["car.middlebrakelight.day.emissive.on"] = 150.0,
		["car.middlebrakelight.night.emissive.on"] = 135.0,
		["car.middlebrakelight.day.emissive.off"] = 0.001,
		["car.middlebrakelight.night.emissive.off"] = 0.001,
		["car.extralight.day.emissive.on"] = 160.0,
		["car.extralight.night.emissive.on"] = 90.0,
		["car.extralight.day.emissive.off"] = 0.001,
		["car.extralight.night.emissive.off"] = 0.001,
		["car.emissiveMultiplier"] = 2.021,
		["car.lod.distance.high"] = 55.0,
		["car.lod.distance.low"] = 210.0,
		["boat.intensity"] = 5.0,
		["train.light.intensity"] = 1.0,
		["train.light.fadingdistance"] = 50.0,
		["defaultsearchlight.mainLightInfo.globalIntensity"] = 2.0,
		["trafficLight.near.intensity"] = 0.0,
		["trafficLight.near.radius"] = 0.0,
		["trafficLight.near.outerConeAngle"] = 20.0,
		["trafficLight.near.coronaHDR"] = 2.0,
		["trafficLight.near.coronaSize"] = 0.0,
		["trafficLight.farFadeStart"] = 200.0,
		["trafficLight.farFadeEnd"] = 250.0,
		["trafficLight.nearFadeStart"] = 100.0,
		["trafficLight.nearFadeEnd"] = 130.0,
		["imposter.color.blendRange"] = 0.0,
		["imposter.color.blendBias"] = 0.0,
		["imposter.color.size1"] = 0.0,
		["imposter.color.amt1"] = 0.0,
		["imposter.color.size2"] = 0.0,
		["imposter.color.amt2"] = 0.0,
		["imposter.backgroundColor.red"] = 0.0,
		["imposter.backgroundColor.green"] = 0.0,
		["imposter.backgroundColor.blue"] = 0.0,
		["imposter.shadow.blendRange"] = 0.0,
		["imposter.shadow.blendBias"] = 0.0,
		["imposter.shadow.size1"] = 0.0,
		["imposter.shadow.amt1"] = 0.0,
		["imposter.shadow.size2"] = 0.0,
		["imposter.shadow.amt2"] = 0.0,
		["ped.ambientvolume.fadestart"] = 12.0,
		["ped.ambientvolume.fadeend"] = 16.0,
		["distantlights.size"] = 0.6,
		["distantlights.sizeReflections"] = 0.0,
		["distantlights.sizeMin"] = 0.8,
		["distantlights.sizeUpscale"] = 8.0,
		["distantlights.sizeUpscaleReflections"] = 0.0,
		["distantlights.flicker"] = 0.2,
		["distantlights.carlight.HDRIntensity"] = 0.0,
		["distantlights.streetlight.HDRIntensity"] = 19.0,
		["distantlights.streetlight.color.green"] = 0.43,
		["misc.DOFBlurMultiplier.HD"] = 0.0,
		["misc.DOFBlurMultiplier.SD"] = 0.0,
		["misc.Multiplier.nearFogMultiplier"] = 0.0,
		["misc.3dMarkers.FrontLightIntensity"] = 2.0,
		["misc.3dMarkers.frontLightExponent"] = 12.0,
		["misc.coronas.sizeScaleGlobal"] = 1.25,
		["misc.coronas.intensityScaleGlobal"] = 0.0,
		["misc.coronas.intensityScaleWater"] = 0.0,
		["misc.coronas.sizeScaleWater"] = 0.0,
		["misc.coronas.screenspaceExpansionWater"] = 0.0,
		["misc.coronas.zBiasMultiplier"] = 25.0,
		["misc.coronas.zBias.fromFinalSizeMultiplier"] = 0.1,
		["misc.coronas.underwaterFadeDist"] = 2.0,
		["misc.coronas.screenEdgeMinDistForFade"] = 0.0,
		["misc.CrossPMultiplier.RimLight"] = 0.0,
		["misc.CrossPMultiplier.GlobalEnvironmentReflection"] = 0.0,
		["misc.CrossPMultiplier.MidBlur"] = 0.0,
		["misc.CrossPMultiplier.Farblur"] = 0.0,
		["misc.CrossPMultiplier.Desaturation"] = 1.20,
		["misc.HiDof.nearBlur"] = 0.0,
		["misc.HiDof.midBlur"] = 0.0,
		["misc.HiDof.farBlur"] = 0.0,
		["misc.cutscene.nearBlurMin"] = 0.0,
		["misc.MoonDimMult"] = 0.0,
		["Tonemapping.bright.filmic.A"] = 0.3,
		["Tonemapping.bright.filmic.B"] = 0.23,
		["Tonemapping.bright.filmic.C"] = 0.1,
		["Tonemapping.bright.filmic.D"] = 0.2,
		["Tonemapping.bright.filmic.E"] = 0.01,
		["Tonemapping.bright.filmic.F"] = 0.3,
		["Tonemapping.bright.filmic.W"] = 4.0,
		["Tonemapping.dark.filmic.A"] = 0.3,
		["Tonemapping.dark.filmic.B"] = 0.23,
		["Tonemapping.dark.filmic.C"] = 0.2,
		["Adaptation.min.step.size"] = 0.0,
		["Adaptation.max.step.size"] = 19.9,
		["Adaptation.step.size.mult"] = 0.55,
		["Adaptation.sun.exposure.tweak"] = -3.0,
		["cloudgen.frequency"] = 1.0,
		["cloudgen.scale"] = 24.0,
		["cloudgen.edge.detail.scale"] = 4.0,
		["cloudgen.overlay.detail.scale"] = 2.0,
		["cloud.speed.small"] = 4.0,
		["lod.fadedist.orphanhd"] = 0.075,
		["rim.lighting.main.colour.intensity"] = 6.0,
		["bloom.blurblendmult.large"] = 0.3,
		["bloom.blurblendmult.med"] = 1.2,
		["bloom.blurblendmult.small"] = 0.6,
		["lodlight.corona.size"] = 1.75,
		["misc.brightlight.distculled.FadeStart"] = 200.0,
		["misc.brightlight.distculled.FadeEnd"] = 220.0,
		["misc.brightlight.notdistculled.FadeStart"] = 180.0,
		["misc.brightlight.notdistculled.FadeEnd"] = 235.0,
		["vehicle.lights.sunrise"] = 5.5,
		["vehicle.lights.sunset"] = 21.0,
		["vehicle.lights.fadeDistance.main"] = 250.0,
		["vehicle.lights.fadeDistance.secondary"] = 250.0,
		["vehicle.lights.fadeDistance.sirens"] = 400.0,
		["vehicle.lights.fadeDistance.AO"] = 250.0,
		["vehicle.lights.fadeDistance.neon"] = 220.0,
		["vehicle.lights.fadeLength"] = 20.0,
		["particles.shadowintensity"] = 1.15,
		["dark.useNormal"] = 1.0,
		["dark.useVolumes"] = 1.0,
		["ped.light.fade.day.end"] = 6.1,
		["ped.light.fade.night.end"] = 20.1,
		["adaptivedof.day.near.nearin"] = 3.0,
		["lensflare.switch.length"] = 90.0,
		["lensflare.hide.length"] = 95.0,
		["lensflare.show.length"] = 64.0,
		["lensflare.desaturation.boost"] = 0.16
	},

	Blipy = {

		{
			Pos     = vector3(1588.73 , 6455.87, 34.64),
			Sprite  = 609,
			Display = 4,
			Scale   = 0.7,
			Colour  = 81,
			Label 	= "Burgerownia"
		},
		{
			Pos     = vector3(68.625, -1569.7737, 28.6455),
			Sprite  = 442,
			Display = 4,
			Scale   = 0.7,
			Colour  = 4,
			Label 	= "Mleczarz"
		},
		{
			Pos     = vector3(-627.85 , 222.70, 94.60),
			Sprite  = 607,
			Display = 4,
			Scale   = 0.7,
			Colour  = 28,
			Label 	= "Kawiarnia"
		},
		{
			Pos     = vector3(-1833.69, -1190.59, 29.98),
			Sprite  = 266,
			Display = 4,
			Scale   = 0.7,
			Colour  = 57,
			Label 	= "Restauracja"
		},
		{
			Pos     = vector3(-2068.93 , -486.59, 12.98),
			Sprite  = 489,
			Display = 4,
			Scale   = 0.7,
			Colour  = 57,
			Label 	= "Molo miłości"
		},
		{
			Pos     = vector3(-1684.17 , -278.34, 74.7),
			Sprite  = 305,
			Display = 4,
			Scale   = 0.7,
			Colour  = 5,
			Label 	= "Kościół"
		},
		{
			Pos     = vector3(250.43 , -1097.30, 28.34),
			Sprite  = 525,
			Display = 4,
			Scale   = 0.7,
			Colour  = 50,
			Label 	= "Doj"
		},
		{
			Pos     = vector3(-553.43, -191.41, 38.22),
			Sprite  = 498,
			Display = 4,
			Scale   = 0.7,
			Colour  = 15,
			Label 	= "Urząd Miasta"
		},
		{
			Pos     = vector3(-786.7534, -1349.0989, 4.2623),
			Sprite  = 68,
			Display = 4,
			Scale   = 0.8,
			Colour  = 3,
			Label 	= "Rybak"
		},    		     
	},
	
}

PlayerData = {}
local disableShuffle = true
local can = true
local displayStreet = true

local currentWeather = 'EXTRASUNNY'
local lastweather = currentWeather
local blackout = false

local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false

local lastPosition = nil
local loadingStatus = 0
local loadingPosition = false

local isHandcuffed = false
local inProperty = false
local aspectThread = nil

function AddTextEntry(key, value)
	Citizen.InvokeNative(`ADD_TEXT_ENTRY`, key, value)
end

CreateThread(function()
    Citizen.Wait(1000)
	for i=1, #Config.Blipy, 1 do
		local blip = AddBlipForCoord(Config.Blipy[i].Pos)

		SetBlipSprite (blip, Config.Blipy[i].Sprite)
		SetBlipDisplay(blip, Config.Blipy[i].Display)
		SetBlipScale  (blip, Config.Blipy[i].Scale)
		SetBlipColour (blip, Config.Blipy[i].Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Blipy[i].Label)
		EndTextCommandSetBlipName(blip)
	end
	
	for i=1, #Config.Strefy, 1 do
		local blip = AddBlipForRadius(Config.Strefy[i].Pos, Config.Strefy[i].Radius)
		
		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, Config.Strefy[i].Colour)
		SetBlipAlpha(blip, 150)
		SetBlipAsShortRange(blip, true)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	PlayerLoaded = true
	if not loadingPosition then
		print('[PlateRP]: PlayerLoaded')
		loadingStatus = 1
		ESX.UI.HUD.SetDisplay(0.0)
		loadingPosition = (xPlayer.coords or {x = -1037.86, y = -2738.11, z = 20.16})

		Citizen.InvokeNative(0x239528EACDC3E7DE, playerid, true)
		Citizen.InvokeNative(0xEA1C610A04DB6BBB, playerPed, false)
		
		FreezeEntityPosition(playerPed, true)
		SetEntityCoords(playerPed, 0, 0, 0)
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:setGroup')
AddEventHandler('esx:setGroup', function(group)
	ESX.PlayerData.group = group
end)

local DisableShuffle = true
function DisableSeatShuffle(status)
	DisableShuffle = status
end

function SeatShuffle()
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetPedInVehicleSeat(vehicle, 0) == playerPed then
			DisableSeatShuffle(false)
			Citizen.Wait(5000)
			DisableSeatShuffle(true)
		else
			TaskShuffleToNextVehicleSeat(playerPed, vehicle)
		end
	end
end

RegisterCommand("miejsce", function(source, args, raw) 
    SeatShuffle()
end, false) 

RegisterCommand("shuff", function(source, args, raw) 
    SeatShuffle()
end, false)

RegisterCommand("clearnui", function()
    SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})
end)

CreateThread(function()
	while true do
		Citizen.Wait(0)
		DisplayAmmoThisFrame(false)
		
		AllowPauseMenuWhenDeadThisFrame()
		DisablePlayerVehicleRewards(playerid)	
		N_0x7669f9e39dc17063()
		for _, iter in ipairs({1, 2, 3, 4, 6, 7, 8, 9, 13, 17, 18, 19}) do -- 6
			HideHudComponentThisFrame(iter)
		end
		
		DisableControlAction(0, 37)
		
		HudWeaponWheelIgnoreSelection()
		local currentWeaponHash = GetSelectedPedWeapon(playerPed)

		if currentWeaponHash == 100416529 then

			isSniper = true

		elseif currentWeaponHash == 205991906 then

			isSniper = true

		elseif currentWeaponHash == -952879014 then

			isSniper = true

		elseif currentWeaponHash == `WEAPON_HEAVYSNIPER_MK2` then

			isSniper = true

		else

			isSniper = false

		end


		if can then
			if not isSniper then

			  if not IsPedInAnyVehicle(playerPed, false) then

				HideHudComponentThisFrame(14)

			  elseif IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed), `lazer`) == false then

				HideHudComponentThisFrame(14)

			  end

			end
		end
		
		if DoesEntityExist(playerPed) then
			local weapon = GetSelectedPedWeapon(playerPed)
			if IsPedArmed(playerPed, 6) then
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
			end
			-- Disable ammo HUD
			DisplayAmmoThisFrame(false)
		end
	end
end)

-- https://forum.fivem.net/t/betterrecoil-better-3rd-person-recoil-for-fivem/82894
local recoils = {
	[`WEAPON_STUNGUN`] = {0.1, 1.1}, -- STUN GUN
	[`WEAPON_STUNGUN_MP`] = {0.1, 1.1}, -- STUN GUN
	[`WEAPON_FLAREGUN`] = {0.9, 1.9}, -- FLARE GUN

	[`WEAPON_SNSPISTOL`] = {3.2, 4.2}, -- SNS PISTOL
	[`WEAPON_SNSPISTOL_MK2`] = {2.7, 3.7}, -- SNS PISTOL MK2
	[`WEAPON_NAVYREVOLVER`] = {2.7, 3.7}, -- SNS PISTOL MK2
	[`WEAPON_GADGETPISTOL`] = {2.7, 3.7}, -- SNS PISTOL MK2
	[`WEAPON_VINTAGEPISTOL`] = {3.0, 4.0}, -- VINTAGE PISTOL
	[`WEAPON_PISTOL`] = {3.0, 4.0}, -- PISTOL
	[`WEAPON_PISTOL_MK2`] = {3.0, 4.0}, -- PISTOL MK2
	[`WEAPON_DOUBLEACTION`] = {3.0, 3.5}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_REVOLVER`] = {3.0, 3.5}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_REVOLVER_MK2`] = {3.0, 3.5}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_COMBATPISTOL`] = {3.5, 4.0}, -- COMBAT PISTOL
	[`WEAPON_HEAVYPISTOL`] = {2.6, 3.1}, -- HEAVY PISTOL
	[`WEAPON_PISTOL50`] = {2.9, 3.4}, -- 50 PISTOL
	[`WEAPON_CERAMICPISTOL`] = {2.7, 3.7}, -- Ceramicpistol

	[`WEAPON_DBSHOTGUN`] = {0.1, 0.6}, -- DOUBLE BARREL SHOTGUN
	[`WEAPON_SAWNOFFSHOTGUN`] = {2.1, 2.6}, -- SAWNOFF SHOTGUN
	[`WEAPON_PUMPSHOTGUN`] = {8.7, 10.2}, -- PUMP SHOTGUN
	[`WEAPON_PUMPSHOTGUN_MK2`] = {2.7, 3.2}, -- PUMP SHOTGUN MK2
	[`WEAPON_BULLPUPSHOTGUN`] = {1.5, 2.0}, -- BULLPUP SHOTGUN

	[`WEAPON_MINISMG`] = {0.01, 0.03}, -- MINISMG
	[`WEAPON_SMG_MK2`] = {0.01, 0.01}, -- SMG MK2

	[`WEAPON_ASSAULTSMG`] = {0.04, 0.14}, -- ASSAULT SMG
	[`WEAPON_COMBATPDW`] = {0.01, 0.04}, -- COMBAT PDW
	[`WEAPON_GUSENBERG`] = {0.005, 0.005}, -- GUSENBERG
	[`WEAPON_ASSAULTRIFLE_MK2`] = {0.005, 0.005}, -- GUSENBERG
	[`WEAPON_CARBINERIFLE_MK2`] = {0.005, 0.005}, -- GUSENBERG

	[`WEAPON_COMPACTRIFLE`] = {0.15, 0.25}, -- COMPACT RIFLE
	[`WEAPON_ASSAULTRIFLE`] = {0.15, 0.25}, -- ASSAULT RIFLE
	[`WEAPON_EMPLAUNCHER`] = {0.15, 0.25}, -- ASSAULT RIFLE
	[`WEAPON_HEAVYRIFLE`] = {0.20, 0.34}, -- ASSAULT RIFLE
	[`WEAPON_CARBINERIFLE`] = {0.20, 0.34}, -- CARBINE RIFLE

	[`WEAPON_MARKSMANRIFLE`] = {0.5, 1.0}, -- MARKSMAN RIFLE
	[`WEAPON_SNIPERRIFLE`] = {0.5, 1.0}, -- SNIPER RIFLE
}

local recoilsOGHaze = {
	[`WEAPON_STUNGUN`] = {0.1, 1.1}, -- STUN GUN
	[`WEAPON_STUNGUN_MP`] = {0.1, 1.1}, -- STUN GUN
	[`WEAPON_FLAREGUN`] = {0.9, 1.9}, -- FLARE GUN

	[`WEAPON_SNSPISTOL`] = {2.2, 3.2}, -- SNS PISTOL
	[`WEAPON_SNSPISTOL_MK2`] = {1.7, 2.7}, -- SNS PISTOL MK2
	[`WEAPON_NAVYREVOLVER`] = {1.7, 2.7}, -- SNS PISTOL MK2
	[`WEAPON_GADGETPISTOL`] = {1.7, 2.7}, -- SNS PISTOL MK2
	[`WEAPON_VINTAGEPISTOL`] = {2.0, 3.0}, -- VINTAGE PISTOL
	[`WEAPON_PISTOL`] = {2.2, 3.2}, -- PISTOL
	[`WEAPON_PISTOL_MK2`] = {2.2, 3.2}, -- PISTOL MK2
	[`WEAPON_DOUBLEACTION`] = {2.0, 2.5}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_REVOLVER_MK2`] = {2.0, 2.5}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_REVOLVER`] = {2.0, 2.5}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_COMBATPISTOL`] = {2.5, 3.0}, -- COMBAT PISTOL
	[`WEAPON_HEAVYPISTOL`] = {1.6, 2.1}, -- HEAVY PISTOL
	[`WEAPON_PISTOL50`] = {2.9, 3.4}, -- 50 PISTOL
	[`WEAPON_CERAMICPISTOL`] = {1.7, 2.7}, -- Ceramicpistol

	[`WEAPON_DBSHOTGUN`] = {0.1, 0.6}, -- DOUBLE BARREL SHOTGUN
	[`WEAPON_SAWNOFFSHOTGUN`] = {2.1, 2.6}, -- SAWNOFF SHOTGUN
	[`WEAPON_PUMPSHOTGUN`] = {8.7, 10.2}, -- PUMP SHOTGUN
	[`WEAPON_PUMPSHOTGUN_MK2`] = {2.7, 3.2}, -- PUMP SHOTGUN MK2
	[`WEAPON_BULLPUPSHOTGUN`] = {1.5, 2.0}, -- BULLPUP SHOTGUN

	[`WEAPON_MICROSMG`] = {0.55, 0.87}, -- MICRO SMG (UZI)
	[`WEAPON_SMG`] = {0.01, 0.01}, -- SMG
	[`WEAPON_MINISMG`] = {0.05, 0.55}, -- MINISMG
	[`WEAPON_SMG_MK2`] = {0.001, 0.01}, -- SMG MK2
	[`WEAPON_ASSAULTSMG`] = {0.04, 0.54}, -- ASSAULT SMG
	[`WEAPON_COMBATPDW`] = {0.01, 0.02}, -- COMBAT PDW
	[`WEAPON_GUSENBERG`] = {0.075, 0.575}, -- GUSENBERG
	[`WEAPON_ASSAULTRIFLE_MK2`] = {0.075, 0.575}, -- GUSENBERG
	[`WEAPON_CARBINERIFLE_MK2`] = {0.075, 0.575}, -- GUSENBERG

	[`WEAPON_COMPACTRIFLE`] = {0.35, 0.45}, -- COMPACT RIFLE
	[`WEAPON_ASSAULTRIFLE`] = {0.35, 0.75}, -- ASSAULT RIFLE
	[`WEAPON_EMPLAUNCHER`] = {0.35, 0.75}, -- ASSAULT RIFLE
	[`WEAPON_HEAVYRIFLE`] = {0.40, 0.74}, -- ASSAULT RIFLE
	[`WEAPON_CARBINERIFLE`] = {0.40, 0.74}, -- CARBINE RIFLE

	[`WEAPON_MARKSMANRIFLE`] = {0.5, 1.0}, -- MARKSMAN RIFLE
	[`WEAPON_SNIPERRIFLE`] = {0.5, 1.0}, -- SNIPER RIFLE
}

local effects = {
	[`WEAPON_STUNGUN`] = {0.01, 0.02}, -- STUN GUN
	[`WEAPON_STUNGUN_MP`] = {0.01, 0.02}, -- STUN GUN
	[`WEAPON_FLAREGUN`] = {0.01, 0.02}, -- FLARE GUN

	[`WEAPON_SNSPISTOL`] = {0.08, 0.16}, -- SNS PISTOL
	[`WEAPON_SNSPISTOL_MK2`] = {0.07, 0.14}, -- SNS PISTOL MK2
	[`WEAPON_NAVYREVOLVER`] = {0.07, 0.14}, -- SNS PISTOL MK2
	[`WEAPON_GADGETPISTOL`] = {0.07, 0.14}, -- SNS PISTOL MK2
	[`WEAPON_VINTAGEPISTOL`] = {0.08, 0.16}, -- VINTAGE PISTOL
	[`WEAPON_PISTOL`] = {0.10, 0.20}, -- PISTOL
	[`WEAPON_PISTOL_MK2`] = {0.11, 0.22}, -- PISTOL MK2
	[`WEAPON_CERAMICPISTOL`] = {0.07, 0.14}, -- Ceramicpistol
	[`WEAPON_DOUBLEACTION`] = {0.1, 0.2}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_REVOLVER_MK2`] = {0.1, 0.2}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_REVOLVER`] = {0.1, 0.2}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_COMBATPISTOL`] = {0.1, 0.2}, -- COMBAT PISTOL
	[`WEAPON_HEAVYPISTOL`] = {0.1, 0.2}, -- HEAVY PISTOL
	[`WEAPON_PISTOL50`] = {0.1, 0.2}, -- 50 PISTOL

	[`WEAPON_DBSHOTGUN`] = {0.1, 0.2}, -- DOUBLE BARREL SHOTGUN
	[`WEAPON_SAWNOFFSHOTGUN`] = {0.095, 0.19}, -- SAWNOFF SHOTGUN
	[`WEAPON_PUMPSHOTGUN`] = {0.09, 0.18}, -- PUMP SHOTGUN
	[`WEAPON_PUMPSHOTGUN_MK2`] = {0.09, 0.18}, -- PUMP SHOTGUN MK2
	[`WEAPON_BULLPUPSHOTGUN`] = {0.085, 0.19}, -- BULLPUP SHOTGUN

	[`WEAPON_MICROSMG`] = {0.05, 0.1}, -- MICRO SMG (UZI)
	[`WEAPON_SMG`] = {0.01, 0.1}, -- SMG
	[`WEAPON_MINISMG`] = {0.05, 0.08}, -- MINISMG
	[`WEAPON_SMG_MK2`] = {0.01, 0.01}, -- SMG MK2
	[`WEAPON_ASSAULTSMG`] = {0.035, 0.07}, -- ASSAULT SMG
	[`WEAPON_COMBATPDW`] = {0.01, 0.02}, -- COMBAT PDW
	[`WEAPON_GUSENBERG`] = {0.035, 0.07}, -- GUSENBERG
	[`WEAPON_ASSAULTRIFLE_MK2`] = {0.035, 0.07}, -- GUSENBERG

	[`WEAPON_COMPACTRIFLE`] = {0.03, 0.08}, -- COMPACT RIFLE
	[`WEAPON_ASSAULTRIFLE`] = {0.023, 0.064}, -- ASSAULT RIFLE
	[`WEAPON_EMPLAUNCHER`] = {0.023, 0.064}, -- ASSAULT RIFLE
	[`WEAPON_HEAVYRIFLE`] = {0.03, 0.06}, -- ASSAULT RIFLE
	[`WEAPON_CARBINERIFLE`] = {0.03, 0.06}, -- CARBINE RIFLE

	[`WEAPON_MARKSMANRIFLE`] = {0.025, 0.05}, -- MARKSMAN RIFLE
	[`WEAPON_SNIPERRIFLE`] = {0.025, 0.05}, -- SNIPER RIFLE	

	[`WEAPON_FIREWORK`] = {0.5, 1.0} -- FIREWORKS
}

local drugged = false
function DisableEffects()
	drugged = true
end

function EnableEffects()
	drugged = false
end

CreateThread(function()
	while true do
		Citizen.Wait(0)
		if DoesEntityExist(playerPed) then
			local status, weapon = GetCurrentPedWeapon(playerPed, true)
			if status == 1 then
				if weapon == 'WEAPON_FIREEXTINGUISHER' then
					Citizen.InvokeNative(0x3EDCB0505123623B, playerPed, true, 'WEAPON_FIREEXTINGUISHER')
				elseif IsPedShooting(playerPed) then
					if can then
						local inVehicle = IsPedInAnyVehicle(playerPed, false)							
						local recoil = recoils[weapon]
						if recoil and #recoil > 0 then
							local i, tv = (inVehicle and 2 or 1), 0
							if GetFollowPedCamViewMode() ~= 4 then
								repeat
									SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.1, 0.2)
									tv = tv + 0.1
									Citizen.Wait(0)
								until tv >= recoil[i]
							else
								repeat
									local t = GetRandomFloatInRange(0.1, recoil[i])
									SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + t, (recoil[i] > 0.1 and 1.2 or 0.333))
									tv = tv + t
									Citizen.Wait(0)
								until tv >= recoil[i]
							end
						end
						if not drugged then	
							local effect = effects[weapon]
							if effect and #effect > 0 then
								ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', (inVehicle and (effect[1] * 3) or effect[2]))
							end
						end
					end
				end
			else
				Citizen.Wait(250)
			end
		end
	end
end)

CreateThread(function()
	while true do
        for _, sctyp in next, Config.SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, Config.SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        for _, model in next, Config.SUPPRESSED_MODELS do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end
        Wait(10000)
	end
end)

CreateThread(function()
	AddTextEntry('FE_THDR_GTAO', 'PlateRP WL OFF ~s~| ~b~ID: ' .. GetPlayerServerId(playerid))
	while true do
		Citizen.Wait(100)	
		if IsPedBeingStunned(playerPed) then
			SetPedMinGroundTimeForStungun(playerPed, 6000)
		end
		
		local melee = Config.Melees[weapon]
		if melee then
			SetPlayerMeleeWeaponDamageModifier(playerid, melee)
		else
			SetPlayerMeleeWeaponDamageModifier(playerid, 1.0)
		end
		
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetPedInVehicleSeat(vehicle, -1) ~= playerPed then
			if DisableShuffle and GetPedInVehicleSeat(vehicle, 0) == playerPed and GetIsTaskActive(playerPed, 165) then
				SetPedIntoVehicle(playerPed, vehicle, 0)
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(4)
		local show, weapon = false, GetSelectedPedWeapon(playerPed)
		for _, model in ipairs(Config.DisplayCrosshair) do
			if weapon == GetHashKey(model) then
				show = true
				break
			end
		end
		
		local aiming, shooting = IsControlPressed(0, 25), IsPedShooting(playerPed)
		local inVehicle = IsPedInAnyVehicle(playerPed, false)
		if not show then
			if Config.FirstPersonShoot then
				local aiming, shooting = IsControlPressed(0, 25), IsPedShooting(playerPed)
				if aiming or shooting then
					if shooting and not aiming then
						isShooting = true
						aimTimer = 0
					else
						isShooting = false
					end
					if not isAiming then
						isAiming = true

						lastCamera = GetFollowPedCamViewMode()
						if lastCamera ~= 4 then
							SetFollowPedCamViewMode(4)
						end
					elseif GetFollowPedCamViewMode() ~= 4 then
						SetFollowPedCamViewMode(4)
					end
				elseif isAiming then
					local off = true
					if isShooting then
						off = false

						aimTimer = aimTimer + 20
						if aimTimer == 3000 then
							isShooting = false
							aimTimer = 0
							off = true
						end
					end
					if off then
						isAiming = false
						if lastCamera ~= 4 then
							SetFollowPedCamViewMode(lastCamera)
						end
					end
				elseif not inVehicle then
					DisableControlAction(0, 24, true)
					DisableControlAction(0, 140, true)
					DisableControlAction(0, 141, true)
					DisableControlAction(0, 142, true)
					DisableControlAction(0, 257, true)
					DisableControlAction(0, 263, true)
					DisableControlAction(0, 264, true)
				end
			end
		else
			Wait(250)
		end
	end
end)
local Radar, Vehicles = {
	shown = false,
	info = "~r~BRAK",
	info2 = "~r~BRAK",
	zamroz = "~g~Radar gotowy do działania! Naciśnij [Num8] aby zamrozić",
	odmroz = "~b~Radar zamrożony! Naciśnij [Num8] aby odmrozić",
	state = "~g~Radar gotowy do działania! Naciśnij [Num8] aby zamrozić",
	plate = nil,
	plate2 = nil,
	model = nil,
	model2 = nil,
}, {}

function DrawAdvancedText(x, y, w, h, sc, text, r, g, b, a, font, jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1 + w, y - 0.02 + h)
end

CreateThread(function()
	Citizen.Wait(5000)
	TriggerEvent('esx_vehicleshop:getVehicles', function(base)
		Vehicles = base
	end)

	Radar.state = "~g~Radar gotowy do działania! Naciśnij [Num8] aby zamrozić"

	while true do
		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			if IsControlJustPressed(1, 128) and (IsPedInAnyPoliceVehicle(playerPed) or (IsVehicleModel(GetVehiclePedIsIn(playerPed, false), `police65`))) and not IsPedInAnyHeli(playerPed) then
				if Radar.shown then
					Radar.shown = false
					Radar.info = "~r~BRAK"
					Radar.info2 = "~r~BRAK"
					Radar.zamroz = "~g~Radar gotowy do działania! Naciśnij [Num8] aby zamrozić"
					Radar.odmroz = "~b~Radar zamrożony! Naciśnij [Num8] aby odmrozić"
					Radar.state = "~g~Radar gotowy do działania! Naciśnij [Num8] aby zamrozić"
					Radar.plate = nil
					Radar.plate2 = nil
					Radar.model = nil
					Radar.model2 = nil
				else
					Radar.shown = true
				end

				Citizen.Wait(75)
			end

			if IsControlJustPressed(1, 127) and Radar.shown then
				Radar.freeze = not Radar.freeze
			end

			if IsControlJustPressed(1, 124) and Radar.plate then
				TriggerEvent('esx_sprawdz:blachy', Radar.plate:gsub("%s$", ""), Radar.model)
			end

			if IsControlJustPressed(1, 125) and Radar.plate2 then
				TriggerEvent('esx_sprawdz:blachy', Radar.plate2:gsub("%s$", ""), Radar.model2)
			end

			if Radar.shown then
				if not Radar.freeze then
					Radar.state = Radar.zamroz
					local veh = GetVehiclePedIsIn(playerPed, false)
					local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)

					local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 60.0, 0.0)
					local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
					local a, b, c, d, e = GetShapeTestResult(frontcar)
					
					local vehicleModel = GetEntityModel(e)
						
					if IsEntityAVehicle(e) and e ~= Radar.vehicle then
						local fmodel = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(e)))
						if fmodel == 'NULL' then				
							local found = false
							for _, veh in ipairs(Vehicles) do
								if GetHashKey(veh.model) == vehicleModel then
									fmodel = veh.name
									found = true
									break
								end
							end

							if not found then							
								fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
							end
						end

						Radar.vehicle = e
						Radar.plate = GetVehicleNumberPlateText(e)
						Radar.model = fmodel
						Radar.info = string.format("~b~Nr rej.: ~w~%s  ~b~Model: ~w~%s  ~b~Prędkość: ~w~%s km/h", Radar.plate, fmodel, math.floor(GetEntitySpeed(e) * 3.6 + 0.5))
					end
						
					local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
					local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
					local f, g, h, i, j = GetShapeTestResult(rearcar)
					
					local vehicleModel = GetEntityModel(j)

					if IsEntityAVehicle(j) and j ~= Radar.vehicle2 then
						local bmodel = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(j)))
						if bmodel == 'NULL' then				
							local found = false
							for _, veh in ipairs(Vehicles) do
								if GetHashKey(veh.model) == vehicleModel then
									bmodel = veh.name
									found = true
									break
								end
							end

							if not found then
								bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
							end
						end

						Radar.vehicle2 = j
						Radar.plate2 = GetVehicleNumberPlateText(j)
						Radar.model2 = bmodel
						Radar.info2 = string.format("~b~Nr rej.: ~w~%s  ~b~Model: ~w~%s  ~b~Prędkość: ~w~%s km/h", Radar.plate2, bmodel, math.floor(GetEntitySpeed(j) * 3.6 + 0.5))
					end
				else
					Radar.state = Radar.odmroz
				end

				DrawAdvancedText(0.602, 0.870, 0.005, 0.0028, 0.4, Radar.state, 255, 255, 255, 255, 6, 0)
				DrawAdvancedText(0.602, 0.903, 0.005, 0.0028, 0.4, "~g~RADAR - Front ([Num4] aby sprawdzić bazę)", 0, 191, 255, 255, 6, 0)
				DrawAdvancedText(0.602, 0.953, 0.005, 0.0028, 0.4, "~g~RADAR - Tył ([Num6] aby sprawdzić bazę)", 0, 191, 255, 255, 6, 0)
				DrawAdvancedText(0.602, 0.928, 0.005, 0.0028, 0.4, Radar.info, 255, 255, 255, 255, 6, 0)
				DrawAdvancedText(0.602, 0.979, 0.005, 0.0028, 0.4, Radar.info2, 255, 255, 255, 255, 6, 0)
			end

			if not IsPedInAnyVehicle(playerPed) then
				Radar.shown = false
				Radar.vehicle = nil
				Radar.vehicle2 = nil
				Radar.plate = nil
				Radar.plate2 = nil
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

RegisterNetEvent('esx_sprawdz:blachy')
AddEventHandler('esx_sprawdz:blachy', function(plate, model)
	ESX.ShowAdvancedNotification('PlateRP', plate, '~y~Pojazd: ~s~'..model..'\n~y~Właściciel: ~s~Wyszukiwanie')
	Wait(2000)

	ESX.TriggerServerCallback('esx_misiaczek:getVehicleFromPlate', function(data)
		CreateThread(function()			
			local poszukiwany = '~r~Nie'
			if data.poszukiwany then
				PlaySound(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
				poszukiwany = '~g~Tak'
			end
			
		
			local str = "Data urodzenia: ~y~"..data.dob.."~s~\n"
			str = str .. "Wzrost: ~y~"..data.height .. "~s~\n"
			str = str .. "Płeć: ~y~" ..data.sex

			TriggerEvent("FeedM:showAdvancedNotification", data.owner, '~s~Poszukiwany: ' ..poszukiwany, str, 'CHAR_BANK_MAZE', 10000)
		end)
		
	end, plate)
end)

CreateThread(function()
	while true do
		Citizen.Wait(60000)
		
		ESX.TriggerServerCallback("esx_scoreboard:getConnectedCops", function(MisiaczekPlayers)
			if MisiaczekPlayers then
				SetDiscordAppId(943162515205013545)

				SetDiscordRichPresenceAsset('logo')
				name = GetPlayerName(playerid)
				id = GetPlayerServerId(playerid)
				SetDiscordRichPresenceAssetText("ID: "..id.." | "..name.." ")
				SetRichPresence("ID: "..id.." | "..name.." | "..MisiaczekPlayers['players'].."/"..MisiaczekPlayers['maxPlayers'])
				SetDiscordRichPresenceAction(1, "DOŁĄCZ DO NAS!", "https://discord.gg/9MgJUuSv4a")
				SetDiscordRichPresenceAction(0, "Zagraj z nami!", "fivem://connect/")
			end
		end)
	end
end)

CreateThread(function()
    while true do
        Citizen.Wait(1000)
		for _, ped in ipairs(ESX.Game.GetPeds()) do
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		SetWeaponDrops()
		ClearAreaOfCops(playercoords.x, playercoords.y, playercoords.z, 400.0)
    end
end)

function SetWeaponDrops()
	local handle, ped = FindFirstPed()
	local finished = false

	repeat
		if not IsEntityDead(ped) then
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		finished, ped = FindNextPed(handle)
	until not finished

	EndFindPed(handle)
end

AddEventHandler('skinchanger:modelLoaded', function()
	ModelLoaded()
end)

AddEventHandler('misiaczek:newplayer', function()
	newPlayer = true
	ModelLoaded()
end)

function ModelLoaded()
	if loadingPosition ~= true and loadingStatus < 2 then
		print('[PlateRP]: ModelLoaded')
		CreateThread(function()
			while not loadingPosition do
				Citizen.Wait(0)
			end
			
			Citizen.Wait(1000)
			loadingStatus = 2
			SendLoadingScreenMessage(json.encode({allow = true}))
		end)
	end
end

CreateThread(function()
	SetManualShutdownLoadingScreenNui(false)
	StartAudioScene("MP_LEADERBOARD_SCENE")
	SendLoadingScreenMessage(json.encode({ready = true}))

	TriggerEvent('chat:display', false)
	while true do
		Citizen.Wait(0)
		if loadingStatus == 2 and (IsControlJustPressed(0, 18) or IsDisabledControlPressed(0, 18)) then
			StartWyspa()
			print('[PlateRP]: Wczytano')
			break
		end
	end
end)

RegisterCommand('play', function(source, args, raw)
	if loadingStatus == 2 then
		CreateThread(StartWyspa)
	end
end, false)

function StartWyspa()
	Citizen.InvokeNative(0xABA17D7CE615ADBF, "FMMC_STARTTRAN")
	Citizen.InvokeNative(0xBD12F8228410D9B4, 4)
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

	local ped = PlayerPedId()
	SetEntityCoords(ped, loadingPosition.x, loadingPosition.y, loadingPosition.z)
	FreezeEntityPosition(ped, false)

	Citizen.InvokeNative(0xEA1C610A04DB6BBB, ped, true)
	Citizen.InvokeNative(0x239528EACDC3E7DE, PlayerId(), false)
	StopAudioScene("MP_LEADERBOARD_SCENE")

	DoScreenFadeOut(0)	
	ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()

	SetPedMaxHealth(ped, 200)
	Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, ped, 200)

	loadingPosition = true
	loadingStatus = 3
	Citizen.Wait(1000)

	DoScreenFadeIn(1000)
	while IsScreenFadingIn() do
		Citizen.Wait(0)
	end

	Citizen.Wait(2000)

	ESX.UI.HUD.SetDisplay(1.0)
	
	TriggerEvent('chat:clear')
	TriggerEvent('wybranopostac', true)
	TriggerEvent('route68:kino_state', false)
	Citizen.InvokeNative(0x10D373323E5B9C0D)
	
	if newPlayer then
		TriggerEvent('esx_skin:openSaveableMenu')
	end
end

AddEventHandler('misiaczek:load', function(cb)
	cb(loadingStatus)
end)

function DisplayingStreet()
	return displayStreet
end


CreateThread(function()
	while true do
		SetBlackout(blackout)
		if lastWeather ~= currentWeather then
			lastWeather = currentWeather
			SetWeatherTypeOverTime(currentWeather, 30.0)
			Citizen.Wait(30000)
		end

		Citizen.Wait(100)
		ClearOverrideWeather()
		ClearWeatherTypePersist()

		SetWeatherTypePersist(lastWeather)
		SetWeatherTypeNow(lastWeather)
		SetWeatherTypeNowPersist(lastWeather)

		if lastWeather == 'XMAS' then
			SetForceVehicleTrails(true)
			SetForcePedFootstepsTracks(true)
		else
			SetForceVehicleTrails(false)
			SetForcePedFootstepsTracks(false)
		end
	end
end)

RegisterNetEvent('misiaczek:updateWeather')
AddEventHandler('misiaczek:updateWeather', function(_weather, _blackout)
	currentWeather = _weather
	blackout = _blackout
end)

RegisterNetEvent('misiaczek:updateTime')
AddEventHandler('misiaczek:updateTime', function(base, offest, freeze)
	freezeTime = freeze
	timeOffset = offest
	baseTime = base
end)
local RPM = 0
local RPMTime = GetGameTimer()
local Status = true

AddEventHandler('carhud:display', function(status)
	Status = status
end)

local Ped = {
	Vehicle = nil,
	VehicleClass = nil,
	VehicleStopped = true,
	VehicleEngine = false,
	VehicleGear = nil,
	Health = 0,
	Armor = 0,
	Stamina = 0,
	Underwater = false,
	UnderwaterTime = 0,
	Driver = false,
	PhoneVisible = false,
}

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		if IsPedInAnyVehicle(playerPed, false) then
			Ped.InVehicle = true
			Ped.Driver = GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed
		else
			Ped.InVehicle = false
			Ped.Health = GetEntityHealth(playerPed)
			Ped.Armor = GetPedArmour(playerPed)
			Ped.Underwater = IsPedSwimmingUnderWater(playerPed)

			Ped.Stamina = GetPlayerSprintStaminaRemaining(playerid)

			Ped.UnderwaterTime = GetPlayerUnderwaterTimeRemaining(playerid)
			if Ped.UnderwaterTime < 0.0 then
				Ped.UnderwaterTime = 0.0
			end
		end

		Ped.PhoneVisible = exports['gcphone']:getMenuIsOpen()
	end
end)

local isUiOpen = false 
local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end 

Fwv = function (entity)
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end
 
 
	  Citizen.CreateThread(
		function()
			RequestStreamedTextureDict("mpinventory")
			while not HasStreamedTextureDictLoaded("mpinventory") do
				Citizen.Wait(50)
			end
	
			local timer = GetGameTimer()
	
			while true do
				Citizen.Wait(1)
				if Ped.Vehicle then
					wasInCar = true
					if isUiOpen == false and not IsPlayerDead(PlayerId()) then
						DrawSprite("mpinventory", "mp_specitem_ped", 0.162, 0.984, 0.015, 0.025, 0.0, 255, 255, 255, 255)
						local tmp = GetGameTimer() - timer
						if tmp > 1000 then
							timer = GetGameTimer()
						elseif tmp > 500 then
							DrawSprite(
								"mpinventory",
								"mp_specitem_partnericon",
								0.162,
								0.984,
								0.01,
								0.02,
								0.0,
								255,
								0,
								0,
								255
							)
						end
					end
					if beltOn then
						DisableControlAction(0, 75)
						DrawSprite("mpinventory", "mp_specitem_ped", 0.162, 0.984, 0.015, 0.025, 0.0, 255, 255, 255, 255)
						DrawSprite("mpinventory", "mp_specitem_partnericon", 0.162, 0.984, 0.01, 0.02, 0.0, 0, 255, 0, 255)
					end
					speedBuffer[2] = speedBuffer[1]
					speedBuffer[1] = GetEntitySpeed(Ped.Vehicle)
					if
						speedBuffer[2] ~= nil and not beltOn and GetEntitySpeedVector(Ped.Vehicle, true).y > 1.0 and
							speedBuffer[1] > 19.25 and
							(speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255)
					 then
						local co = GetEntityCoords(playerPed)
						local fw = Fwv(playerPed)
						SetEntityCoords(playerPed, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
						SetEntityVelocity(playerPed, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
						Citizen.Wait(1)
						SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0)
					end
					velBuffer[2] = velBuffer[1]
					velBuffer[1] = GetEntityVelocity(Ped.Vehicle)
					if IsControlJustReleased(0, 29) and GetLastInputMethod(0) then
						beltOn = not beltOn
						if beltOn then
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "belton", 1.0)
							DrawSprite(
								"mpinventory",
								"mp_specitem_ped",
								0.162,
								0.984,
								0.015,
								0.025,
								0.0,
								255,
								255,
								255,
								255
							)
							DrawSprite(
								"mpinventory",
								"mp_specitem_partnericon",
								0.162,
								0.984,
								0.01,
								0.02,
								0.0,
								0,
								255,
								0,
								255
							)
						else
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "beltoff", 1.0)
							DrawSprite(
								"mpinventory",
								"mp_specitem_ped",
								0.162,
								0.984,
								0.015,
								0.025,
								0.0,
								255,
								255,
								255,
								255
							)
							local tmp = GetGameTimer() - timer
							if tmp > 1000 then
								timer = GetGameTimer()
							elseif tmp > 500 then
								DrawSprite(
									"mpinventory",
									"mp_specitem_partnericon",
									0.162,
									0.984,
									0.01,
									0.02,
									0.0,
									255,
									0,
									0,
									255
								)
							end
						end
					end
				elseif wasInCar then
					wasInCar = false
					beltOn = false
					speedBuffer[1], speedBuffer[2] = 0.0, 0.0
					if isUiOpen == true and not IsPlayerDead(PlayerId()) then
						DrawSprite("mpinventory", "mp_specitem_ped", 0.162, 0.984, 0.015, 0.025, 0.0, 255, 255, 255, 255)
						DrawSprite("mpinventory", "mp_specitem_partnericon", 0.162, 0.984, 0.01, 0.02, 0.0, 0, 255, 0, 255)
					end
				end
			end
		end
)

local streetLabel = {}

CreateThread(function()
	local hour, minute = 0, 0
	while true do
		Citizen.Wait(2)
		
		local newBaseTime = baseTime
		if GetGameTimer() - 500 > timer then
			newBaseTime = newBaseTime + 0.25
			timer = GetGameTimer()
		end

		if freezeTime then
			timeOffset = timeOffset + baseTime - newBaseTime			
		end
		
		baseTime = newBaseTime
		hour = math.floor(((baseTime + timeOffset) / 60) % 24)
		minute = math.floor((baseTime + timeOffset) % 60)
		NetworkOverrideClockTime(hour, minute, 0)
	

		if displayStreet and streetLabel.direction and not isHandcuffed then
			_DrawText(0.515, 1.26, 1.0, 1.0, 0.4, streetLabel.zone, 66, 165, 245, 200)
			_DrawText(0.635, 1.26, 1.0, 1.0, 0.4, (hour < 10 and '0' or '') .. hour .. ':' .. (minute < 10 and '0' or '') .. minute, 107, 131, 22, 200)
			_DrawText(0.515, 1.28, 1.0, 1.0, 0.33, streetLabel.street, 165, 165, 165, 200)
			_DrawText((streetLabel.direction:len() > 1 and 0.644 or 0.648), 1.28, 1.0, 1.0, 0.33, streetLabel.direction, 255, 255, 255, 200)
		else
			Citizen.Wait(150)
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped, direction = PlayerPedId(), nil
		for k, v in pairs(Config.Directions) do
			direction = GetEntityHeading(ped)
			if math.abs(direction - k) < 22.5 then
				direction = v
				break
			end
		end

		local coords = GetEntityCoords(ped, true)
		local zone = GetNameOfZone(coords.x, coords.y, coords.z)

		streetLabel.zone = (Config.Zones[zone:upper()] or zone:upper())
		streetLabel.street = GetStreetsCustom(coords)
		streetLabel.direction = (direction or 'N')
	end
end)

function GetStreetsCustom(coords)
	for _, street in ipairs(Config.CustomStreets) do
		if coords.x >= street.start_x and coords.x <= street.end_x and coords.y >= street.start_y and coords.y <= street.end_y then
			return "~y~" .. street.name
		end
	end

	local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
	local street1, street2 = GetStreetNameFromHashKey(s1), GetStreetNameFromHashKey(s2)
	return "~y~" .. street1 .. (street2 ~= "" and "~s~ / " .. street2 or "")
end

function _DrawText(x, y, width, height, scale, text, r, g, b, a)
	SetTextFont(4)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

AddEventHandler('ExileRP:setDisplayStreet', function(val)
	displayStreet = val
end)

local OnlyDriver = false
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(200)
		if Hide then
			DisplayRadar(false)
			TriggerEvent('ExileRP:setDisplayStreet', false)
		else
			if Ped.InVehicle then
				if not OnlyDriver or Ped.Driver then
					DisplayRadar(true)
					if not displayStreet then
						TriggerEvent('ExileRP:setDisplayStreet', true)
					end
				end
			elseif Ped.PhoneVisible then
				DisplayRadar(true)
				if not displayStreet then
					TriggerEvent('ExileRP:setDisplayStreet', true)
				end
			else
				DisplayRadar(false)
				if displayStreet then
					TriggerEvent('ExileRP:setDisplayStreet', false)
				end
			end
		end
	end
end)


CreateThread(function()
	while true do
		Citizen.Wait(3)
		if not Ped.InVehicle then
			local MM = GetMinimapAnchor()
			local BarY = MM.bottom_y - ((MM.yunit * 18.0) * 0.5)
			local BackgroundBarH = MM.yunit * 18.0
			local BarH = BackgroundBarH / 2
			local BarSpacer = MM.xunit * 3.0
			local BackgroundBar = {['R'] = 0, ['G'] = 0, ['B'] = 0, ['A'] = 125, ['L'] = 0}
			
			local HealthBaseBar = {['R'] = 57, ['G'] = 102, ['B'] = 57, ['A'] = 175, ['L'] = 1}
			local HealthBar = {['R'] = 114, ['G'] = 204, ['B'] = 114, ['A'] = 175, ['L'] = 2}
			
			local HealthHitBaseBar = {['R'] = 112, ['G'] = 25, ['B'] = 25, ['A'] = 175}
			local HealthHitBar = {['R'] = 224, ['G'] = 50, ['B'] = 50, ['A'] = 175}
			
			local ArmourBaseBar = {['R'] = 47, ['G'] = 92, ['B'] = 115, ['A'] = 175, ['L'] = 1}
			local ArmourBar = {['R'] = 93, ['G'] = 182, ['B'] = 229, ['A'] = 175, ['L'] = 2}
			
			local AirBaseBar = {['R'] = 67, ['G'] = 106, ['B'] = 130, ['A'] = 175, ['L'] = 1}
			local AirBar = {['R'] = 174, ['G'] = 219, ['B'] = 242, ['A'] = 175, ['L'] = 2}
			
			local BackgroundBarW = MM.width
			local BackgroundBarX = MM.x + (MM.width / 2)
			_DrawRect(BackgroundBarX, BarY, BackgroundBarW, BackgroundBarH, BackgroundBar.R, BackgroundBar.G, BackgroundBar.B, BackgroundBar.A, BackgroundBar.L)

			local HealthBaseBarW = (MM.width / 2) - (BarSpacer / 2)
			local HealthBaseBarX = MM.x + (HealthBaseBarW / 2)
			local HealthBaseBarR, HealthBaseBarG, HealthBaseBarB, HealthBaseBarA = HealthBaseBar.R, HealthBaseBar.G, HealthBaseBar.B, HealthBaseBar.A
			local HealthBarW = (MM.width / 2) - (BarSpacer / 2)
			if Ped.Health < 200 and Ped.Health > 100 then
				HealthBarW = ((MM.width / 2) - (BarSpacer / 2)) / 100 * (Ped.Health - 100)
			elseif Ped.Health < 100 then
				HealthBarW = 0
			end

			local HealthBarX = MM.x + (HealthBarW / 2)
			local HealthBarR, HealthBarG, HealthBarB, HealthBarA = HealthBar.R, HealthBar.G, HealthBar.B, HealthBar.A
			if Ped.Health <= 130 or (Ped.Stamina >= 90.0 and (IsPedRunning(ped) or IsPedSprinting(ped))) then
				HealthBaseBarR, HealthBaseBarG, HealthBaseBarB, HealthBaseBarA = HealthHitBaseBar.R, HealthHitBaseBar.G, HealthHitBaseBar.B, HealthHitBaseBar.A
				HealthBarR, HealthBarG, HealthBarB, HealthBarA = HealthHitBar.R, HealthHitBar.G, HealthHitBar.B, HealthHitBar.A
			end
			
			_DrawRect(HealthBaseBarX, BarY, HealthBaseBarW, BarH, HealthBaseBarR, HealthBaseBarG, HealthBaseBarB, HealthBaseBarA, HealthBaseBar.L)
			_DrawRect(HealthBarX, BarY, HealthBarW, BarH, HealthBarR, HealthBarG, HealthBarB, HealthBarA, HealthBar.L)
			if not Ped.Underwater then
				local ArmourBaseBarW = (MM.width / 2) - (BarSpacer / 2)
				local ArmourBaseBarX = MM.right_x - (ArmourBaseBarW / 2)
				local ArmourBarW = ((MM.width / 2) - (BarSpacer / 2)) / 100 * Ped.Armor
				local ArmourBarX = MM.right_x - ((MM.width / 2) - (BarSpacer / 2)) + (ArmourBarW / 2)

				_DrawRect(ArmourBaseBarX, BarY, ArmourBaseBarW, BarH, ArmourBaseBar.R, ArmourBaseBar.G, ArmourBaseBar.B, ArmourBaseBar.A, ArmourBaseBar.L)
				_DrawRect(ArmourBarX, BarY, ArmourBarW, BarH, ArmourBar.R, ArmourBar.G, ArmourBar.B, ArmourBar.A, ArmourBar.L)
			else
				local ArmourBaseBarW = (((MM.width / 2) - (BarSpacer / 2)) / 2) - (BarSpacer / 2)
				local ArmourBaseBarX = MM.right_x - (((MM.width / 2) - (BarSpacer / 2)) / 2) - (ArmourBaseBarW / 2) - (BarSpacer / 2)
				local ArmourBarW = ((((MM.width / 2) - (BarSpacer / 2)) / 2) - (BarSpacer / 2)) / 100 * Ped.Armor
				local ArmourBarX = MM.right_x - ((MM.width / 2) - (BarSpacer / 2)) + (ArmourBarW / 2)

				_DrawRect(ArmourBaseBarX, BarY, ArmourBaseBarW, BarH, ArmourBaseBar.R, ArmourBaseBar.G, ArmourBaseBar.B, ArmourBaseBar.A, ArmourBaseBar.L)
				_DrawRect(ArmourBarX, BarY, ArmourBarW, BarH, ArmourBar.R, ArmourBar.G, ArmourBar.B, ArmourBar.A, ArmourBar.L)
				
				local AirBaseBarW = (((MM.width / 2) - (BarSpacer / 2)) / 2) - (BarSpacer / 2)
				local AirBaseBarX = MM.right_x - (AirBaseBarW / 2)
				local AirBarW = ((((MM.width / 2) - (BarSpacer / 2)) / 2) - (BarSpacer / 2)) / 10.0 * Ped.UnderwaterTime
				local AirBarX = MM.right_x - ((((MM.width / 2) - (BarSpacer / 2)) / 2) - (BarSpacer / 2)) + (AirBarW / 2)

				_DrawRect(AirBaseBarX, BarY, AirBaseBarW, BarH, AirBaseBar.R, AirBaseBar.G, AirBaseBar.B, AirBaseBar.A, AirBaseBar.L)
				_DrawRect(AirBarX, BarY, AirBarW, BarH, AirBar.R, AirBar.G, AirBar.B, AirBar.A, AirBar.L)
			end
		else
			Citizen.Wait(100)
		end
	end
end)

function _DrawRect(X, Y, W, H, R, G, B, A, L)
	SetUiLayer(L)
	DrawRect(X, Y, W, H, R, G, B, A)
end

local CruiseControl = false
CreateThread(function()
	while true do
		Citizen.Wait(200)

		if Status and not exports['esx_policejob']:IsCuffed() then
			if IsPedInAnyVehicle(playerPed, false) then
				Ped.Vehicle = GetVehiclePedIsIn(playerPed, false)
				Ped.VehicleClass = GetVehicleClass(Ped.Vehicle)
				Ped.VehicleStopped = IsVehicleStopped(Ped.Vehicle)
				Ped.VehicleEngine = GetIsVehicleEngineRunning(Ped.Vehicle)
				Ped.VehicleGear = GetVehicleCurrentGear(Ped.Vehicle)	
			else
				Ped.Vehicle = nil
			end
		else
			Ped.Vehicle = nil
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)
		if Ped.Vehicle then
			local Gear = Ped.VehicleGear
			if not Ped.VehicleEngine then
				Gear = 'P'
			elseif Ped.VehicleStopped then
				Gear = 'N'
			elseif Ped.VehicleClass == 15 or Ped.VehicleClass == 16 then
				Gear = 'F'
			elseif Ped.VehicleClass == 14 then
				Gear = 'S'
			elseif Gear == 0 then
				Gear = 'R'
			end

			local RPMScale = 0
			if (Ped.VehicleClass >= 0 and Ped.VehicleClass <= 5) or (Ped.VehicleClass >= 9 and Ped.VehicleClass <= 12) or Ped.VehicleClass == 17 or Ped.VehicleClass == 18 or Ped.VehicleClass == 20 then
				RPMScale = 7000
			elseif Ped.VehicleClass == 6 then
				RPMScale = 7500
			elseif Ped.VehicleClass == 7 then
				RPMScale = 8000
			elseif Ped.VehicleClass == 8 then
				RPMScale = 11000
			elseif Ped.VehicleClass == 15 or Ped.VehicleClass == 16 then
				RPMScale = -1
			end

			local Speed = math.floor(GetEntitySpeed(Ped.Vehicle) * 3.6 + 0.5)
			if RPMTime <= GetGameTimer() then
				local r = GetVehicleCurrentRpm(Ped.Vehicle)
				if not Ped.VehicleEngine then
					r = 0
				elseif r > 0.99 then
					r = r * 100
					r = r + math.random(-2,2)

					r = r / 100
					if r < 0.12 then
						r = 0.12
					end
				else
					r = r - 0.1
				end

				RPM = math.floor(RPMScale * r + 0.5)
				if RPM < 0 then
					RPM = 0
				elseif Speed == 0.0 and r ~= 0 then
					RPM = math.random(RPM, (RPM + 50))
				end

				RPM = math.floor(RPM / 10) * 10
				RPMTime = GetGameTimer() + 50
			end

			local UI = { x = 0.0, y = 0.0 }
			if RPMScale > 0 then
				drawRct(UI.x + 0.1135, 	UI.y + 0.804, 0.042,0.026,0,0,0,100)
				drawTxt(UI.x + 0.6137, 	UI.y + 1.296, 1.0,1.0,0.45 , "~" .. (RPM > (RPMScale - 1000) and "r" or "w") .. "~" .. RPM, 255, 255, 255, 255)
				drawTxt(UI.x + 0.635, 	UI.y + 1.3, 1.0,1.0,0.35, "~w~rpm/~y~" .. Gear, 255, 255, 255, 255)
			else
				drawRct(UI.x + 0.1135, 	UI.y + 0.804, 0.042,0.026,0,0,0,100)
				local coords = GetEntityCoords(Ped.Vehicle, false)
				drawTxt(UI.x + 0.6137, 	UI.y + 1.296, 1.0,1.0,0.45, math.floor(coords.z), 255, 255, 255, 255)
				drawTxt(UI.x + 0.635, 	UI.y + 1.3, 1.0,1.0,0.35, "mnpm", 255, 255, 255, 255)
			end

			drawRct(UI.x + 0.1195, 	UI.y + 0.938, 0.036,0.03,0,0,0,100)
			drawTxt(UI.x + 0.62, 	UI.y + 1.431, 1.0,1.0,0.5 , "~" .. (CruiseControl and "b" or "w") .. "~" .. Speed, 255, 255, 255, 255)
			drawTxt(UI.x + 0.637, 	UI.y + 1.438, 1.0,1.0,0.35, "~" .. (Speed > 85 and (Speed > 155 and "r" or "y") or "w") .. "~km/h", 255, 255, 255, 255)
		else
			Citizen.Wait(200)
		end
	end
end)

function drawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()

    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function drawRct(x, y, width, height, r, g, b, a)
	DrawRect(x + width / 2, y + height / 2, width, height, r, g, b, a)
end

local hour, minute = 0, 0

CreateThread(function()
	while true do
		Citizen.Wait(0)

		local inVehicle = IsPedInAnyVehicle(playerPed, false)
		local cc, cv = Config.Density.CitizenDefault, Config.Density.VehicleDefault
		if inVehicle then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			
			if GetPedInVehicleSeat(vehicle, -1) ~= playerPed then
				cc, cv = Config.Density.CitizenPassengers, Config.Density.VehiclePassengers
				if DisableShuffle and GetPedInVehicleSeat(vehicle, 0) == playerPed and GetIsTaskActive(playerPed, 165) then
					SetPedIntoVehicle(playerPed, vehicle, 0)
				end
			else
				cc, cv = Config.Density.CitizenDriver, Config.Density.VehicleDriver
			end
		end
		
		SetPlayerHealthRechargeMultiplier(playerPed, 0.0)
		

		if Config.AdjustDensity then
			SetPedDensityMultiplierThisFrame(cc)
			SetScenarioPedDensityMultiplierThisFrame(cc, cc)

			SetVehicleDensityMultiplierThisFrame(cv)
			SetRandomVehicleDensityMultiplierThisFrame(cv)
			SetParkedVehicleDensityMultiplierThisFrame(cv)
		end

		SetGarbageTrucks(false)
		SetRandomBoats(false)
		SetCreateRandomCops(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetCreateRandomCopsOnScenarios(false)

		if inProperty then
			ClearAreaOfPeds(playercoords.x, playercoords.y, playercoords.z, 10.0, 0)
		end
	end

	
end)

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/weather', 'Zmień pogode.', {{ name="Pogoda", help="Dostępne: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}})
    TriggerEvent('chat:addSuggestion', '/time', 'Zmień czas.', {{ name="Godzina", help="Liczba między 0 - 23"}, { name="Minuty", help="Liczba między 0 - 59"}})
    TriggerEvent('chat:addSuggestion', '/freezetime', 'Zamroź/odmroź czas.')
    TriggerEvent('chat:addSuggestion', '/freezeweather', 'Zamroź/odmroź opcje Dynamic Weather.')
    TriggerEvent('chat:addSuggestion', '/blackout', 'Zmień tryb blackout.')
	StatSetProfileSetting(226, 0)	
	for key, value in pairs(Config.Visuals) do
		SetVisualSettingFloat(key, value)
	end
	while not Citizen.InvokeNative(0xB8DFD30D6973E135, playerid) do
		Citizen.Wait(100)
	end
	
	TriggerServerEvent('misiaczek:playerConnected')
end)

local skinbag = nil
local time = 7000
local nbrDisplaying = 0
local tookWeapon = false
local LoadedIn = false
local timeout = false

CreateThread(function()
	while true do
		Citizen.Wait(18000)
		if not LoadedIn then
			LoadedIn = true
		end
	end
end)

local function timeOut()
    SetTimeout(4100, function()
        timeout = false
    end)
end

CreateThread(function()
	local pausing = false
	while true do
		Citizen.Wait(200)
		
		local direction = nil
		for k, v in pairs(Config.Directions) do
			direction = GetEntityHeading(playerPed)
			if math.abs(direction - k) < 22.5 then
				direction = v
				break
			end
		end
		
		inProperty = exports['esx_property']:isInProperty()
		isHandcuffed = exports['esx_policejob']:IsCuffed()

		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end

		local status, weapon = GetCurrentPedWeapon(playerPed, true)
		if status == 1 then

			local mul = Config.Weapons[weapon]
			if mul then
				SetPlayerWeaponDamageModifier(playerid, mul)
			else
				mul = Config.Melees[weapon]
				if mul then
					SetPlayerMeleeWeaponDamageModifier(playerid, mul)
				else
					SetPlayerWeaponDamageModifier(playerid, 1.0)
					SetPlayerMeleeWeaponDamageModifier(playerid, 1.0)
				end
			end

			if Config.WeaponWhitelistEnabled then
				local found = false
				for _, model in ipairs(Config.WeaponWhitelist) do
					if weapon == model then
						found = true
						break
					end
				end

				if not found and GetWeapontypeModel(weapon) ~= 0 then
					strike = strike + 1
					if strike >= 6 then
						TriggerServerEvent('exile_logs:triggerLog', "Wykryto zablokowane bronie: "..strike.." razy.", 'protect')
						Citizen.InvokeNative(0x4899CB088EDF59B8, playerPed, weapon)
					else
						TriggerServerEvent('exile_logs:triggerLog', "Wykryto zablokowaną broń: " .. weapon, 'protect')
						Citizen.InvokeNative(0x4899CB088EDF59B8, playerPed, weapon)
					end
				end
			end
		else
			SetPlayerMeleeWeaponDamageModifier(playerid, Config.Melees[`WEAPON_UNARMED`])
		end
	end
end)

function weather()
    CreateThread(function()
        while true do
            SetWeatherTypePersist("HALLOWEEN")
            SetWeatherTypeNowPersist("HALLOWEEN")
            SetWeatherTypeNow("HALLOWEEN")
            SetOverrideWeather("HALLOWEEN")
            Citizen.Wait(0)
        end
    end)
end
local vehicleRollThresh = 60
local vehicleClassDisable = {
    [0] = true,     --compacts
    [1] = true,     --sedans
    [2] = true,     --SUV's
    [3] = true,     --coupes
    [4] = true,     --muscle
    [5] = true,     --sport classic
    [6] = true,     --sport
    [7] = true,     --super
    [8] = false,    --motorcycle
    [9] = true,     --offroad
    [10] = true,    --industrial
    [11] = true,    --utility
    [12] = true,    --vans
    [13] = false,   --bicycles
    [14] = false,   --boats
    [15] = false,   --helicopter
    [16] = false,   --plane
    [17] = true,    --service
    [18] = true,    --emergency
    [19] = false    --military
}

CreateThread(function()
    while true do
        Citizen.Wait(0)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local vehicleClass = GetVehicleClass(vehicle)
        if ((GetPedInVehicleSeat(vehicle, -1) == playerPed) and vehicleClassDisable[vehicleClass]) then
                if not IsEntityInAir(vehicle) then
                    local vehicleRoll = GetEntityRoll(vehicle)
                    if (math.abs(vehicleRoll) > vehicleRollThresh) then
                    DisableControlAction(2, 59)
                    DisableControlAction(2, 60)
                end
            end
        else
            Wait(250)
        end
    end
end)

local blackBars = false
RegisterNetEvent('route68:kino_state')
AddEventHandler('route68:kino_state', function(rodzaj)
	if rodzaj then
		blackBars = true
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('chat:toggleChat', true)
		TriggerServerEvent('misiaczek:kino', true)
		TriggerEvent('hungerthirst:hud_state', true)
		TriggerEvent('bodycam:state', true)
		TriggerEvent('esx_status:setDisplay', 0.0)
		TriggerEvent('esx_voice:setDisplay', 0.0)
		TriggerEvent('radar:setHidden', true)
		TriggerEvent('carhud:display', false)
		TriggerEvent('esx_customui:toggle', false)
		TriggerEvent('misiaczek_dzwon:display', false)
	elseif rodzaj == false then
		blackBars = false
		ESX.UI.HUD.SetDisplay(1.0)
		TriggerEvent('chat:toggleChat', false)
		TriggerEvent('hungerthirst:hud_state', false)
		TriggerEvent('bodycam:state', false)
		TriggerEvent('esx_status:setDisplay', 1.0)
		TriggerEvent('esx_voice:setDisplay', 1)
		TriggerEvent('radar:setHidden', false)
		TriggerEvent('carhud:display', true)
		TriggerEvent('misiaczek_dzwon:display', true)
		TriggerEvent('esx_customui:toggle', true)
	end
end)

RegisterNetEvent('route68:kino')
AddEventHandler('route68:kino', function()
	cam = not cam
	
	if cam then
		blackBars = true
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('chat:toggleChat', true)
		TriggerServerEvent('misiaczek:kino', true)
		TriggerEvent('hungerthirst:hud_state', true)
		TriggerEvent('bodycam:state', true)
		TriggerEvent('esx_status:setDisplay', 0.0)
		TriggerEvent('radar:setHidden', true)
		TriggerEvent('carhud:display', false)
		TriggerEvent('exile:pasy', false)
		TriggerEvent('esx_customui:toggle', false)
	elseif not cam then
		blackBars = false
		ESX.UI.HUD.SetDisplay(1.0)
		TriggerEvent('chat:toggleChat', false)
		TriggerEvent('hungerthirst:hud_state', false)
		TriggerEvent('bodycam:state', false)
		TriggerEvent('esx_status:setDisplay', 1.0)
		TriggerEvent('radar:setHidden', false)
		TriggerEvent('carhud:display', true)
		TriggerEvent('exile:pasy', true)
		TriggerEvent('esx_customui:toggle', true)
	end
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
        if blackBars then
            DrawRect(1.0, 1.0, 2.0, 0.25, 0, 0, 0, 255)
            DrawRect(1.0, 0.0, 2.0, 0.25, 0, 0, 0, 255)
			else
			Citizen.Wait(500)
		end
    end
end)

CreateThread(function()
	if ESX and ESX.PlayerData.group == 'user' then
	while true do
		Citizen.Wait(500)
			if NetworkIsInSpectatorMode() then
				TriggerServerEvent("pierdolciesieniggerydumpujacebotujestwszystko2")
			end
		end
	end
end)

local holstered = false
local hand = false
local weapons = {
    --BRON BIALA--
    "WEAPON_DAGGER",
    "WEAPON_BAT",
    "WEAPON_BOTTLE",
    "WEAPON_CROWBAR",
    "WEAPON_FLASHLIGHT",
    "WEAPON_GOLFCLUB",
    "WEAPON_HAMMER",
    "WEAPON_HATCHET",
    "WEAPON_KNIFE",
    "WEAPON_MACHETE",
    "WEAPON_NIGHTSTICK",
    "WEAPON_WRENCH",
    "WEAPON_BATTLEAXE",
    "WEAPON_POOLCUE",
    "WEAPON_STONE_HATCHET",

    --PISTOLETY--
    "WEAPON_PISTOL",
    "WEAPON_PISTOL_MK2",
	"WEAPON_NAVYREVOLVER",
    "WEAPON_COMBATPISTOL",
    "WEAPON_APPISTOL",
    "WEAPON_STUNGUN",
    "WEAPON_PISTOL50",
    "WEAPON_SNSPISTOL",
    "WEAPON_SNSPISTOL_MK2",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_FLAREGUN",
    "WEAPON_MARKSMANPISTOL",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_NAVYREVOLVER",
	"WEAPON_GADGETPISTOL",
	"WEAPON_STUNGUN_MP",
    "WEAPON_REVOLVER",
    "WEAPON_REVOLVER_MK2",
    
    --MACHINE PISTOLE--
    "WEAPON_MICROSMG",
    "WEAPON_SMG",
    "WEAPON_SMG_MK2",
    "WEAPON_ASSAUTSMG",
    "WEAPON_COMBATPDW",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_MINISMG",
    
   --POMPY-- 
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_PUMPSHOTGUN_MK2",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_MUSKET",
    "WEAPON_HEAVYSHOTGUN",
    "WEAPON_DBSHOTGUN",
    "WEAPON_AUTOSHOTGUN",

    --DLUGIE--
    "WEAPON_ASSAULTRIFLE",
	"weapon_bullpuprifle",
	"WEAPON_PIPEBOMB",
	"WEAPON_PROXMINE",
    "WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_HEAVYRIFLE",
	"WEAPON_FERTILIZERCAN",
	"WEAPON_EMPLAUNCHER",
    "WEAPON_CARBINERIFLE",
    "WEAPON_ADVANCEDRIFLE",
	"WEAPON_REVOLVER_MK2",
    "WEAPON_CARBINERIFLE_MK2",
    "WEAPON_MILITARYRIFLE",
    "WEAPON_SPECIALRIFLE",
    "WEAPON_SPECIALRIFLE_MK2",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_BULLPUPRIFLE_MK2",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_MG",
    "WEAPON_COMBATMG",
    "WEAPON_COMBATMG_MK2",
    "WEAPON_GUSENBERG",
	"WEAPON_RPG",

    --SNIPERKI--
    "WEAPON_SNIPERRIFLE",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
    "WEAPON_MARKSMANRIFLE",
    "WEAPON_MARKSMANRIFLE_MK2",

    --DODATKOWE--
    "WEAPON_GRANADE",
    "WEAPON_BZGAS",
    "WEAPON_MOLOTOV",
    "WEAPON_STICKYBOMB",
    "WEAPON_PROXMINE",
    "WEAPON_SNOWBALL",
    "WEAPON_BALL",

    "WEAPON_FLARE",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_STICKYBOMB",

}

local simples = {
	`WEAPON_STUNGUN`,
	`WEAPON_FLAREGUN`,

	`WEAPON_SNSPISTOL`,
	`WEAPON_SNSPISTOL_MK2`,
	`WEAPON_VINTAGEPISTOL`,
	`WEAPON_PISTOL`,
	`WEAPON_PISTOL_MK2`,
	`WEAPON_GADGETPISTOL`,
	`WEAPON_DOUBLEACTION`,
	`WEAPON_COMBATPISTOL`,
	`WEAPON_HEAVYPISTOL`,
	`WEAPON_CERAMICPISTOL`,
	`WEAPON_SNOWBALL`,
	`WEAPON_BALL`,
	`WEAPON_FLARE`,
	`WEAPON_FLASHLIGHT`,
	`WEAPON_KNUCKLE`,
	`WEAPON_SWITCHBLADE`,
	`WEAPON_NIGHTSTICK`,
	`WEAPON_KNIFE`,
	`WEAPON_DAGGER`,
	`WEAPON_MACHETE`,
	`WEAPON_HAMMER`,
	`WEAPON_WRENCH`,
	`WEAPON_CROWBAR`,
	`WEAPON_FERTILIZERCAN`,
	'WEAPON_REVOLVER',
	'WEAPON_REVOLVER_MK2',
	`WEAPON_STUNGUN_MP`,

	`WEAPON_STICKYBOMB`,
	`WEAPON_MOLOTOV`,
	`WEAPON_COMPACTLAUNCHER`,
	`WEAPON_DBSHOTGUN`,
	`WEAPON_SAWNOFFSHOTGUN`,
	`WEAPON_MICROSMG`,
	`WEAPON_SMG_MK2`,

	`WEAPON_NAVYREVOLVER`,
}

local types = {
	[2] = true,
	[3] = true,
	[5] = true,
	[6] = true,
	[10] = true,
	[12] = true
}

local holstered = 0
CreateThread(function()
	RequestAnimDict("rcmjosh4")
	while not HasAnimDictLoaded("rcmjosh4") do
		Citizen.Wait(0)
	end

	RequestAnimDict("reaction@intimidation@1h")
	while not HasAnimDictLoaded("reaction@intimidation@1h") do
		Citizen.Wait(0)
	end

	RequestAnimDict("weapons@pistol@")
	while not HasAnimDictLoaded("weapons@pistol@") do
		Citizen.Wait(0)
	end

	while true do
		Citizen.Wait(125)
		if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) and not IsPedInAnyVehicle(playerPed, false) then
			local weapon = GetSelectedPedWeapon(playerPed)
			if weapon ~= `WEAPON_UNARMED` then
				if holstered == 0 then
					local t = 0
					if `WEAPON_SWITCHBLADE` == weapon then
						t = 1
					elseif CheckSimple(weapon) then
						TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 5, 0, 0, 0)
						t = 1
					elseif types[GetWeaponDamageType(weapon)] then
						TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 3.0,1.0, -1, 48, 0, 0, 0, 0)
						SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED` , true)
						t = 2
					end

					holstered = weapon
					if t > 0 then
						if t == 1 then
							Citizen.Wait(600)
						elseif t == 2 then
							Citizen.Wait(1000)
							SetCurrentPedWeapon(playerPed, weapon, true)
							Citizen.Wait(1500)
						end

						ClearPedTasks(playerPed)
					end
				elseif holstered ~= weapon then
					local t, h = 0, false
					if `WEAPON_SWITCHBLADE` == holstered then
						Citizen.Wait(1500)
						ClearPedTasks(playerPed)

						if CheckSimple(weapon) then
							TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 5, 0, 0, 0)
							t = 600
						elseif types[GetWeaponDamageType(weapon)] then
							TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 3.0,1.0, -1, 48, 0, 0, 0, 0)
							SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED` , true)
							h = true
							t = 1000
						end
					elseif `WEAPON_SWITCHBLADE` == weapon then
						t = 600
					elseif CheckSimple(holstered) and CheckSimple(weapon) then
						TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 5, 0, 0, 0)
						t = 600
					elseif types[GetWeaponDamageType(holstered)] and types[GetWeaponDamageType(weapon)] then
						TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 3.0,1.0, -1, 48, 0, 0, 0, 0)
						SetCurrentPedWeapon(playerPed, holstered, true)
						h = true
						t = 1000
					end

					holstered = weapon
					if t > 0 then
						Citizen.Wait(t)
						if h then
							SetCurrentPedWeapon(playerPed, weapon, true)
							Citizen.Wait(1500)
						end

						ClearPedTasks(playerPed)
					end
				end
			elseif holstered ~= 0 then
				local t, h = 0, false
				if `WEAPON_DOUBLEACTION` == holstered or `WEAPON_SWITCHBLADE` == holstered then
					t = 1500
				elseif CheckSimple(holstered) then
					TaskPlayAnim(playerPed, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 5, 0, 0, 0)
					t = 600
				elseif types[GetWeaponDamageType(holstered)] then
					TaskPlayAnim(playerPed, "reaction@intimidation@1h", "outro", 8.0,2.0, -1, 48, 1, 0, 0, 0)
					SetCurrentPedWeapon(playerPed, holstered, true)
					h = true
					t = 1500
				end

				holstered = 0
				if t > 0 then
					Citizen.Wait(t)
					if h then
						SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED` , true)
					end

					ClearPedTasks(playerPed)
				end
			end
		end
	end
end)

function CheckSimple(weapon)
	for _, simple in ipairs(simples) do
		if simple == weapon then
			return true
		end
	end

	return false
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end


CreateThread(function()
	while hand do
		Citizen.Wait(0)
		DisableControlAction(0,24,true) -- disable attack
		DisableControlAction(0,25,true) -- disable aim
		DisableControlAction(0,47,true) -- disable weapon
		DisableControlAction(0,58,true) -- disable weapon
		DisableControlAction(0,263,true) -- disable melee
		DisableControlAction(0,264,true) -- disable melee
		DisableControlAction(0,257,true) -- disable melee
		DisableControlAction(0,140,true) -- disable melee
		DisableControlAction(0,141,true) -- disable melee
		DisableControlAction(0,142,true) -- disable melee
		DisableControlAction(0,143,true) -- disable melee
	end
end)

CreateThread(function()
    while true do
		Citizen.Wait(500)
		if IsPedOnFoot(playerPed) then 
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(playerPed, true) then
			SetRadarZoom(1100)
		end
    end
end)

local wait = false

RegisterCommand("propfix", function()
	if GetEntityHealth(playerPed) > 0 then
		if not IsPedCuffed(playerPed) then
		if not IsPedSittingInAnyVehicle(playerPed) then
			if not wait then
					TriggerEvent('skinchanger:getSkin', function(skin)
					wait = true
					Citizen.Wait(50)
					local armour = Citizen.InvokeNative(0x9483AF821605B1D8, playerPed)
					local health = Citizen.InvokeNative(0xEEF059FAD016D209, playerPed)
					if skin.sex == 0 then
							TriggerEvent('skinchanger:loadSkin', {sex=1})
							Citizen.Wait(1000)
							TriggerEvent('skinchanger:loadSkin', {sex=0})
					elseif skin.sex == 1 then
							TriggerEvent('skinchanger:loadSkin', {sex=0})
							Citizen.Wait(1000)
							TriggerEvent('skinchanger:loadSkin', {sex=1})
					end
					--TriggerServerEvent('exile_logs:triggerLog', "Użył komendy /propfix", 'propfix')
					Citizen.Wait(1000)
					ESX.ShowNotification('Załadowano ~g~HP / ARMOR ~w~sprzed użycia ~g~/propfix')
					Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, playerPed, health)
					Citizen.InvokeNative(0xCEA04D83135264CC, playerPed, armour)
					Citizen.Wait(300000)
					wait = false
					end)
				else
					ESX.ShowNotification('Nie możesz tak często używać tej komendy!')
				end
			else
				ESX.ShowNotification('Nie możesz używac propfixa w aucie')
			end
		else
			ESX.ShowNotification('Nie możesz używac tej komendy podczas BW.')
		end
	else
		ESX.ShowNotification('Nie możesz używac tej komendy podczas bycia zakutym.')
	end
end)

if not IsDuplicityVersion() then

	local _decorExists, _drawMarker = DecorExistOn, DrawMarker
	function DrawMarker(...)
		if playerPed and not _decorExists(playerPed, "misiaczek:marker") then
			_drawMarker(...)
		end
	end

	local _getVehicleNumberPlateText = GetVehicleNumberPlateText
	function GetVehicleNumberPlateText(vehicle, unveil)
		local plate = _getVehicleNumberPlateText(vehicle)
		if plate and unveil and plate:gsub("^%s*(.-)%s*$", "%1") == "" and _decorExists(vehicle, "misiaczek:plate") then
			return exports['esx_plates']:GetPlate(DecorGetInt(vehicle, "misiaczek:plate"))
		end

		return plate
	end
end

local modifieddmg = {
    {
        weapon = `WEAPON_PISTOL`,
        dmg = 0.55
    },
    {
        weapon = `WEAPON_COMBATPISTOL`,
        dmg = 0.55
    },
    {
        weapon = `WEAPON_SNSPISTOL`,
        dmg = 0.45
    },
    {
        weapon = `WEAPON_PISTOL_MK2`,
        dmg = 0.55
    },
    {
        weapon = `WEAPON_SNSPISTOL_MK2`,
        dmg = 0.435
    },
    {
        weapon = `WEAPON_HEAVYPISTOL`,
        dmg = 0.55
    },
    {
        weapon = `WEAPON_VINTAGEPISTOL`,
        dmg = 0.55
    },
    {
        weapon = `WEAPON_CERAMICPISTOL`,
        dmg = 0.65
    },
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsPedArmed(PlayerPedId(), 4) then
            local weapon = GetSelectedPedWeapon(PlayerPedId())
            for k,v in pairs(modifieddmg) do
                N_0x4757f00bc6323cfe(v.weapon, v.dmg)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

local helmets = {
    {
        helmet = 150,
        sex = 'male'
    },
}

local iswearinghelmet = false

Citizen.CreateThread(function()
    while true do
        for number, value in pairs(helmets) do
            if IsPedMale(PlayerPedId()) then
                if value.sex == 'male' then
                    if GetPedPropIndex(PlayerPedId(), 0) == value.helmet then
                        iswearinghelmet = true
                    end
                end
            else
                if value.sex == 'female' then
                    if GetPedPropIndex(PlayerPedId(), 0) == value.helmet then
                        iswearinghelmet = true
                    end
                end
            end
        end
        Citizen.Wait(30000)
    end
end)

local death = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            local a = PlayerPedId()
            if not IsEntityDead(a) then
                local b, c = GetPedLastDamageBone(a)
                if c == 31086 then
                    for d, e in pairs(modifieddmg) do
                        if HasEntityBeenDamagedByWeapon(a, e.weapon, 0) then
                            if not iswearinghelmet then
                                ESX.TriggerServerCallback("getKill",function(f)
                                        Citizen.Wait(110)
                                        if f and f <= 80.0 then
                                            if death == false then
                                                SetEntityHealth(a, 0)
                                                death = true
                                            end
                                            Citizen.Wait(500)
                                            death = false
                                        else
                                            local g = GetEntityHealth(a)
                                            givehealth = g - 25
                                            if givehealth <= 100 then
                                                givehealth = 0
                                            else
                                                ClearEntityLastDamageEntity(a)
                                            end
                                            if death == false then
                                                SetEntityHealth(a, givehealth)
                                            end
                                            Citizen.Wait(500)
                                            death = false
                                        end
                                    end
                                )
                            else
                                local g = GetEntityHealth(a)
                                local h = GetPedArmour(a)
                                if h > 0 then
                                    givearmor = h - 50
                                    if givearmor < 0 then
                                        givearmor = 0
                                    end
                                    SetPedArmour(a, givearmor)
                                    ClearEntityLastDamageEntity(a)
                                else
                                    givehealth = g - 25
                                    if givehealth <= 100 then
                                        givehealth = 0
                                    else
                                        ClearEntityLastDamageEntity(a)
                                    end
                                    SetEntityHealth(a, givehealth)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)


RegisterNetEvent('setKill')
AddEventHandler('setKill', function()
    SetTimecycleModifier("hud_def_desat_cold_kill")
    Citizen.Wait(300)
    ClearTimecycleModifier()
    Citizen.Wait(300)
end)