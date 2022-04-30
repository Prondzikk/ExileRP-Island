ESX = nil
local PlayerData = {}
local level = 0
local workers = 0

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
		
		Citizen.Wait(250)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
	PlayerData.hiddenjob = hiddenjob
end)

function OpenBossMenu(society, close, options, extras)	
	ESX.TriggerServerCallback('exile_legaljobs:getLicenses', function(licenses)
		level = licenses.level
	end, society)
	ESX.TriggerServerCallback('society:countMembers', function(all)
		workers = all
	end, society)
	local options = options or {}
	
	if options.withdraw ~= nil and options.showmoney == nil then
		options.withdraw = options.withdraw
	end
	
	for k,v in pairs({
		showmoney = true,
		withdraw = true,
		deposit = true,
		employees = true,
		dirty = false,
		badges = false,
		licenses  = false,
		grades = false	
	}) do
		if options[k] == nil then
			options[k] = v
		end
	end
	
	local elements = {}
	ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
		if options.showmoney then
			table.insert(elements, {label = 'Stan konta frakcji: <span style="color:limegreen;">'..money.normal..'$', value = 'none'})
		end

		if options.withdraw then
			table.insert(elements, {label = _U('withdraw_society_money'), value = 'withdraw_society_money'})
		end

		if options.deposit then
			table.insert(elements, {label = _U('deposit_society_money'), value = 'deposit_money'})
		end

		if options.employees then
			table.insert(elements, {label = _U('employee_management'), value = 'manage_employees'})
		end

		if options.grades then
			table.insert(elements, {label = _U('salary_management'), value = 'manage_grades'})
		end

		if (society == 'police' and (PlayerData.hiddenjob.name == 'sheriff' and PlayerData.hiddenjob.grade >= 11) or (PlayerData.job.name == 'police' and PlayerData.job.grade >= 11)) then
			table.insert(elements, {label = 'Sheriff Office', value = 'manage_sheriff'})
		end

		if (society == 'police' and (PlayerData.hiddenjob.name == 'dtu' and PlayerData.hiddenjob.grade >= 4) or (PlayerData.job.name == 'police' and PlayerData.job.grade >= 11)) then
			table.insert(elements, {label = 'Detective Tactical Unit', value = 'manage_dtu'})
		end

		if (society == 'police' and (PlayerData.hiddenjob.name == 'hwp' and PlayerData.hiddenjob.grade >= 6) or (PlayerData.job.name == 'police' and PlayerData.job.grade >= 11)) then
			table.insert(elements, {label = 'Highway Patrol', value = 'manage_hwp'})
		end

		if (society == 'mechanik' and (PlayerData.job.name == 'mechanik' and PlayerData.job.grade >= 7)) then
			table.insert(elements, {label = 'Lista pracowników na służbie', value = 'duty_list'})
		end

		if (society == 'mechanik2' and (PlayerData.job.name == 'mechanik2' and PlayerData.job.grade >= 7)) then
			table.insert(elements, {label = 'Lista pracowników na służbie', value = 'duty_list2'})
		end	

		if extras and extras.main then
			for _, extra in ipairs(extras.main) do
				table.insert(elements, {label = extra.name, value = 'extra', event = extra.event, eventValue = extra.value})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_actions_' .. society,
		{
			title    = _U('boss_menu'),
			align    = 'left',
			elements = elements
		}, function(data, menu)

			if data.current.value == 'extra' then
				TriggerEvent(data.current.event, menu, data.current.eventValue) 
			elseif data.current.value == 'withdraw_society_money' then

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. society, {
					title = _U('withdraw_amount')
				}, function(data, menu)

					local amount = tonumber(data.value)

					if amount == nil then
						ESX.ShowNotification(_U('invalid_amount'))
					else
						menu.close()
						TriggerServerEvent('spoleczenstwo:wyplacajSzmato', society, amount)
					end

				end, function(data, menu)
					menu.close()
				end)

			elseif data.current.value == 'manage_sheriff' then
				TriggerEvent('esx_society:openHiddenBossMenu', 'sheriff', 100, function(data, menu)
					menu.close()
				end, { showmoney = false, withdraw = false, deposit = false, employees = true })
			elseif data.current.value == 'manage_dtu' then
				TriggerEvent('esx_society:openHiddenBossMenu', 'dtu', 100, function(data, menu)
					menu.close()
				end, { showmoney = false, withdraw = false, deposit = false, employees = true })
			elseif data.current.value == 'manage_hwp' then
				TriggerEvent('esx_society:openHiddenBossMenu', 'hwp', 100, function(data, menu)
					menu.close()
				end, { showmoney = false, withdraw = false, deposit = false, employees = true })
			elseif data.current.value == 'duty_list' then
				OpenDutyListMenu('mechanik')
			elseif data.current.value == 'duty_list2' then
				OpenDutyListMenu2('mechanik2')
			elseif data.current.value == 'deposit_money' then

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. society,
				{
					title = _U('deposit_amount')
				}, function(data, menu)

					local amount = tonumber(data.value)

					if amount == nil then
						ESX.ShowNotification(_U('invalid_amount'))
					else
						menu.close()
						TriggerServerEvent('spoleczenstwo:kitrajHajs', society, amount)
					end

				end, function(data, menu)
					menu.close()
				end)

			elseif data.current.value == 'manage_employees' then
				OpenManageEmployeesMenu(society, options.licenses)
			elseif data.current.value == 'manage_grades' then
				OpenManageGradesMenu(society)
			end

		end, function(data, menu)
			if close then
				close(data, menu)
			end
		end)
	end, society)
