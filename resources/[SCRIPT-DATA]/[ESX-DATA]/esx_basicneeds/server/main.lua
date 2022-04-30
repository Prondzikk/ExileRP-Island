ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 600000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)

ESX.RegisterUsableItem('donut', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('donut', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 450000)
	TriggerClientEvent('esx_basicneeds:donut', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_donut'))
end)

ESX.RegisterUsableItem('cupcake', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cupcake', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 450000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cupcake'))
end)

ESX.RegisterUsableItem('banan', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('banan', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Zjedzono Banana')
end)

ESX.RegisterUsableItem('apple', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('apple', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500000)
	TriggerClientEvent('esx_basicneeds:apple', source)
	TriggerClientEvent('esx_status:add', source, 'thirst', 500000)
	TriggerClientEvent('esx:showNotification', source, _U('used_apple'))
end)

ESX.RegisterUsableItem('chipsy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('chipsy', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:chipsy', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_chipsy'))
end)

ESX.RegisterUsableItem('hamburger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 650000)
	TriggerClientEvent('esx_basicneeds:hamburger', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_hamburger'))
end)

ESX.RegisterUsableItem('sandwich', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sandwich', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 620000)
	TriggerClientEvent('esx_basicneeds:sandwich', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_sandwich'))
end)

ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('icetea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 590000)
	TriggerClientEvent('esx_basicneeds:juice', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_icetea'))
end)

ESX.RegisterUsableItem('juice', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('juice', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 590000)
	TriggerClientEvent('esx_basicneeds:juice', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_juice'))
end)

ESX.RegisterUsableItem('cola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 590000)
	TriggerClientEvent('esx_basicneeds:juice', source)
	TriggerClientEvent('FeedM:showNotification', source, 'Wypiłeś butelkę ~y~Coca Coli')
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 600000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_water'))
end)

ESX.RegisterUsableItem('roza', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('roza', 1)

	TriggerClientEvent('itemki-roza', source)
	TriggerClientEvent('esx:showNotification', source, 'Uzyłeś/aś ~y~róży')
end)

ESX.RegisterUsableItem('kocyk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('kocyk', 1)

	TriggerClientEvent('itemki-kocyk', source)
	TriggerClientEvent('esx:showNotification', source, 'Uzyłeś/aś ~y~kocyk')
end)



ESX.RegisterUsableItem('milk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('milk', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 585000)
	TriggerClientEvent('esx_basicneeds:milk', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_milk'))
end)

ESX.RegisterUsableItem('coffee', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coffee', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 600000)
	TriggerClientEvent('esx_basicneeds:coffee', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_coffee'))
end)

ESX.RegisterUsableItem('redbull', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('redbull', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onEnergy', source)
	TriggerClientEvent('esx:showNotification', source, 'Wypiłeś/aś ~b~Redbulla')
end)

ESX.RegisterUsableItem('kawa', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('kawa', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrinkKawa', source)
	TriggerClientEvent('esx_basicneeds:onEnergy2', source)
	TriggerClientEvent('esx:showNotification', source, 'Wypiłeś/aś ~b~X-Gamer')
end)

ESX.RegisterUsableItem('gbs', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('gbs', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkKawa', source)
	TriggerClientEvent('esx:showNotification', source, 'Wypiłeś/aś ~b~kawę')
end)


RegisterCommand('heal', function(source, args, user)
	if source == 0 then
		TriggerClientEvent('esx_basicneeds:healPlayer', tonumber(args[1]))
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.group == 'superadmin' or xPlayer.group == 'admin' then
			if args[1] then
				local target = tonumber(args[1])

				if target ~= nil then

					if GetPlayerName(target) then
						TriggerClientEvent('esx_basicneeds:healPlayer', target)
						local xPlayer2 = ESX.GetPlayerFromId(target)
						xPlayer2.showNotification('~g~Zostałeś/aś uleczony/a!')
					else
						xPlayer.showNotification('~r~Nie odnaleziono gracza')
					end
				else
					xPlayer.showNotification('~r~Nieprawidłowe ID')
				end
			else
				TriggerClientEvent('esx_basicneeds:healPlayer', source)
				xPlayer.showNotification('~g~Zostałeś/aś uleczony/a!')
			end
		else
			xPlayer.showNotification('~r~Nie posiadasz permisji')
		end
	end
end, false)