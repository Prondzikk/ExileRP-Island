ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local used_stock = {}


-- set used
RegisterServerEvent('exile:setUsed')
AddEventHandler('exile:setUsed', function(zonename, society, dane)
    if dane then 
        used_stock[zonename] = society
    else
        if used_stock[zonename] == society then
            used_stock[zonename] = nil
        end
    end
end)

ESX.RegisterServerCallback('exile_organizations:checkmoneyforskin', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= 1500 then
		xPlayer.removeMoney(1500)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('exile_organizacje:saveOutfit')
AddEventHandler('exile_organizacje:saveOutfit', function(label, skin, org)
	TriggerEvent('esx_datastore:getSharedDataStore', org, function(store)
		local dressing = store.get('dressing')
		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)
	end)
end)

ESX.RegisterServerCallback('exile_organizacje:getPlayerDressing', function(source, cb, num)
	TriggerEvent('esx_datastore:getSharedDataStore', num, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('exile_organizacje:getPlayerOutfit', function(source, cb, num, org)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		TriggerEvent('esx_datastore:getSharedDataStore', org, function(store)
			local outfit = store.get('dressing', num)
			cb(outfit.skin)
		end)
	end
end)

RegisterServerEvent('exile_organizacje:removeOutfit')
AddEventHandler('exile_organizacje:removeOutfit', function(co, org)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_datastore:getSharedDataStore', org, function(store)
		local dressing = store.get('dressing')
		if dressing == nil then
			dressing = {}
		end
		label = co
		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)

-- item count
ESX.RegisterServerCallback('org:getItemAmount', function(source, cb, item)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local items = xPlayer.getInventoryItem(item)
		if items == nil then
			cb(0)
		else
			cb(items.count)
		end
	end
end)

-- uzywa kurwa czy nie
ESX.RegisterServerCallback('exile:isUsed', function(source, cb, cochcesz, orgname)
    if used_stock[cochcesz] == orgname then 
        cb(true)
    else
        cb(false)
    end
end)

-- licencje pedaly 
ESX.RegisterServerCallback('exile_organizations:getLicenses', function(source, cb, society)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local licka = {}

    MySQL.Async.fetchAll('SELECT * FROM exile_org WHERE orgname = @job',{
		['@job'] = society
	}, function(result)
        if result[1] ~= nil then
            licka.menuf7 = result[1].menuf7
            licka.level = result[1].level
            licka.safe = result[1].safe
            licka.items = result[1].items
            licka.addoncloakroom = result[1].addoncloakroom
            cb(licka)
        end
    end)
end)

-- kupowanie licencji pedaly
RegisterServerEvent('exile_organizations:upgradeOrganization')
AddEventHandler('exile_organizations:upgradeOrganization', function(co, naco, org, cena)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if cena > xPlayer.getMoney() then
        local brakuje = cena - xPlayer.getMoney()
        TriggerClientEvent('esx:showNotification', _source, "~r~Nie posiadasz wystarczającej ilosci gotówki\nBrakuje ci ~g~" .. brakuje .. "$ ~s~czystej gotówki")
    else
        TriggerClientEvent('esx:showNotification', _source, "~g~Pomyślnie zapłacono za ulepszenie organizacji")
        xPlayer.removeAccountMoney('money', cena)
		exports.exile_logs:discord(source, 'Ulepszył/a organizacje za '..cena..'$ ['..co..' | '..naco..']', 'bossmenuorg', true)
        MySQL.Async.execute('UPDATE exile_org SET ' .. co .. ' = @chuj WHERE orgname = @job',{
            ['@job'] = org,
            ['@chuj'] = naco
        })
    end
end)








-- WOREK


RegisterServerEvent('atlantisHeadbag:setbagon')
AddEventHandler('atlantisHeadbag:setbagon', function(target, idkurwy)
	local _target = target
	local _idkurwy = idkurwy
	local xPlayer = ESX.GetPlayerFromId(_idkurwy)
	local xTarget = ESX.GetPlayerFromId(_target)
		TriggerClientEvent('atlantisHeadbag:setbag', _target, _idkurwy)

end)

RegisterServerEvent('atlantisHeadbag:check')
AddEventHandler('atlantisHeadbag:check', function(target, idkurwy)
	local _target = target
	local _idkurwy = idkurwy
		TriggerClientEvent('atlantisHeadbag:checkthiskurwe', _target, _idkurwy)
end)

RegisterServerEvent('atlantisHeadbag:itemhuj')
AddEventHandler('atlantisHeadbag:itemhuj', function(idkurwy, gowno)
	local idhuj = idkurwy
	local _gowno = gowno
		TriggerClientEvent('atlantisHeadbag:kurwodajitem', idhuj, _gowno)
end)

RegisterServerEvent('atlantisHeadbag:item')
AddEventHandler('atlantisHeadbag:item', function(what)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _what = what
	local limitworkowbotypersiesprul = xPlayer.getInventoryItem('worek').count
		if _what == 'remove' then
			xPlayer.removeInventoryItem('worek', 1)
		elseif _what == 'give' then
			if limitworkowbotypersiesprul < 5 then
				xPlayer.addInventoryItem('worek', 1)
			else
				ESX.ShowNotification("~r~Masz pełne kieszenie")
			end	
		end
end)

RegisterServerEvent('atlantisHeadbag:woreknaleb')
AddEventHandler('atlantisHeadbag:woreknaleb', function(idkurwy, onglowa)
	local _source = source
	local _idkurwy = idkurwy
	local xPlayer = ESX.GetPlayerFromId(_idkurwy)
	local xTarget = ESX.GetPlayerFromId(_source)
	if onglowa == 0 then
		TriggerEvent('esx:woreknaleb', xPlayer.source..' sciągnął '..xTarget.source..' worek z łba')
	elseif onglowa == 1 then
		TriggerEvent('esx:woreknaleb', xPlayer.source..' załozył '..xTarget.source..' worek na łeb i bomby od dołu mu wali')
	end
end)