end

function OpenDutyListMenu(society) 
	ESX.TriggerServerCallback('csskrouble:societyDutyList', function(list)
		ESX.UI.Menu.CloseAll()
		local elements = {}
		local workers = {}
		for i,v in ipairs(list) do
			local ii = #elements
			table.insert(elements, {label = v[1], value = ii+1})
			table.insert(workers, v)
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(),society.."_dutylist",
		{ 
		title = "Pracownicy na służbie", 
		align = "center", 
		elements = elements 
		}, function(data, menu)
			local worker = workers[data.current.value]
			ESX.ShowNotification('Wyrzucono ze służby '..worker[2][3])
			TriggerServerEvent("csskrouble:kickFromDuty", worker[2][1], society, worker[2][2])
			menu.close()
		end, function(data, menu) 
		menu.close() 
		end)
	end, society)
end 

function OpenDutyListMenu2(society) 
	ESX.TriggerServerCallback('csskrouble:societyDutyList', function(list)
		ESX.UI.Menu.CloseAll()
		local elements = {}
		local workers = {}
		for i,v in ipairs(list) do
			local ii = #elements
			table.insert(elements, {label = v[1], value = ii+1})
			table.insert(workers, v)
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(),society.."_dutylist",
		{ 
		title = "Pracownicy na służbie", 
		align = "center", 
		elements = elements 
		}, function(data, menu)
			local worker = workers[data.current.value]
			ESX.ShowNotification('Wyrzucono ze służby '..worker[2][3])
			TriggerServerEvent("csskrouble:kickFromDuty", worker[2][1], society, worker[2][2])
			menu.close()
		end, function(data, menu) 
		menu.close() 
		end)
	end, society)
end 

