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
  
PlayerData = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPartNum             = nil
local zakuciesprawdz = false
local CurrentAction = nil
local CurrentActionMsg  = ''
local CurrentActionData = {}
local DragStatus 					= {}
local IsDragged 					= false
local IsHandcuffed = false
local HandcuffTimer = nil
local isDead = false
local CopPlayer 					= nil
local Dragging 						= nil
local CurrentTask = {}
ESX                           = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
	  
		Citizen.Wait(250)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
	
    while not HasAnimDictLoaded("random@mugging3") do
        RequestAnimDict("random@mugging3")
        Citizen.Wait(1)
    end
end)

function IsCuffed()
	return IsHandcuffed
end
  
function SetVehicleMaxMods(vehicle, livery, offroad, wheelsxd, color, extrason, extrasoff, bulletproof, tint, wheel, tuning, plate)
	local t = {
		modArmor        = 4,
		modTurbo        = true,
		modXenon        = true,
		windowTint      = 0,
		dirtLevel       = 0,
		color1			= 0,
		color2			= 0
	}
	
	if tuning then
		t.modEngine = 3
		t.modBrakes = 2
		t.modTransmission = 2
		t.modSuspension = 3
	end

	if offroad then
		t.wheelColor = 5
		t.wheels = 4
		t.modFrontWheels = 17
	end

	if wheelsxd then
		t.wheels = 1
		t.modFrontWheels = 5
	end

	if bulletproof then
		t.bulletProofTyre = true
	end

	if color then
		t.color1 = color
	end

	if tint then
		t.windowTint = tint
	end

	if wheel then
		t.wheelColor = wheel.color
		t.wheels = wheel.group
		t.modFrontWheels = wheel.type
	end
	
	ESX.Game.SetVehicleProperties(vehicle, t)

	if #extrason > 0 then
		for i=1, #extrason do
			SetVehicleExtra(vehicle, extrason[i], false)
		end
	end
	
	if #extrasoff > 0 then
		for i=1, #extrasoff do
			SetVehicleExtra(vehicle, extrasoff[i], true)
		end
	end
	  
	if livery then
		SetVehicleLivery(vehicle, livery)
	end
end
  
