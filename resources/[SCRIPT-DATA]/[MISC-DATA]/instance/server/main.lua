local instances = {}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

function GetInstancedPlayers()
	local players = {}

	for k,v in pairs(instances) do
		for k2,v2 in ipairs(v.players) do
			players[v2] = true
		end
	end

	return players
end

function CreateInstance(type, player, data)
	instances[player] = {
		type    = type,
		host    = player,
		players = {},
		data    = data
	}

	TriggerEvent('instance:onCreate', instances[player])
	TriggerClientEvent('instance:onCreate', player, instances[player])
	TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
end

ESX.RegisterServerCallback("instance:find",function(source, cb, data)
	local found = false
	for k,v in pairs(instances) do
		if v.data.property == data.property then
			found = v
			break
		end
	end
	
	cb(found)
end)

function CloseInstance(instance)
	if instances[instance] then

		for i=1, #instances[instance].players do
			TriggerClientEvent('instance:onClose', instances[instance].players[i])
		end

		instances[instance] = nil

		TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
		TriggerEvent('instance:onClose', instance)
	end
end

function AddPlayerToInstance(instance, player)
	local found = false

	for i=1, #instances[instance].players do
		if instances[instance].players[i] == player then
			found = true
			break
		end
	end

	if not found then
		table.insert(instances[instance].players, player)
	end

	TriggerClientEvent('instance:onEnter', player, instances[instance])

	for i=1, #instances[instance].players do
		if instances[instance].players[i] ~= player then
			local xPlayer = ESX.GetPlayerFromId(player)
			TriggerClientEvent('instance:onPlayerEntered', instances[instance].players[i], instances[instance], player, xPlayer.character.firstname..' '..xPlayer.character.lastname)
		end
	end

	TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
end

function RemovePlayerFromInstance(instance, player)
	if instances[instance] then
		TriggerClientEvent('instance:onLeave', player, instances[instance])

		if instances[instance].host == player then
			for i=1, #instances[instance].players do
				if instances[instance].players[i] ~= player then
					local xPlayer = ESX.GetPlayerFromId(player)
					TriggerClientEvent('instance:onPlayerLeft', instances[instance].players[i], instances[instance], player, xPlayer.character.firstname..' '..xPlayer.character.lastname)
				end
			end

			CloseInstance(instance)
		else
			for i=1, #instances[instance].players do
				if instances[instance].players[i] == player then
					instances[instance].players[i] = nil
				end
			end

			for i=1, #instances[instance].players do
				if instances[instance].players[i] ~= player then
					local xPlayer = ESX.GetPlayerFromId(player)
					TriggerClientEvent('instance:onPlayerLeft', instances[instance].players[i], instances[instance], player, xPlayer.character.firstname..' '..xPlayer.character.lastname)
				end

			end

			TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
		end
	end
end

function InvitePlayerToInstance(instance, type, player, data)
	TriggerClientEvent('instance:onInvite', player, instance, type, data)
end

RegisterServerEvent('instance:create')
AddEventHandler('instance:create', function(type, data)
	CreateInstance(type, source, data)
end)

RegisterServerEvent('instance:close')
AddEventHandler('instance:close', function()
	CloseInstance(source)
end)

RegisterServerEvent('instance:enter')
AddEventHandler('instance:enter', function(instance)
	AddPlayerToInstance(instance, source)
end)

RegisterServerEvent('instance:leave')
AddEventHandler('instance:leave', function(instance)
	RemovePlayerFromInstance(instance, source)
end)

RegisterServerEvent('instance:invite')
AddEventHandler('instance:invite', function(instance, type, player, data)
	InvitePlayerToInstance(instance, type, player, data)
end)
