ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bagniak', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('acidtrip:weed', source)
	TriggerClientEvent('esx_basicneeds:onEnergy', source)
	xPlayer.removeInventoryItem('bagniak', 1)
	TriggerClientEvent('esx:showNotification', 'Zaczyna ci się kręcić w głowie..')
	Citizen.Wait(200)
	TriggerClientEvent('esx:showNotification','Twoje nerwy wariują..')
	Citizen.Wait(250)
	TriggerClientEvent('esx:showNotification', 'Twoja adrenalina buzuje, czujesz przypływ Haze.')
end)