function cleanPlayer(playerPed)
	Citizen.InvokeNative(0xCEA04D83135264CC, playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end
  
function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end
  
function setLastUniform(clothes, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerEvent('skinchanger:loadClothes', skin, clothes)
	end)
end
  
function setArmour(value, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin['bproof_1'] ~= 0 and skin['bproof_1'] ~= 10 then
			Citizen.InvokeNative(0xCEA04D83135264CC, playerPed, value)
		else
			ESX.ShowNotification("~r~Nie masz kamizelki, która ma możliwość zaaplikowania wkładów")
		end
	end)
end
  
  
function OpenCloakroomMenu()
	ESX.UI.Menu.CloseAll()
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name
	local hasSertLicense = false

	local elements = {
		{ label = ('Ubranie cywilne'), value = 'citizen_wear' },
		{ label = ('Ubranie służbowe'), value = 'job_wear' }		
	}
  
	if PlayerData.job.name == 'police' then
		table.insert(elements, {label = 'Private', value = 'player_dressing' })
		if PlayerData.hiddenjob.name == 'sheriff' then
			table.insert(elements, {label = "Sheriff Uniforms", value = 'sheriffuniforms'})
			table.insert(elements, {label = "Combat Sheriff Uniforms", value = 'combatsheriff'})
			table.insert(elements, {label = "Sheriff Event Uniforms", value = 'addonssheriff'})
		end
		
		ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
			if hasWeaponLicense then 
				table.insert(elements, {label = "USMS Uniforms", value = 'usmsuniforms'})
			end
		end, GetPlayerServerId(PlayerId()), 'usms')
		
		ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
			if hasWeaponLicense then
				table.insert(elements, {label = "AIAD Uniforms", value = 'aiaduniforms'})
			end
		end, GetPlayerServerId(PlayerId()), 'aiad')
		
		ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
			if hasWeaponLicense then
				hasSertLicense = true
				table.insert(elements, {label = "SERT / SWAT Uniforms", value = 'sertswatuniforms'})
			end
		end, GetPlayerServerId(PlayerId()), 'sert')

		Citizen.Wait(100)
	   
		table.insert(elements, {label = "Offical Patrol Uniforms", value = 'mundury1'})
		table.insert(elements, {label = "Patrol Uniforms", value = 'mundury4'})
		table.insert(elements, {label = "Combat Patrol Uniforms", value = 'mundury2'})
		table.insert(elements, {label = "Event Uniforms", value = 'mundury3'})
		table.insert(elements, {label = "Accessories", value = 'dodatki'})
	end
  
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)
		
		if data.current.value == 'job_wear' then
			menu.close()
			
			setUniform('officer_wear', playerPed)
		end

		if data.current.value == 'mundury1' then
			local elements2 = {
				{label = "Cadet Uniform", value = 'recruit_wear'},
				{label = "Officer Uniform", value = 'officer_wear'},
				{label = "Officer Long Uniform", value = 'officer_wear2'},
				{label = "Sergeant Uniform", value = 'sergeant_wear'},
				{label = "Sergeant Long Uniform", value = 'sergeant_wear2'},
				{label = "Lieutenant Uniform", value = 'lieutenant_wear'},
				{label = "Lieutenant Long Uniform", value = 'lieutenant_wear2'},
				{label = "Captain Uniform", value = 'captain_wear'},
				{label = "Captain Long Uniform", value = 'captain_wear2'},
			}
			
			if PlayerData.job.grade_name == 'chef' or PlayerData.job.grade_name == 'chef' then
				table.insert(elements, {label = "I Mundur ACOP/DCOP", value = 'chef_wear'})
				table.insert(elements, {label = "I Mundur COP", value = 'boss_wear'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mundury1', {
				title    = "Szatnia - Mundury I",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				setUniform(data2.current.value, playerPed)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	  
		if data.current.value == 'sheriffuniforms' then
			local elements2 = {
				{label = "Probie Uniform", value = 'probie_wear'},
			}
			
			if (PlayerData.hiddenjob.grade >= 1 and PlayerData.hiddenjob.grade < 5) or PlayerData.hiddenjob.grade >= 11 then
				table.insert(elements2, {label = "Deputy Uniform", value = 'deputy_wear'})
				table.insert(elements2, {label = "Deputy Long Uniform", value = 'deputy_wear2'})
			end
			
			if (PlayerData.hiddenjob.grade >= 4 and PlayerData.hiddenjob.grade < 7) or PlayerData.hiddenjob.grade >= 11 then
				table.insert(elements2, {label = "Sergeant Uniform", value = 'sergeantsh_wear'})
				table.insert(elements2, {label = "Sergeant Long Uniform", value = 'sergeantsh_wear2'})
			end
			
			if (PlayerData.hiddenjob.grade >= 7 and PlayerData.hiddenjob.grade < 9) or PlayerData.hiddenjob.grade >= 11 then
				table.insert(elements2, {label = "Lieutenant Uniform", value = 'lieutenantsh_wear'})
				table.insert(elements2, {label = "Lieutenant Long Uniform", value = 'lieutenantsh_wear2'})
			end
			
			if (PlayerData.hiddenjob.grade >= 9 and PlayerData.hiddenjob.grade < 11) or PlayerData.hiddenjob.grade >= 11 then
				table.insert(elements2, {label = "Captain Uniform", value = 'captainsh_wear'})
				table.insert(elements2, {label = "Captain Long Uniform", value = 'captainsh_wear2'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mundury1', {
				title    = "Szatnia - Mundury Szeryfa",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				setUniform(data2.current.value, playerPed)
			end, function(data2, menu2)
				menu2.close()
			end)
		end

		if data.current.value == 'usmsuniforms' then
			local elements2 = {
				{label = "Training Uniform", value = 'usmstraining_uniform'},
				{label = "Official Uniform", value = 'usmsofficial_uniform'},
				{label = "High Command Uniform", value = 'usmshc_uniform'},
				{label = "High Command Uniform 2", value = 'usmshc2_uniform'},
				{label = "Combat Uniform", value = 'usmscombat_uniform'},
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mundury1', {
				title    = "Szatnia - Mundury USMS",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				setUniform(data2.current.value, playerPed)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
		
		if data.current.value == 'aiaduniforms' then
			local elements2 = {
				{label = "AIAD Official Uniform", value = 'aiadofficial_uniform'},
				{label = "AIAD Patrol Uniform", value = 'aiadpatrol_uniform'},
				{label = "AIAD Combat Uniform", value = 'aiadcombat_uniform'},
				{label = "AIAD Combat Uniform 2", value = 'aiadcombat2_uniform'},
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mundury5', {
				title    = "Szatnia - Mundury AIAD",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				setUniform(data2.current.value, playerPed)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
		
		if data.current.value == 'sertswatuniforms' then
			local elements2 = {
				{label = "S.E.R.T. Light Uniform", value = 'sert_wear2'},
				{label = "S.E.R.T. Long Light Uniform", value = 'sert_wear3'},
				{label = "S.E.R.T. Combat Uniform", value = 'sert_wear4'},
				{label = "S.E.R.T. Long Combat Uniform", value = 'sert_wear5'},
				{label = "S.E.R.T. Heavy Uniform", value = 'sert_wear'},
				{label = "S.W.A.T. Light Uniform", value = 'swat_wear'},
				{label = "S.W.A.T. Long Light Uniform", value = 'swat_wear2'},
				{label = "S.W.A.T. Hoodie Uniform", value = 'swat_wear6'},
				{label = "S.W.A.T. Hoodie Combat Uniform", value = 'swat_wear7'},
				{label = "S.W.A.T. Combat Uniform", value = 'swat_wear3'},
				{label = "S.W.A.T. Long Combat Uniform", value = 'swat_wear4'},
				{label = "S.W.A.T. Heavy Uniform", value = 'swat_wear5'},
				{label = "Heavy Vest", value = 'armor_sert'},
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mundury6', {
				title    = "Szatnia - SERT/SWAT",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				if data2.current.value ~= 'armor_sert' then
					setUniform(data2.current.value, playerPed)
				end
				if data2.current.value == 'armor_sert' then
					setArmour(100, playerPed)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	  
		if data.current.value == 'combatsheriff' then
			local elements2 = {}
			
			if PlayerData.hiddenjob.grade >= 5 then
				table.insert(elements2, {label = "Sheriff Combat Uniform Sergeant", value = 'sheriff_patrol2'})
			end
			
			if PlayerData.hiddenjob.grade >= 7 then
				table.insert(elements2, {label = "Sheriff Combat Uniform Lieutenant", value = 'sheriff_patrol3'})
			end
			
			if PlayerData.hiddenjob.grade >= 9 then
				table.insert(elements2, {label = "Sheriff Combat Uniform Capitan", value = 'sheriff_patrol4'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mundury2', {
				title    = "Szatnia - Bojówka Szeryfa",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				setUniform(data2.current.value, playerPed)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	  
		if data.current.value == 'mundury2' then
			local elements2 = {
				{label = "Combat Uniform Sergeant", value = 'police_patrol2'},
				{label = "Combat Uniform Lieutenant", value = 'police_patrol3'},
				{label = "Combat Uniform Capitan", value = 'police_patrol4'},
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mundury2', {
				title    = "Szatnia - Mundury II",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				setUniform(data2.current.value, playerPed)
			end, function(data2, menu2)
				menu2.close()
			end)
		end

		if data.current.value == 'mundury3' then
  
			local elements2 = {
				{label = "Official Uniform", value = 'oficjalny_wear'},
				{label = "Motorcycle Uniform", value = 'motocykl_wear'},
				{label = "K-9 Uniform", value = 'k9_wear'},
			}

			ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
				if hasWeaponLicense then
					table.insert(elements2, {label = "Diver Uniform", value = 'nurek_wear'})
				end
				
				if PlayerData.hiddenjob.name == 'sheriff' then
					table.insert(elements2, {label = "Sheriff Official Uniform", value = 'sheriff_official'})
					table.insert(elements2, {label = "Sheriff Motorcycle Uniform", value = 'motocyklsheriff_wear'})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mundury3', {
					title    = "Szatnia - Mundury sytuacyjne",
					align    = 'right',
					elements = elements2
				}, function(data2, menu2)
					setUniform(data2.current.value, playerPed)
				end, function(data2, menu2)
					menu2.close()
				end)		
			end, GetPlayerServerId(PlayerId()), 'nurek')
		end

		if data.current.value == 'mundury4' then

			local elements2 = {
				{label = "K-9 Deszczowy", value = 'Deszczowy7'},
				{label = "Deszczowy", value = 'Deszczowy8'},
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mundury4', {
				title    = "Szatnia - Mundury sytuacyjne",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				setUniform(data2.current.value, playerPed)
			end, function(data2, menu2)
				menu2.close()
			end)
	  end

	  if data.current.value == 'addonssheriff' then
			local elements2 = {
				{label = "VEST - SASD", value = 's_vest'},				
				{label = "Armor", value = 'armour'}
			}
		  
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dodatki', {
				title    = "Szatnia - Dodatki",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				if data2.current.value == 'armour' then
					setArmour(75, playerPed)
				else
					setUniform(data2.current.value, playerPed)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end

		if data.current.value == 'dodatki' then
			local elements2 = {
				{label = "VEST Bulletproof", value = 'bullet_wear'},
				{label = "VEST Reflective", value = 'gilet_wear'},
				{label = "SASP BAG", value = 'torba_wear'},
				{label = "Armor", value = 'armour'}
			}
		  
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dodatki', {
				title    = "Szatnia - Dodatki",
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				if data2.current.value == 'armour' then
					setArmour(75, playerPed)
				else
					setUniform(data2.current.value, playerPed)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end

		if data.current.value == 'player_dressing' then
			ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
					title    = "Garderoba prywatna",
					align    = 'right',
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
		end
	  
		if data.current.value == 'citizen_wear' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end

		if
			data.current.value == 'recruit_wear' or
			data.current.value == 'recruitszeryf_wear' or
			data.current.value == 'officer_wear' or
			data.current.value == 'officer_wear2' or
			data.current.value == 'officerszeryf_wear' or
			data.current.value == 'sergeant_wear' or
			data.current.value == 'sergeant_wear2' or
			data.current.value == 'sergeantszeryf_wear' or
			data.current.value == 'intendent_wear' or
			data.current.value == 'intendent_wear2' or
			data.current.value == 'intendentszeryf_wear' or
			data.current.value == 'lieutenant_wear' or
			data.current.value == 'lieutenant_wear2' or
			data.current.value == 'lieutenantszeryf_wear' or
			data.current.value == 'captain_wear' or
			data.current.value == 'captain_wear2' or
			data.current.value == 'chef_wear' or
			data.current.value == 'chefszeryf_wear' or
			data.current.value == 'boss_wear' or
			data.current.value == 'bossszeryf_wear' or
			data.current.value == 'sert_wear' or
			data.current.value == 'k9_wear' or
			data.current.value == 'police_patrol2' or
			data.current.value == 'police_patrol3' or
			data.current.value == 'oficjalny_wear' or
			data.current.value == 'motocykl_wear' or
			data.current.value == 'motocyklsheriff_wear' or
			data.current.value == 'nurek_wear' or
			data.current.value == 'sert2_wear' or
			data.current.value == 'bullet_wear' or
			data.current.value == 'bullet2_wear' or
			data.current.value == 'torba_wear' or
			data.current.value == 'gilet_wear' or
			data.current.value == 'gilet2_wear'
		then
			setUniform(data.current.value, playerPed)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end
  
function OpenVehicleSpawnerMenu(partNum)
	local vehicles = Config.PoliceStations.Vehicles
	
	ESX.UI.Menu.CloseAll()
	local elements = {}
	local found = true
	
	for i, group in ipairs(Config.VehicleGroups) do
		local elements2 = {}
		
		for _, vehicle in ipairs(Config.AuthorizedVehicles) do
			local let = false
			for _, group in ipairs(vehicle.groups) do
				if group == i then
					let = true
					break
				end
			end

			if let then
				if vehicle.grade then
					if vehicle.hidden == true then
						if i ~= 5 then
							if not CanPlayerUseHidden(vehicle.grade) then
								let = false
							end
						else
							if not CanPlayerUseHidden(vehicle.grade) and not CanPlayerUse(vehicle.grade) then
								let = false
							end
						end
					else
						if not CanPlayerUse(vehicle.grade) then
							let = false
						end
					end
				elseif vehicle.grades and #vehicle.grades > 0 then
					let = false
					for _, grade in ipairs(vehicle.grades) do
						if ((vehicle.swat and IsSWAT) or grade == PlayerData.job.grade) and (not vehicle.label:find('SEU') or IsSEU) then
							let = true
							break
						end
					end
				end

				if let then
					table.insert(elements2, { label = vehicle.label, model = vehicle.model, livery = vehicle.livery, extrason = vehicle.extrason, extrasoff = vehicle.extrasoff, offroad = vehicle.offroad, wheelsxd = vehicle.wheelsxd, color = vehicle.color, plate = vehicle.plate, tint = vehicle.tint, bulletproof = vehicle.bulletproof, wheel = vehicle.wheel, tuning = vehicle.tuning })
				end
			end
		end
			
		if (PlayerData.job.name == 'police' and PlayerData.job.grade >= 12) or (PlayerData.hiddenjob.name == 'sheriff' and PlayerData.hiddenjob.grade >= 11) then
			if #elements2 > 0 then
				table.insert(elements, {label = group, value = elements2, group = i})				
			end
		else
			if i == 5 then
				found = false
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
					if hasWeaponLicense then
						table.insert(elements, { label = group, value = elements2, group = i })
					end
					
					found = true
				end, GetPlayerServerId(PlayerId()), 'seu')
			elseif i == 6 then
				found = false
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
					if hasWeaponLicense then
						table.insert(elements, { label = group, value = elements2, group = i })
					end
					
					found = true
				end, GetPlayerServerId(PlayerId()), 'dtu')
			elseif i == 7 then
				found = false
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
					if hasWeaponLicense then
						table.insert(elements, { label = group, value = elements2, group = i })
					end
					
					found = true
				end, GetPlayerServerId(PlayerId()), 'sert')
			elseif i == 8 then
				if PlayerData.hiddenjob.name == 'sheriff' then
					table.insert(elements, { label = group, value = elements2, group = i })
				end
			elseif i == 9 then
				found = false
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
					if hasWeaponLicense then
						table.insert(elements, { label = group, value = elements2, group = i })
					end
					
					found = true
				end, GetPlayerServerId(PlayerId()), 'usms')
			elseif i == 10 then
				if PlayerData.hiddenjob.name == 'hwp' then
					table.insert(elements, { label = group, value = elements2, group = i })
				end
			elseif i == 11 then
				if PlayerData.hiddenjob.name == 'hwp' then
					table.insert(elements, { label = group, value = elements2, group = i })
				end
			else
				table.insert(elements, { label = group, value = elements2, group = i })
			end
		end
	end
	
	while not found do
		Citizen.Wait(100)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
	  title    = _U('vehicle_menu'),
	  align    = 'right',
	  elements = elements
	}, function(data, menu)
		menu.close()
		if type(data.current.value) == 'table' and #data.current.value > 0 then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner_' .. data.current.group, {
				title    = data.current.label,
				align    = 'right',
				elements = data.current.value
			}, function(data2, menu2)
				local livery = data2.current.livery
				local extrason = data2.current.extrason
				local extrasoff = data2.current.extrasoff
				local offroad = data2.current.offroad
				local wheelsxd = data2.current.wheelsxd
				local color = data2.current.color
				local bulletproof = data2.current.bulletproof or false
				local tint = data2.current.tint
				local wheel = data2.current.wheel
				local tuning = data2.current.tuning

				local setPlate = true
				if data2.current.plate ~= nil and not data2.current.plate then
					setPlate = false
				end

				local vehicle = GetClosestVehicle(vehicles[partNum].spawnPoint.x,  vehicles[partNum].spawnPoint.y,  vehicles[partNum].spawnPoint.z, 3.0, 0, 71)
				if not DoesEntityExist(vehicle) then
					local playerPed = PlayerPedId()
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data2.current.model, {
							x = vehicles[partNum].spawnPoint.x,
							y = vehicles[partNum].spawnPoint.y,
							z = vehicles[partNum].spawnPoint.z
						}, vehicles[partNum].heading, function(vehicle)
							SetVehicleMaxMods(vehicle, livery, offroad, wheelsxd, color, data2.current.extrason, data2.current.extrasoff, bulletproof, tint, wheel, tuning)
							
							if setPlate then
								local plate = ""
								if data.current.label == 'UNMARKED' then
									plate = math.random(100, 999) .. "UM" .. math.random(100, 999)
								elseif data.current.label == 'HP UNMARKED' then
									plate = math.random(100, 999) .. "UM" .. math.random(100, 999)
								elseif PlayerData.hiddenjob.name == 'sheriff' then
									plate = "SASD " .. math.random(100,999)
								elseif PlayerData.hiddenjob.name == 'hwp' then
									plate = "SAHP " .. math.random(100,999)
								else
									plate = "SASP " .. math.random(100,999)
								end
								
								SetVehicleNumberPlateText(vehicle, plate)
								local localVehPlate = GetVehicleNumberPlateText(vehicle)
								TriggerEvent("ls:newVehicle", vehicle, localVehPlate, false)
								TriggerServerEvent("ls:addOwner", localVehPlate)
							else
								local localVehPlate = GetVehicleNumberPlateText(vehicle)
								TriggerEvent("ls:newVehicle", vehicle, localVehPlate, false)
								TriggerServerEvent("ls:addOwner", localVehPlate)
							end

							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						end)
					else
						ESX.Game.SpawnVehicle(data2.current.model, {
							x = vehicles[partNum].spawnPoint.x,
							y = vehicles[partNum].spawnPoint.y,
							z = vehicles[partNum].spawnPoint.z
						}, vehicles[partNum].heading, function(vehicle)
							SetVehicleMaxMods(vehicle, livery, offroad, wheelsxd, color, data2.current.extrason, data2.current.extrasoff, bulletproof, tint, wheel, tuning)
						 
							if setPlate then
								local plate = ""
								
								if data.current.label == 'UNMARKED' then
									plate = math.random(100, 999) .. "UM" .. math.random(100, 999)
								elseif PlayerData.hiddenjob.name == 'sheriff' then
									plate = "SASD " .. math.random(100,999)
								else
									plate = "SASP " .. math.random(100,999)
								end
								
								SetVehicleNumberPlateText(vehicle, plate)
								local localVehPlate = GetVehicleNumberPlateText(vehicle)
								TriggerEvent("ls:newVehicle", vehicle, localVehPlate, false)
								TriggerServerEvent("ls:addOwner", localVehPlate)
							else
								local localVehPlate = GetVehicleNumberPlateText(vehicle)
								TriggerEvent("ls:newVehicle", vehicle, localVehPlate, false)
								TriggerServerEvent("ls:addOwner", localVehPlate)
							end

							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						end)
					end
				else
					ESX.ShowNotification('Pojazd znaduje się w miejscu wyciągnięcia następnego')
				end
			end, function(data2, menu2)
				menu.close()
				OpenVehicleSpawnerMenu(partNum)
			end)
		else
			ESX.ShowNotification("~r~Brak pojazdów w tej kategorii")
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	end)
end
  
  
function OpenLodzieSpawnerMenu(partNum)
	local lodzie = Config.PoliceStations.Lodzie
	ESX.UI.Menu.CloseAll()
	
	local elements = {}
	for i, group in ipairs(Config.LodzieGroups) do
		if (i ~= 10 and i ~= 6) or (i == 10 and IsSheriff) or (i == 6 and IsSEU) then
			local elements2 = {}
			for _, lodz in ipairs(Config.AuthorizedLodzie) do
				local let = false
				for _, group in ipairs(lodz.groups) do
					if group == i then
						let = true
						break
					end
				end

				if let then
					if lodz.grade then
						if not CanPlayerUse(lodz.grade) or (lodz.label:find('SEU') and not IsSEU) then
							let = false
						end
					elseif lodz.grades and #lodz.grades > 0 then
						let = false
						for _, grade in ipairs(lodz.grades) do
							if ((lodz.swat and IsSWAT) or grade == PlayerData.job.grade) and (not lodz.label:find('SEU') or IsSEU) then
								let = true
								break
							end
						end
					end

					if let then
						table.insert(elements2, { label = lodz.label, model = lodz.model, livery = lodz.livery, offroad = lodz.offroad, wheelsxd = lodz.wheelsxd, color = lodz.color, extrason = lodz.extrason, extrasoff = lodz.extrasoff, plate = lodz.plate, tint = lodz.tint, bulletproof = lodz.bulletproof, wheel = lodz.wheel, tuning = lodz.tuning })
					end
				end
			end

			if #elements2 > 0 then
				table.insert(elements, { label = group, value = elements2, group = i })
			end
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lodzie_spawner', {
		title    = _U('lodzie_menu'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		menu.close()
		if type(data.current.value) == 'table' and #data.current.value > 0 then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lodzie_spawner_' .. data.current.group, {
				title    = data.current.label,
				align    = 'right',
				elements = data.current.value
			}, function(data2, menu2)
					local livery = data2.current.livery
					local offroad = data2.current.offroad
					local wheelsxd = data2.current.wheelsxd
					local color = data2.current.color
					local extrason = data2.current.extrason
					local extrasoff = data2.current.extrasoff
					local bulletproof = data2.current.bulletproof or false
					local tint = data2.current.tint
					local wheel = data2.current.wheel
					local tuning = data2.current.tuning

					local setPlate = true
					if data2.current.plate ~= nil and not data2.current.plate then
						setPlate = false
					end

					local lodz = GetClosestVehicle(lodzie[partNum].spawnPoint.x,  lodzie[partNum].spawnPoint.y,  lodzie[partNum].spawnPoint.z, 3.0, 0, 71)
					if not DoesEntityExist(lodz) then
						local playerPed = PlayerPedId()

						ESX.Game.SpawnVehicle(data2.current.model, {
							x = lodzie[partNum].spawnPoint.x,
							y = lodzie[partNum].spawnPoint.y,
							z = lodzie[partNum].spawnPoint.z
						}, lodzie[partNum].heading, function(lodz)
							SetVehicleMaxMods(lodz, livery, offroad, wheelsxd, color, extrason, extrasoff, bulletproof, tint, wheel, tuning)
							
							if setPlate then
								if data.current.label == 'UNMARKED' then
									plate = math.random(100, 999) .. "UM" .. math.random(100, 999)
								elseif PlayerData.hiddenjob.name == 'sheriff' then
									plate = "SASD " .. math.random(100,999)
								else
									plate = "SASP " .. math.random(100,999)
								end
								
								SetVehicleNumberPlateText(lodz, plate)
								local localVehPlate = GetVehicleNumberPlateText(lodz)
								TriggerEvent("ls:newVehicle", lodz, localVehPlate, false)
								TriggerServerEvent("ls:addOwner", localVehPlate)
							else
								local localVehPlate = GetVehicleNumberPlateText(lodz)
								TriggerEvent("ls:newVehicle", lodz, localVehPlate, false)
								TriggerServerEvent("ls:addOwner", localVehPlate)
							end

							TaskWarpPedIntoVehicle(playerPed,  lodz,  -1)
						end)
					else
						ESX.ShowNotification('Pojazd znaduje się w miejscu wyciągnięcia następnego')
					end
			end, function(data2, menu2)
				menu.close()
				OpenLodzieSpawnerMenu(partNum)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_lodzie_spawner'
		CurrentActionMsg  = _U('lodzie_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	end)
end

function HandcuffMenu()
	ESX.UI.Menu.CloseAll()
	  
	local elements = {}
	if PlayerData.job.name == 'police' then
		table.insert(elements, {label = "Zakuj/Rozkuj",      value = 'handcuff'})
		table.insert(elements, {label = "Zakuj/Rozkuj Agresywnie", value = 'agresivehandcuff'})				
	else
		table.insert(elements, {label = "Zakuj/Rozkuj",      value = 'handcuff'})
	end
	
	table.insert(elements, {label = "Przenieś",      value = 'drag'})
	table.insert(elements, {label = "Przeszukaj",    value = 'body_search'})
	--table.insert(elements, {label = "Ściągnij/Załóż ubrania",	value = 'clothes'})
	table.insert(elements, {label = "Włóż do pojazdu",  value = 'put_in_vehicle'})
	table.insert(elements, {label = "Wyciągnij z pojazdu", value = 'out_the_vehicle'})
	table.insert(elements, {label = "Włóż do bagażnika",	value = 'bagol1'})
	table.insert(elements, {label = "Wyciągnij z bagażnika",	value = 'bagol2'})
	
	if PlayerData.job.name == 'police' then
		table.insert(elements, {label = _U('licencja'), value = 'license1'})
		table.insert(elements, {label = _U('GSR-test'), value = 'gsr'})
		table.insert(elements, {label = _U('license_check'), value = 'license' })
		--table.insert(elements, {label = "Załóż/zdejmij nadajnik GPS", value = 'nadajnik'})
	end
  
	table.insert(elements, {label = "Sprawdź dokumenty",      value = 'identity_card'})
	
	ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'citizen_interaction', {
		title    = "Kajdanki",
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			local action = data.current.value
			local targetPed = Citizen.InvokeNative(0x43A66C31C68491C0, closestPlayer)
			local hasAnim1 = IsEntityPlayingAnim(targetPed, "missminuteman_1ig_2", "handsup_enter", 3)
			local hasAnim2 = IsEntityPlayingAnim(targetPed, "random@arrests@busted", "enter", 3)
			local hasAnimrece = IsEntityPlayingAnim(targetPed, "random@mugging3", "handsup_standing_base", 3)

			if action == 'identity_card' then
				if IsPedCuffed(targetPed) then
					exports["exile_taskbar"]:taskBar(1000, "Szukanie dokumentow", false, true)					
					TriggerServerEvent('ExileRP:Dowod1', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification('~r~Musisz najpierw zakuć obywatela!')
				end
			elseif action == 'agresivehandcuff' then
				
				if not IsPedCuffed(targetPed) then
					local target, distance = ESX.Game.GetClosestPlayer()
					
					local playerheading = GetEntityHeading(PlayerPedId())
					local playerlocation = GetEntityForwardVector(PlayerPedId())
					local playerCoords = GetEntityCoords(PlayerPedId())
					
					local target_id = GetPlayerServerId(target)
					if distance <= 2.0 then
						zakuciesprawdz = true
	
						TriggerServerEvent('esx_policejob:requestarrest', target_id, playerheading, playerCoords, playerlocation)
						exports["exile_taskbar"]:taskBar(4000, "Zakuwanie", false, true)
						TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), '~o~Zostałeś/aś zakuty przez ~g~[' ..GetPlayerServerId(PlayerId())..']')
						ESX.ShowNotification('~o~Zakułeś ~g~[' .. GetPlayerServerId(closestPlayer) ..']')
					else
						ESX.ShowNotification("~r~Brak osób w pobliżu")
					end				
				else
					local target, distance = ESX.Game.GetClosestPlayer()
					
					local playerheading = GetEntityHeading(PlayerPedId())
					local playerlocation = GetEntityForwardVector(PlayerPedId())
					local playerCoords = GetEntityCoords(PlayerPedId())
					
					local target_id = GetPlayerServerId(target)
					if distance <= 2.0 then
						zakuciesprawdz = false
						TriggerServerEvent('esx_policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
						exports["exile_taskbar"]:taskBar(6000, "Odkuwanie", false, true)
						TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), '~o~Zostałeś/aś rozkuty przez ~g~[' ..GetPlayerServerId(PlayerId())..']')
						ESX.ShowNotification('~o~Odkułeś ~g~[' .. GetPlayerServerId(closestPlayer) ..']')
					else
						ESX.ShowNotification("~r~Brak osób w pobliżu")
					end				
				end
				
			elseif action == 'handcuff' then
			--	if not exports['esx_property']:isProperty() then
					Citizen.InvokeNative(0xBC045625, targetPed)
					animacjazakuciarozkuciaxd()
					exports["exile_taskbar"]:taskBar(1000, "Zakuwanie/Odkuwanie", false, true)
					TriggerServerEvent('esx_policejob:handcuffhype', GetPlayerServerId(closestPlayer))
					TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), '~o~Zostałeś/aś zakuty przez ~g~[' ..GetPlayerServerId(PlayerId())..']')
					ESX.ShowNotification('~o~Zakułeś/Odkułeś ~g~[' .. GetPlayerServerId(closestPlayer) ..']')
			--	end
			elseif action == 'body_search' then
				if IsPedCuffed(targetPed) then
					if IsPedCuffed(targetPed) or hasAnim1 or hasAnim2 and not IsPlayerDead(closestPlayer) then
						Citizen.Wait(1)
						TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), '~o~Jesteś przeszukiwany przez ~g~[' ..GetPlayerServerId(PlayerId())..']')
						ESX.ShowNotification('~o~Przeszukujesz ~g~[' .. GetPlayerServerId(closestPlayer) ..']')
						TriggerEvent('esx_jobpolice:playAnim', 'anim@gangops@facility@servers@bodysearch@', 'player_search')
						exports["exile_taskbar"]:taskBar(2000, "Przeszukiwanie", false, true)
						OpenBodySearchMenu(closestPlayer)
					end
				end
			elseif action == 'drag' then
				if not Dragging then
					if IsPedCuffed(targetPed) then
						exports["exile_taskbar"]:taskBar(1000, "Łapanie/Puszczanie", false, true)
						TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
					end
				else
					exports["exile_taskbar"]:taskBar(1000, "Łapanie/Puszczanie", false, true)
					TriggerServerEvent('esx_policejob:drag', Dragging)
				end
			elseif action == 'put_in_vehicle' then
				if IsPedCuffed(targetPed) then
					exports["exile_taskbar"]:taskBar(1000, "Wkładzanie do pojazdu", false, true)
					if Dragging then
						TriggerServerEvent('esx_policejob:drag', Dragging)
					end
								
					TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
				end
			elseif action == 'out_the_vehicle' then
				if IsPedCuffed(targetPed) then
					exports["exile_taskbar"]:taskBar(1000, "Wyciąganie z pojazdu", false, true)
					TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
				end
			elseif action == 'bagol1' then
				if IsPedCuffed(targetPed) then
					exports["exile_taskbar"]:taskBar(1000, "Wkładzanie do bagażnika", false, true)
					if Dragging then
						TriggerServerEvent('esx_policejob:drag', Dragging)
					end
								
					TriggerServerEvent('exile:putTargetInTrunk', GetPlayerServerId(closestPlayer))
				end
			elseif action == 'bagol2' then
				if IsPedCuffed(targetPed) then
					exports["exile_taskbar"]:taskBar(1000, "Wyciąganie z bagażnika", false, true)
					TriggerServerEvent('exile:outTargetFromTrunk', GetPlayerServerId(closestPlayer))
				end
			elseif action == 'clothes' then
			
				if IsPedCuffed(targetPed) then
					menu.close()
				  
					local elements2 = {
						{label = 'Maska', value = 'mask'},
						{label = 'Czapka / Hełm', value = 'hat'},
						{label = 'Okulary', value = 'glasses'},
						{label = 'Łańcuch / Krawat / Plakietka', value = 'chain'},
						{label = 'Lewa ręka / Zegarek', value = 'zegarek'},
						{label = 'Prawa ręka', value = 'branzoleta'},
						{label = 'Tułów', value = 'coat'},
						{label = 'Nogi', value = 'legs'},
						{label = 'Stopy', value = 'shoes'},
						{label = 'Torba / Plecak', value = 'bag'},
						{label = 'Kamizelka', value = 'kamizelka'},
					}

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_clothes', {
						title    = 'Kajdanki - Ubrania',
						align    = 'center',
						elements = elements2
					}, function(data2, menu2)
						if data2.current.value ~= nil then
							TriggerServerEvent('esx_ciuchy:takeoff', data2.current.value, GetPlayerServerId(closestPlayer))
						end
					end, function(data2, menu2)
						menu2.close()
						menu.open()
					end)
				end
				
			elseif action == 'license' then
				if IsPedCuffed(targetPed) then
					ShowPlayerLicense(closestPlayer)
				else
					ESX.ShowNotification("~r~Musisz najpierw zakuć obywatela!")
				end
			elseif action == 'unpaid_bills' then
				if IsPedCuffed(targetPed) then
					OpenUnpaidBillsMenu(closestPlayer)
				else
					ESX.ShowNotification("~r~Musisz najpierw zakuć obywatela!")
				end
			elseif action == 'license1' then
				if IsPedCuffed(targetPed) then
					TriggerServerEvent('esx_policejob:DajLicencjexd', GetPlayerServerId(closestPlayer))
					TriggerServerEvent('esx_policejob:message',  GetPlayerServerId(closestPlayer), '~o~Otrzymałeś licencję na broń od ~g~[' ..GetPlayerServerId(PlayerId()).. ']')
					ESX.ShowNotification('~o~Nadano licencję na broń dla ~g~[' ..GetPlayerServerId(closestPlayer).. ']')
				else
					ESX.ShowNotification("~r~Musisz najpierw zakuć obywatela!")
				end
			elseif action == 'gsr' then
			
				TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), "~y~Funkcjonariusz~w~ sprawdza ~b~proch~w~ na Twoich dłoniach")
				ESX.ShowNotification("Sprawdzanie dłoni pod kątem prochu...")
				
				TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
				exports["exile_taskbar"]:taskBar(5000, "Sprawdzanie prochu", false, true)

				if DecorExistOn(Citizen.InvokeNative(0x43A66C31C68491C0, closestPlayer), 'Gunpowder') then
					ESX.ShowNotification("~r~Wykryto proch na dłoniach!")
				else
					ESX.ShowNotification("~g~Nie wykryto prochu na dłoniach.")
				end
				
			elseif action == 'nadajnik' then
				if IsPedCuffed(targetPed) then
					ESX.TriggerServerCallback('exile_gps:checkHasGPS', function(cb)
						if cb.has == true then
							exports["exile_taskbar"]:taskBar(6000, "Zdejmowanie nadajnika", false, true)
							ESX.ShowNotification("Ściągasz ~r~nadajnik GPS~w~ dla ~y~" .. cb.firstname .. " " .. cb.lastname)
							TriggerServerEvent('exile_gps:opaska', false, cb)
						else
							exports["exile_taskbar"]:taskBar(6000, "Zakładanie nadajnika", false, true)
							ESX.ShowNotification("Zakładasz ~r~nadajnik GPS~w~ dla ~y~" .. cb.firstname .. " " .. cb.lastname)
							TriggerServerEvent('exile_gps:opaska', true, cb)
						end
					end, GetPlayerServerId(closestPlayer))
				end
			end
		else
			ESX.ShowNotification(_U('no_players_nearby'))
		end
	end, function(data, menu)
		menu.close()
	end)