function OpenManageEmployeesMenu(society, licenses)
	local limitworkers = exports['exile_legaljobs']:GetLimits(level)
	local elements = {
		{label = "Zrekrutuj",       value = 'recruit'},
		{label = "Zarządzaj pracownikami", value = 'employee_list'},
	}
	
	if limitworkers ~= nil then
		table.insert(elements, {label = "Zeruj wszystkie kursy tymaczasowe", value = 'zeruj_kursy'})
		table.insert(elements, {label = "Zatrudnionych: "..workers.." / "..limitworkers, value = nil})
	end
	
	if licenses then
		table.insert(elements, {label = "Zarządzaj licencjami", value = 'licenses'})
	end

	if society == 'police' or society == 'ambulance' or society == 'fire' or society == 'mechanik' or society == 'doj' or society == 'psycholog' or society == 'dtu' or society == 'mechanik2' then
		table.insert(elements, {label = "Przelej premię", value = 'give_money'})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_' .. society, {
		title    = _U('employee_management'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'employee_list' then
			OpenEmployeeList(society)
		end

		if data.current.value == 'recruit' then
			for i=1, #Config.LegalJobsList, 1 do
				if society == Config.LegalJobsList[i] then
					ESX.TriggerServerCallback('exile_legaljobs:getLicenses', function(licenses)
						level = licenses.level
						OpenRecruitMenu(society, level, true)
					end, society)
					break
				else
					OpenRecruitMenu(society, level, false)
				end
			end
		end
		
		if data.current.value == 'zeruj_kursy' then
			ESX.TriggerServerCallback('esx_society:zeruj_kursy_all', function(cb)
				-- cb()
			end, PlayerData.job.name)
		end

		if data.current.value == 'licenses' then
			OpenLicensesMenu(society)
		end

		if data.current.value == 'give_money' then
			OpenGiveMoneyMenu(society)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenGiveMoneyMenu(society)
	local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
	local elements = {}
	local serverIds = {}
	
	for k,v in ipairs(players) do
		if v ~= PlayerId() then
			table.insert(serverIds, GetPlayerServerId(v))
		end
	end
	
	ESX.TriggerServerCallback("esx_society:getMeNames", function(identities)
		for k,v in pairs(identities) do
			table.insert(elements, {
				player = k,
				label = v
			})
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'obywatele_obok',
		{
			title = "Wybierz obywatela",
			align = 'left',
			elements = elements,
		},
		function(data, menu)
			menu.close()
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'give_money', {
				title    = "Ile pieniędzy chcesz przelać?",
				align    = 'center'
			}, function(data2, menu2)
				menu2.close()
				TriggerServerEvent('esx_society:giveMoney', data.current.player, society, data2.value)
				Citizen.Wait(300)
				OpenGiveMoneyMenu(society)
			end, function(data2, menu2)
				menu2.close()
				OpenGiveMoneyMenu(society)
			end)
		end,
		function(data, menu)
			menu.close()
		end)	
	end, serverIds)
end

function OpenGiveLicenseMenu(employee, society)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give', {
		title    = 'Jaką licencję chcesz nadać?',
		align    = 'bottom-right',
		elements = employee.available
	}, function(data, menu)
		menu.close()
		TriggerServerEvent('esx_society:giveLicense', employee, data.current.value)
		Citizen.Wait(500)
		OpenLicensesMenu(society)
	end, function(data, menu)
		menu.close()
		OpenLicensesMenu(society)
	end)
end

function OpenGetLicenseMenu(employee, society)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give', {
		title    = 'Jaką licencję chcesz odebrać?',
		align    = 'bottom-right',
		elements = employee.owned
	}, function(data, menu)
		menu.close()
		TriggerServerEvent('esx_society:getLicense', employee, data.current.value)
		Citizen.Wait(500)
		OpenLicensesMenu(society)
	end, function(data, menu)
		menu.close()
		OpenLicensesMenu(society)
		
	end)
end

