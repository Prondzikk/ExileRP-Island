ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('xk3ly-bodycam:getPlayerName', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local result = {
        name = xPlayer.character.firstname..' '..xPlayer.character.lastname
    }
	cb(result)
end)