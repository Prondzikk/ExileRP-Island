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

ESX                           = nil
local OwnedProperties         = {}
local Blips                   = {}
local CurrentProperty         = nil
local CurrentPropertyOwner    = nil
local LastProperty            = nil
local LastPart                = nil
local HasAlreadyEnteredMarker = false
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local FirstSpawn              = true
local HasChest                = false
local BlipsProperties 		  = {}
local isUsing				  = false

function isInProperty()
    return CurrentProperty ~= nil
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(250)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('esx_property:getProperties', function(properties)
		Config.Properties = properties
		CreateBlips()
	end)

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end)
end)

-- only used when script is restarting mid-session
RegisterNetEvent('esx_property:sendProperties')
AddEventHandler('esx_property:sendProperties', function(properties)
	Config.Properties = properties
	CreateBlips()

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end)
end)

function DrawSub(text, time)
	ClearPrints()
	SetTextEntry_2('STRING')
	AddTextComponentString(text)
	DrawSubtitleTimed(time, 1)
end

RegisterNetEvent('esx_property:reloadProperties')
AddEventHandler('esx_property:reloadProperties', function()
	RemoveBlips()
	Citizen.Wait(100)
	ESX.TriggerServerCallback('esx_property:getProperties', function(properties)
		Config.Properties = properties
		CreateBlips()
	end)

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end)
end)

function RemoveBlips()
	for i=1, #Config.Properties, 1 do
		local property = Config.Properties[i]
		if property.entering then
			RemoveBlip(Blips[property.name])
		end
	end
	Blips = {}
end

function CreateBlips()
	ESX.TriggerServerCallback('esx_property:getAllOwnedProperties', function(props)
		for i=1, #Config.Properties, 1 do
			Wait(25)
			local property = Config.Properties[i]
			local found = false
			for j=1, #props, 1 do
				if property.name == props[j].name then
					found = true
					property.owned = true
					break
				end
			end
			if not found then
				if property.entering then
					property.owned = false
					Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)

					SetBlipSprite (Blips[property.name], Config.BlipSpriteNotOwned)
					SetBlipDisplay(Blips[property.name], Config.BlipDisplay)
					SetBlipScale  (Blips[property.name], Config.BlipScale)
					SetBlipAsShortRange(Blips[property.name], true)
					SetBlipCategory(Blips[property.name], 10)

					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(_U('free_prop'))
					EndTextCommandSetBlipName(Blips[property.name])
				end
			end
		end
	end)
end

function GetProperties()
	return Config.Properties
end

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function GetGateway(property)
	for i=1, #Config.Properties, 1 do
		local property2 = Config.Properties[i]

		if property2.isGateway and property2.name == property.gateway then
			return property2
		end
	end
end

function GetGatewayProperties(property)
	local properties = {}

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].gateway == property.name then
			table.insert(properties, Config.Properties[i])
		end
	end

	return properties
end

function EnterProperty(name, owner)
	local property       = GetProperty(name)
	local playerPed      = PlayerPedId()
	CurrentProperty      = property
	CurrentPropertyOwner = owner

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name ~= name then
			Config.Properties[i].disabled = true
		end
	end

	TriggerServerEvent('esx_property:saveLastProperty', name)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(1)
		end

		for i=1, #property.ipls, 1 do
			RequestIpl(property.ipls[i])

			while not IsIplActive(property.ipls[i]) do
				Citizen.Wait(1)
			end
		end

		SetEntityCoords(playerPed, property.inside.x, property.inside.y, property.inside.z)
		DoScreenFadeIn(800)
		DrawSub(property.label, 5000)
	end)

end