function OpenLicensesMenu(society)
	TriggerServerEvent('esx_policejob:loadLicense')
	Wait(500)
	ESX.TriggerServerCallback('flux:pokazLicencje', function(licenses)
		if #licenses > 0 then
			local elements = {
			  head = {'Imię i nazwisko', 'SEU', 'SWAT', 'DTU', 'EAGLE', 'WMK2', 'SERT', 'Działania'},
			  rows = {}
			}

			for _, license in ipairs(licenses) do

			  table.insert(elements.rows, {
				data = license,
				cols = {
				  license.name,
				  license.licenses.seu,
				  license.licenses.swat,
				  license.licenses.dtu,
				  license.licenses.eagle,
				  license.licenses.wmk2,
				  license.licenses.sert,
				  '{{Odbierz|remove}}{{Nadaj|add}}',
				}
			  })
			end

			ESX.UI.Menu.Open(
			  'list', GetCurrentResourceName(), 'license_management',
			  elements,
			  function(data, menu)
				local license = data.data
				if data.value == 'remove' then
					menu.close()
					local elements2 = {}

					if license.licenses.seu == '✔️' then
						table.insert(elements2, {label = 'Zabierz SEU', value = 'seu', key = 'SEU'})
					end

					if license.licenses.swat == '✔️' then
						table.insert(elements2, {label = 'Zabierz SWAT', value = 'swat', key = 'SWAT'})
					end

					if license.licenses.dtu == '✔️' then
						table.insert(elements2, {label = 'Zabierz DTU', value = 'dtu', key = 'DTU'})
					end

					if license.licenses.eagle == '✔️' then
						table.insert(elements2, {label = 'Zabierz EAGLE', value = 'eagle', key = 'EAGLE'})
					end

					if license.licenses.wmk2 == '✔️' then
						table.insert(elements2, {label = 'Zabierz WMK2', value = 'wmk2', key = 'WMK2'})
					end

					if license.licenses.sert == '✔️' then
						table.insert(elements2, {label = 'Zabierz SERT', value = 'sert', key = 'SERT'})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dwadwadwa', {
						title    = PlayerData.job.name == 'sheriff' and 'Licencje szeryfowskie' or 'Licencje policyjne',
						align    = 'center',
						elements = elements2
					}, function(data2, menu2)
							menu.close()
							TriggerServerEvent('esx:policejob:removeLicenseOffline', license.identifier, data2.current.value)
							ESX.ShowNotification('~g~Odebrano licencję ' .. data2.current.key)

							Citizen.Wait(500)
							TriggerEvent('esx_policejob:openLicenseListMenu', parent, eventValue)
					end, function(data2, menu2)
						TriggerEvent('esx_policejob:openLicenseListMenu', parent, eventValue)
						menu2.close()
					end)	
				elseif data.value == 'add' then
					menu.close()
					local elements2 = {}

					if license.licenses.seu == '❌' then
						table.insert(elements2, {label = 'Nadaj SEU', value = 'seu', key = 'SEU'})
					end

					if license.licenses.swat == '❌' then
						table.insert(elements2, {label = 'Nadaj SWAT', value = 'swat', key = 'SWAT'})
					end

					if license.licenses.dtu == '❌' then
						table.insert(elements2, {label = 'Nadaj DTU', value = 'dtu', key = 'DTU'})
					end

					if license.licenses.eagle == '❌' then
						table.insert(elements2, {label = 'Nadaj EAGLE', value = 'eagle', key = 'EAGLE'})
					end

					if license.licenses.wmk2 == '❌' then
						table.insert(elements2, {label = 'Nadaj WMK2', value = 'wmk2', key = 'WMK2'})
					end

					if license.licenses.sert == '❌' then
						table.insert(elements2, {label = 'Nadaj SERT', value = 'sert', key = 'SERT'})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dwadwadwadawdwadwadwa', {
						title    = PlayerData.job.name == 'sheriff' and 'Licencje szeryfowskie' or 'Licencje policyjne',
						align    = 'center',
						elements = elements2
					}, function(data2, menu2)
							menu.close()
							menu2.close()
							TriggerServerEvent('esx:policejob:addLicenseOffline', license.identifier, data2.current.value)
							ESX.ShowNotification('~g~Nadano licencję ' .. data2.current.key)

							Citizen.Wait(500)
							TriggerEvent('esx_policejob:openLicenseListMenu', parent, eventValue)
					end, function(data2, menu2)
						menu.close()
						menu2.close()
						TriggerEvent('esx_policejob:openLicenseListMenu', parent, eventValue)
					end)	
				end
			  end,
			  function(data, menu)
				menu.close()
				if parent then
					parent.open()
				end
			  end
			)
		else
			ESX.ShowNotification('~r~Brak nadanych licencji')
			if parent then
				parent.open()
			end
		end
	end, society)
end

