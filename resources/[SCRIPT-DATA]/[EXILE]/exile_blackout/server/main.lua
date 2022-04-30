
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('exile_blackout:dzwon')
AddEventHandler('exile_blackout:dzwon', function(list, damage)	
	local _source = source
	for k,v in pairs(list) do
		TriggerClientEvent('exile_blackout:dzwon', v, damage)
	end
	
	TriggerClientEvent('exile_blackout:dzwon', _source, damage)
end)

RegisterServerEvent('exile_blackout:impact')
AddEventHandler('exile_blackout:impact', function(list, speedBuffer, velocityBuffer)
	local _source = source
	for k,v in pairs(list) do
		TriggerClientEvent('exile_blackout:impact', v, speedBuffer, velocityBuffer)
	end
	
	TriggerClientEvent('exile_blackout:impact', _source, speedBuffer, velocityBuffer)
end)