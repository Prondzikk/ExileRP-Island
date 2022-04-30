_ = nil

TriggerEvent('esx:getSharedObject', function(__) _ = __ end)

local a = "jakas pizda ma eksegjutor %s [%s]"
local b = "EinsZwei:"..math.random(1,999).."kuauj"
local c = {}
RegisterServerEvent("exile_pralnia:request", function()
    local d = source
    if c[d] then
        print(a:format(GetPlayerName(d), d))
    else
        c[d] = true
        TriggerClientEvent("exile_pralnia:getrequest", d, b)
    end
end)

RegisterServerEvent(b, function(d)
    local e = source
    if d == GetCurrentResourceName() then
        local f = _.GetPlayerFromId(e)
        local g = tonumber(f.getAccount('black_money').money)
        if g and g > Config.MinBrud then
            f.removeAccountMoney('black_money', Config.Reward)
            f.addMoney(Config.Reward)
        else 
            TriggerClientEvent('esx:showNotification', e, "~r~Nie posiadasz wiecej brudnej gotówki\n~s~Wracaj na baze")
        end
    else
        print(a:format(GetPlayerName(e), e))
    end
end)

_.RegisterServerCallback('exile_pralnia:maBrud', function(source, cb)
    local xPlayer = _.GetPlayerFromId(source)
    if xPlayer.getAccount('black_money').money > Config.MinBrud then 
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("exile_pralnia:alert", function(coords)
    TriggerClientEvent("exile_pralnia:alert", -1, coords)
end)