function OpenEmployeeList(society)
	ESX.TriggerServerCallback('flux:pokazKlapkow', function(employees)	
	
		local elements = nil
		
		if (PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'police' or PlayerData.job.name == 'fire' or PlayerData.job.name == 'mechanik' or PlayerData.job.name == 'doj' or PlayerData.job.name == 'psycholog' or PlayerData.job.name == 'dtu' or PlayerData.job.name == 'mechanik2' ) then
			elements = {
				head = {_U('employee'), _U('grade'), 'Odznaka', _U('actions')},
				rows = {}
			}
		else
			elements = {
				head = {_U('employee'), _U('grade'), "Globalne kursy", _U('actions')},
				rows = {}
			}			
		end

		if (PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'police' or PlayerData.job.name == 'fire' or PlayerData.job.name == 'mechanik' or PlayerData.job.name == 'doj' or PlayerData.job.name == 'psycholog' or PlayerData.job.name == 'dtu' or PlayerData.job.name == 'mechanik2' ) then
			for i=1, #employees, 1 do
				local gradeLabel = (employees[i].job.grade_label == '' and employees[i].job.label or employees[i].job.grade_label)

				local numer
				if employees[i].badge.number > 0 and employees[i].badge.number < 10 then
					numer = '0' .. employees[i].badge.number
				else
					numer = employees[i].badge.number
				end
				local gradeBadge = (tostring(numer))

				if employees[i].badge.number == 0 then
					gradeBadge = 'Brak Odznaki'
				end
				table.insert(elements.rows, {
					data = employees[i],
					cols = {
						employees[i].name,
						gradeLabel,
						gradeBadge,
						'{{Odznaka |odznaka}} {{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}'
					}
				})
			end
		else
			for i=1, #employees, 1 do
				local gradeLabel = (employees[i].job.grade_label == '' and employees[i].job.label or employees[i].job.grade_label)
				
				table.insert(elements.rows, {
					data = employees[i],
					cols = {
						employees[i].name,
						gradeLabel,
						employees[i].job.courses,
						'{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}} {{Zeruj kursy|zeruj_kursy}}'
					}
				})
			end
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. society, elements, function(data, menu)
			local employee = data.data

			if data.value == 'odznaka' then
				menu.close()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'odznaki', {
					title = 'Numer Odznaki'
				}, function(data2, menu2)
					local amount = tonumber(data2.value)

					if amount == nil or amount < 1 then
						ESX.ShowNotification('Niepoprawny numer!')
					else
						menu2.close()
						TriggerServerEvent('esx_society:setBadge', employee, amount)
						Citizen.Wait(200)
						OpenBossMenu(society)
					end
				end, function(data2, menu2)
					menu2.close()			
				end)				
			elseif data.value == 'promote' then
				menu.close()
				OpenPromoteMenu(society, employee)
			elseif data.value == 'fire' then
				ESX.ShowNotification(_U('you_have_fired', employee.name))

				ESX.TriggerServerCallback('esx_society:setJob', function()
					OpenEmployeeList(society)
				end, employee.identifier, 'unemployed', 0, 'fire')
			elseif data.value == 'zeruj_kursy' then
				ESX.TriggerServerCallback('esx_society:zeruj_kursy', function()
					OpenEmployeeList(society)
				end, employee)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, society)
end

