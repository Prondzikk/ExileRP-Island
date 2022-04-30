ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local selled = {}
local CountSelledDrugs = {}

local narkos = {
	'weed_pooch',
	'meth_pooch',
	'coke_pooch',
	'exctasy_pooch',
	'opium_pooch',
}

ESX.RegisterServerCallback('xfsd-sell:checkDoesHaveAnyDrugs', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local count = 0

	for k,v in pairs(narkos) do
		if xPlayer.getInventoryItem(v).count then
			count = count + 1
		end
	end

	if count > 0 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_sellnpc:canSell')
AddEventHandler('esx_sellnpc:canSell', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	
	--New narko
	local weedqty = xPlayer.getInventoryItem('weed_pooch').count
	
	local metaqty = xPlayer.getInventoryItem('meth_pooch').count
	
	local kokainaqty = xPlayer.getInventoryItem('coke_pooch').count
	
	local exctasyqty = xPlayer.getInventoryItem('exctasy_pooch').count
	
	local opiumqty = xPlayer.getInventoryItem('opium_pooch').count
	
	local drugType = nil
	
	if metaqty >= 1 then
		drugType = 'meth_pooch'
	end
	
	if kokainaqty >= 1 then
		drugType = 'coke_pooch' 
	end
	
	if exctasyqty >= 1 then
		drugType = 'exctasy'
	end
	
	if opiumqty >= 1 then
		drugType = 'opium_pooch'
	end
	
	if weedqty >= 1 then
		drugType = 'weed'
	end		
	
	if drugType ~= nil then
		TriggerClientEvent('esx_sellnpc:canSell', _source, true)
	else
		TriggerClientEvent('esx_sellnpc:canSell', _source, false)
	end	
end)

RegisterServerEvent('esx_sellnpc:sell')
AddEventHandler('esx_sellnpc:sell', function(coords, str, ped)
	local _source = source
	if not selled[_source] then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local isInterested = math.random(10, 60)		
		local notifyCops = math.random(1, 100)
		local photo = math.random(1, Config.photo)
		local cops = exports['esx_scoreboard']:CounterPlayers('police')
		
		selled[_source] = true
		
		if cops >= Config.LSPD then
			if isInterested >= 25 then
				TriggerClientEvent('esx_sellnpc:sell', _source, isInterested >= 25, notifyCops >= 30, cops, photo == 1)
			else
				TriggerClientEvent('esx_sellnpc:sell', _source, false, true, cops, true)
				xPlayer.showNotification('~r~Obywatel odrzucił ofertę sprzedaży')
			end
		else
			TriggerClientEvent('esx_sellnpc:sell', _source, false)
			xPlayer.showNotification('~r~Zbyt mało jednostek żeby sprzedawać narkotyki')			
		end

	end	
end)

RegisterServerEvent('esx_sellnpc:acceptSell')
AddEventHandler('esx_sellnpc:acceptSell', function(cops)
	local _source = source
	if selled[_source] then
		local xPlayer = ESX.GetPlayerFromId(_source)
		--New narko
		local weedqty = xPlayer.getInventoryItem('weed_pooch').count
		
		local metaqty = xPlayer.getInventoryItem('meth_pooch').count
	
		local kokainaqty = xPlayer.getInventoryItem('coke_pooch').count
		
		local exctasyqty = xPlayer.getInventoryItem('exctasy_pooch').count
		
		local opiumqty = xPlayer.getInventoryItem('opium_pooch').count
		--
		local x = 0
		local blackMoney = 0
		local drugType = nil
		
		if metaqty > 0 then
			drugType = 'meth_pooch'
			if metaqty == 1 then
				x = 1
			elseif metaqty == 2 then
				x = math.random(1,2)
			elseif metaqty >= 3 then
				x = math.random(1,3)
			end
		end
		
		if kokainaqty > 0 then
			drugType = 'coke_pooch'
			if kokainaqty == 1 then
				x = 1
			elseif kokainaqty == 2 then
				x = math.random(1,2)
			elseif kokainaqty >= 3 then
				x = math.random(1,3)
			end
		end
		
		if exctasyqty > 0 then
			drugType = 'exctasy_pooch'
			if exctasyqty == 1 then
				x = 1
			elseif exctasyqty == 2 then
				x = math.random(1,2)
			elseif exctasyqty >= 3 then
				x = math.random(1,3)
			end
		end				
		
		if opiumqty > 0 then
			drugType = 'opium_pooch'
			if opiumqty == 1 then
				x = 1
			elseif opiumqty == 2 then
				x = math.random(1,2)
			elseif opiumqty >= 3 then
				x = math.random(1,3)
			end
		end		
		
		if weedqty > 0 then
			drugType = 'weed_pooch'
			if weedqty == 1 then
				x = 1
			elseif weedqty == 2 then
				x = math.floor(1,2)
			elseif weedqty >= 3 then
				x = math.random(1,3)
			end
		end		
		
		--New narko
		if drugType == 'meth_pooch' then
			blackMoney = math.random(3250, 4250) * x
		elseif drugType == 'coke_pooch' then
			blackMoney = math.random(4000, 5000) * x
		elseif drugType == 'exctasy_pooch' then
			blackMoney = math.random(2500, 3500) * x
		elseif drugType == 'weed_pooch' then
			blackMoney = math.random(1250, 2250) * x
		elseif drugType == 'opium_pooch' then
			blackMoney = math.random(2000, 3000) * x
		end
		
		if cops > 4 and cops < 6 then 
			blackMoney = blackMoney * 1.10
		elseif cops > 6 and cops < 8 then
			blackMoney = blackMoney * 1.15
		elseif cops > 8 and cops < 10 then
			blackMoney = blackMoney * 1.20
		elseif cops > 10 then
			blackMoney = blackMoney * 1.25
		end
		
		if drugType ~= nil then
			xPlayer.removeInventoryItem(drugType, x)
		end
		
		selled[_source] = nil
		
		blackMoney = tonumber(blackMoney) / 100 * 130
		xPlayer.addAccountMoney('black_money', blackMoney)

		exports.exile_logs:discord(source, 'Sprzedał/a' .. ' '..x..'x ' .. _U(drugType) .. blackMoney .. '$', "esxselldrugs", true)

		TriggerClientEvent('esx:showNotification', _source, 'Sprzedałeś/aś' .. ' ~y~'..x..'x ~y~' .. _U(drugType) .. blackMoney .. '$')
	end
end)

RegisterServerEvent('sellDrugsInProgress')
AddEventHandler('sellDrugsInProgress', function(coords, str, photo, gender)
	TriggerEvent('ReturnSkin', tonumber(source), function(skin)
		TriggerClientEvent("drugPlace", -1, coords, photo, source, gender, str, skin)
	end)
end)

RegisterServerEvent('esx_sellnpc:denySell')
AddEventHandler('esx_sellnpc:denySell', function(type)
	local _source = source	
	if type == true then
		selled[_source] = nil
		TriggerClientEvent('esx:showNotification', _source, '~r~Obywatel odrzucił ofertę sprzedaży')
		TriggerClientEvent('esx_sellnpc:canSell', _source, false, 0)
	elseif type == false then
		selled[_source] = nil
		TriggerClientEvent('esx_sellnpc:canSell', _source, false, 0)
	else
		selled[_source] = nil
		TriggerClientEvent('esx:showNotification', _source, '~r~Anulowałeś sprzedawanie narkotyków')
		TriggerClientEvent('esx_sellnpc:canSell', _source, false, 0)
	end
end)
