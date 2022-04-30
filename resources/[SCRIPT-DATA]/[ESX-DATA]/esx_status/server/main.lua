ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded',function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
		}, function(status)
			if status[1] ~= nil then
				if status[1].status ~= nil and status[1].status ~= '' then
					TriggerClientEvent('esx_status:load', _source, json.decode(status[1].status))
					xPlayer.set('status', json.decode(status[1].status))
				else
					TriggerClientEvent('esx_status:load', _source, nil)
					xPlayer.set('status', {})
				end
			else
				TriggerClientEvent('esx_status:load', _source, nil)
				xPlayer.set('status', {})			
			end
		end)		
	end
end)

AddEventHandler('esx:playerDropped', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	
	if xPlayer ~= nil then
		local status = xPlayer.get('status')
		
		MySQL.Async.execute('UPDATE users SET status = @status WHERE identifier = @identifier', {
			['@status']     = json.encode(status),
			['@identifier'] = xPlayer.identifier
		})	
	end
end)

AddEventHandler('esx_status:getStatus', function(playerId, statusName, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local status  = xPlayer.get('status')

	if type(statusName) == 'table' then
		local statuses = {}
		for j=1, #statusName, 1 do
			local name = statusName[j]
			for i=1, #status, 1 do
				if status[i].name == name then
					table.insert(statuses, status[i])
				end
			end
		end
		
		cb(statuses)
	else
		for i=1, #status, 1 do
			if status[i].name == statusName then
				cb(status[i])
				break
			end
		end
	end
end)

RegisterServerEvent('esx_status:updateDB')
AddEventHandler('esx_status:updateDB', function(status)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer then
		xPlayer.set('status', status)
	end	
end)

ESX.RegisterUsableItem('gopro', function(source)
    TriggerClientEvent('ls_gopro:goproMenu', source)
end)

RegisterServerEvent('ls_gopro:destroyItem')
AddEventHandler('ls_gopro:destroyItem', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem("gopro", 1)
end)