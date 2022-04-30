ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  
owners = {}
secondOwners = {}

RegisterServerEvent("ls:retrieveVehiclesOnconnect")
AddEventHandler("ls:retrieveVehiclesOnconnect", function()
    local src = source
    local srcIdentifier = GetPlayerIdentifiers(src)[2]

    for plate, plyIdentifier in pairs(owners) do
        if(plyIdentifier == srcIdentifier)then
            TriggerClientEvent("ls:newVehicle", src, nil, plate, nil)
        end
    end

    for plate, identifiers in pairs(secondOwners) do
        for _, plyIdentifier in ipairs(identifiers) do
            if(plyIdentifier == srcIdentifier)then
                TriggerClientEvent("ls:newVehicle", src, nil, plate, nil)
            end
        end
    end
end)

RegisterServerEvent("ls:addOwner")
AddEventHandler("ls:addOwner", function(plate)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if plate ~= nil then
        owners[plate] = identifier
    else
        print("")
        print("")
        print("")
        print("")
        print("")
        print("")
        print("BŁĄD ESX_KLUCZYKI : ls:addOwner "..tostring(plate))
        print("")
        print("")
        print("")
        print("")
        print("")
        print("")
    end
end)

RegisterServerEvent("menu:giveKeysAction")
AddEventHandler("menu:giveKeysAction", function(target, plate)
    local identifier = GetPlayerIdentifiers(source)[1]
    local targetIdentifier = GetPlayerIdentifiers(target)[1]

    if owners[plate] == identifier then
        if secondOwners[plate] then
            --
        else
            TriggerClientEvent('esx:showAdvancedNotification', source, plate, "", "~o~Dałeś zapasowe kluczyki do pojazdu obywatelowi: " .. target)
            TriggerClientEvent('esx:showAdvancedNotification', target, plate, "", "~o~Otrzymałeś zapasowe kluczyki do pojazdu od obywatela: " .. source)
            secondOwners[plate] = targetIdentifier
        end
    else
        --
    end
end)

RegisterNetEvent("ls:checkOwner")
AddEventHandler("ls:checkOwner", function(localVehId, plate, lockStatus)
    local plate = string.lower(plate)
    local src = source
    local hasOwner = false

    if(not owners[plate])then
        TriggerClientEvent("ls:getHasOwner", src, nil, localVehId, plate, lockStatus)
    else
        if(owners[plate] == "locked")then
        else
            TriggerClientEvent("ls:getHasOwner", src, true, localVehId, plate, lockStatus)
        end
    end
end)

RegisterServerEvent("ls:lockTheVehicle")
AddEventHandler("ls:lockTheVehicle", function(plate)
    owners[plate] = "locked"
end)

RegisterServerEvent('ls:haveKeys') 
AddEventHandler('ls:haveKeys', function(target, vehPlate, cb)
    targetIdentifier = GetPlayerIdentifiers(target)[1]
    hasKey = false

    for plate, identifier in pairs(owners) do
        if(plate == vehPlate and identifier == targetIdentifier)then
            hasKey = true
            break
        end
    end
    for plate, identifiers in pairs(secondOwners) do
        if(plate == vehPlate)then
            for _, plyIdentifier in ipairs(identifiers) do
                if(plyIdentifier == targetIdentifier)then
                    hasKey = true
                    break
                end
            end
        end
    end

    if(hasKey)then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("ls:updateServerVehiclePlate")
AddEventHandler("ls:updateServerVehiclePlate", function(oldPlate, newPlate)
    local oldPlate = string.lower(oldPlate)
    local newPlate = string.lower(newPlate)

    if(owners[oldPlate] and not owners[newPlate])then
        owners[newPlate] = owners[oldPlate]
        owners[oldPlate] = nil
    end
    if(secondOwners[oldPlate] and not secondOwners[newPlate])then
        secondOwners[newPlate] = secondOwners[oldPlate]
        secondOwners[oldPlate] = nil
    end
end)

TriggerEvent("ls:hasKey", target, vehPlate, function(cb)
    --print(cb)
end)

ESX.RegisterServerCallback('ls:check', function(source, cb, plate)

    local maklucze = false
    local targetIdentifier = GetPlayerIdentifiers(source)[1]
    local hasKey = false
    local lockStatus = false
    local kurwa = false 
    
    if not owners[plate] then
       lockStatus = false
    else
        if(owners[plate] == "locked")then
            lockStatus = true
        else
            lockStatus = false
        end
    end

    if owners[plate] == targetIdentifier or secondOwners[plate] == targetIdentifier then 
        maklucze = true
    elseif owners[plate] == nil or owners[plate] ~= targetIdentifier or secondOwners[plate] ~= targetIdentifier then
        maklucze = false
    end

    if owners[plate] == targetIdentifier or secondOwners[plate] == targetIdentifier then 

        kurwa = true
    elseif owners[plate] == nil or owners[plate] ~= targetIdentifier or secondOwners[plate] ~= targetIdentifier then
        kurwa = false
    end

    cb(maklucze, kurwa, lockStatus)
end)

ESX.RegisterServerCallback('ls:hasKey', function(source, cb, plate)
    local maklucze = false
    local targetIdentifier = GetPlayerIdentifiers(source)[1]

    if owners[plate] == targetIdentifier or secondOwners[plate] == targetIdentifier then 
        maklucze = true
    elseif owners[plate] == nil or owners[plate] ~= targetIdentifier then
        maklucze = false
    end

    cb(maklucze)
end)