function ExitProperty(name)
	local property  = GetProperty(name)
	local playerPed = PlayerPedId()
	local outside   = nil
	CurrentProperty = nil

	if property.isSingle then
		outside = property.outside
	else
		outside = GetGateway(property).outside
	end

	TriggerServerEvent('esx_property:deleteLastProperty')

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(1)
		end

		SetEntityCoords(playerPed, outside.x, outside.y, outside.z)

		for i=1, #property.ipls, 1 do
			RemoveIpl(property.ipls[i])
		end

		for i=1, #Config.Properties, 1 do
			Config.Properties[i].disabled = false
		end

		DoScreenFadeIn(800)
	end)
end

function SetPropertyBuyable(prop, value)
	local property = GetProperty(prop.name)
	property.owned = value
	property.isOwner = prop.owned
	property.isSubowner = prop.subowned
	property.owner = prop.owner
	if value == true then
		RemoveBlip(Blips[property.name])
	elseif value == false then
		Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)
		
		SetBlipSprite (Blips[property.name], Config.BlipSpriteNotOwned)
		SetBlipDisplay(Blips[property.name], Config.BlipDisplay)
		SetBlipScale  (Blips[property.name], Config.BlipScale)
		SetBlipAsShortRange(Blips[property.name], true)
		SetBlipCategory(Blips[property.name], 10)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('free_prop'))
		EndTextCommandSetBlipName(Blips[property.name])
	end
end

function SetPropertyOwned(prop, owned)
	local property     = GetProperty(prop.name)
	local entering     = nil
	local enteringName = nil

	if property.isSingle then
		entering     = property.entering
		enteringName = property.name
	else
		local gateway = GetGateway(property)
		entering      = gateway.entering
		enteringName  = gateway.name
	end
	
	property.isOwner = prop.owned
	property.isSubowner = prop.subowned
	property.owner = prop.owner
	
	if owned then
		property.owned = true
		OwnedProperties[prop.name] = true
		RemoveBlip(Blips[enteringName])
		
		if property.garage ~= nil then
			TriggerEvent('esx_garages:addNewGarage', property.garage.x,property.garage.y, property.garage.z)
		end
			
		Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
		
		SetBlipSprite (Blips[enteringName], Config.BlipSpriteOwned)
		SetBlipColour (Blips[property.name], 2)
		SetBlipDisplay(Blips[enteringName], Config.BlipDisplay)
		SetBlipScale  (Blips[enteringName], Config.BlipScale)
		SetBlipAsShortRange(Blips[enteringName], true)
		SetBlipCategory(Blips[property.name], 11)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('property'))
		EndTextCommandSetBlipName(Blips[enteringName])

	else
		property.owned = false
		OwnedProperties[prop.name] = nil
		local found = false

		for k,v in pairs(OwnedProperties) do
			local _property = GetProperty(k)
			local _gateway  = GetGateway(_property)

			if _gateway then
				if _gateway.name == enteringName then
					found = true
					break
				end
			end
		end

		if not found then
			RemoveBlip(Blips[enteringName])
			
			if property.garage ~= nil then
				TriggerEvent('esx_garages:removeGarage', property.garage.x,property.garage.y, property.garage.z)
			end
			
			Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
			
			SetBlipSprite (Blips[enteringName], Config.BlipSpriteNotOwned)
			SetBlipDisplay(Blips[enteringName], Config.BlipDisplay)
			SetBlipScale  (Blips[enteringName], Config.BlipScale)
			SetBlipAsShortRange(Blips[enteringName], true)
			SetBlipCategory(Blips[property.name], 10)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('free_prop'))
			EndTextCommandSetBlipName(Blips[enteringName])
		end

	end

end

function PropertyIsOwned(property)
	return OwnedProperties[property.name] == true
end

