ESX = nil TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)


RegisterServerEvent('esx_animations:save')
AddEventHandler('esx_animations:save', function(binds)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.execute('UPDATE users SET animacje = @animacje WHERE identifier = @identifier', {
		['@animacje'] = json.encode(binds),
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_animations:load')
AddEventHandler('esx_animations:load', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local bindy = nil
	
	if xPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT animacje FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1].animacje then
				TriggerClientEvent('esx_animations:bind', _source, json.decode(result[1].animacje))
			else
				TriggerClientEvent('esx_animations:bind', _source, {})
			end
		end)
	end
end)




RegisterServerEvent('exile_animacje:triggerAnim')
AddEventHandler('exile_animacje:triggerAnim', function(asst, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
	asstlabel = 'JAK TO WIDZISZ ZGŁOŚ SIĘ NA KANAŁ POMOCY'
	if asst == 'powitaj' then
		asstlabel = 'przywitać'
	elseif asst == 'piona' then
		asstlabel = 'zbić pionę'
	elseif asst == 'obejmij' then
		asstlabel = 'objąć'
	elseif asst == 'przytulas' then
		asstlabel = 'objąć'
	elseif asst == 'pocaluj' then
		asstlabel = 'pocałować'
	elseif asst == 'rublud' then
		asstlabel = 'pierdolić'
	elseif asst == 'anal' then
		asstlabel = 'ruchać'
	elseif asst == 'standingsex' then
		asstlabel = 'ruchać'
	end
	TriggerClientEvent('esx:showNotification', xTarget.source, 'Naciśnij [Y] aby '..asstlabel..' się z ['..xPlayer.source..'] (5 sekund)')
	TriggerClientEvent('esx:showNotification', xPlayer.source, 'Wysłano propozycję animacji ['..xTarget.source..']')
	TriggerClientEvent('exile_animacje:clientreq', xTarget.source, xPlayer.source, asst)
end)

RegisterServerEvent('exile_animacje:startAnim')
AddEventHandler('exile_animacje:startAnim', function(asst, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
	if xTarget ~= nil and xPlayer ~= nil then
		TriggerClientEvent('exile_animacje:animTarget', xTarget.source, xPlayer.source, asst)
		TriggerClientEvent('exile_animacje:animSource', xPlayer.source, asst)
	end
end)