end

function CanPlayerUseHidden(grade)
	return not grade or PlayerData.hiddenjob.grade >= grade
end

function CanPlayerUse(grade)
	return not grade or PlayerData.job.grade >= grade
end

local hasOdblask = false
local skinOdblask = {}
local hasRekawiczki = false
local skinRekawiczki = {}

  
RegisterNetEvent('esx_jobpolice:playAnim')
AddEventHandler('esx_jobpolice:playAnim', function(dict, anim)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, -1, 49, 0, false, false, false)
end)

RegisterNetEvent('esx_policejob:getarrested')
AddEventHandler('esx_policejob:getarrested', function(playerheading, playercoords, playerlocation)	
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()
	
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
--	TriggerEvent('esx_policejob:handcuff')
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	
	CreateThread(function()
		if IsHandcuffed then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if not exports['exile_trunk']:checkInTrunk() then
				RequestAnimDict('mp_arresting')
				while not HasAnimDictLoaded('mp_arresting') do
					Citizen.Wait(1)
				end

				if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8.0, -1, 49, 0.0, 0, 0, 0)
				end
			end
			
			ESX.UI.Menu.CloseAll()
			-- TriggerEvent('radar:setHidden', true)
			TriggerEvent('carhud:display', false)
			
			SetEnableHandcuffs(playerPed, true)
			
			SetPedCanPlayGestureAnims(playerPed, false)
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "zakuj", 0.5)
			
			StartHandcuffTimer()
		else
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "odkuj", 0.5)
			Citizen.InvokeNative(0xAAA34F8A7CB32098, playerPed)
			if Config.EnableHandcuffTimer and HandcuffTimer then
				ESX.ClearTimeout(HandcuffTimer)
			end

			SetEnableHandcuffs(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			-- TriggerEvent('radar:setHidden', false)
			TriggerEvent('carhud:display', true)

			FreezeEntityPosition(playerPed, false)
			
			if exports['exile_trunk']:checkInTrunk() then
				TaskPlayAnim(playerPed, "fin_ext_p1-7", "cs_devin_dual-7", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
			end
		end
	end)
end)

