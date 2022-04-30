ESX = nil
CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj)
			ESX = obj
		end)
	  
		Citizen.Wait(250)
	end
end)

Config.Zones = {
	vector3(-553.84, -191.58, 38.22-0.955)
}

local menuIsShowed, hasAlreadyEnteredMarker, isInMarker = false, false, false

function Menu()
	ESX.TriggerServerCallback('listing:get', function(jobs)
		local elements = {}

		for i=1, #jobs, 1 do
			table.insert(elements, {
				label = jobs[i].label,
				job   = jobs[i].job
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'joblisting', {
			title    = 'Katalog prac',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			TriggerServerEvent('listing:set', data.current.job)
			ESX.ShowNotification('Zatrudniłeś się w pracy ~y~' ..data.current.label)
			menu.close()
		end, function(data, menu)
			menu.close()
		end)

	end)
end

AddEventHandler('listing:marker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords, sleep = GetEntityCoords(PlayerPedId()), true
		isInMarker = false

		for i=1, #Config.Zones, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones[i], true)

			if distance < 5 then
				sleep = false
				ESX.DrawMarker(Config.Zones[i])
			end

			if distance < 2 then
				isInMarker = true
				ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby obejrzeć katalog prac')
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('listing:marker')
		end
		if sleep then
			Citizen.Wait(1000)
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)

		if IsControlJustReleased(0, 38) and isInMarker and not menuIsShowed then
			ESX.UI.Menu.CloseAll()
			Menu()
		end
	end
end)