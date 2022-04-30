ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end

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

	local GUI = {}
	GUI.Time = 0

	local MenuType = 'default'
	local MenuFocus = false
	local OpenedMenus = {}

	local openMenu = function(namespace, name, data)
		OpenedMenus[namespace .. '_' .. name] = true
		SendNUIMessage({
			action    = 'openMenu',
			namespace = namespace,
			name      = name,
			data      = data,
		})

	end

	local closeMenu = function(namespace, name)
		OpenedMenus[namespace .. '_' .. name] = nil
		SendNUIMessage({
			action    = 'closeMenu',
			namespace = namespace,
			name      = name,
			data      = data,
		})
	end

	ESX.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)

	AddEventHandler('esx_menu_default:message:menu_submit', function(data)
		if data ~= nil then
			local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
			if menu.submit ~= nil then
				menu.submit(data, menu)
			end

			if MenuFocus then
				SetNuiFocus(false)
				MenuFocus = false
			end
		end
	end)

	AddEventHandler('esx_menu_default:message:menu_delete', function(data)
		if data ~= nil then
			local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
			if menu.delete ~= nil then
				menu.delete(data, menu)
			end

			if MenuFocus then
				SetNuiFocus(false)
				MenuFocus = false
			end
		end
	end)

	AddEventHandler('esx_menu_default:message:menu_cancel', function(data)
		if data ~= nil then
			local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
			if menu.cancel ~= nil then
				menu.cancel(data, menu)
			end

			if MenuFocus then
				SetNuiFocus(false)
				MenuFocus = false
			end
		end
	end)

	RegisterNUICallback('menu_change', function(data, cb)
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

		for i=1, #data.elements, 1 do
			menu.setElement(i, 'value', data.elements[i].value)

			if data.elements[i].selected then
				menu.setElement(i, 'selected', true)
			else
				menu.setElement(i, 'selected', false)
			end

		end

		if menu.change then
			menu.change(data, menu)
		end

		if MenuFocus then
			SetNuiFocus(false)
			MenuFocus = false
		end

		cb('OK')
	end)

	--[[AddEventHandler('esx_menu_default:message:menu_change', function(data)
		if data ~= nil then
			local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
			for i = 1, #data.elements, 1 do
				menu.setElement(i, 'value', data.elements[i].value)
				if data.elements[i].selected then
					menu.setElement(i, 'selected', true)
				else
					menu.setElement(i, 'selected', false)
				end

			end

			if menu.change ~= nil then
				menu.change(data, menu)
			end

			if MenuFocus then
				SetNuiFocus(false)
				MenuFocus = false
			end
		end
	end)]]

	CreateThread(function()
		while true do
			Citizen.Wait(1)

			local OpenedMenuCount = 0
			for k, v in pairs(OpenedMenus) do
				if v == true then
					OpenedMenuCount = OpenedMenuCount + 1
				end
			end

			if OpenedMenuCount > 0 then
				DisableControlAction(0, Keys['ENTER'], true)
				if IsDisabledControlPressed(0, Keys['ENTER']) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
					SendNUIMessage({
						action  = 'controlPressed',
						control = 'ENTER'
					})
					GUI.Time = GetGameTimer()
				end

				DisableControlAction(0, Keys['DELETE'], true)
				if IsDisabledControlPressed(0, Keys['DELETE']) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
					SendNUIMessage({
						action  = 'controlPressed',
						control = 'DELETE'
					})
					GUI.Time = GetGameTimer()
				end

				DisableControlAction(0, Keys['PAGEDOWN'], true)
				if IsDisabledControlPressed(0, Keys['PAGEDOWN']) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
					SendNUIMessage({
						action  = 'controlPressed',
						control = 'PAGEDOWN'
					})

					ESX.SetTimeout(200, function()
						SetNuiFocus(true, true)
					end)

					GUI.Time = GetGameTimer()
					MenuFocus = true
				end

				DisableControlAction(0, Keys['BACKSPACE'], true)
				if IsDisabledControlPressed(0, Keys['BACKSPACE']) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
					SendNUIMessage({
						action  = 'controlPressed',
						control = 'BACKSPACE'
					})
					GUI.Time = GetGameTimer()
				end

				DisableControlAction(0, Keys['TOP'], true)
				DisableControlAction(0, 17, true)

				local b = IsDisabledControlPressed(0, Keys['TOP'])
				if (b or IsDisabledControlPressed(0, 17)) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > (b and 150 or 30) then
					SendNUIMessage({
						action  = 'controlPressed',
						control = 'TOP'
					})
					GUI.Time = GetGameTimer()
				end

				DisableControlAction(0, Keys['DOWN'], true)
				DisableControlAction(0, 16, true)

				b = IsDisabledControlPressed(0, Keys['DOWN'])
				if (b or IsDisabledControlPressed(0, 16)) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > (b and 150 or 30) then
					SendNUIMessage({
						action  = 'controlPressed',
						control = 'DOWN'
					})
					GUI.Time = GetGameTimer()
				end

				DisableControlAction(0, Keys['LEFT'], true)
				if IsDisabledControlPressed(0, Keys['LEFT']) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
					SendNUIMessage({
						action  = 'controlPressed',
						control = 'LEFT'
					})
					GUI.Time = GetGameTimer()
				end

				DisableControlAction(0, Keys['RIGHT'], true)
				if IsDisabledControlPressed(0, Keys['RIGHT']) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
					SendNUIMessage({
						action  = 'controlPressed',
						control = 'RIGHT'
					})
					GUI.Time = GetGameTimer()
				end
			else
				Citizen.Wait(100)
			end
		end
	end)
end)