function OpenPropertyMenu(property)
	local elements = {}

	if PropertyIsOwned(property) then
		table.insert(elements, {label = _U('enter'), value = 'enter'})

		if not Config.EnablePlayerManagement and property.isOwner then
			table.insert(elements, {
				label = ('%s <span style="color:green;">$%s</span>'):format(_U('leave'), ESX.Math.GroupDigits(math.floor(property.price * 0.6))),
				value = 'leave'
			})
			
			table.insert(elements, {label = _U('sell'), value = 'sell'})
		end
	else
		if not Config.EnablePlayerManagement then
			table.insert(elements, 
			{
				label = ('%s <span style="color:green;">$%s</span>'):format(_U('buy'), ESX.Math.GroupDigits(property.price)),
				value = 'buy'
			})
			--table.insert(elements, {label = _U('rent'), value = 'rent'})
		end

		--table.insert(elements, {label = _U('visit'), value = 'visit'})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'property',
	{
		title    = property.label,
		align    = 'center',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'enter' then
            menu.close()
            TriggerEvent('instance:create', 'property', {property = property.name, owner = property.owner})
		elseif data.current.value == 'leave' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'propertyleave',
			{
				title    = "Czy na pewno chcesz sprzedać mieszkanie?",
				align    = 'center',
				elements = {
					{label = "Nie", value = 'no'},
					{label = "Tak", value = 'yes'}
				}
			}, function(data2, menu2)
				if data2.current.value == 'yes' then
					menu.close()
					menu2.close()
					TriggerServerEvent('esx_property:removeOwnedProperty', property)
				else
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'sell' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell', {
				title = "Kwota"
			}, function(data2, menu2)

				local quantity = tonumber(data2.value)
				if quantity == nil then
					ESX.ShowNotification(_U('amount_invalid'))
				else
					menu2.close()
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('esx_property:sellForPlayer', property.name, quantity, GetPlayerServerId(closestPlayer))
					else
						ESX.ShowNotification("~r~Brak osób w pobliżu")
					end
				end

			end, function(data2,menu)
				menu2.close()
			end)
		elseif data.current.value == 'buy' then
			menu.close()
			TriggerServerEvent('esx_property:buyProperty', property.name)
		elseif data.current.value == 'rent' then
			menu.close()
			TriggerServerEvent('esx_property:rentProperty', property.name)
		elseif data.current.value == 'visit' then
			menu.close()
			TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'property_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {property = property}
	end)
end

function OpenGatewayMenu(property)
	if Config.EnablePlayerManagement then
		OpenGatewayOwnedPropertiesMenu(gatewayProperties)
	else

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway',
		{
			title    = property.name,
			align    = 'center',
			elements = {
				{label = _U('owned_properties'),    value = 'owned_properties'},
				{label = _U('available_properties'), value = 'available_properties'}
			}
		}, function(data, menu)
			if data.current.value == 'owned_properties' then
				OpenGatewayOwnedPropertiesMenu(property)
			elseif data.current.value == 'available_properties' then
				OpenGatewayAvailablePropertiesMenu(property)
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		end)

	end
end

function OpenGatewayOwnedPropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements          = {}

	for i=1, #gatewayProperties, 1 do
		if PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				value = gatewayProperties[i].name,
				prop  = gatewayProperties[i]
			})
		end
	end
	
	if #elements == 0 then
		ESX.ShowNotification("~r~Nie posiadasz żadnych mieszkań w tym apartamentowcu")
	elseif #elements > 0 then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties',
		{
			title    = property.name .. ' - ' .. _U('owned_properties'),
			align    = 'center',
			elements = elements
		}, function(data, menu)
			menu.close()

			local elements = {
				{label = _U('enter'), value = 'enter'}
			}

			if not Config.EnablePlayerManagement and (data.current.prop).isOwner then
				table.insert(elements, {
					label = ('%s <span style="color:green;">$%s</span>'):format(_U('leave'), ESX.Math.GroupDigits(math.floor((data.current.prop).price * 0.6))),
					value = 'leave'
				})
				
				table.insert(elements, {label = _U('sell'), value = 'sell'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties_actions',
			{
				title    = data.current.label,
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				menu2.close()

				if data2.current.value == 'enter' then
					TriggerEvent('instance:create', 'property', {property = data.current.value, owner = (data.current.prop).owner})
					ESX.UI.Menu.CloseAll()
				elseif data2.current.value == 'leave' then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'propertyleave',
					{
						title    = "Czy na pewno chcesz sprzedać mieszkanie?",
						align    = 'center',
						elements = {
							{label = "Nie", value = 'no'},
							{label = "Tak", value = 'yes'}
						}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
							menu.close()
							menu2.close()
							TriggerServerEvent('esx_property:removeOwnedProperty', data.current.prop)
						else
							menu2.close()
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				elseif data2.current.value == 'sell' then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell', {
						title = "Kwota"
					}, function(data3, menu3)
						local quantity = tonumber(data3.value)
						if quantity == nil then
							ESX.ShowNotification(_U('amount_invalid'))
						else
							menu3.close()
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('esx_property:sellForPlayer', data.current.value, quantity, GetPlayerServerId(closestPlayer))
							else
								ESX.ShowNotification("~r~Brak osób w pobliżu")
							end
						end

					end, function(data3,menu3)
						menu3.close()
					end)
				end
			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	end
end



















function printTable(o)

	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
		   if type(k) ~= 'number' then k = '"'..k..'"' end
		   s = s .. '['..k..'] = ' .. printTable(v) .. ','
		end
		return s .. '} '
	 else
		return tostring(o)
	 end

end



























function OpenGatewayAvailablePropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements          = {}
	ESX.TriggerServerCallback('esx_property:getAllOwnedProperties', function(props)
		for i=1, #gatewayProperties, 1 do
			local found = false
			for j=1, #props, 1 do
				if gatewayProperties[i].name == props[j].name then
					found = true
					break
				end
			end
			if not found then
				table.insert(elements, {
					label = ('%s <span style="color:green;">$%s</span>'):format(gatewayProperties[i].label, ESX.Math.GroupDigits(gatewayProperties[i].price)),
					value = gatewayProperties[i].name,
					price = gatewayProperties[i].price
				})
			end
		end
		
		if #elements == 0 then
			ESX.ShowNotification("~r~Brak wolnych mieszkań w tym apartamentowcu")
		elseif #elements > 0 then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties',
			{
				title    = property.name .. ' - ' .. _U('available_properties'),
				align    = 'center',
				elements = elements
			}, function(data, menu)

				menu.close()
				if data.current.value ~= 'nothing' then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties_actions',
					{
						title    = property.label .. ' - ' .. _U('available_properties'),
						align    = 'center',
						elements = {
							{label = _U('buy'), value = 'buy'},
							--{label = _U('rent'), value = 'rent'},
							--{label = _U('visit'), value = 'visit'}
						}
					}, function(data2, menu2)
						menu2.close()

						if data2.current.value == 'buy' then
							TriggerServerEvent('esx_property:buyProperty', data.current.value)
						elseif data2.current.value == 'rent' then
							TriggerServerEvent('esx_property:rentProperty', data.current.value)
						elseif data2.current.value == 'visit' then
							TriggerEvent('instance:create', 'property', {property = data.current.value, owner = ESX.GetPlayerData().identifier})
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end, function(data, menu)
				menu.close()
			end)
		end
	end)
end

function OpenRoomMenu(property, owner)
	ESX.TriggerServerCallback('esx_property:checkStock', function(isUsed)
		if not isUsed then
			isUsing = true
			TriggerServerEvent('esx_property:setStockUsed', property.name, true)
			
			local entering = nil
			local elements = {}

			if property.isSingle then
				entering = property.entering
			else
				entering = GetGateway(property).entering
			end

			table.insert(elements, {label = _U('invite_player'),  value = 'invite_player'})

			if CurrentPropertyOwner == owner then
				table.insert(elements, {label = _U('player_clothes'), value = 'player_dressing'})
				table.insert(elements, {label = _U('remove_cloth'), value = 'remove_cloth'})
			end

			table.insert(elements, {label = _U('remove_object'),  value = 'room_inventory'})
			table.insert(elements, {label = _U('deposit_object'), value = 'player_inventory'})

			ESX.UI.Menu.CloseAll()

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room',
			{
				title    = property.label,
				align    = 'center',
				elements = elements
			}, function(data, menu)

				if data.current.value == 'invite_player' then
					local elements      = {}
					ESX.TriggerServerCallback('esx_property:getPlayers', function(players)				
						for i=1, #players, 1 do
							table.insert(elements, {label = players[i], value = players[i]})
						end
						
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_invite', {
							title    = property.label .. ' - ' .. _U('invite'),
							align    = 'center',
							elements = elements
						}, function(data, menu2)
							TriggerEvent('instance:invite', 'property', data.current.value, {property = property.name, owner = owner})
							ESX.ShowNotification(_U('you_invited', data.current.value))
						end, function(data, menu2)
							menu2.close()
						end)
					end, entering)		

				elseif data.current.value == 'player_dressing' then

					ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
						local elements = {}

						for i=1, #dressing, 1 do
							table.insert(elements, {
								label = dressing[i],
								value = i
							})
						end

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
						{
							title    = property.label .. ' - ' .. _U('player_clothes'),
							align    = 'center',
							elements = elements
						}, function(data2, menu2)

							TriggerEvent('skinchanger:getSkin', function(skin)
								ESX.TriggerServerCallback('esx_property:getPlayerOutfit', function(clothes)
									TriggerEvent('skinchanger:loadClothes', skin, clothes)
									TriggerEvent('esx_skin:setLastSkin', skin)

									TriggerEvent('skinchanger:getSkin', function(skin)
										TriggerServerEvent('esx_skin:save', skin)
									end)
								end, data2.current.value)
							end)

						end, function(data2, menu2)
							menu2.close()
						end)
					end)

				elseif data.current.value == 'remove_cloth' then

					ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
						local elements = {}

						for i=1, #dressing, 1 do
							table.insert(elements, {
								label = dressing[i],
								value = i
							})
						end

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
							title    = property.label .. ' - ' .. _U('remove_cloth'),
							align    = 'center',
							elements = elements
						}, function(data2, menu2)
							menu2.close()
							TriggerServerEvent('esx_property:removeOutfit', data2.current.value)
							ESX.ShowNotification(_U('removed_cloth'))
						end, function(data2, menu2)
							menu2.close()
						end)
					end)

				elseif data.current.value == 'room_inventory' then
					OpenRoomInventoryMenu(property, owner)
				elseif data.current.value == 'player_inventory' then
					OpenPlayerInventoryMenu(property, owner)
				end

			end, function(data, menu)
				menu.close()

				CurrentAction     = 'room_menu'
				CurrentActionMsg  = _U('press_to_menu')
				CurrentActionData = {property = property, owner = owner}
				
				isUsing = false
				TriggerServerEvent('esx_property:setStockUsed', property.name, false)
			end)
		else
			ESX.ShowNotification("~r~Ktoś właśnie używa tej szafki!")
		end
	end, property.name)
