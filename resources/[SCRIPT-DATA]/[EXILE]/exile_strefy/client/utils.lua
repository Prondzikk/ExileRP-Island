ESX = nil

CreateThread(function()
    while not ESX do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(3)
    end

    ESX.TriggerServerCallback('kossek-zones:getData', function(data) 
        Config.Zones = data
    end)

    while not ESX.GetPlayerData().job do
        Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

IsDead = false

PlayerPed = nil
PlayerPos = vector3(0.0, 0.0, 0.0)

CreateThread(function()
	while true do
		PlayerPed = PlayerPedId()
		PlayerPos = GetEntityCoords(PlayerPed)
		Wait(500)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

	ESX.TriggerServerCallback('kossek-zones:getData', function(data)
		Config.Zones = data
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
    PlayerData.hiddenjob = hiddenjob
end)

LoadModel = function(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(10)
    end
end

LoadAnim = function(anim)
    RequestAnimDict(anim)
    while not HasAnimDictLoaded(anim) do
        Wait(10)
    end
end

DrawText3D = function(x, y, z, text)
    local coords = vector3(x, y, z)
    local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
    local dist = #(GetGameplayCamCoord() - coords)
    
    local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * Config.Text3D.scale
    
    if onScreen then
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringKeyboardDisplay(text)
        SetTextColour(Config.Text3D.font.r, Config.Text3D.font.g, Config.Text3D.font.b, Config.Text3D.font.a)
        SetTextScale(0.0 * scale, 0.50 * scale)
        SetTextFont(0)
        SetTextCentre(1)
        SetTextDropshadow(1, 0, 0, 0, 155)
        EndTextCommandDisplayText(x, y)
        
        local height = GetTextScaleHeight(1 * scale, 0) - 0.005
        local length = string.len(text)
        local limiter = 120
        if length > 98 then
            length = 98
            limiter = 200
        end
        local width = length / limiter * scale
        DrawRect(x, (y + scale / 50), width, height, Config.Text3D.background.r, Config.Text3D.background.g, Config.Text3D.background.b, Config.Text3D.background.a)
    end
end

AddEventHandler('esx:onPlayerDeath', function()
    IsDead = true
end)

AddEventHandler('playerSpawned', function()
    IsDead = false
end)