RegisterNetEvent('esx_policejob:doarrested')
AddEventHandler('esx_policejob:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
end) 

RegisterNetEvent('esx_policejob:douncuffing')
AddEventHandler('esx_policejob:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('esx_policejob:getuncuffed')
AddEventHandler('esx_policejob:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = false
	--TriggerEvent('esx_policejob:unrestrain')
	ClearPedTasks(PlayerPedId())
end)

function OpenPoliceActionsMenu()
	ESX.UI.Menu.CloseAll()
	local playerPed = PlayerPedId()
	
	local elements = {
		{label = "Interakcje z obywatelem",	value = 'citizen_interaction'},
		{label = "Interakcje z pojazdem", value = 'vehicle_interaction'},
	}
	
	if PlayerData.job.name == 'police' then
		table.insert(elements, {label = "Interakcje z obiektami", value = 'object_spawner'})
		table.insert(elements, {label = 'Wyciągnij lornetkę', value = 'lorneta'})
		table.insert(elements, {label = 'Załóż/zdejmij kamizelkę odblaskową', value = 'odblask'})
		table.insert(elements, {label = 'Załóż/zdejmij rękawiczki lateksowe', value = 'rekawiczki'})
	end
  
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		title    = 'Police',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'odblask' then
			if hasOdblask then
				setLastUniform(skinOdblask, playerPed)
				hasOdblask = false
			else
				TriggerEvent('skinchanger:getSkin', function(skin)
					skinOdblask = skin
					setUniform('odblask_wear', playerPed)
					hasOdblask = true
				end)
			end
		elseif data.current.value == 'rekawiczki' then
			if hasRekawiczki then
				setLastUniform(skinRekawiczki, playerPed)
				hasRekawiczki = false
			else
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin['torso_1'] == 31 then
						skinRekawiczki = skin
						setUniform('rekawiczki1_wear', playerPed)
						hasRekawiczki = true
					elseif skin['torso_1'] == 32 then
						skinRekawiczki = skin
						setUniform('rekawiczki2_wear', playerPed)
						hasRekawiczki = true
					else
						ESX.ShowNotification("~r~Nie masz przy sobie rękawiczek")
					end
				end)
			end
		elseif data.current.value == 'lorneta' then
			TriggerEvent('exile_lorneta:lornetaon')
			ESX.ShowNotification("~g~Użyłeś lornetki!")
			menu.close()
		elseif data.current.value == 'citizen_interaction' then
			HandcuffMenu()
		elseif data.current.value == 'vehicle_interaction' then
			local elements2  = {}
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
	
			if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
				if not IsPedInAnyVehicle(playerPed, false) then
					table.insert(elements2, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
					table.insert(elements2, {label = "Napraw pojazd", value = 'fix_vehicle'})
				  
					if PlayerData.job.name == 'police' then
						table.insert(elements2, {label = "Odholuj pojazd",			value = 'impound'})
						table.insert(elements2, {label = "Zajmij pojazd na parking policyjny",		value = 'impoundpd'})						
					end
				end
			end
		  
			table.insert(elements2, {label = ('Wyszukiwanie w bazie danych'), value = 'search_database'})
		  
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				title    = _U('vehicle_interaction'),
				align    = 'right',
				elements = elements2
			}, function(data2, menu2)
				local action    = data2.current.value
				if action == 'search_database' or IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
					local vehicle = nil

					if action == 'search_database' then
					--
					elseif IsPedInAnyVehicle(playerPed, false) then
						vehicle = GetVehiclePedIsIn(playerPed, false)
					else
						vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
					end
				  
					if action == 'search_database' then
						LookupVehicle()
					elseif DoesEntityExist(vehicle) then
						if action == 'hijack_vehicle' then
							if(not IsPedInAnyVehicle(playerPed)) then
								TriggerEvent('esx_policejob:onHijack')
							end
						elseif action == 'fix_vehicle' then
							if(not IsPedInAnyVehicle(playerPed)) then
								menu.close()
								exports['esx_mechanikjob']:RepairEngine()
							end
						elseif action == 'impound' then
							if CurrentTask.Busy then
								return
							end

							SetTextComponentFormat('STRING')
							AddTextComponentString('Naciśnij ~INPUT_CONTEXT~ żeby unieważnić ~y~zajęcie~s~')
							DisplayHelpTextFromStringLabel(0, 0, 1, -1)
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

							CurrentTask.Busy = true
							CurrentTask.Task = ESX.SetTimeout(10000, function()
								ClearPedTasks(playerPed)
								ImpoundVehicle(vehicle)

								CurrentTask.Busy = false
								Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
							end)

							CreateThread(function()
								while CurrentTask.Busy do
									Citizen.Wait(1000)

									vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
									if not DoesEntityExist(vehicle) and CurrentTask.Busy then
										ESX.ShowNotification('~r~Zajęcie zostało anulowane, ponieważ pojazd przemieścił się')
										ESX.ClearTimeout(CurrentTask.Task)

										ClearPedTasks(playerPed)
										CurrentTask.Busy = false
										break
									end
								end
							end)
						elseif action == 'impoundpd' then
							if CurrentTask.Busy then
								return
							end

							SetTextComponentFormat('STRING')
							AddTextComponentString('Naciśnij ~INPUT_CONTEXT~ żeby unieważnić ~y~zajęcie na parking policyjny~s~')
							DisplayHelpTextFromStringLabel(0, 0, 1, -1)
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

							CurrentTask.Busy = true
							CurrentTask.Task = ESX.SetTimeout(10000, function()
								ClearPedTasks(playerPed)
								TriggerEvent("esx_impound", 'cos', 'cos')

								CurrentTask.Busy = false
								Citizen.Wait(100)
							end)

							-- keep track of that vehicle!
							CreateThread(function()
								while CurrentTask.Busy do
									Citizen.Wait(1000)

									vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
									if not DoesEntityExist(vehicle) and CurrentTask.Busy then
										ESX.ShowNotification('~r~Zajęcie zostało anulowane, ponieważ pojazd przemieścił się')
										ESX.ClearTimeout(CurrentTask.Task)

										ClearPedTasks(playerPed)
										CurrentTask.Busy = false
										break
									end
								end
							end)							
						end
					end
				end
		  end, function(data2, menu2)
			  menu2.close()
		  end)
	  elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = _U('cone'),		value = 'prop_roadcone02a'},
					{label = _U('barrier'),		value = 'prop_barrier_work05'},
					{label = _U('spikestrips'),	value = 'p_ld_stinger_s'},
					{label = _U('cash'),		value = 'hei_prop_cash_crate_half_full'}
				}
			}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
				local objectCoords = (coords + forward * 1.0)
			  
				TriggerServerEvent('exile_logs:triggerLog', "Postawił/a objekt: "..data2.current.value, 'obiekt', true)

				ESX.Game.SpawnObject(data2.current.value, objectCoords, function(obj)					
					SetEntityHeading(obj, tonumber(GetEntityHeading(playerPed)))
					PlaceObjectOnGroundProperly(obj)
					
					if data2.current.value == 'prop_barrier_work05' then
						FreezeEntityPosition(obj, true)
						SetEntityCollision(obj, true)
					end
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

CreateThread(function()
	local object
	while true do
		Citizen.Wait(200)
		local coords = GetEntityCoords(PlayerPedId())

		local pass = false
		if not object or object == 0 then
			pass = true
		elseif not DoesEntityExist(object) or #(coords - GetEntityCoords(object)) > 50.0 then
			pass = true
		end

		if pass then
			object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 50.0, `p_ld_stinger_s`, false, false, false)
		end

		if object and object ~= 0 then
			for _, vehicle in ipairs(ESX.Game.GetVehicles()) do
				local position = GetEntityCoords(vehicle)
				if #(position - coords) <= 30.0 then
					local closest = GetClosestObjectOfType(position.x, position.y, position.z, 1.5, `p_ld_stinger_s`, false, false, false)
					if closest and closest ~= 0 then
						for i = 0, 7 do
							if not IsVehicleTyreBurst(vehicle, i, true) then
								SetVehicleTyreBurst(vehicle, i, true, 1000)
							end
						end
					end
				end
			end
		end
	end
end)
  