end

function OpenRoomInventoryMenu(property, owner)

	ESX.TriggerServerCallback('esx_property:getPropertyInventory', function(inventory)

		local elements = {}

		if inventory.blackMoney > 0 then
			table.insert(elements, {
				label = _U('dirty_money', ESX.Math.GroupDigits(inventory.blackMoney)),
				type = 'item_account',
				value = 'black_money'
			})
		end

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_inventory',
		{
			title    = property.label .. ' - ' .. _U('inventory'),
			align    = 'center',
			elements = elements
		}, function(data, menu)

			if data.current.type == 'item_weapon' then

				menu.close()

				TriggerServerEvent('esx_property:getItem', owner, data.current.type, data.current.value, data.current.ammo, property)
				ESX.SetTimeout(300, function()
					OpenRoomInventoryMenu(property, owner)
				end)

			else

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'get_item_count', {
					title = _U('amount')
				}, function(data2, menu)

					local quantity = tonumber(data2.value)
					if quantity == nil then
						ESX.ShowNotification(_U('amount_invalid'))
					else
						menu.close()

						TriggerServerEvent('esx_property:getItem', owner, data.current.type, data.current.value, quantity, property)
						ESX.SetTimeout(300, function()
							OpenRoomInventoryMenu(property, owner)
						end)
					end

				end, function(data2,menu)
					menu.close()
				end)

			end

		end, function(data, menu)
			menu.close()
		end)
	end, owner, property)
