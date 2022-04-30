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

local ragdoll = false
local isDead = false
local prop = nil
local loop = {
	status = nil,
	current = nil,
	finish = nil,
	delay = 0,
	dettach = false,
	last = 0
}
local binds = nil
local binding = nil
ESX = nil
local PlayerData = {}
local currentwalkingstyle = 'default'

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
		
        Citizen.Wait(250)
    end


	Citizen.Wait(5000)
    PlayerData = ESX.GetPlayerData()
	if not binds then
		TriggerServerEvent('esx_animations:load')
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job

end)

RegisterNetEvent('esx_animations:bind')
AddEventHandler('esx_animations:bind', function(list)
	binds = list
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	isDead = false
end)



RegisterNetEvent('esx_animations:trigger')
AddEventHandler('esx_animations:trigger', function(anim)
		if anim.type == 'ragdoll' then
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				ragdoll = true
			end
		elseif anim.type == 'attitude' then
			if anim.data.car == true then
				if IsPedInAnyVehicle(PlayerPedId(), false) then
					startAttitude(anim.data.lib, anim.data.anim)
				end
			else
				if not IsPedInAnyVehicle(PlayerPedId(), false) then
					startAttitude(anim.data.lib, anim.data.anim)
				end
			end
		elseif anim.type == 'scenario' then
			if anim.data.car == true then
				if IsPedInAnyVehicle(PlayerPedId(), false) then
					startScenario(anim.data.anim, anim.data.offset)
				end
			else
				if not IsPedInAnyVehicle(PlayerPedId(), false) then
					startScenario(anim.data.anim, anim.data.offset)
				end
			end
		elseif anim.type == 'anim' then
			if anim.data.car == true then
				if IsPedInAnyVehicle(PlayerPedId(), false) then
					startAnim(anim.data.lib, anim.data.anim, anim.data.mode, anim.data.prop)
				end
			else
				if not IsPedInAnyVehicle(PlayerPedId(), false) then
					startAnim(anim.data.lib, anim.data.anim, anim.data.mode, anim.data.prop)
				end
			end
		elseif anim.type == 'facial' then
			TriggerEvent('esx_voice:facial', anim.data)
		elseif anim.type == 'wspolne' then
			if Ped.Available then
				local closestPlayer, distance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= nil and distance ~= -1 and distance <= 3.0 then
					TriggerServerEvent('exile_animacje:triggerAnim', anim.data.name, GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification('~r~Brak obywatela w poblizu')
				end
			end
		else
			if not IsPedInAnyVehicle(PlayerPedId(), false) then
				startAnimLoop(anim.data)
			end
		end

end)

function startAttitude(lib, anim)
	CreateThread(function()
		RequestAnimSet(anim)
		while not HasAnimSetLoaded(anim) do
			Citizen.Wait(1)
		end

		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

function startScenario(anim, offset)
	if loop.status == true then
		finishLoop(function()
			startScenario(anim, offset)
		end)
	else
		local ped = PlayerPedId()
		if offset then
			local coords = GetEntityCoords(ped, true)
			TaskStartScenarioAtPosition(ped, anim, coords.x, coords.y, coords.z + offset, GetEntityHeading(ped), 0, true, true)
		else
			TaskStartScenarioInPlace(ped, anim, 0, false)
		end
	end
end

function startAnim(lib, anim, mode, obj)
	if loop.status == true then
		finishLoop(function()
			startAnim(lib, anim, mode, obj)
		end)
	else
		mode = mode or 0
		CreateThread(function()
			RequestAnimDict(lib)
			while not HasAnimDictLoaded(lib) do
				Citizen.Wait(1)
			end

			local ped = PlayerPedId()
			TaskPlayAnim(ped, lib, anim, 8.0, -8.0, -1, mode, 0, false, false, false)
			if obj then
				if type(prop) == 'table' then
					DeleteObject(prop.obj)
				end

				local coords = GetEntityCoords(ped)
				local boneIndex = GetPedBoneIndex(ped, obj.bone)
				ESX.Game.SpawnObject(obj.object, {
					x = coords.x,
					y = coords.y,
					z = coords.z + 2
				}, function(object)
					AttachEntityToEntity(object, ped, boneIndex, obj.offset.x + 0.0, obj.offset.y + 0.0, obj.offset.z + 0.0, obj.rotation.x + 0.0, obj.rotation.y + 0.0, obj.rotation.z + 0.0, true, true, false, true, 1, true)
					prop = {obj = object, lib = lib, anim = anim}
				end)
			end
		end)
	end
end

function startAnimLoop(data)
	if loop.status == true then
		finishLoop(function()
			startAnimLoop(data)
		end)
	else
		CreateThread(function()
			while loop.status ~= nil do
				Citizen.Wait(1)
			end

			RequestAnimDict(data.base.lib)
			while not HasAnimDictLoaded(data.base.lib) do
				Citizen.Wait(1)
			end

			RequestAnimDict(data.idle.lib)
			while not HasAnimDictLoaded(data.idle.lib) do
				Citizen.Wait(1)
			end

			RequestAnimDict(data.finish.lib)
			while not HasAnimDictLoaded(data.finish.lib) do
				Citizen.Wait(1)
			end

			local playerPed = PlayerPedId()
			if data.prop then
				local coords	= GetEntityCoords(playerPed)
				local boneIndex = GetPedBoneIndex(playerPed, data.prop.bone)

				ESX.Game.SpawnObject(data.prop.object, {
					x = coords.x,
					y = coords.y,
					z = coords.z + 2
				}, function(object)
					AttachEntityToEntity(object, playerPed, boneIndex, data.prop.offset.x, data.prop.offset.y, data.prop.offset.z, data.prop.rotation.x, data.prop.rotation.y, data.prop.rotation.z, true, true, false, true, 1, true)
					prop = object
				end)
			end

			TaskPlayAnim(PlayerPedId(), data.base.lib, data.base.anim, 8.0, -8.0, -1, data.mode, 0, false, false, false)
			loop = {status = true, current = nil, finish = data.finish, delay = (GetGameTimer() + 100), last = 0}

			loop.finish.mode = data.mode
			if data.prop then
				loop.dettach = data.prop.dettach
			else
				loop.dettach = false
			end

			Citizen.Wait(data.base.length)
			while loop.status do
				local rng
				repeat
					rng = math.random(0, #data.idle.anims)
				until rng ~= loop.last

				loop.delay = GetGameTimer() + 100
				loop.last = rng
				if rng == 0 then
					TaskPlayAnim(PlayerPedId(), data.base.lib, data.base.anim, 8.0, -8.0, -1, data.mode, 0, false, false, false)
					loop.current = data.base
					Citizen.Wait(data.base.length)
				else
					TaskPlayAnim(PlayerPedId(), data.idle.lib, data.idle.anims[rng][1], 8.0, -8.0, -1, data.mode, 0, false, false, false)
					loop.current = {lib = data.idle.lib, anim = data.idle.anims[rng][1]}
					Citizen.Wait(data.idle.anims[rng][2])
				end
			end
		end)
	end
end

function finishLoop(cb)
	loop.status = false
	CreateThread(function()
		TaskPlayAnim(PlayerPedId(), loop.finish.lib, loop.finish.anim, 8.0, 8.0, -1, loop.finish.mode, 0, false, false, false)

		Citizen.Wait(loop.finish.length)
		if loop.status == false and prop then
			if loop.dettach then
				DetachEntity(prop, true, false)
			else
				DeleteObject(prop)
			end

			prop = nil
		end

		loop.status = nil
		if cb then
			cb()
		end
	end)
end


function OpenAnimationsMenu()

	local elements = {}
	if not binding then
		if binds then
			table.insert(elements, {label = "Ulubione (SHIFT+1-9)", value = "binds"})
		end

		table.insert(elements, {label = "- PRZERWIJ -", value = "cancel"})
		table.insert(elements, {label = "Obywatel - Styl Chodzenia", value = "walking"})
	end
	
	for _, group in ipairs(Config.Animations) do
		if not group.resource or GetResourceState(group.resource) == 'started' then
			table.insert(elements, {label = group.label, value = group.name})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animations', {
		title    = 'Animacje',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'binds' then
			menu.close()
			OpenBindsSubMenu()
		elseif data.current.value == 'walking' then
			menu.close()
			OpenWalkMenu()
		elseif data.current.value ~= "cancel" then
			menu.close()
			OpenAnimationsSubMenu(data.current.value)
		elseif not exports['esx_policejob']:IsCuffed() and not exports['exile_trunk']:checkInTrunk() then
			clearTask()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenWalkMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Styl_chodzenia',
	{
		title    = 'Obywatel - Styl Chodzenia',
		align    = 'center',
		elements = {
		{
			label = 'Arrogant',
			value = 'move_f@arrogant@a'
		},
		{
			label = 'Casual',
			value = 'move_m@casual@a'
		},
		{
			label = 'Casual 2',
			value = 'move_m@casual@b'
		},
		{
			label = 'Casual 3',
			value = 'move_m@casual@c'
		},
		{
			label = 'Casual 4',
			value = 'move_m@casual@d'
		},
		{
			label = 'Casual 5',
			value = 'move_m@casual@e'
		},
		{
			label = 'Casual 6',
			value = 'move_m@casual@f'
		},
		{
			label = 'Confident',
			value = 'move_m@confident'
		},
		{
			label = 'Business',
			value = 'move_m@business@a'
		},
		{
			label = 'Business 2',
			value = 'move_m@business@b'
		},
		{
			label = 'Business 3',
			value = 'move_m@business@c'
		},
		{
			label = 'Femme',
			value = 'move_f@femme@'
		},
		{
			label = 'Flee',
			value = 'move_f@flee@a'
		},
		{
			label = 'Gangster',
			value = 'move_m@gangster@generic'
		},
		{
			label = 'Gangster 2',
			value = 'move_m@gangster@ng'
		},
		{
			label = 'Gangster 3',
			value = 'move_m@gangster@var_e'
		},
		{
			label = 'Gangster 4',
			value = 'move_m@gangster@var_f'
		},
		{
			label = 'Gangster 5',
			value = 'move_m@gangster@var_i'
		},
		{
			label = 'Heels',
			value = 'move_f@heels@c'
		},
		{
			label = 'Heels 2',
			value = 'move_f@heels@d'
		},
		{
			label = 'Hiking',
			value = 'move_m@hiking'
		},
		{
			label = 'Muscle',
			value = 'move_m@muscle@a'
		},
		{
			label = 'Quick',
			value = 'move_m@quick'
		},
		{
			label = 'Wide',
			value = 'move_m@bag'
		},
		{
			label = 'Scared',
			value = 'move_f@scared'
		},
		{
			label = 'Brave',
			value = 'move_m@brave'
		},
		{
			label = 'Tipsy',
			value = 'move_m@drunk@slightlydrunk'
		},
		{
			label = 'Injured',
			value = 'move_m@injured'
		},
		{
			label = 'Tough',
			value = 'move_m@tough_guy@'
		},
		{
			label = 'Sassy',
			value = 'move_m@sassy'
		},
		{
			label = 'Sad',
			value = 'move_m@sad@a'
		},
		{
			label = 'Posh',
			value = 'move_m@posh@'
		},
		{
			label = 'Alien',
			value = 'move_m@alien'
		},
		{
			label = 'Nonchalant',
			value = 'move_m@non_chalant'
		},
		{
			label = 'Hobo',
			value = 'move_m@hobo@a'
		},
		{
			label = 'Money',
			value = 'move_m@money'
		},
		{
			label = 'Swagger',
			value = 'move_m@swagger'
		},
		{
			label = 'Shady',
			value = 'move_m@shadyped@a'
		},
		{
			label = 'Man Eater',
			value = 'move_f@maneater'
		},
		{
			label = 'ChiChi',
			value = 'move_f@chichi'
		},
		{
			label = 'Default',
			value = 'default'
		}
	}
	}, function(data, menu)
		setwalkstyle(data.current.value)
		currentwalkingstyle = data.current.value
	end, function(data, menu)
		menu.close()
	end)
end

function setwalkstyle(anim)
	local playerped = PlayerPedId()

	if anim == 'default' then
		ResetPedMovementClipset(playerped)
		ResetPedWeaponMovementClipset(playerped)
		ResetPedStrafeClipset(playerped)
	else
		RequestAnimSet(anim)
		while not HasAnimSetLoaded(anim) do Citizen.Wait(1) end
		SetPedMovementClipset(playerped, anim)
		ResetPedWeaponMovementClipset(playerped)
		ResetPedStrafeClipset(playerped)
	end
end

function OpenBindsSubMenu()
	local elements = {}
	for i = 1, 9 do
		local bind = binds[i]
		if bind then
			table.insert(elements, {label = i .. ' - ' .. bind.label, value = i, assigned = true})
		else
			table.insert(elements, {label = i .. ' - PRZYPISZ', value = i, assigned = false})
		end
	end

	window = ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animations_binds', {
		title    = 'Animacje - ulubione',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		menu.close()
		window = nil

		local index = tonumber(data.current.value)
		if data.current.assigned then
			binds[index] = nil
			TriggerServerEvent('esx_animations:save', binds)
			OpenBindsSubMenu()
		else
			binding = tonumber(data.current.value)
			OpenAnimationsMenu()
		end
	end, function(data, menu)
		menu.close()
		window = nil
		OpenAnimationsMenu()
	end)
end


function OpenAnimationsSubMenu(menu)
	local title, elements = nil, {}
	for _, group in ipairs(Config.Animations) do
		if group.name == menu then
			for _, item in ipairs(group.items) do
				table.insert(elements, {label = item.label .. (item.keyword and ' <span style="font-size: 11px; color: #fff000;">/e ' .. item.keyword .. '</span>' or ''), short = item.label, type = item.type, data = item.data})
			end

			title = group.label
			break
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animations_' .. menu, {
		title    = title,
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if binding then
			menu.close()

			window = nil
			if not binds then
				binds = {}
			end

			binds[binding] = {
				label = '[' .. title .. '] ' .. data.current.short,
				type = data.current.type,
				data = data.current.data
			}
			TriggerServerEvent('esx_animations:save', binds)

			binding = nil
			OpenBindsSubMenu()
		else
			TriggerEvent('esx_animations:trigger', data.current)
		end
	end, function(data, menu)
		menu.close()
		OpenAnimationsMenu()
	end)
