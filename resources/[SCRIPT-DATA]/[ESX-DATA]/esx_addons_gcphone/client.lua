RegisterNetEvent('esx_addons_gcphone:call')
AddEventHandler('esx_addons_gcphone:call', function(data)
	local cbs = function(msg)
		if msg ~= nil and msg ~= "" then
			local coords = GetEntityCoords(PlayerPedId(), false)			
			TriggerServerEvent('esx_addons_gcphone:startCall', data.number, msg, {
				x = coords.x,
				y = coords.y,
				z = coords.z
			})
		end
	end
  
	if data.message == nil then
		TriggerEvent('misiaczek:keyboard', function(value)
		  cbs(value)
		end, {
		  limit = 255,
		  type = 'textarea',
		  title = 'Wpisz wiadomość:'
		})
	else 
		cbs(data.message)
	end
end)
