ESX	= nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_headbag:closest')
AddEventHandler('esx_headbag:closest', function()
    local name = GetPlayerName(closest)
    TriggerClientEvent('esx_headbag:puton', closest)
end)

RegisterServerEvent('esx_headbag:sendclosest')
AddEventHandler('esx_headbag:sendclosest', function(closest)
    closest = closestPlayer
end)

RegisterServerEvent('esx_headbag:putoff')
AddEventHandler('esx_headbag:putoff', function()
    TriggerClientEvent('esx_headbag:putoffc', closest)
end)

ESX.RegisterUsableItem('worek', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_headbag:put', _source)
    TriggerEvent('esx_headbag:debugger', source)
end)