end

CreateThread(function()
	while not HasAnimSetLoaded("move_ped_crouched") do
		RequestAnimSet("move_ped_crouched")
		Citizen.Wait(1)
	end
end)

local GraczKuca = false

RegisterCommand('+-kucaj', function(source, args, rawCommand)
	if Ped.Available then
		DisableControlAction(0, 36, true)
		if not IsPauseMenuActive() then 
			if not IsPedInAnyVehicle(Ped.Id, false) then
				if GraczKuca == true then 
					ResetPedMovementClipset(Ped.Id, 0)
					GraczKuca = false 
				else
					SetPedMovementClipset(Ped.Id, "move_ped_crouched", 0.25)
					GraczKuca = true 
				end
			end
		end
	end
end, false)

RegisterKeyMapping('+-kucaj', 'Kucnij','keyboard', 'LCONTROL')

RegisterCommand("e",function(source, args)
	if not exports['esx_policejob']:IsCuffed() then
		local player = PlayerPedId()
	if tostring(args[1]) == nil then
		return
	else
		if tostring(args[1]) ~= nil then
            local argh = tostring(args[1])
			for _, group in ipairs(Config.Animations) do
				for _, anim in ipairs(group.items) do
					if argh == anim.keyword then
						if anim.type == 'ragdoll' then
							if IsPedInAnyVehicle(PlayerPedId(), false) then
								ragdoll = true
							end
						elseif anim.type == 'attitude' then
							if anim.data.car == true then
								if IsPedInAnyVehicle(PlayerPedId(), false) then
									startAttitude(anim.data.lib, anim.data.anim)
								end
							else
								if not IsPedInAnyVehicle(PlayerPedId(), false) then
									startAttitude(anim.data.lib, anim.data.anim)
								end
							end
						elseif anim.type == 'scenario' then
							if anim.data.car == true then
								if IsPedInAnyVehicle(PlayerPedId(), false) then
									startScenario(anim.data.anim, anim.data.offset)
								end
							else
								if not IsPedInAnyVehicle(PlayerPedId(), false) then
									startScenario(anim.data.anim, anim.data.offset)
								end
							end
						elseif anim.type == 'anim' then
							if anim.data.car == true then
								if IsPedInAnyVehicle(PlayerPedId(), false) then
									startAnim(anim.data.lib, anim.data.anim, anim.data.mode, anim.data.prop)
								end
							else
								if not IsPedInAnyVehicle(PlayerPedId(), false) then
									startAnim(anim.data.lib, anim.data.anim, anim.data.mode, anim.data.prop)
								end
							end
						elseif anim.type == 'wspolne' then
							if Ped.Available then
								local closestPlayer, distance = ESX.Game.GetClosestPlayer()
								if closestPlayer ~= nil and distance ~= -1 and distance <= 3.0 then
									TriggerServerEvent('exile_animacje:triggerAnim', anim.data.name, GetPlayerServerId(closestPlayer))
								else
									ESX.ShowNotification('~r~Brak obywatela w poblizu')
								end
							end
						else
							if not IsPedInAnyVehicle(PlayerPedId(), false) then
								startAnimLoop(anim.data)
							end
						end
					end
				end
			end
		end
	end
	end
end)

-- CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(10)

-- 		local ped = Ped.Id
-- 		if ragdoll then
-- 			SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
-- 		end

-- 		if loop.status and loop.current and loop.delay < GetGameTimer() and not IsEntityPlayingAnim(ped, loop.current.lib, loop.current.anim, 3) then
-- 			loop.status = nil
-- 			if prop and type(prop) ~= 'table' then
-- 				if loop.dettach then
-- 					DetachEntity(prop, true, false)
-- 				else
-- 					DeleteObject(prop)
-- 				end

-- 				prop = nil
-- 			end
-- 		end
-- 		if IsControlPressed(0, Keys['LEFTSHIFT']) and not IsPedSprinting(ped) and not IsPedRunning(ped) then
-- 			local bind = nil
-- 			for i, key in ipairs({157, 158, 160, 164, 165, 159, 161, 162, 163}) do
-- 				DisableControlAction(0, key, true)
-- 				if IsDisabledControlJustPressed(0, key) and binds[i] then
-- 					bind = i
-- 					break
-- 				end
-- 			end

-- 			if bind and not isDead and not exports['exile_trunk']:checkInTrunk() and not exports['esx_policejob']:IsCuffed() then
-- 				TriggerEvent('esx_animations:trigger', binds[bind])
-- 			end
-- 		elseif IsControlPressed(0, Keys['F3']) and not isDead then
-- 			OpenAnimationsMenu(PlayerPedId())
-- 		--elseif IsControlPressed(0, Keys['X']) and GetLastInputMethod(2) and not isDead then		
-- 			--clearTask()
-- 		elseif IsControlJustReleased(0, Keys['X']) and GetLastInputMethod(2) and not isDead then		
-- 			clearTask()
-- 		end

