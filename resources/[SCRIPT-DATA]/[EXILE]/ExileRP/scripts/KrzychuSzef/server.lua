RegisterCommand("clearmap", function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)
    if source == 0 then
        TriggerClientEvent("Exile:ClearAllPeds1", -1)
    else
        if xPlayer.group == 'superadmin' or xPlayer.group == 'admin' or xPlayer.group == 'moderator' then
            TriggerClientEvent("Exile:ClearAllPeds1", -1)
            exports.exile_logs:discord(source, "Użył/a komendy /clearmap", "clearmap", true)
        end
    end
end)

RegisterCommand("clearobjects", function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)
    if source == 0 then
        TriggerClientEvent("Exile:ClearAllEntities", -1)
    else
        if xPlayer.group == 'superadmin' then
            TriggerClientEvent("Exile:ClearAllEntities", -1)
            exports.exile_logs:discord(source, "Użył/a komendy /clearobjects", "clearobjects", true)
        end
    end
end)

RegisterCommand("clearpeds", function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)
    if source == 0 then
        TriggerClientEvent("Exile:ClearAllPeds", -1)
    else
        if xPlayer.group == 'superadmin' then
            TriggerClientEvent("Exile:ClearAllPeds", -1)
            exports.exile_logs:discord(source, "Użył/a komendy /clearpeds", "clearpeds", true)
        end
    end
end)

RegisterCommand("clearvehs", function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)
    if source == 0 then
        TriggerClientEvent("Exile:ClearAllVehs", -1)
    else
        if xPlayer.group == 'superadmin' then
            TriggerClientEvent("Exile:ClearAllVehs", -1)
            exports.exile_logs:discord(source, "Użył/a komendy /clearvehs", "clearvehs", true)
        end
    end
end)