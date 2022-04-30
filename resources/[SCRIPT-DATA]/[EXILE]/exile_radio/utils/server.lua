CachedOwners = {}

-- Mysql functions (are just links to functions, nothing else, you can change them to yours)
--------------
-- sync / async

function MySQLSyncfetchAll(query, table, cb)
    return MySQL.Sync.fetchAll(query, table, cb)
end

function MySQLAsyncfetchAll(query, table, cb)
    return MySQL.Async.fetchAll(query, table, cb)
end

---
-- sync / async

function MySQLSyncexecute(query, table, cb)
    return MySQL.Sync.execute(query, table, cb)
end

function MySQLAsyncexecute(query, table, cb)
    return MySQL.Async.execute(query, table, cb)
end
--

-- check vehicle SPZ, does it have radio ? yes -> lets open UI
-- or is vehicle stolen ? or bought -> open UI
RegisterNetEvent("rcore_radiocar:openUI")
AddEventHandler("rcore_radiocar:openUI", function(spz)
    local player = source
    local xPlayer = ESX.GetPlayerFromId(player)

    if Config.OnlyCarWhoHaveRadio then
        if exports.rcore_radiocar:HasCarRadio(spz) then
            TriggerClientEvent("rcore_radiocar:openUI", player)
        end
        return
    end
end)