-- 	end
-- end)

CreateThread(function()
	while true do
		Citizen.Wait(1)

		local ped = PlayerPedId()
		if ragdoll then
			SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
		end

		if loop.status and loop.current and loop.delay < GetGameTimer() and not IsEntityPlayingAnim(ped, loop.current.lib, loop.current.anim, 3) then
			loop.status = nil
			if prop and type(prop) ~= 'table' then
				if loop.dettach then
					DetachEntity(prop, true, false)
				else
					DeleteObject(prop)
				end

				prop = nil
			end
		end

		if type(prop) == 'table' and not IsEntityPlayingAnim(ped, prop.lib, prop.anim, 3) then
			DeleteObject(prop.obj)
			prop = nil
		end
		
		if IsControlPressed(0, Keys['LEFTSHIFT']) and not IsPedSprinting(ped) and not IsPedRunning(ped) then
			local bind = nil
			for i, key in ipairs({157, 158, 160, 164, 165, 159, 161, 162, 163}) do
				DisableControlAction(0, key, true)
				if IsDisabledControlJustPressed(0, key) and binds[i] then
					bind = i
					break
				end
			end

			--if bind and not isDead and not exports['exile_trunk']:checkInTrunk() and not exports['esx_policejob']:IsCuffed() and not getCarry() then
			if bind and not isDead and not exports['exile_trunk']:checkInTrunk() and not exports['esx_policejob']:IsCuffed() then
				TriggerEvent('esx_animations:trigger', binds[bind])
			end
		end
		
		if IsControlJustPressed(0, Keys['F3']) and not isDead then
			OpenAnimationsMenu(PlayerPedId())
		elseif IsControlJustReleased(0, Keys['X']) and GetLastInputMethod(2) and not isDead then		
			clearTask()
		end

	end
end)

