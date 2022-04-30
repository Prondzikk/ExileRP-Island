ESX = nil
local shopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('clip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clip', 1)
	xPlayer.addInventoryItem('pistol_ammo', 12)
	TriggerClientEvent('esx:showNotification', 'Użyto ~y~magazynka')
end)

RegisterServerEvent('weaponshop:buyItem')
AddEventHandler('weaponshop:buyItem', function(itemName, amount, price, max, moneytype, token, tyasdasd)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local type

	amount = ESX.Round(amount)
	if token == "SDFHIUDFBNVJDFbnvnb4cvjr3425%$&%^@#$^TBCVH$%^&gdkfljnhlh" then 
		if tyasdasd	== "ashgdfhdfhgjdofihonjksgfhujsdBGJDBYGDFGOUIYIY348967RTB8T034WEQGFAISUGFBYNH8IHg" then
			if amount < 0 then
				return
			end
			if moneytype == 'black_money' then
				type = 'Brudnej gotówki'
				paytype = 'Brudna Gotówka'
			end

			price = price * amount
			local getmoney = xPlayer.getAccount(moneytype).money
			local missingMoney = (getmoney - price) * -1

			if xPlayer.getAccount(moneytype).money >= price then
				local limit = max
				local weq = xPlayer.getInventoryItem(itemName).count
				if weq == nil then 
					weq = 0
				end
				local one = weq + amount
				local two = {}
				local three = 0

				for k,v in pairs(Config.Zones['ashgdfhdfhgjdofihonjksgfhujsdBGJDBYGDFGOUIYIY348967RTB8T034WEQGFAISUGFBYNH8IHg'].Items) do
					if v.item == itemName then
						three = 1
					end
				end

				if three ~= 1 then
					DropPlayer(_source, 'rucham ci matke cwelu kumasz??')
				end

				if limit < amount or 1 > limit then
					TriggerClientEvent('esx:showNotification', source, '~r~Nie masz~s~ tyle ~y~wolnego miejsca ~s~ w ekwipunku!')
				else
					xPlayer.removeAccountMoney(moneytype, price)
					if limit ~= nil then
						xPlayer.addInventoryItem(itemName, amount)
					else
						xPlayer.addInventoryItem(itemName, amount)
					end
				end
			else
				TriggerClientEvent('esx:showNotification', source, '~r~Nie masz tyle '..type..', brakuje ci ~g~$'..missingMoney..'~r~!')
			end
		else
			if amount < 0 then
				return
			end
			if moneytype == 'money' then
				type = 'gotówki'
				paytype = 'Gotówka'
			elseif moneytype == 'bank' then
				type = 'pieniędzy na karcie'
				paytype = 'Bank'
			end

			price = price * amount
			local getmoney = xPlayer.getAccount(moneytype).money
			local missingMoney = (getmoney - price) * -1

			if xPlayer.getAccount(moneytype).money >= price then
				local limit = max
				local weq = xPlayer.getInventoryItem(itemName).count
				if weq == nil then 
					weq = 0
				end
				local one = weq + amount
				local two = {}
				local three = 0

				for k,v in pairs(Config.Zones['GunShop'].Items) do
					if v.item == itemName then
						three = 1
					end
				end

				if three ~= 1 then
					DropPlayer(_source, 'rucham ci matke cwelu kumasz??')
				end

				if limit < amount or 1 > limit then
					TriggerClientEvent('esx:showNotification', source, '~r~Nie masz~s~ tyle ~y~wolnego miejsca ~s~ w ekwipunku!')
				else
					xPlayer.removeAccountMoney(moneytype, price)
					if limit ~= nil then
						xPlayer.addInventoryItem(itemName, amount)
					else
						xPlayer.addInventoryItem(itemName, amount)
					end
				end
			else
				TriggerClientEvent('esx:showNotification', source, '~r~Nie masz tyle '..type..', brakuje ci ~g~$'..missingMoney..'~r~!')
			end
		end
	else
	end
end)