end

function OpenPlayerInventoryMenu(property, owner)

	ESX.TriggerServerCallback('esx_property:getPlayerInventory', function(inventory)

		local elements = {}

		if inventory.blackMoney > 0 then
			table.insert(elements, {
				label = _U('dirty_money', ESX.Math.GroupDigits(inventory.blackMoney)),
				type  = 'item_account',
				value = 'black_money'
			})
		end

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_inventory',
		{
			title    = property.label .. ' - ' .. _U('inventory'),
			align    = 'center',
			elements = elements
		}, function(data, menu)

			if data.current.type == 'item_weapon' then

				menu.close()
				TriggerServerEvent('esx_property:putItem', owner, data.current.type, data.current.value, data.current.ammo, property)

				ESX.SetTimeout(300, function()
					OpenPlayerInventoryMenu(property, owner)
				end)

			else

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'put_item_count', {
					title = _U('amount')
				}, function(data2, menu2)

					local quantity = tonumber(data2.value)

					if quantity == nil then
						ESX.ShowNotification(_U('amount_invalid'))
					else

						menu2.close()

						TriggerServerEvent('esx_property:putItem', owner, data.current.type, data.current.value, tonumber(data2.value), property)
						ESX.SetTimeout(300, function()
							OpenPlayerInventoryMenu(property, owner)
						end)
					end

				end, function(data2, menu2)
					menu2.close()
				end)

			end

		end, function(data, menu)
			menu.close()
		end)

	end)

end

AddEventHandler('instance:loaded', function()
	TriggerEvent('instance:registerType', 'property', function(instance)
		EnterProperty(instance.data.property, instance.data.owner)
	end, function(instance)
		ExitProperty(instance.data.property)
	end)
end)

AddEventHandler('playerSpawned', function()
	if FirstSpawn then

		Citizen.CreateThread(function()

			while not ESX.IsPlayerLoaded() do
				Citizen.Wait(1)
			end

			ESX.TriggerServerCallback('esx_property:getLastProperty', function(propertyName)
				if propertyName then
					if propertyName ~= '' then
						local property = GetProperty(propertyName)

						for i=1, #property.ipls, 1 do
							RequestIpl(property.ipls[i])
				
							while not IsIplActive(property.ipls[i]) do
								Citizen.Wait(1)
							end
						end

						TriggerEvent('instance:create', 'property', {property = propertyName, owner = property.owner})
					end
				end
			end)
		end)

		FirstSpawn = false
	end
end)

AddEventHandler('esx_property:getProperties', function(cb)
	cb(GetProperties())
end)

AddEventHandler('esx_property:getProperty', function(name, cb)
	cb(GetProperty(name))
end)

AddEventHandler('esx_property:getGateway', function(property, cb)
	cb(GetGateway(property))
end)

RegisterNetEvent('esx_property:setPropertyBuyable')
AddEventHandler('esx_property:setPropertyBuyable', function(name, value)
	SetPropertyBuyable(name, value)
end)

RegisterNetEvent('esx_property:setPropertyOwned')
AddEventHandler('esx_property:setPropertyOwned', function(name, owned)
	SetPropertyOwned(name, owned)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'property' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
	if instance.type == 'property' then
		local property = GetProperty(instance.data.property)
		local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
		local isOwned  = false

		if PropertyIsOwned(property) == true then
			isOwned = true
		end

		if isOwned or not isHost then
			HasChest = true
		else
			HasChest = false
		end
	end
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(instance, player)
	if player == instance.host then
		TriggerEvent('instance:leave')
	end
end)