RegisterNetEvent('animacje')
AddEventHandler('animacje', function()
	OpenAnimationsMenu(PlayerPedId())
end)

function clearTask()
	if loop.status == true then
		finishLoop()
	elseif ragdoll then
		ragdoll = false
	else
		ClearPedTasks(PlayerPedId())
		if loop.status ~= nil then
			loop.status = nil
			if prop and type(prop) ~= 'table' then
				if loop.dettach then
					DetachEntity(prop, true, false)
				else
					DeleteObject(prop)
				end

				prop = nil
			end
		elseif type(prop) == 'table' then
			DeleteObject(prop.obj)
			prop = nil
		end
	end
end

local __synchro = {
	Wait = 7,
	Target = nil,
	isWaiting = false,
	Accepted = false,
	asst = nil
}

RegisterNetEvent('exile_animacje:clientreq')
AddEventHandler('exile_animacje:clientreq', function(target, animka)
	__synchro.isWaiting = true
	__synchro.Target = target
	__synchro.asst = animka
end)

CreateThread(function()
    while true do
		Citizen.Wait(70)
		if __synchro.isWaiting then
			if IsControlPressed(0, 246) and not __synchro.Accepted then
				__synchro.Accepted = true
				__synchro.isWaiting = false
				__synchro.Wait = 7
				TriggerServerEvent('exile_animacje:startAnim', __synchro.asst, __synchro.Target)
			end
		else
			Citizen.Wait(1000)
		end
    end
end)

