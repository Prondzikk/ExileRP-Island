
-- Config by grupa JustLeaks - https://bit.ly/3rdRNeX
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
	for k, v in pairs(Config["5mscriptscom"]) do
		ESX.RegisterUsableItem(k, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeInventoryItem(k, 1)
			TriggerClientEvent('mkbuss:open5mscriptscom', source,k)
		end)
	end
end)

-- Config by grupa JustLeaks - https://bit.ly/3rdRNeX

RegisterServerEvent('mkbuss:giveReward')
AddEventHandler('mkbuss:giveReward', function (t, data, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if t == "item" then
		xPlayer.addInventoryItem(data, amount)
	elseif t == "weapon" then
		xPlayer.addWeapon(data, 1)
	elseif t == "money" then
		xPlayer.addMoney(data)
	elseif t == "black_money" then
		xPlayer.addAccountMoney('black_money', data)
	end
	
end)

-- Config by grupa JustLeaks - https://bit.ly/3rdRNeX

RegisterServerEvent("mkbuss:boradcast")
AddEventHandler("mkbuss:boradcast", function(tier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if Config["broadcast"] then
        tier = tonumber(tier)
        if Config["broadcast_tier"][tier] == true then
            TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2Gachapon: ' .. GetPlayerName(source) .. ' Got '..Config["chance"][tier].name) 
        end
    end
end)
