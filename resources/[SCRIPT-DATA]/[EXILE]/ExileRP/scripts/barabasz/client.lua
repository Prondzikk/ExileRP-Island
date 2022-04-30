Barabasz = {}
local healing = false

Barabasz.Zones = {
	Pos = {
		{
			Coords = vector3(-255.45, 6331.11, 31.53),
			Name = 'Paleto'
		}, 
		
		{
			Coords = vector3(306.37, -594.89, 43.28-0.90),
			Name = 'Pillbox'
		},
		
		{
			Coords = vector3(1824.88, 3669.13, 33.32),
			Name = 'Sandy'
		},

        {
			Coords = vector3(1716.18, 3322.76, 41.22-0.9),
			Name = 'Lotnisko',
            Field = true
        },
	},
}

CreateThread(function()
    while true do
		Citizen.Wait(0)
		local found = false
		for k,v in pairs(Barabasz.Zones) do
			for i=1, #v, 1 do
				local distance = #(playercoords - v[i].Coords)
				if distance < 8 then
					found = true
					ESX.DrawMarker(v[i].Coords)
					if distance < 1.5 then
						if not IsPedInAnyVehicle(playerPed, true) then
							ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby uzyskać ~y~pomoc medyczną~s~')
							if IsControlJustReleased(0, 46) and not healing then
								if GetEntityHealth(playerPed) < 200 then
                                    if v[i].Field == nil then
                                        ESX.TriggerServerCallback("esx_scoreboard:getConnectedCops", function(MisiaczekPlayers)
                                            if MisiaczekPlayers then
                                                if MisiaczekPlayers['ambulance'] < 4 then
                                                    ESX.TriggerServerCallback('esx_license:checkLicense', function(hasInsurance)
                                                        if hasInsurance then
                                                            ESX.UI.Menu.CloseAll()
                                                            healing = true
                                                            exports["exile_taskbar"]:taskBar(25000, "Trwa Leczenie", false, true)
                                                            TriggerEvent('esx_ambvlancejob:revive')
                                                            healing = false
                                                        else
                                                            local elements = {
                                                                { label = 'Zapłać gotówką', value = 'money' },
                                                                { label = 'Zapłać kartą', value = 'bank' },
                                                            }
                                                        
                                                            ESX.UI.Menu.CloseAll()
                                                        
                                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'paymenu',
                                                            {
                                                                title    = 'Wybierz sposób płatności - '..v[i].Name..' [2500$]',
                                                                align    = 'center',
                                                                elements = elements
                                                            }, function(data, menu)
                                                                if data.current.value ~= nil then
                                                                    ESX.TriggerServerCallback('basiuniasuki', function(hasEnoughMoney)
                                                                        if hasEnoughMoney then
                                                                            ESX.UI.Menu.CloseAll()
                                                                            healing = true
                                                                            exports["exile_taskbar"]:taskBar(25000, "Trwa Leczenie", false, true)
                                                                            TriggerEvent('esx_ambvlancejob:revive')
                                                                            healing = false
                                                                        else
                                                                            TriggerEvent('esx:showNotification', 'Nie masz wystarczająco pieniędzy!')
                                                                        end
                                                                    end, data.current.value, a)
                                                                end
                                                            end, function(data, menu)
                                                                menu.close()
                                                            end)
                                                        end
                                                    end, GetPlayerServerId(PlayerId()), 'ems_insurance')

                                                else
                                                    ESX.ShowNotification('Nie możesz skorzystać z ~r~pomocy medycznej~w~ ponieważ na służbie jest już ~y~' .. MisiaczekPlayers['ambulance'] .. ' medyków')
                                                end
                                            end
                                        end)
                                    else
                                        healing = true
                                        exports["exile_taskbar"]:taskBar(100, "Leczenie Starymi Narzędziami", false, true)
                                        TriggerEvent('esx_ambvlancejob:revive')
                                        Citizen.Wait(1500)
                                        SetEntityHealth(PlayerPedId(), 150)
                                        healing = false
                                    end
								else
									ESX.ShowNotification('~r~Nie potrzebujesz~w~ pomocy medycznej!')
								end
							end
						end
					end
				end
			end
		end

		if not found then
			Citizen.Wait(1000)
		end
    end
end)