Citizen.CreateThread(function()
	while __synchro.isWaiting do
		Citizen.Wait(1000)
		if __synchro.Wait == 0 then
			ESX.ShowNotification('~r~Anulowano propozycję animacji')
			__synchro.isWaiting = false
			__synchro.Accepted = false
			__synchro.Wait = 7
			__synchro.Target = nil
			__synchro.asst = nil
		end
		__synchro.Wait = __synchro.Wait - 1
	end
end)

RegisterNetEvent('exile_animacje:animTarget')
AddEventHandler('exile_animacje:animTarget', function(target, asst)

	local playerPed = PlayerPedId()
	local targetPed = Citizen.InvokeNative(0x43A66C31C68491C0, GetPlayerFromServerId(target))
	if asst == 'powitaj' then
		AttachEntityToEntity(PlayerPedId(), targetPed, 11816, 0.1, 1.15, 0.0, 0.0, 0.0, 180.0, false, false, false, false, 20, false)
		ESX.Streaming.RequestAnimDict("mp_ped_interaction", function()
			TaskPlayAnim(playerPed, "mp_ped_interaction", "handshake_guy_b", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif asst == 'piona' then
		AttachEntityToEntity(PlayerPedId(), targetPed, 11816, -0.05, 0.9, 0.0, 0.0, 0.0, 180.0, false, false, false, false, 20, false)
		ESX.Streaming.RequestAnimDict("mp_ped_interaction", function()
			TaskPlayAnim(playerPed, "mp_ped_interaction", "hugs_guy_a", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif asst == 'obejmij' then
		AttachEntityToEntity(PlayerPedId(), targetPed, 0, -0.2, 0.53, 0.0, 0.0, 0.0, 180.0, false, false, false, false, 20, false)
		ESX.Streaming.RequestAnimDict("misscarsteal2chad_goodbye", function()
			TaskPlayAnim(playerPed, "misscarsteal2chad_goodbye", "chad_armsaround_chad", 2.0, 2.0, -1, 0, 0, false, false, false)
		end)
	elseif asst == 'przytulas' then
		AttachEntityToEntity(PlayerPedId(), targetPed, 11816, 0.0, 1.2, 0.0, 0.0, 0.0, 180.0, false, false, false, false, 20, false)
		ESX.Streaming.RequestAnimDict("mp_ped_interaction", function()
			TaskPlayAnim(playerPed, "mp_ped_interaction", "kisses_guy_a", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif asst == 'pocaluj' then
		AttachEntityToEntity(PlayerPedId(), targetPed, 0, 0.0, 0.53, 0.0, 0.0, 0.0, 180.0, false, false, false, false, 20, false)
		ESX.Streaming.RequestAnimDict("hs3_ext-20", function()
			TaskPlayAnim(playerPed, "hs3_ext-20", "cs_lestercrest_3_dual-20", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	--NFSW
	elseif asst == 'rublud' then
		AttachEntityToEntity(PlayerPedId(), targetPed, 9816, 0.0, 0.65, 0.0, 120.0, 0.0, 180.0, false, false, false, false, 20, false)
		ESX.Streaming.RequestAnimDict("misscarsteal2pimpsex", function()
			TaskPlayAnim(playerPed, "misscarsteal2pimpsex", "pimpsex_hooker", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif asst == 'anal' then
		AttachEntityToEntity(PlayerPedId(), targetPed, 9816, 0.015, 0.35, 0.0, 0.9, 0.3, 0.0, false, false, false, false, 20, false)
		ESX.Streaming.RequestAnimDict("rcmpaparazzo_2", function()
			TaskPlayAnim(playerPed, "rcmpaparazzo_2", "shag_loop_poppy", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif asst == 'standingsex' then
		AttachEntityToEntity(PlayerPedId(), targetPed, 9816, 0.05, 0.4, 0.0, 120.0, 0.0, 180.0, false, false, false, false, 20, false)
		ESX.Streaming.RequestAnimDict("misscarsteal2pimpsex", function()
			TaskPlayAnim(playerPed, "misscarsteal2pimpsex", "shagloop_pimp", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	end
		
	Citizen.Wait(950)
	DetachEntity(PlayerPedId(), true, false)
	__synchro.isWaiting = false
	__synchro.Wait = 7
	__synchro.Target = nil
	__synchro.asst = nil
	__synchro.Accepted = false
end)

RegisterNetEvent('exile_animacje:animSource')
AddEventHandler('exile_animacje:animSource', function(animka)
	local playerPed = PlayerPedId()

	if animka == 'powitaj' then
		ESX.Streaming.RequestAnimDict("mp_ped_interaction", function()
			TaskPlayAnim(playerPed, "mp_ped_interaction", "handshake_guy_a", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif animka == 'piona' then
		ESX.Streaming.RequestAnimDict("mp_ped_interaction", function()
			TaskPlayAnim(playerPed, "mp_ped_interaction", "hugs_guy_a", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif animka == 'obejmij' then
		ESX.Streaming.RequestAnimDict("misscarsteal2chad_goodbye", function()
			TaskPlayAnim(playerPed, "misscarsteal2chad_goodbye", "chad_armsaround_girl", 2.0, 2.0, -1, 0, 0, false, false, false)
		end)
	elseif animka == 'przytulas' then
		ESX.Streaming.RequestAnimDict("mp_ped_interaction", function()
			TaskPlayAnim(playerPed, "mp_ped_interaction", "kisses_guy_b", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif animka == 'pocaluj' then
		ESX.Streaming.RequestAnimDict("hs3_ext-20", function()
			TaskPlayAnim(playerPed, "hs3_ext-20", "csb_georginacheng_dual-20", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	--NFSW
	elseif animka == 'rublud' then
		ESX.Streaming.RequestAnimDict("misscarsteal2pimpsex", function()
			TaskPlayAnim(playerPed, "misscarsteal2pimpsex", "pimpsex_punter", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif animka == 'anal' then
		ESX.Streaming.RequestAnimDict("rcmpaparazzo_2", function()
			TaskPlayAnim(playerPed, "rcmpaparazzo_2", "shag_loop_a", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	elseif animka == 'standingsex' then
		ESX.Streaming.RequestAnimDict("misscarsteal2pimpsex", function()
			TaskPlayAnim(playerPed, "misscarsteal2pimpsex", "shagloop_hooker", 8.0, -8.0, -1, 0, 0, false, false, false)
		end)
	end
end)
local lockpick = false

RegisterNetEvent('animki:lockpick')
AddEventHandler('animki:lockpick', function(rodzaj)
	if rodzaj == true then
		lockpick = true
	elseif rodzaj == false then
		lockpick = false
	end
end)