function OpenRecruitMenu(society, level, custom)
	if custom then
		ESX.TriggerServerCallback('society:countMembers', function(all)
			if all >= exports['exile_legaljobs']:GetLimits(level) then
				if tonumber(level) == 10 then
					ESX.ShowNotification('~r~Twoja firma posiada już maksymalny poziom i maksymalną ilość członków')
				else
					ESX.UI.Menu.CloseAll()
					ESX.ShowNotification('~r~Aby zatrudnić więcej osób musisz podnieść poziom firmy')
				end
			else
				local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
				if json.encode(players) ~= '[]' then
					local elements = {}
					local serverIds = {}
					
					for k,v in ipairs(players) do
						if v ~= PlayerId() then
							table.insert(serverIds, GetPlayerServerId(v))
						end
					end
					
					ESX.TriggerServerCallback("esx_society:getMeNames",function(identities)
						for k,v in pairs(identities) do
							table.insert(elements, {
								player = k,
								label = v
							})
						end		
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'special_cop_menu',
						{
							title = _U('recruiting'),
							align = 'left',
							elements = elements,
						},
						function(data, menu)
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_confirm_' .. society, {
								title    = _U('do_you_want_to_recruit', data.current.label),
								align    = 'center',
								elements = {
									{label = _U('no'),  value = 'no'},
									{label = _U('yes'), value = 'yes'}
								}
							}, function(data2, menu2)
								menu2.close()

								if data2.current.value == 'yes' then
									ESX.ShowNotification(_U('you_have_hired', data.current.label))
									ESX.TriggerServerCallback('esx_society:setJob', function()
										OpenRecruitMenu(society, level, custom)
									end, data.current.player, society, 0, 'hire', PlayerData.job.name, society)
								end
							end, function(data2, menu2)
								menu2.close()
							end)
						end,
						function(data, menu)
							menu.close()
						end)	
					end, serverIds)
				else
					ESX.ShowNotification('~r~Brak graczy w pobliżu!')
				end
			end
		end, society)
	else
		local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
		if json.encode(players) ~= '[]' then
			local elements = {}
			local serverIds = {}
			
			for k,v in ipairs(players) do
				if v ~= PlayerId() then
					table.insert(serverIds, GetPlayerServerId(v))
				end
			end
			
			ESX.TriggerServerCallback("esx_society:getMeNames",function(identities)
				for k,v in pairs(identities) do
					table.insert(elements, {
						player = k,
						label = v
					})
				end		
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'special_cop_menu',
				{
					title = _U('recruiting'),
					align = 'left',
					elements = elements,
				},
				function(data, menu)
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_confirm_' .. society, {
						title    = _U('do_you_want_to_recruit', data.current.label),
						align    = 'center',
						elements = {
							{label = _U('no'),  value = 'no'},
							{label = _U('yes'), value = 'yes'}
						}
					}, function(data2, menu2)
						menu2.close()

						if data2.current.value == 'yes' then
							ESX.ShowNotification(_U('you_have_hired', data.current.label))
							ESX.TriggerServerCallback('esx_society:setJob', function()
								OpenRecruitMenu(society, level, custom)
							end, data.current.player, society, 0, 'hire', PlayerData.job.name, society)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end,
				function(data, menu)
					menu.close()
				end)	
			end, serverIds)
		else
			ESX.ShowNotification('~r~Brak graczy w pobliżu!')
		end
	end
end

