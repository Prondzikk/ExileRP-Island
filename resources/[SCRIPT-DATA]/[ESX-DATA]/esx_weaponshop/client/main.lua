local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local A = "SDFHIUDFBNVJDFbnvnb4cvjr3425%$&%^@#$^TBCVH$%^&gdkfljnhlh"
PlayerData = {}
ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(250)
	end
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function OpenWeaponMenu(cwel)
	local elements = {}
	if cwel == 'hehehasdfgfg' then 
		for k,v in pairs(Config.Zones['GunShop'].Items) do
			table.insert(elements, 
				{
					label =  v.title..' <span style="color: #7cfc00;">$'..v.price..'</span>',
					item = v.item,
					price = v.price,
					titleconfirm = v.title,
					value      = 1,
					type       = 'slider',
					min        = 1,
					max        = v.limit
				}
			)
		end

		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_menu', {
				align    = 'bottom-right',
				title    = 'Sklep',
				elements = elements
			}, function(data, menu)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
					title    = 'Wybierz metodę płatności',
					align    = 'bottom-right',
					elements = {
						{label = 'Gotówka',  value = 'cash'},
						{label = 'Karta płatnicza', value = 'card'},
					}
				}, function(data2, menu2)
					if data2.current.value == 'cash' then
						TriggerServerEvent('weaponshop:buyItem', data.current.item, data.current.value, data.current.price, data.current.max, 'money', A, "fgdgdfddfgdfdfghjhgjkghmkffddfgdfgdfgdfgfghgdfg")
					elseif data2.current.value == 'card' then
						TriggerServerEvent('weaponshop:buyItem', data.current.item, data.current.value, data.current.price, data.current.max, 'bank', A, "gdfdfgdfgdfgdfgjdfsghjklhkldsfgddhgddfhfgkfgdddddfdffdg")
					end

					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)			
			end,
		function(data, menu)
			menu.close()
		end)
	else
		for k,v in pairs(Config.Zones['ashgdfhdfhgjdofihonjksgfhujsdBGJDBYGDFGOUIYIY348967RTB8T034WEQGFAISUGFBYNH8IHg'].Items) do
			table.insert(elements, 
				{
					label =  v.title..' <span style="color: #7cfc00;">$'..v.price..'</span>',
					item = v.item,
					price = v.price,
					titleconfirm = v.title,
					value      = 1,
					type       = 'slider',
					min        = 1,
					max        = v.limit
				}
			)
		end

		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_menu', {
				align    = 'bottom-right',
				title    = 'Sklep',
				elements = elements
			}, function(data, menu)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
					title    = 'Wybierz metodę płatności',
					align    = 'bottom-right',
					elements = {
						{label = 'Brudna gotówka',  value = 'black'},
					}
				}, function(data2, menu2)
					if data2.current.value == 'black' then
						local x = TriggerServerEvent
						local a = "SDFHIUDFBNVJDFbnvnb4cvjr3425%$&%^@#$^TBCVH$%^&gdkfljnhlh"
						x('weaponshop:buyItem', data.current.item, data.current.value, data.current.price, data.current.max, 'black_money', A, "ashgdfhdfhgjdofihonjksgfhujsdBGJDBYGDFGOUIYIY348967RTB8T034WEQGFAISUGFBYNH8IHg")
					end

					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)			
			end,
		function(data, menu)
			menu.close()
		end)
	end
end

AddEventHandler('esx_weaponshop:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('shop_menu')
	CurrentActionData = { zone = zone }
end)

AddEventHandler('esx_weaponshop:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

CreateThread(function()
	for k,v in pairs(Config.Zones) do
		if v.legal then
			for i = 1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

				SetBlipSprite (blip, 110)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 0.7)
				SetBlipColour (blip, 2)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('map_blip'))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords, sleep = GetEntityCoords(PlayerPedId()), true

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 3) then
                    sleep = false
					DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end

        if sleep then
			Citizen.Wait(500)
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(60)

		local coords, sleep = GetEntityCoords(PlayerPedId()), true
		local isInMarker, currentZone = false, nil
		for k,v in pairs(Config.Zones) do
			for i=1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x) then
                    sleep = false
					isInMarker  = true
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_weaponshop:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_weaponshop:hasExitedMarker', LastZone)
		end

        if sleep then
			Citizen.Wait(500)
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)
			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'shop_menu' then
					if CurrentActionData.zone == 'GunShop' then 
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
							if hasWeaponLicense then
								OpenWeaponMenu('hehehasdfgfg')
							else
								ESX.ShowNotification('~r~Nie masz wyrobionej licencji na broń')
							end
						end, GetPlayerServerId(PlayerId()), 'weapon')
					else
						OpenWeaponMenu('fdfgjkjkbfgd8453489jkdcvb')
					end
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)