function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 255)
	SetTextOutline()

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 270
	DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
end
  
local timeLeft = nil
CreateThread(function()
	while true do
		Citizen.Wait(1)
		if timeLeft ~= nil then
			local coords = GetEntityCoords(PlayerPedId())
			DrawText3D(coords.x, coords.y, coords.z + 0.1, timeLeft .. '~g~%', 0.4)
		else
			Citizen.Wait(500)
		end
	end
end)

function OpenBodySearchMenu(target)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
  
	  local elements = {}
			--   for i=1, #data.accounts, 1 do
			-- 	if data.accounts[i].money > 0 then
			-- 	  if data.accounts[i].name == 'black_money' then
			-- 		table.insert(elements, {
			-- 		  label    = '[Brudna Gotówka] $'..data.accounts[i].money,
			-- 		  value    = 'black_money',
			-- 		  itemType = 'item_account',
			-- 		  amount   = data.accounts[i].money
			-- 		})
			-- 		break
			-- 	  end
			-- 	end
			--   end

			--   for i=1, #data.accounts, 1 do
			-- 	if data.accounts[i].money > 0 then
			-- 	  if data.accounts[i].name == 'money' then
			-- 		table.insert(elements, {
			-- 		  label    = '[Gotówka] $'..data.accounts[i].money,
			-- 		  value    = 'money',
			-- 		  itemType = 'item_account',
			-- 		  amount   = data.accounts[i].money
			-- 		})
			-- 		break
			-- 	  end
			-- 	end
			--   end
  
	  for i=1, #data.inventory, 1 do
		if data.inventory[i].count > 0 then
		  table.insert(elements, {
			label          = data.inventory[i].count..'x '..data.inventory[i].label,
			value          = data.inventory[i].name,
			itemType       = 'item_standard',
			amount         = data.inventory[i].count
		  })
		end
	  end
				
		--   local found = false
		--   ESX.TriggerServerCallback('route68:getTargetSim', function(sims)
		-- 	  if sims[1] then
		-- 		  for i=1, #sims, 1 do
		-- 			  table.insert(elements, {
		-- 				  label    = 'Karta SIM #'..sims[i].number,
		-- 				  number 	 = sims[i].number,
		-- 				  value    = 'sim',
		-- 				  itemType     = 'item_sim'
		-- 			  })
		-- 		  end
		-- 		  found = true
		-- 	  else
		-- 		  found = true
		-- 	  end
		--   end, GetPlayerServerId(target))
		--   while not found do
		-- 	  Citizen.Wait(100)
		--   end
	  

	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'body_search',
		{
		  title    = _U('search'),
		  align    = 'center',
		  elements = elements,
		},
		function(data, menu)
  
		  local itemType = data.current.itemType
		  local itemName = data.current.value
		  local amount   = data.current.amount
		  
		  local playerCoords = GetEntityCoords(PlayerPedId())
		  local playerCoords2 = GetEntityCoords(GetPlayerPed(target))
	  
		  if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, playerCoords2.x, playerCoords2.y, playerCoords2.z) <= 1.5 then
			if itemType == 'item_sim' then		
				ESX.UI.Menu.CloseAll()
				exports["exile_taskbar"]:taskBar(1000, "Zabieranie karty SIM", false, true)
				TriggerServerEvent('route68:TakeNumber', GetPlayerServerId(target), data.current.number)
				TriggerServerEvent('esx_policejob:isSearching', GetPlayerServerId(target), false)
				OpenBodySearchMenu(target)
			
			else
				if data.current.value ~= nil then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bodysearch_count', {
						title = 'Ilość',
					}, function(data2, menu2)
						menu2.close()
						local quantity = tonumber(data2.value)
						if not quantity or quantity > amount then
							ESX.ShowNotification('~r~Nieprawidłowa ilość')
						else
							exports["exile_taskbar"]:taskBar(1000, "Zabieranie przedmiotu", false, true)
							TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(target), itemType, itemName, quantity)
							menu2.close()
							Citizen.Wait(200)
							OpenBodySearchMenu(target)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end
		  else
			ESX.ShowNotification("~r~Jestes za daleko by zabrać przedmiot")
		  end
		end, function(data, menu)
		  if IsEntityPlayingAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "player_search", 3 ) then
			StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
		  end
		  menu.close()
		end)
	  end, GetPlayerServerId(target), false)
  end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
				exports["exile_taskbar"]:taskBar(5000, "Sparawdzanie tablic", false, true)	
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification('Ten ~y~numer rejestracyjny~s~  ~r~nie zostal~s~ zarejestrowany lub ~y~samochod jest ~r~kradziony!')
				end
			end, data.value)
			
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		if data.licenses ~= nil then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
					table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
				end
			end
		end

		local targetName = data.firstname .. ' ' .. data.lastname
		
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'Right',
			elements = elements,
		},
		function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.value)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end,
		function(data, menu)
			menu.close()
		end
		)

	end, GetPlayerServerId(player), true)
end
  
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job, response)
	PlayerData.job = job
end)
  
RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
	PlayerData.hiddenjob = hiddenjob
end)
  