function OpenPromoteMenu(society, employee)

	ESX.TriggerServerCallback('esx_society:getJob', function(job)

		local elements = {}
		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

			if PlayerData.job.grade >= job.grades[i].grade then
				table.insert(elements, {
					label = gradeLabel,
					value = job.grades[i].grade,
					selected = (employee.job.grade == job.grades[i].grade)
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'promote_employee_' .. society, {
			title    = _U('promote_employee', employee.name),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()
			ESX.ShowNotification(_U('you_have_promoted', employee.name, data.current.label))

			ESX.TriggerServerCallback('esx_society:setJob', function()
				OpenEmployeeList(society)
			end, employee.identifier, society, data.current.value, 'promote')
		end, function(data, menu)
			menu.close()
			OpenEmployeeList(society)
		end)

	end, society)

end

function OpenManageGradesMenu(society)

	ESX.TriggerServerCallback('esx_society:getJob', function(job)

		local elements = {}

		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(gradeLabel, _U('money_generic', ESX.Math.GroupDigits(job.grades[i].salary))),
				value = job.grades[i].grade
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_' .. society, {
			title    = _U('salary_management'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. society, {
				title = _U('salary_amount')
			}, function(data2, menu2)

				local amount = tonumber(data2.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				elseif amount > Config.MaxSalary then
					ESX.ShowNotification(_U('invalid_amount_max'))
				else
					menu2.close()

					ESX.TriggerServerCallback('esx_society:setJobSalary', function()
						OpenManageGradesMenu(society)
					end, society, data.current.value, amount)
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	end, society)

end

AddEventHandler('esx_society:openBossMenu', function(society, close, options)
	OpenBossMenu(society, close, options)
end)

function OpenHiddenBossMenu(society, level, close, options)
	local options  = options or {}
	local elements = {}
	
	local fractionAccount = 0
	local fractionAccountBlack = 0
    local moneyLoaded = false

	ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
		fractionAccount = money.normal
		fractionAccountBlack = money.black
		moneyLoaded = true
	end, society)

	while not moneyLoaded do
		Citizen.Wait(100)
	end

	local defaultOptions = {
		showmoney = false,
		withdraw  = false,
		deposit   = true,
		employees = false,
		grades    = false
	}

	for k,v in pairs(defaultOptions) do
		if options[k] == nil then
			options[k] = v
		end
	end

	if options.showmoney then
		table.insert(elements, {label = ('Saldo: '..fractionAccount..'$'), value = 'none'})
	end

	if options.showmoney and string.find(society, "org") then
		table.insert(elements, {label = ('Saldo (Brudne): '..fractionAccountBlack..'$'), value = 'none'})
	end

	if options.withdraw then
		table.insert(elements, {label = _U('withdraw_society_money'), value = 'withdraw_society_money'})
	end

	if options.withdraw and string.find(society, "org") then
		table.insert(elements, {label = "Wypłać brudne pieniądze", value = 'withdraw_black_money'})
	end

	if options.deposit then
		table.insert(elements, {label = _U('deposit_society_money'), value = 'deposit_money'})
	end

	if options.deposit and string.find(society, "org") then
		table.insert(elements, {label = "Zdeponuj brudne pieniądze", value = 'deposit_black_money'})
	end

	if options.employees then
		table.insert(elements, {label = _U('employee_management'), value = 'manage_employees'})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_actions_' .. society, {
		title    = _U('boss_menu'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'withdraw_society_money' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. society, {
				title = _U('withdraw_amount')
			}, function(data, menu)

				local amount = tonumber(data.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu.close()
					TriggerServerEvent('spoleczenstwo:wyplacajUkryteSzmato', society, amount)
				end

			end, function(data, menu)
				menu.close()
			end)

			elseif data.current.value == 'withdraw_black_money' then

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_black_money_amount_' .. society, {
					title = _U('withdraw_amount')
				}, function(data, menu)
	
					local amount = tonumber(data.value)
	
					if amount == nil then
						ESX.ShowNotification(_U('invalid_amount'))
					else
						menu.close()
						TriggerServerEvent('spoleczenstwo:wyplacajUkryteSzmatoBlack', society, amount)
					end
	
				end, function(data, menu)
					menu.close()
				end)

		elseif data.current.value == 'deposit_money' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. society, {
				title = _U('deposit_amount')
			}, function(data, menu)

				local amount = tonumber(data.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu.close()
					TriggerServerEvent('spoleczenstwo:kitrajUkrytyHajs', society, amount)
				end

			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'deposit_black_money' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_black_money_amount_' .. society, {
				title = _U('deposit_amount')
			}, function(data, menu)

				local amount = tonumber(data.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu.close()
					TriggerServerEvent('spoleczenstwo:kitrajUkrytyHajsBlack', society, amount)
				end

			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'manage_employees' then
			OpenHiddenManageEmployeesMenu(society, level)
		end

	end, function(data, menu)
		if close then
			close(data, menu)
		end
	end)

end

function OpenHiddenManageEmployeesMenu(society, level)
	ESX.TriggerServerCallback('society:countHiddenMembers', function(all)
		local maxCount = tonumber(level) * 5

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_' .. society, {
			title    = _U('employee_management'),
			align    = 'top-left',
			elements = {
				{label = _U('employee_list') .. ' <span style="color: #add8e6;">' .. all .. '/' .. maxCount .. '</span>', value = 'employee_list'},
				{label = _U('recruit'),       value = 'recruit'}
			}
		}, function(data, menu)

			if data.current.value == 'employee_list' then
				OpenHiddenEmployeeList(society, level)
			end

			if data.current.value == 'recruit' then
				OpenHiddenRecruitMenu(society, level)
			end

		end, function(data, menu)
			menu.close()
		end)
	end, society)
