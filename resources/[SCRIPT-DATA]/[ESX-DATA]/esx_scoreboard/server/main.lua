ESX = nil
local connectedPlayers = {}
local Counter = {	
	['players'] = GetNumPlayerIndices(),
	['ambulance'] = 0,
	['sheriff'] = 0,
	['taxi'] = 0,
	['mechanik'] = 0,
	['police'] = 0,
	['cardealer'] = 0,
	['doj'] = 0,
	['avocat'] = 0,
	['fib'] = 0,
	['psycholog'] = 0,
	['admin'] = 0,
	['maxPlayers'] = GetConvarInt('sv_maxclients', 150)
}

RegisterCommand('stats-scoreboard', function(source, args, raw)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.group == 'superadmin' then
		for k,v in pairs(Counter) do
			print(k, v)
		end
	end
end)

function MisiaczekPlayers()
	return connectedPlayers
end

function CounterPlayers(what)
	return Counter[what]
end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_scoreboard:getConnectedCops', function(source, cb)
	cb(Counter)
end)

ESX.RegisterServerCallback('esx_scoreboard:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name

	if Counter[job.name] then
		Counter[job.name] = Counter[job.name] + 1
	end

	if Counter[lastJob.name] then
		Counter[lastJob.name] = Counter[lastJob.name] - 1
	end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	if not connectedPlayers[playerId] then
		AddPlayerToScoreboard(xPlayer, true)
	else
		if connectedPlayers[playerId] then
			if Counter[connectedPlayers[playerId].job] then
				Counter[connectedPlayers[playerId].job] = Counter[connectedPlayers[playerId].job] - 1
			end
			
			connectedPlayers[playerId].job = xPlayer.job.name
			
			if Counter[xPlayer.job.name] then
				Counter[xPlayer.job.name] = Counter[xPlayer.job.name] + 1
			end			
		end	
	end
	
	Counter['players'] = GetNumPlayerIndices()
end)

AddEventHandler('playerDropped', function()	
	local groups = {
		['superadmin'] = true,
		['admin'] = true,
		['moderator'] = true,
		['support'] = true,
		['trialsupport'] = true
	}
	
	if connectedPlayers[source] then
		if Counter[connectedPlayers[source].job] then
			Counter[connectedPlayers[source].job] = Counter[connectedPlayers[source].job] - 1
		end
		
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer ~= nil then
			if groups[xPlayer.group] then
				Counter['admin'] = Counter['admin'] - 1
			end		
		end
		
		connectedPlayers[source] = nil
	end
	
	Counter['players'] = GetNumPlayerIndices()
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		CreateThread(function()
			Citizen.Wait(1000)
			local players = ESX.GetPlayers()
			
			for _, player in ipairs(players) do
				local xPlayer = ESX.GetPlayerFromId(player)
				AddPlayerToScoreboard(xPlayer, true)
			end	
			
		end)
		
		Citizen.Wait(30000)
		Counter['maxPlayers'] = GetConvarInt('sv_maxclients', 150)
	end
end)

function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source

	local groups = {
		['superadmin'] = true,
		['admin'] = true,
		['moderator'] = true,
		['support'] = true,
		['trialsupport'] = true
	}

	if playerId ~= 0 then		
		connectedPlayers[playerId] = {}
		connectedPlayers[playerId].id = playerId
		connectedPlayers[playerId].identifier = xPlayer.identifier
		connectedPlayers[playerId].name = xPlayer.getName()
		connectedPlayers[playerId].job = xPlayer.job.name
		connectedPlayers[playerId].group = xPlayer.group
	end

	if update then
		if Counter[xPlayer.job.name] ~= nil then
			Counter[xPlayer.job.name] = Counter[xPlayer.job.name] + 1
		end
		
		if groups[xPlayer.group] then
			Counter['admin'] = Counter['admin'] + 1
		end
		
		Counter['players'] = GetNumPlayerIndices()
	end
end

RegisterServerEvent('esx_scoreboard:players')
AddEventHandler('esx_scoreboard:players', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local groups = {
		['superadmin'] = true,
		['admin'] = true,
		['moderator'] = true,
		['support'] = true,
		['trialsupport'] = true,
		['user'] = false,
	}
	if xPlayer then
		TriggerClientEvent('esx_scoreboard:players', _source, Counter, groups[xPlayer.group])
	end
end)

RegisterServerEvent('esx_scoreboard:Show')
AddEventHandler('esx_scoreboard:Show', function(text)
	local _source = source
	TriggerClientEvent("sendProximityMessageMe", -1, _source, _source, text)
end)