AddEventHandler('esx_policejob:hasEnteredMarker', function(station, partNum)
	if station == 'Cloakrooms' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	elseif station == 'Pharmacy' then
		CurrentAction		= 'menu_pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}	
	elseif station == 'SERTArmory' then
		CurrentAction = 'menu_sert_armory'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~, aby otworzyć zbrojownię SERT/SWAT"
		CurrentActionData = {}
	elseif station == 'Vehicles' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = {partNum = partNum}
	elseif station == 'Lodzie' then
		CurrentAction     = 'menu_lodzie_spawner'
		CurrentActionMsg  = _U('lodzie_spawner')
		CurrentActionData = {partNum = partNum}
	elseif station == 'Helicopters' then
		CurrentAction = 'menu_helicopter_spawner'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~, aby wyciągnąć helikopter"
		CurrentActionData = {partNum = partNum}
	elseif station == 'VehicleDodatki' then
		CurrentAction = 'menu_dodatki'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~, aby otworzyć menu dodatków do pojazdu"
		CurrentActionData = {}
	elseif station == 'VehicleDeleters' then
	  local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed,  false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_vehicle')
				CurrentActionData = {vehicle = vehicle}
			end
		end
	elseif station == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	elseif station == 'SkinMenu' then
		CurrentAction = 'menu_skin'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~ aby się przebrać"
		CurrentActionData = {}
	elseif station == 'ChangeJob' then
		CurrentAction = 'change_job'
		CurrentActionMsg = "Naciśnij ~INPUT_CONTEXT~ pobrać drugą odznakę"
		CurrentActionData = {}
	end
end)
  
AddEventHandler('esx_policejob:hasExitedMarker', function(station, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)
  
  
RegisterNetEvent('esx_policejob:handcuffhype')
AddEventHandler('esx_policejob:handcuffhype', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()
	
	CreateThread(function()
		if IsHandcuffed then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if not exports['exile_trunk']:checkInTrunk() then
				RequestAnimDict('mp_arresting')
				while not HasAnimDictLoaded('mp_arresting') do
					Citizen.Wait(1)
				end

				if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8.0, -1, 49, 0.0, 0, 0, 0)
				end
			end
			
			ESX.UI.Menu.CloseAll()
			-- TriggerEvent('radar:setHidden', true)
			TriggerEvent('carhud:display', false)
			
			SetEnableHandcuffs(playerPed, true)
			
			SetPedCanPlayGestureAnims(playerPed, false)
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "zakuj", 0.5)
			
			StartHandcuffTimer()
		else
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "odkuj", 0.5)
			Citizen.InvokeNative(0xAAA34F8A7CB32098, playerPed)
			if Config.EnableHandcuffTimer and HandcuffTimer then
				ESX.ClearTimeout(HandcuffTimer)
			end

			SetEnableHandcuffs(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			-- TriggerEvent('radar:setHidden', false)
			TriggerEvent('carhud:display', true)

			FreezeEntityPosition(playerPed, false)
			
			if exports['exile_trunk']:checkInTrunk() then
				TaskPlayAnim(playerPed, "fin_ext_p1-7", "cs_devin_dual-7", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
			end
		end
	end)

end)
	
RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
	if IsHandcuffed then
		IsHandcuffed = false
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.5, 'odkuj', 0.2)
		local playerPed = PlayerPedId()

		Citizen.InvokeNative(0xAAA34F8A7CB32098, playerPed)
		if Config.EnableHandcuffTimer and HandcuffTimer then
			ESX.ClearTimeout(HandcuffTimer)
		end

		SetEnableHandcuffs(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)

		TriggerEvent('radar:setHidden', false)
		TriggerEvent('carhud:display', true)
		FreezeEntityPosition(playerPed, false)
	end
end)

  
RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(cop)
	if IsHandcuffed or IsPlayerDead(PlayerId()) then
		IsDragged = not IsDragged
		CopPlayer = tonumber(cop)
	end
end)

RegisterNetEvent('esx_policejob:dragging')
AddEventHandler('esx_policejob:dragging', function(target, dropped)
	if not dropped then
		Dragging = target
	elseif Dragging == target then
		Dragging = nil
	end
end)

CreateThread(function()
	local attached = false
	while true do
		if Dragging then
			local ped = PlayerPedId()			
			Citizen.Wait(100)
		elseif IsHandcuffed or IsPlayerDead(PlayerId()) then
			local playerPed = PlayerPedId()
			if IsDragged then
				if not attached then
					attached = true
					FreezeEntityPosition(playerPed, true)
					AttachEntityToEntity(playerPed, Citizen.InvokeNative(0x43A66C31C68491C0, GetPlayerFromServerId(CopPlayer)), 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					TriggerServerEvent('esx_policejob:dragging', CopPlayer, GetPlayerServerId(PlayerId()))
				end
			elseif CopPlayer then
				DetachEntity(playerPed, true, false)
				FreezeEntityPosition(playerPed, false)

				TriggerServerEvent('esx_policejob:dragging', CopPlayer)
				attached = false
				CopPlayer = nil
			end

			Citizen.Wait(10)
		else
			if IsDragged then
				local playerPed = PlayerPedId()
				DetachEntity(playerPed, true, false)
				TriggerServerEvent('esx_policejob:dragging', CopPlayer)

				local coords = GetEntityCoords(playerPed, true)
				RequestCollisionAtCoord(coords.x, coords.y, coords.z)

				attached = false
				CopPlayer = nil
				IsDragged = false
			end

			Citizen.Wait(500)
		end	
	end
end)

RegisterNetEvent('esx_policejob:putInTrunk')
AddEventHandler('esx_policejob:putInTrunk', function(cop)
	if IsHandcuffed then				
		TriggerEvent('exile:forceInTrunk', cop)
	end
end)

RegisterNetEvent('esx_policejob:OutTrunk')
AddEventHandler('esx_policejob:OutTrunk', function(cop)
	if IsHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(1)
		end

		TriggerEvent('exile:forceOutTrunk', cop)
		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
	else
		TriggerEvent('exile:forceOutTrunk', cop)
	end
end)
  

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
	if IsHandcuffed or isDead then
		local playerPed = PlayerPedId()

		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = ESX.Game.GetVehicleInDirection()
			if not vehicle then
				local coords = GetEntityCoords(playerPed, false)
				if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
					vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
				end
			end
		end

		if vehicle and vehicle ~= 0 then
			local maxSeats =  GetVehicleMaxNumberOfPassengers(vehicle)
			if maxSeats >= 0 then
				local freeSeat
				for i = (maxSeats - 1), 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat ~= nil then					
					local tick = 20
					repeat
						TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
						tick = tick - 1
						Citizen.Wait(50)
					until IsPedInAnyVehicle(playerPed, false) or tick == 0
				
					TriggerEvent('exile_blackout:belt', true)
				end
			end
		end
	end
end)
  
RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		if IsPedSittingInAnyVehicle(playerPed) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			TaskLeaveVehicle(playerPed, vehicle, 16)

			if not exports['exile_trunk']:checkInTrunk() then
				RequestAnimDict('mp_arresting')
				while not HasAnimDictLoaded('mp_arresting') do
					Citizen.Wait(1)
				end

				TriggerEvent('misiaczek:belt', false)
				TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8.0, -1, 49, 0.0, 0, 0, 0)
			end
		end
	end
end)
    -- Handcuff
CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if IsHandcuffed then
			if IsFirstHandcuffTick then
				IsFirstHandcuffTick = false
				ESX.UI.Menu.CloseAll()
			end

			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
			DisableControlAction(2, Keys['SPACE'], true) -- Jump
			DisableControlAction(2, Keys['Q'], true) -- Cover
			DisableControlAction(2, Keys['~'], true) -- Hands up
			DisableControlAction(2, Keys['Y'], true) -- Turn off vehicle
			DisableControlAction(2, Keys['B'], true) -- Pointing
			DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(2, Keys['F1'], true) -- Disable phone
			DisableControlAction(2, Keys['F2'], true) -- Inventory
			DisableControlAction(2, Keys['F3'], true) -- Animations
			DisableControlAction(2, Keys['F6'], true) -- Fraction actions
			DisableControlAction(2, Keys['LEFTSHIFT'], true) -- Running
			DisableControlAction(2, Keys['V'], true) -- Disable changing view
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen
			DisableControlAction(2, 59, true) -- Disable steering in vehicle
			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 56, true)

			local playerPed = PlayerPedId()
			if not IsPedCuffed(playerPed) then
				SetEnableHandcuffs(playerPed, true)
			end
			
			if IsPedInAnyPoliceVehicle(playerPed) then
				DisableControlAction(0, 75, true) 
				DisableControlAction(27, 75, true)
			end

			RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(1)
            end

            if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) and not exports['exile_trunk']:checkInTrunk() then
				TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
            end
		else
			SetEnableHandcuffs(playerPed, false)
			IsFirstHandcuffTick = true
			Citizen.Wait(500)
		end
	end
end)
  

CreateThread(function()
	while PlayerData.job == nil do
		Citizen.Wait(500)
	end
	
	for i=1, #Config.Blips, 1 do
		local blip = AddBlipForCoord(Config.Blips[i].Pos)

		SetBlipSprite (blip, Config.Blips[i].Sprite)
		SetBlipDisplay(blip, Config.Blips[i].Display)
		SetBlipScale  (blip, Config.Blips[i].Scale)
		SetBlipColour (blip, Config.Blips[i].Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Blips[i].Label)
		EndTextCommandSetBlipName(blip)
	end
	
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then
		for i=1, #Config.PoliceStations.Lodzie, 1 do
			local blip = AddBlipForCoord(Config.PoliceStations.Lodzie[i].coords)

			SetBlipSprite (blip, 404)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.9)
			SetBlipColour (blip, 38)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Port SASP")
			EndTextCommandSetBlipName(blip)
		end
	end
end)
  
CreateThread(function()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait(3)
		local found = false
		
		local coords = GetEntityCoords(PlayerPedId())
		if PlayerData.job ~= nil then
			for i=1, #Config.PoliceCount, 1 do
				if #(coords - Config.PoliceCount[i].coords) < Config.DrawDistance then
					found = true
					ESX.DrawMarker(Config.PoliceCount[i].coords)
					if #(coords - Config.PoliceCount[i].coords) < 1.5 then
						ESX.ShowHelpNotification("Naciśnij ~INPUT_CONTEXT~, aby sprawdzić tablicę funkcjonariuszy")
						if IsControlJustReleased(0, Keys['E']) then
							ESX.TriggerServerCallback("esx_scoreboard:getConnectedCops", function(MisiaczekPlayers)
								if MisiaczekPlayers then
									ESX.ShowNotification("~b~Na służbie jest aktualnie " .. MisiaczekPlayers['police'] .. " funkcjonariuszy")
								end
							end)
						end
					end
				end
			end
			
			if not found then
				Citizen.Wait(2000)
			end
			
		else
			Citizen.Wait(2000)
		end
	end
end)
  

CreateThread(function()
	while PlayerData.job == nil do
		Citizen.Wait(100)
	end
	
	while true do
		Citizen.Wait(3)
		local found = false
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			
			for k,v in pairs(Config.PoliceStations) do
				for i=1, #v, 1 do
					if k == "VehicleDeleters" or k == 'VehicleDodatki' then
						if #(coords - v[i].coords) < Config.DrawDistance then
							found = true
							DrawMarker(27, v[i].coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 3.0, 56, 197, 201, 100, false, true, 2, false, false, false, false)
						end
					end
					if k ~= "VehicleDeleters" and k ~= 'VehicleDodatki' then
						if #(coords - v[i].coords) < Config.DrawDistance then
							found = true
							ESX.DrawMarker(v[i].coords)
						end
					end
				end
			end
			
			if not found then
				Citizen.Wait(2000)
			end
		else
			Citizen.Wait(2000)
		end
	end
end)

