ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('getKill', function(source, cb)
    local ped = GetPlayerPed(source)
    local pCoords = GetEntityCoords(ped)
    local dCoords = GetEntityCoords(GetPedSourceOfDamage(ped))
    local distance = #(pCoords - dCoords)
    cb(distance)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    data.victim = source
    
    if data.killedByPlayer then
        TriggerClientEvent("setKill", data.killerServerId)
    end
end)