AddEventHandler('esx_property:hasEnteredMarker', function(name, part)
	local property = GetProperty(name)

	if part == 'entering' then
		if property.isSingle then
			CurrentAction     = 'property_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		else
			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		end
	elseif part == 'exit' then
		CurrentAction     = 'room_exit'
		CurrentActionMsg  = _U('press_to_exit')
		CurrentActionData = {propertyName = name}
	elseif part == 'roomMenu' then
		CurrentAction     = 'room_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {property = property, owner = property.owner}
	end
end)

AddEventHandler('esx_property:hasExitedMarker', function(name, part)
	if isUsing then
		isUsing = false
		TriggerServerEvent('esx_property:setStockUsed', name, false)
	end
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Enter / Exit marker events & Draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords, sleep = GetEntityCoords(PlayerPedId()), true
		local isInMarker = false
		local currentProperty, currentPart

		for i=1, #Config.Properties, 1 do
			local property = Config.Properties[i]

			-- Entering
			if property.entering and not property.disabled then
				if not property.owned or (property.isOwner or property.isSubowner) then 
					local distance = GetDistanceBetweenCoords(coords, property.entering.x, property.entering.y, property.entering.z, true)
					if distance < Config.DrawDistance then
						sleep = false
						DrawMarker(Config.MarkerType, property.entering.x, property.entering.y, property.entering.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.MarkerSize.x then
						isInMarker      = true
						currentProperty = property.name
						currentPart     = 'entering'
					end
				end
			end

			-- Exit
			if property.exit and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.exit.x, property.exit.y, property.exit.z, true)

				if distance < Config.DrawDistance then
					sleep = false
					DrawMarker(Config.MarkerType, property.exit.x, property.exit.y, property.exit.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'exit'
				end
			end

			-- Room menu
			if property.roomMenu and HasChest and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, true)

				if distance < Config.DrawDistance then
					sleep = false
					DrawMarker(Config.MarkerType, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'roomMenu'
				end
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastProperty ~= currentProperty or LastPart ~= currentPart) ) then
			HasAlreadyEnteredMarker = true
			LastProperty            = currentProperty
			LastPart                = currentPart

			TriggerEvent('esx_property:hasEnteredMarker', currentProperty, currentPart)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_property:hasExitedMarker', LastProperty, LastPart)
		end
		if sleep then
			Citizen.Wait(200)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
			if CurrentAction and not exports['esx_policejob']:IsCuffed() and not exports['esx_ambulancejob']:getDeathStatus() then
				ESX.ShowHelpNotification(CurrentActionMsg)

				if IsControlJustReleased(0, Keys['E']) then

					if CurrentAction == 'property_menu' then
						OpenPropertyMenu(CurrentActionData.property)
					elseif CurrentAction == 'gateway_menu' then
						if Config.EnablePlayerManagement then
							OpenGatewayOwnedPropertiesMenu(CurrentActionData.property)
						else
							OpenGatewayMenu(CurrentActionData.property)
						end
					elseif CurrentAction == 'room_menu' then
						if (CurrentActionData.property).isOwner or (CurrentActionData.property).isSubowner then
							OpenRoomMenu(CurrentActionData.property, CurrentActionData.owner)
						else
							ESX.ShowNotification("~r~Nie możesz korzystać z tej szafki")
						end
					elseif CurrentAction == 'room_exit' then
						TriggerEvent('instance:leave')
					end

					CurrentAction = nil

				end
			end
	end
end)

----

Citizen.CreateThread(function()
	while true do
		UpdatePedCoords()
		Citizen.Wait(1000)
	end
end)

