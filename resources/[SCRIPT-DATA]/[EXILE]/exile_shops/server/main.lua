ESX             = nil
local ShopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local donttouchme = 'donttouxchme:'..math.random(11111111,999999999)..':skidsgang'
local xddddddd = 'imaginebxycdogiem:'..math.random(11111111,999999999)..':skidsgang'

local reviced = {}
local bipolarsnobitches = TriggerClientEvent

RegisterServerEvent('exile_shops:request')
AddEventHandler('exile_shops:request', function()
    local _source = source
    if not reviced[_source] then
        bipolarsnobitches("exile_shops:getrequest", _source, donttouchme, xddddddd)
        reviced[_source] = true
    else
        
        exports.exile_logs:discord(source, "exile_shops:request", "request", true)
    end
end)



function GenerateUniquePhoneNumber()
    local running = true
    local phone = nil
    while running do
        local rand = '' .. math.random(11111,99999)
        local count = MySQL.Sync.fetchScalar("SELECT COUNT(number) FROM user_sim WHERE number = @phone_number", { ['@phone_number'] = rand })
        if count < 1 then
            phone = rand
            running = false
        end
    end
    return phone
end




RegisterServerEvent(xddddddd)
AddEventHandler(xddddddd, function(itemName, amount, price, max, moneytype, zone, token)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if token == donttouchme then

		local czegoniemam

		amount = ESX.Round(amount)

		if tonumber(amount) < 0 or tonumber(price) == nil or tonumber(price) < 0 or itemName == nil or moneytype == nil then
			if itemName == nil then
				itemName = "Brak"
			end
			if amount == nil then
				amount = "Brak"
			end
			if price == nil then
				price = "Brak"
			end
			if max == nil then
				max = "Brak"
			end
			if moneytype == nil then
				moneytype = "Brak"
			end
			if zone == nil then
				zone = "Brak"
			end

			exports.exile_logs:discord(_source, "Błąd lokalna amount, price: esx_shops:buyItem ("..itemName..", "..amount..", "..price..", "..max..", "..moneytype..", "..zone..")", 'protect', true)
			return
		end

		if moneytype == 'money' then
			czegoniemam = 'gotówki'
			typplatnosci = 'Gotówka'
		elseif moneytype == 'bank' then
			czegoniemam = 'pieniędzy na karcie'
			typplatnosci = 'Bank'
		end

		price = price * amount
		local jebacciemoney = xPlayer.getAccount(moneytype).money
		local missingMoney = (jebacciemoney - price) * -1

		if xPlayer.getAccount(moneytype).money >= price then
			local sprawdzlimit = max
			local weq = xPlayer.getInventoryItem(itemName).count
			if weq == nil then 
				weq = 0
			end
			local drezsmiec = weq + amount
			local drezajebiemy = {}
			local dshgfdsg = 0

			for k,v in pairs(Config.Zones[zone].Items) do
				if v.item == itemName then
					dshgfdsg = 1
				end
			end

			if dshgfdsg ~= 1 then
				exports.exile_logs:discord(_source, "Próba kupna itemu nieznajdującego się na allowliście: esx_shops:buyItem", 'protect', true)
				return 
			end

			if sprawdzlimit < amount or drezsmiec > sprawdzlimit then
				TriggerClientEvent('esx:showNotification', source, '~r~Nie masz~s~ tyle ~y~wolnego miejsca ~s~ w ekwipunku!')
			else
				phoneNumber = GenerateUniquePhoneNumber()
				if itemName == 'sim' then
					MySQL.Async.fetchAll('SELECT * FROM user_sim WHERE identifier = @identifier',
					{
						['@identifier'] = xPlayer.identifier,
					}, function(result)
						if #result >= 5 then
							TriggerClientEvent('gcphone:komunikat', _source, "~r~Możesz posiadać maksymalnie 5 kart SIM")
						else
							MySQL.Async.execute('INSERT INTO user_sim (identifier,user,number,label) VALUES(@identifier,@user,@number,@label)',
							{
								['@identifier']   = xPlayer.identifier,
								['@user']   = xPlayer.identifier,
								['@number'] = phoneNumber,
								['@label'] = "SIM #"..phoneNumber,
							})
							TriggerClientEvent('gcphone:komunikat', _source, "Kupiłeś nowy starter #" .. phoneNumber)
							TriggerClientEvent('esx_inventoryhud:getOwnedSim', _source)
							xPlayer.removeAccountMoney(moneytype, price)
						end
					end)
				end
				xPlayer.removeAccountMoney(moneytype, price)
				if itemName ~= 'sim' then
					if sprawdzlimit ~= nil then
						xPlayer.addInventoryItem(itemName, amount)
					else
						xPlayer.addInventoryItem(itemName, amount)
					end
				end
				exports.exile_logs:discord(_source, "Zakupił/a przedmiot: "..amount.."x "..itemName.." za $"..price.." korzystając z "..czegoniemam.." w "..zone, 'shops', false)
			end
		else
			if itemName ~= 'sim' then
				TriggerClientEvent('esx:showNotification', _source, '~r~Nie masz tyle '..czegoniemam..', brakuje ci ~g~$'..missingMoney..'~r~!')
			else
				TriggerClientEvent('esx:showNotification', _source, '~r~Zbyt mała ilość gotówki, aby wyrobić nową kartę')
			end
		end
	else

	end
end)


RegisterServerEvent('esx_shops:sellitems')
AddEventHandler('esx_shops:sellitems', function(itemname, count, total)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	exports.exile_logs:discord(_source, "esx_shops:sellitems", "protect", true)

	-- if count ~= 0 then 
	-- 	xPlayer.removeInventoryItem(itemname, count)
	-- 	xPlayer.addMoney(total)
		-- exports.exile_logs:discord(source, "Sprzedał przedmiot w lombardzie ["..itemname..","..count..","..total.."]", "lombard", true)
	-- else 
	-- 	TriggerClientEvent('esx:showNotification', _source, "~r~Nie posiadasz tego przedmiotu")
	-- end
end)

ESX.RegisterServerCallback('gcPhone:getHasSimsCopy', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT number FROM user_sim WHERE `identifier` = @identifier AND user = @user', {
        ['@identifier'] = xPlayer.identifier,
		['@user'] = xPlayer.identifier
    }, function(result)
		if result[1] ~= nil then
			cb(result, xPlayer.character.phone_number)
		else
			cb(nil)
		end
    end)
end)


ESX.RegisterServerCallback('gcPhone:getHasSims', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll(
      'SELECT * FROM user_sim WHERE `identifier` = @identifier OR admin1 = @identifier OR admin2 = @identifier',
      {
		  ['@identifier'] = xPlayer.identifier,
      },
      function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('gcPhone:checkMoney', function(source, cb, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= amount then
        cb(1)
    else
        cb(0)
    end
end)