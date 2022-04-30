ESX = nil
local siano = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('scratchcard', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)
	local percent = math.random(1,100)

	if percent <= 30 then
        local whichPayment = math.random(1,100)
        -- 1 -> 25% ; 2 -> 30% ; 3 -> 30% ; 4 -> 10% ; 5 -> 5%
        if whichPayment <= 25 then
            siano[source] = 1500
        elseif whichPayment > 25 and whichPayment <= 55 then
            siano[source] = 3000
        elseif whichPayment > 55 and whichPayment <= 85 then
            siano[source] = 6000
        elseif whichPayment > 85 and whichPayment <= 95 then
            siano[source] = 10000
        elseif whichPayment > 95 then
            siano[source] = 20000
        end
    else
        siano[source] = 0
    end

    xPlayer.removeInventoryItem('scratchcard', 1)
    TriggerClientEvent('flux_scratchcard:showSC', source, 'silver', siano[source])

end)

ESX.RegisterUsableItem('scratchcardgold', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    local percent = math.random(1,100)

	if percent <= 30 then

        local whichPayment = math.random(1,100)
        -- 1 -> 25% ; 2 -> 30% ; 3 -> 30% ; 4 -> 10% ; 5 -> 5%
        if whichPayment <= 25 then
            siano[source] = 10000
        elseif whichPayment > 25 and whichPayment <= 55 then
            siano[source] = 15000
        elseif whichPayment > 55 and whichPayment <= 85 then
            siano[source] = 30000
        elseif whichPayment > 85 and whichPayment <= 95 then
            siano[source] = 50000
        elseif whichPayment > 95 then
            siano[source] = 100000
        end
    else
        siano[source] = 0
    end

    xPlayer.removeInventoryItem('scratchcardgold', 1)
    TriggerClientEvent('flux_scratchcard:showSC', source, 'gold', siano[source])

end)

ESX.RegisterUsableItem('scratchcarddiamond', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)


    local percent = math.random(1,100)

	if percent <= 30 then
        local whichPayment = math.random(1,100)
        -- 1 -> 25% ; 2 -> 30% ; 3 -> 30% ; 4 -> 10% ; 5 -> 5%
        if whichPayment <= 25 then
            siano[source] = 35000
        elseif whichPayment > 25 and whichPayment <= 55 then
            siano[source] = 50000
        elseif whichPayment > 55 and whichPayment <= 85 then
            siano[source] = 75000
        elseif whichPayment > 85 and whichPayment <= 95 then
            siano[source] = 125000
        elseif whichPayment > 95 then
            siano[source] = 250000
        end
    else
        siano[source] = 0
    end
    xPlayer.removeInventoryItem('scratchcarddiamond', 1)
    TriggerClientEvent('flux_scratchcard:showSC', source, 'diamond', siano[source])

end)

RegisterServerEvent('flux_scratchcard:payment', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local reward = siano[source]
    if reward > 0 then
        xPlayer.addMoney(reward)
        xPlayer.showNotification("Wygrałeś/aś ~g~$" .. reward .."~w~!")
    else
        xPlayer.showNotification("~r~Spróbuj ponownie")
    end
    reward = nil
    siano[source] = nil
end)