CreateThread(function()
	while PlayerData.job == nil do
		Citizen.Wait(100)
	end
	
	while true do
		Citizen.Wait(3)
		local found = false
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local playerPed      = PlayerPedId()
			local isInMarker     = false
			local currentStation = nil
			local currentPartNum = nil
			local coords = GetEntityCoords(playerPed)

			for k,v in pairs(Config.PoliceStations) do
				for i=1, #v, 1 do
					if k == "VehicleDeleters" or k == 'VehicleDodatki' then
						if #(coords - v[i].coords) < 3.0 then
							found = true
							isInMarker     = true
							currentStation = k
							currentPartNum = i
						end
					end
					
					if k ~= "VehicleDeleters" and k ~= 'VehicleDodatki' then
						if #(coords - v[i].coords) < Config.MarkerSize.x then
							found = true
							isInMarker     = true
							currentStation = k
							currentPartNum = i
						end
					end
				end
			end

			local hasExited = false

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPartNum ~= currentPartNum)) then

				if (LastStation ~= nil and LastPartNum ~= nil) and (LastStation ~= currentStation or LastPartNum ~= currentPartNum) then
					TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPartNum             = currentPartNum
	
				TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPartNum)
			end
		  
			if not found then
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(2000)
		end
	end
end)
  
  
RegisterNetEvent('esx_policejob:dodatkiGaraz')
AddEventHandler('esx_policejob:dodatkiGaraz', function()
	local Gracz = PlayerPedId()
	if IsPedInAnyVehicle(Gracz, false) then
		local vehicle = GetVehiclePedIsIn(Gracz, false)
		OpenDodatkiGarazMenu()
	end
end)

function DodatkiGarazCommand()
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade >= 11 then
		local Gracz = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(Gracz, false)
		if IsPedInAnyVehicle(Gracz, false) then
			OpenDodatkiGarazMenu()
		end
	else
		ESX.ShowNotification('~r~Nie masz odpowiedniej rangi aby tego uzyc')
	end
end
  
RegisterCommand('dodatkisasp', function()
	DodatkiGarazCommand()
end, false)
  
function OpenDodatkiGarazMenu()
	local elements1 = {}
	local Gracz = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(Gracz, false)

	for ExtraID=0, 20 do
		if DoesExtraExist(vehicle, ExtraID) then
			if IsVehicleExtraTurnedOn(vehicle, ExtraID) == 1 then
				local tekstlabel = 'Dodatek '..tostring(ExtraID)..' - Zdemontuj'
				table.insert(elements1, {label = tekstlabel, posiada = true, value = ExtraID})
			elseif IsVehicleExtraTurnedOn(vehicle, ExtraID) == false then
				local tekstlabel = 'Dodatek '..tostring(ExtraID)..' - Podgląd'
				table.insert(elements1, {label = tekstlabel, posiada = false, value = ExtraID})
			end
		end
	end

	if #elements1 == 0 then
		table.insert(elements1, {label = 'Ten pojazd nie posiada dodatków!', posiada = nil, value = nil})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sklep_dodatki_policja', {
		title    = 'Dodatki - Sklep',
		align    = 'left',
		elements = elements1
	}, function(data, menu)
		local dodatek2 = data.current.value
		if dodatek2 ~= nil then
			local dodatekTekst = 'extra'..dodatek2
			local posiada = data.current.posiada
			if posiada then
				menu.close()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sklep_dodatki_policja_usun', {
					title    = 'Zdemontować dodatek?',
					align    = 'left',
					elements = {
						{label = "Tak", value = "tak"},
						{label = "Nie", value = "nie"},
					}
				}, function(data2, menu2)
					local akcja = data2.current.value
					local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
					local tablica = vehicleProps.plate
					if akcja == 'tak' then
						SetVehicleExtra(vehicle, dodatek2, 1)
						TriggerServerEvent('esx_policejob:DodatkiKup', tablica, dodatekTekst, false)
					elseif akcja == 'nie' then
						SetVehicleExtra(vehicle, dodatek2, 0)
					end
					menu2.close()
					Citizen.Wait(200)
					OpenDodatkiGarazMenu()
				end, function(data2, menu2)
					menu2.close()
				end)
				
			elseif posiada == false then
				SetVehicleExtra(vehicle, dodatek2, 0)
				menu.close()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sklep_dodatki_policja_kup', {
					title = 'Potwierdzić montaż?',
					align = 'left',
					elements = {
						{label = "Tak - Zamontuj", value = "tak"},
						{label = "Nie - Anuluj", value = "nie"},
					}
				}, function(data3, menu3)
					local akcja = data3.current.value
					local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
					local tablica = vehicleProps.plate
					if akcja == 'tak' then
						TriggerServerEvent('esx_policejob:DodatkiKup', tablica, dodatekTekst, true)
					elseif akcja == 'nie' then
						SetVehicleExtra(vehicle, dodatek2, 1)
					end
					
					menu3.close()
					Citizen.Wait(200)
					OpenDodatkiGarazMenu()
				end, function(data3, menu3)
					menu3.close()
				end)
			end
		end
	end, function(data, menu)
		menu.close()
		CurrentAction = 'menu_dodatki'
		CurrentActionMsg = ""
		CurrentActionData = {}
	end)
end
	
function SpawnHelicopter(partNum)
	local helicopters = Config.PoliceStations.Helicopters

	if not IsAnyVehicleNearPoint(helicopters[partNum].spawnPoint.x, helicopters[partNum].spawnPoint.y, helicopters[partNum].spawnPoint.z,  3.0) then
		ESX.Game.SpawnVehicle('pd_heli', helicopters[partNum].spawnPoint, helicopters[partNum].heading, function(vehicle)
		  SetVehicleLivery(vehicle, 0)
		  local localVehPlate = GetVehicleNumberPlateText(vehicle)
		  TriggerEvent("ls:newVehicle", vehicle, localVehPlate, false)
		  TriggerServerEvent("ls:addOwner", localVehPlate)
	  end)
	end
end

CreateThread(function()
	while true do
		if PlayerData.job ~= nil and PlayerData.job.name == 'police'  then
			local playerPed = PlayerPedId()
			if not IsPedInAnyVehicle(playerPed, false) then
				local coords = GetEntityCoords(playerPed)

				local found = false
				for _, prop in ipairs({
					`prop_roadcone02a`,
					`prop_barrier_work06a`,
					`p_ld_stinger_s`,
					`prop_barrier_work05`
				}) do
					local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  2.0,  prop, false, false, false)
					if DoesEntityExist(object) then
						CurrentAction     = 'remove_entity'
						CurrentActionMsg  = _U('remove_prop')
						CurrentActionData = {entity = object}
						found = true
						break
					end
				end

				if not found and CurrentAction == 'remove_entity' then
					CurrentAction = nil
				end

				Citizen.Wait(100)
			else
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)
  
CreateThread(function()
	while true do
		Citizen.Wait(5)
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'menu_pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'menu_sert_armory' then
					OpenSERTArmoryMenu()
				elseif CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu(CurrentActionData.partNum)
				elseif CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'menu_lodzie_spawner' then
					OpenLodzieSpawnerMenu(CurrentActionData.partNum)
				elseif CurrentAction == 'menu_helicopter_spawner' then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
						if hasWeaponLicense then
							SpawnHelicopter(CurrentActionData.partNum)
						else
							ESX.ShowNotification("~r~Nie posiadasz odpowiedniej licencji")
						end
					end, GetPlayerServerId(PlayerId()), 'eagle')
				elseif CurrentAction == 'menu_dodatki' then
					OpenDodatkiGarazMenu()
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					if (PlayerData.job.name == 'police' and PlayerData.job.grade >= 12) or (PlayerData.hiddenjob.name == 'sheriff' and PlayerData.hiddenjob.grade >= 11) then
						TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
							menu.close()
							CurrentAction     = 'menu_boss_actions'
							CurrentActionMsg  = _U('open_bossmenu')
							CurrentActionData = {}
						end, { showmoney = true, withdraw = true, deposit = true, wash = true, employees = true, badges = true, licenses = true})
					else
						TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
							menu.close()
							CurrentAction     = 'menu_boss_actions'
							CurrentActionMsg  = _U('open_bossmenu')
							CurrentActionData = {}
						end, { showmoney = false, withdraw = false, deposit = true, wash = true, employees = false, badges = false, licenses = false})
					end
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				elseif CurrentAction == 'menu_skin' then
					TriggerEvent('esx_skin:openSaveableMenu')
				elseif CurrentAction == 'change_job' then
					OpenChangeJobMenu()
				end
			  
				CurrentAction = nil
			end
		end
	  
		if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
			OpenPoliceActionsMenu()
		end

		if IsControlPressed(0, Keys['LEFTSHIFT']) then
			DisableControlAction(0, Keys['Q'], true)
			if IsDisabledControlJustPressed(0, Keys['Q']) and not IsPedInAnyVehicle(PlayerPedId()) and not isDead and not IsHandcuffed and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 and not IsPedInAnyVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, closestPlayer)) then
					animacjazakuciarozkuciaxd()
					Citizen.Wait(700)
					TriggerServerEvent('esx_policejob:handcuffhype', GetPlayerServerId(closestPlayer))
					TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), '~o~Zostałeś zakuty/odkuty przez ~g~[' .. GetPlayerServerId(PlayerId()).. ']')
					ESX.ShowNotification('~o~Zakułeś/Odkułeś ~g~[' .. GetPlayerServerId(closestPlayer) ..']')
				else
					ESX.ShowNotification("~r~Brak osób w pobliżu")
				end
			end
			
			if IsControlJustPressed(0, Keys['E']) and not IsPedInAnyVehicle(PlayerPedId()) and not isDead and not IsHandcuffed and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification("~r~Brak osób w pobliżu")
				end
			end
		end

	  
		if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(CurrentTask.Task)
			ClearPedTasks(PlayerPedId())
		  
			CurrentTask.Busy = false
		end
	end
end)
  
RegisterNetEvent('esx_policejob:removedGPS')
AddEventHandler('esx_policejob:removedGPS', function(data)
	ESX.ShowNotification("~r~Utracono połączenie z nadajnikiem ~w~" .. data.name)
	local alpha = 250
	local gpsBlip = AddBlipForCoord(data.coords)
	SetBlipSprite(gpsBlip, 280)
	SetBlipColour(gpsBlip, 3)
	SetBlipAlpha(gpsBlip, alpha)
	SetBlipScale(gpsBlip, 1.2)
	SetBlipAsShortRange(gpsBlip, false)
	SetBlipCategory(gpsBlip, 15)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("# OSTATNIA LOKALIZACJA " .. data.name)
	EndTextCommandSetBlipName(gpsBlip)
	
	for i=1, 25, 1 do
		PlaySound(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0, 0, 1)
		Wait(300)
		PlaySound(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0, 0, 1)
		Wait(300)
	end
	
	while alpha ~= 0 do
		Citizen.Wait(180 * 4)
		alpha = alpha - 1
		SetBlipAlpha(gpsBlip, alpha)
		if alpha == 0 then
			RemoveBlip(gpsBlip)
			return
		end
	end
end)
  
AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')
end)
  
AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)
  
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')

		if Config.EnableHandcuffTimer and HandcuffTimer then
			ESX.ClearTimeout(HandcuffTimer)
		end
	end
end)
  

function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer then
		ESX.ClearTimeout(HandcuffTimer)
	end
	
	HandcuffTimer = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification("~y~Czujesz jak Twoje kajdanki luzują się...")
		TriggerEvent('esx_policejob:unrestrain')
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "odkuj", 0.4)
	end)
end
  
function ImpoundVehicle(vehicle)
	ESX.Game.DeleteVehicle(vehicle) 
	ESX.ShowNotification(_U('impound_successful'))
	CurrentTask.Busy = false
end
  
function MenuBroni()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = 'Latarka', value = 'flashlight', count = 1},
		{label = 'Pałka Policyjna', value = 'nightstick', count = 1},
		{label = 'Paralizator', value = 'stungun', count = 1},
		{label = 'Pistolet', value = 'pistol', count = 1},
		{label = 'Pukawka', value = 'snspistol', count = 1},
		{label = 'Pukawka.wer 2', value = 'snspistol_mk2', count = 1},
		{label = 'Pistolet bojowy', value = 'combatpistol', count = 1},
		{label = 'Vintage pistol', value = 'vintagepistol', count = 1},
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
	{
		title    = _U('armory'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('esx_policejob:giveItem', data.current.value, data.current.count)
	end, function(data, menu)
		menu.close()
	end)
end
  
OpenSERTArmoryMenu = function()
	local elements = {
		{label = _U('put_weapon'),     value = 'put_weapon'}, 	
	}

	ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
		if hasWeaponLicense or (PlayerData.job and PlayerData.job.name == 'police' and PlayerData.job.grade >= 11) or (PlayerData.hiddenjob and PlayerData.hiddenjob.name == 'sheriff' and PlayerData.hiddenjob.grade >= 11) then
			table.insert(elements, {label = _U('get_weapon'),     value = 'get_weapon'})
		end
	end, GetPlayerServerId(PlayerId()), 'sert')
	
	Wait(100)
  
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sert_armory', {
		title		= "Zbrojownia SERT/SWAT",
		align		= 'right',			
		elements = elements
	}, function(data, menu)
		if data.current.value == 'put_weapon' then
			TriggerEvent('exile:putInventoryItem', 'society_sert')
		elseif data.current.value == 'get_weapon' then
			TriggerEvent('exile:getInventoryItem', 'society_sert')
		end
	end, function(data, menu)
		menu.close()

		CurrentAction		= 'menu_sert_armory'
		CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~, aby otworzyć zbrojownię SERT/SWAT"
		CurrentActionData	= {}
	end)
end
  
function OpenPharmacyMenu()
  
	local elements = {
		{label = 'Pobierz wyposażenie', value = 'get_wypo'},
		{label = 'Pobierz broń',     value = 'get_weapon'},
		{label = 'Zdeponuj przedmiot', value = 'put_stock'},
	}

	if PlayerData.job.name == 'police' and PlayerData.job.grade > 8 then
		table.insert(elements, {label = 'Weź przedmiot',  value = 'get_stock'})
	end
  
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title		= _U('pharmacy_menu_title'),
		align		= 'right',			
		elements = elements
	}, function(data, menu)
		if data.current.value == 'put_stock' then
			TriggerEvent('exile:putInventoryItem', 'society_police')
		elseif data.current.value == 'put_weapon' then
			TriggerEvent('exile:putInventoryItem', 'society_sert')
		elseif data.current.value == 'get_wypo' then
			OpenGetWypoMenu()
		elseif data.current.value == 'get_weapon' then
			MenuBroni()
		elseif data.current.value == 'get_stock' then
			TriggerEvent('exile:getInventoryItem', 'society_police')
		end
	end, function(data, menu)
		menu.close()

		CurrentAction		= 'menu_pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	end)
end
  
function OpenGetWypoMenu()
	local elements = {
		{label = _U('pharmacy_takeclip', "Magazynek do pistoletu"), value = 'pistol_ammo', count = 100},
		{label = _U('pharmacy_takeradio', "GPS"), value = 'gps', count = 1},
		{label = _U('pharmacy_takeradio', "Panic Button"), value = 'panicbutton', count = 1},
		{label = _U('pharmacy_takeradio', "Radio"), value = 'radio', count = 1},
		{label = _U('pharmacy_takeradio', "Bodycam"), value = 'bodycam', count = 1},
	}
  
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_take_wposazenie', {
		title    = 'Wyposażenie',
		align    = 'center',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('esx_policejob:giveItem', data.current.value, data.current.count)
	end, function(data, menu)
		menu.close()
		
		OpenPharmacyMenu()
	end)
end
  
function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end
  
function animacjazakuciarozkuciaxd()
	local ad = "mp_arresting"
	local anim = "a_uncuff"
	local player = PlayerPedId()

	if ( DoesEntityExist(player) and not IsEntityDead(player)) then
		loadanimdict(ad)
		if (IsEntityPlayingAnim(player, ad, anim, 8)) then
			TaskPlayAnim(player, ad, "exit", 8.0, 3.0, 2000, 26, 1, 0, 0, 0)
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim(player, ad, anim, 8.0, 3.0, 2000, 26, 1, 0, 0, 0)
		end
	end
end

RegisterNetEvent('esx_policejob:onHijack')
AddEventHandler('esx_policejob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			local model = GetEntityModel(vehicle)
			if not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABoat(model) then
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
				CreateThread(function()
					exports["exile_taskbar"]:taskBar(5000, "Trwa Odblokowywanie", false, true)
					
					while GetVehicleDoorsLockedForPlayer(vehicle, PlayerId()) ~= false do
						SetVehicleDoorsLocked(vehicle, 1)
						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
						Citizen.Wait(1)
					end

					Citizen.InvokeNative(0xAAA34F8A7CB32098, playerPed)
					ESX.ShowNotification(_U('vehicle_unlocked'))
				end)
			end
		end
	else
		ESX.ShowNotification('~r~Brak pojazdu w pobliżu')
	end

end)
  
  --lornetka
local fov_max = 150.0
local fov_min = 7.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right 
local speed_ud = 8.0 -- speed by which the camera pans up-down
local toggle_helicam = 51 -- control id of the button by which to toggle the helicam mode. Default: INPUT_CONTEXT (E)
local toggle_rappel = 154 -- control id to rappel out of the heli. Default: INPUT_DUCK (X)
local toggle_spotlight = 183 -- control id to toggle the front spotlight Default: INPUT_PhoneCameraGrid (G)
local toggle_lock_on = 22 -- control id to lock onto a vehicle with the camera. Default is INPUT_SPRINT (spacebar)

local helicam = false
local pd_heli_hash = `pcj`
local fov = (fov_max+fov_min)*0.5
local vision_state = 0 -- 0 is normal, 1 is nightmode, 2 is thermal vision
  
  ----
  
CreateThread(function()
	while true do
		Wait(3)
		local lPed = PlayerPedId()
		local heli = GetVehiclePedIsIn(lPed)
		
		if helicam then
			if not ( IsPedSittingInAnyVehicle( lPed ) ) then
				CreateThread(function()
					TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BINOCULARS", 0, 1)
					PlayAmbientSpeech1(PlayerPedId(), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
				end)
			end	
			
			Wait(2000)
			SetTimecycleModifier("heliGunCam")
			SetTimecycleModifierStrength(0.3)
			local scaleform = RequestScaleformMovie("HELI_CAM")
			while not HasScaleformMovieLoaded(scaleform) do
				Wait(3)
			end

			local lPed = PlayerPedId()
			local heli = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam, lPed, 0.0,0.0,1.0, true)
			SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()

			local locked_on_vehicle = nil

			while helicam and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == heli) and true do

				if IsControlJustPressed(0, 177) then -- Toggle Helicam
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ClearPedTasks(PlayerPedId())
					helicam = false
				end

				if not locked_on_vehicle then
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam, zoomvalue)
					local vehicle_detected = GetVehicleInView(cam)
				end

				HandleZoom(cam)
				HideHUDThisFrame()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Wait(3)

			end

			helicam = false

			ClearTimecycleModifier()

			fov = (fov_max+fov_min)*0.5

			RenderScriptCams(false, false, 0, 1, 0)

			SetScaleformMovieAsNoLongerNeeded(scaleform)

			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('exile_lorneta:lornetaon') --Just added the event to activate the binoculars
AddEventHandler('exile_lorneta:lornetaon', function()
	helicam = not helicam
	ESX.UI.Menu.CloseAll()
end)
  
function IsPlayerInPolmav()
	local lPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(lPed)
	return IsVehicleModel(vehicle, polmav_hash)
end
  
  
function ChangeVision()
	if vision_state == 0 then
		SetNightvision(true)
		vision_state = 1
	elseif vision_state == 1 then
		SetNightvision(false)
		SetSeethrough(true)
		vision_state = 2
	else
		SetSeethrough(false)
		vision_state = 0
	end
end
  
function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudComponentThisFrame(19) -- weapon wheel
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
end
  
function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end
  
function HandleZoom(cam)
	local lPed = PlayerPedId()
	
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then
		if IsControlJustPressed(0,32) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,8) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	else
		if IsControlJustPressed(0,241) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	end
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	--DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0), 10, GetVehiclePedIsIn(PlayerPedId()), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end
  
  --guntest

--[[RegisterCommand("ulecz",function(source, cmd)
	if PlayerData.job.name == 'ambulance' then
		TriggerServerEvent('esx_policejob:es', cmd)
	else
		if PlayerData.job.name == 'police' then
			if PlayerData.job.grade > 4 and PlayerData.job.grade <= 10 then
				ESX.TriggerServerCallback("esx_scoreboard:getConnectedCops", function(MisiaczekPlayers)
					if MisiaczekPlayers then
						if MisiaczekPlayers['ambulance'] == 0 then
							TriggerServerEvent('esx_policejob:es', cmd)
						else
							ESX.ShowNotification('~r~Aby pomóc wezwij SAMS')
						end
					end
				end)
			elseif PlayerData.job.grade > 10 then
				TriggerServerEvent('esx_policejob:es', cmd)
			elseif PlayerData.job.grade <= 2 then
				ESX.ShowNotification('~r~Nie masz odpowiedniego wyszkolenia do pomocy obywatelom')
			end
		end
	end
end)]]

RegisterNetEvent('esx_handcuffs:onUse')
AddEventHandler('esx_handcuffs:onUse', function()
	if not IsPedInAnyVehicle(PlayerPedId(), false) then
		HandcuffMenu()
	end
end)


RegisterNetEvent('Kajdanki')
AddEventHandler('Kajdanki', function()
	if not IsPedInAnyVehicle(PlayerPedId(), false) then
		HandcuffMenu()
	end
end)


function ImpoundVehicle(vehicle)
	ESX.Game.DeleteVehicle(vehicle) 
	ESX.ShowNotification(_U('impound_successful'))
	CurrentTask.Busy = false
end