ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('silencieux', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('exile_accessories:equipSilencer', source)
end)

ESX.RegisterUsableItem('flashlight', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('exile_accessories:equipFlashlight', source)
end)

ESX.RegisterUsableItem('grip', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('exile_accessories:equipGrip', source)
end)

ESX.RegisterUsableItem('bron_magazynek', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('exile_accessories:equipExtendedMag', source)
end)

ESX.RegisterUsableItem('bron_magazynek_powiekszony', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('exile_accessories:equipVeryExtendedMag', source)
end)

ESX.RegisterUsableItem('scope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('exile_accessories:equipScope', source)
end)

ESX.RegisterUsableItem('scope2', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('exile_accessories:equipAdvancedScope', source)
end)

ESX.RegisterUsableItem('kamizelka', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('kamizelka', 1)
    TriggerClientEvent('exile_kamza', source, 'small')
end)

ESX.RegisterUsableItem('kamizelka2', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('kamizelka2', 1)
    TriggerClientEvent('exile_kamza', source, 'big')
end)

ESX.RegisterUsableItem('skarpetka', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('skarpetka', 1)
    TriggerClientEvent('exile_kamza', source, 'skarpetka')
end)