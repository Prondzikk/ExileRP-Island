ESX=nil;TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_repair:checkmoneyforrepair', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if Config.EnablePrice then
        if xPlayer.getMoney() >= Config.Price then
            xPlayer.removeMoney(Config.Price)
            cb(true)
        else
            cb(false)
        end
    else
        cb(true)
    end
end)