local playerPedCoords = vector3(0.0, 0.0, 0.0)

UpdatePedCoords = function()
	playerPedCoords = GetEntityCoords(PlayerPedId())
end

Citizen.CreateThread(function()
	while true do
		local subowner = GetVDistToSubowner()
		if (subowner < 10.0) then
			if subowner < 1.5 then
				if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby zarządzać swoimi mieszkaniami')
					if IsControlJustPressed(0, 38) then
						OpenSubownerMenu()
						Citizen.Wait(500)
					end
				end
			end

			DrawMarker(Config.MarkerType, Subowner.Location.coords.x, Subowner.Location.coords.y, Subowner.Location.coords.z-0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false);
		else
			Citizen.Wait(500)
		end
		Citizen.Wait(3)
	end
end)

GetVDistToSubowner = function()
	return GetDistanceBetweenCoords(playerPedCoords, Subowner.Location.coords.x, Subowner.Location.coords.y, Subowner.Location.coords.z, true)
end

function OpenSubownerMenu()
	ESX.TriggerServerCallback('esx_properties:getOwnedProperties', function(properties)
		if properties ~= nil and (json.encode(properties) ~= '{}') then
			local elements = {}
			for i=1, #properties, 1 do
				local property = GetProperty(properties[i].name)
				while not property do
					Citizen.Wait(20)
				end
				table.insert(elements, {label = property.label, name = property.name})
			end
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'subowner_menu',
				{
					title = "Lista Mieszkań",
					align = 'center',
					elements = elements
				},
				function(data, menu)
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'subowner_menu2',
						{
							title = data.current.label .. " - Zarządzanie",
							align = 'center',
							elements = {
								{label = "Nadaj współwłaściciela (30 000$)", value = 'give_sub'},
								{label = "Zmień zamki", value = 'manage_sub'},
							}
						},
						function(data2, menu2)
							if data2.current.value == 'give_sub' then
								menu2.close()
								menu.close()
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer ~= -1 and closestDistance <= 3.0 then
									TriggerServerEvent('esx_property:setSubowner', data.current.name, GetPlayerServerId(closestPlayer))
								else
									ESX.ShowNotification("~r~Brak osób w pobliżu")
								end
							elseif data2.current.value == 'manage_sub' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'yesorno',
									{
										title = "Czy na pewno chcesz zmienić zamki w drzwiach?",
										align = 'center',
										elements = {
											{label = "Nie", value = 'no'},
											{label = "Tak", value = 'yes'}
										}
									},
									function(data3, menu3)
										if data3.current.value == 'yes' then
											TriggerServerEvent('esx_properties:deleteSubowners', data.current.name)
											menu3.close()
											menu2.close()
											menu.close()
										elseif data3.current.value == 'no' then
											menu3.close()
										end
									end,
									function(data3, menu3)
										menu3.close()
									end
								)	
							end
						end,
						function(data2,menu2)
							menu2.close()
						end
					)
				end,
				function(data,menu)
					menu.close()
				end
			)
		else
			ESX.ShowNotification("~r~Nie posiadasz żadnych mieszkań na własność!")
		end
	end)
end

--
RegisterNetEvent('esx_property:acceptBuy')
AddEventHandler('esx_property:acceptBuy', function(owner, name, price)
	local pOwner, pName, pPrice = owner, name, price
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'yes_or_no',
	{
		title    = 'Czy chcesz zakupić ' .. pName .. ' za ' .. pPrice .. '$?',
		align    = 'center',
		elements = {
			{label = "Nie",	value = 'no'},
			{label = "Tak",	value = 'yes'},
		}
	}, 	function(data, menu)
			if data.current.value == 'yes' then
				menu.close()
				TriggerServerEvent('esx_property:changeOwner', pOwner, pName, pPrice)
			elseif data.current.value == 'no' then
				menu.close()
				ESX.ShowNotification("Odrzuciłeś ofertę kupna")
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end)