end

function OpenHiddenEmployeeList(society, level)
	ESX.TriggerServerCallback('flux:pokazUkrytychKlapkow', function(employees)
		local elements = {
			head = {_U('employee'), _U('grade'), _U('actions')},
			rows = {}
		}

		for i=1, #employees, 1 do
			local gradeLabel = (employees[i].hiddenjob.grade_label == '' and employees[i].hiddenjob.label or employees[i].hiddenjob.grade_label)

			table.insert(elements.rows, {
				data = employees[i],
				cols = {
					employees[i].name,
					gradeLabel,
					'{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}'
				}
			})
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. society, elements, function(data, menu)
			local employee = data.data

			if data.value == 'promote' then
				menu.close()
				OpenHiddenPromoteMenu(society, employee, level)
			elseif data.value == 'fire' then
				ESX.ShowNotification(_U('you_have_fired', employee.name))

				ESX.TriggerServerCallback('esx_society:setHiddenJob', function()
					OpenHiddenEmployeeList(society, level)
				end, employee.identifier, 'unemployed', 0, 'fire')
			end
		end, function(data, menu)
			menu.close()
			OpenHiddenManageEmployeesMenu(society, level)
		end)

	end, society)

end

function OpenHiddenRecruitMenu(society, level)
	ESX.TriggerServerCallback('society:countMembers', function(all)
		if all >= (tonumber(level) * 5) then
			if tonumber(level) == 20 then
				ESX.ShowNotification('~r~Twoja organizacja posiada już maksymalny poziom i maksymalną ilość członków')
			else
				ESX.ShowNotification('~r~Aby zatrudnić więcej osób musisz podnieść poziom organizacji')
			end
		else
			local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)
			if json.encode(players) ~= '[]' then
				local elements = {}
				local serverIds = {}

				for k,v in ipairs(players) do
					if v ~= PlayerId() then
						table.insert(serverIds, GetPlayerServerId(v))
					end
				end
				ESX.TriggerServerCallback("esx_society:getMeNames",function(identities)
					for k,v in pairs(identities) do
						table.insert(elements, {
							player = k,
							label = v
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_' .. society, {
						title    = _U('recruiting'),
						align    = 'top-left',
						elements = elements
					}, function(data, menu)

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_confirm_' .. society, {
							title    = _U('do_you_want_to_recruit', data.current.label),
							align    = 'top-left',
							elements = {
								{label = _U('no'),  value = 'no'},
								{label = _U('yes'), value = 'yes'}
							}
						}, function(data2, menu2)
							menu2.close()

							if data2.current.value == 'yes' then
								ESX.ShowNotification(_U('you_have_hired', data.current.label))

								ESX.TriggerServerCallback('esx_society:setHiddenJob', function()
									OpenHiddenRecruitMenu(society, level)
								end, data.current.player, society, 0, 'hire')
							end
						end, function(data2, menu2)
							menu2.close()
						end)

					end, function(data, menu)
						menu.close()
					end)

				end, serverIds)
			else
				ESX.ShowNotification('~r~Brak graczy w pobliżu!')
			end
		end
	end, society)
end

function OpenHiddenPromoteMenu(society, employee, level)

	ESX.TriggerServerCallback('esx_society:getJob', function(job)

		local elements = {}

		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

			table.insert(elements, {
				label = gradeLabel,
				value = job.grades[i].grade,
				selected = (employee.hiddenjob.grade == job.grades[i].grade)
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'promote_employee_' .. society, {
			title    = _U('promote_employee', employee.name),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()
			ESX.ShowNotification(_U('you_have_promoted', employee.name, data.current.label))

			ESX.TriggerServerCallback('esx_society:setHiddenJob', function()
				OpenHiddenEmployeeList(society, level)
			end, employee.identifier, society, data.current.value, 'promote')
		end, function(data, menu)
			menu.close()
			OpenHiddenEmployeeList(society, level)
		end)

	end, society)

end

AddEventHandler('esx_society:openHiddenBossMenu', function(society, level, close, options)
	OpenHiddenBossMenu(society, level, close, options)
end)