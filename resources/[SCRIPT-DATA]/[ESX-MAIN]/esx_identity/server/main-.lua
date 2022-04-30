ESX = nil

TriggerEvent('esx:getShtestaredObjtestect', function(obj) ESX = obj end)

RegisterServerEvent('getIdentity')
AddEventHandler('getIdentity', function(source, callback)
	local identifier = ESX.GetPlayerFromId(source).identifier

	MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1].firstname ~= nil then
			local data = {
				identifier			= result[1].identifier,
				charid				= result[1].charid,
				firstname			= result[1].firstname,
				lastname			= result[1].lastname,
				fake_firstname		= result[1].fake_firstname,
				fake_lastname		= result[1].fake_lastname,
				dateofbirth			= result[1].dateofbirth,
				sex					= result[1].sex,
				status				= result[1].status,
				height				= result[1].height,
				accounts 			= result[1].accounts,
				inventory			= result[1].inventory,
				job					= result[1].job,
				job_grade  			= result[1].job_grade,
				job_count  			= result[1].job_count,
				loadout				= result[1].loadout,
				isDead 				= result[1].isDead,
				position			= result[1].position,
				last_property 		= result[1].last_property,
				insuranceDate		= result[1].insuranceDate,
				mechanicyDate		= result[1].mechanicyDate,
				tattoos				= result[1].tattoos,
				piekarz				= result[1].piekarz,
                sadkursy            = result[1].sadkursy,
				zlomkursy           = result[1].zlomkursy,
				winiarnia			= result[1].winiarnia,
				kursy				= result[1].kursy,
				odznaka				= result[1].odznaka,
				phone_number		= result[1].phone_number,
				animacje			= result[1].animacje,
				cardsnumber			= result[1].cardsnumber,
				job_level			= result[1].job_level,
				kawa				= result[1].kawa,
				hospital			= result[1].hospital,
				notepad				= result[1].notepad,
				opaska				= result[1].opaska,
				slot				= result[1].slot,
				
			}

			callback(data)
		else
			local data = {
				identifier			= '',
				idchar				= '',
				firstname			= '',
				lastname			= '',
				fake_firstname		= '',
				fake_lastname		= '',
				dateofbirth			= '',
				sex					= '',
				status				= '',
				height				= '',
				accounts 			= '',
				inventory			= '',
				job					= '',
				job_grade	  		= '',
				job_count  			= '',
				loadout				= '',
				isDead 				= '',
				position			= '',
				last_property 		= '',
				insuranceDate		= '',
				mechanicyDate		= '',
				tattoos				= '',
				piekarz				= '',
				sadkursy            = '',
				zlomkursy           = '',
				winiarnia			= '',
				kursy				= '',
				odznaka				= '',
				phone_number		= '',
				animacje 			= '',
				cardsnumber			= '',
				job_level			= '',
				kawa				= '',
				hospital			= '',
				notepad				= '',
				opaska				= '',
				slot				= '',
			}

			callback(data)
		end
	end)
end)


AddEventHandler('esx:playerLoaded', function(source, xPlayer)
	local myID = {
		steamid = xPlayer.identifier,
		playerid = source
	}

	TriggerClientEvent('esx_identity:saveID', source, myID)
	
	TriggerEvent('getIdentity', source, function(data)
		if data.firstname == '' then
			TriggerClientEvent('esx_identity:identityCheck', source, false, false)
			TriggerClientEvent('esx_identity:showRegisterIdentity', source)
		else
			TriggerClientEvent('esx_identity:identityCheck', source, true)
		end
	end)
end)

RegisterServerEvent('getCharacters')
AddEventHandler('getCharacters', function(source, callback)
	local identifier = ESX.GetPlayerFromId(source).identifier
	MySQL.Async.fetchAll('SELECT * FROM `characters` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] and result[2] and result[3] then

			local data = {
				identifier				= result[1].identifier,
				
				--Char 1
				charid1					= result[1].charid,
				firstname1				= result[1].firstname,
				lastname1				= result[1].lastname,
				fake_firstname1			= result[1].fake_firstname,
				fake_lastname1			= result[1].fake_lastname,
				dateofbirth1			= result[1].dateofbirth,
				sex1					= result[1].sex,
				status1					= result[1].status,
				height1					= result[1].height,
				accounts1 				= result[1].accounts,
				inventory1				= result[1].inventory,
				job1					= result[1].job,
				skin1					= result[1].skin,
				job_grade1  			= result[1].job_grade,
				job_count1  			= result[1].job_count1,
				loadout1				= result[1].loadout,
				isDead1 				= result[1].isDead,
				position1				= result[1].position,
				last_property1 			= result[1].last_property,
				insuranceDate1			= result[1].insuranceDate,
				mechanicyDate1			= result[1].mechanicyDate,
				tattoos1				= result[1].tattoos,
				piekarz1				= result[1].piekarz,
				sadkursy1               = result[1].sadkursy,
				zlomkursy1              = result[1].zlomkursy,
				winiarnia1				= result[1].winiarnia,
				kursy1					= result[1].kursy,
				odznaka1				= result[1].odznaka,
				phone_number1			= result[1].phone_number,
				animacje1				= result[1].animacje,
				cardsnumber1			= result[1].cardsnumber,
				job_level1				= result[1].job_level,
				kawa1					= result[1].kawa,
				hospital1				= result[1].hospital,
				notepad1				= result[1].notepad,
				opaska1					= result[1].opaska,
				slot1					= result[1].slot,
				
				--Char 2
				
				charid2					= result[2].charid,
				firstname2				= result[2].firstname,
				lastname2				= result[2].lastname,
				fake_firstname2			= result[2].fake_firstname,
				fake_lastname2			= result[2].fake_lastname,
				dateofbirth2			= result[2].dateofbirth,
				sex2					= result[2].sex,
				status2					= result[2].status,
				height2					= result[2].height,
				accounts2 				= result[2].accounts,
				inventory2				= result[2].inventory,
				job2					= result[2].job,
				skin2					= result[2].skin,
				job_grade2  			= result[2].job_grade,
				job_count2  			= result[2].job_count,
				loadout2				= result[2].loadout,
				isDead2 				= result[2].isDead,
				position2				= result[2].position,
				last_property2 			= result[2].last_property,
				insuranceDate2			= result[2].insuranceDate,
				mechanicyDate2			= result[2].mechanicyDate,
				tattoos2				= result[2].tattoos,
				piekarz2				= result[2].piekarz,
				sadkursy2               = result[2].sadkursy,
				zlomkursy2              = result[2].zlomkursy,
				winiarnia2		 		= result[2].winiarnia,
				kursy2					= result[2].kursy,
				odznaka2				= result[2].odznaka,
				phone_number2			= result[2].phone_number,
				animacje2				= result[2].animacje,
				cardsnumber2			= result[2].cardsnumber,
				job_level2				= result[2].job_level,
				kawa2					= result[2].kawa,
				hospital2				= result[2].hospital,
				notepad2				= result[2].notepad,
				opaska2					= result[2].opaska,
				slot2					= result[2].slot,
				
				--Char 3
				
				charid3					= result[3].charid,
				firstname3				= result[3].firstname,
				lastname3				= result[3].lastname,
				fake_firstname3			= result[3].fake_firstname,
				fake_lastname3			= result[3].fake_lastname,
				dateofbirth3			= result[3].dateofbirth,
				sex3					= result[3].sex,
				status3					= result[3].status,
				height3					= result[3].height,
				accounts3 				= result[3].accounts,
				inventory3				= result[3].inventory,
				job3					= result[3].job,
				skin3					= result[3].skin,
				job_grade3  			= result[3].job_grade,
				job_count3  			= result[3].job_count,
				loadout3				= result[3].loadout,
				isDead3					= result[3].isDead,
				position3				= result[3].position,
				last_property3 			= result[3].last_property,
				insuranceDate3			= result[3].insuranceDate,
				mechanicyDate3			= result[3].mechanicyDate,
				tattoos3				= result[3].tattoos,
				piekarz3				= result[3].piekarz,
				sadkursy3               = result[3].sadkursy,
				zlomkursy3              = result[3].zlomkursy,
				winiarnia3				= result[3].winiarnia,
				kursy3					= result[3].kursy,
				odznaka3				= result[3].odznaka,
				phone_number3			= result[3].phone_number,
				animacje3				= result[3].animacje,
				cardsnumber3			= result[3].cardsnumber,
				job_level3				= result[3].job_level,
				kawa3					= result[3].kawa,
				hospital3				= result[3].hospital,
				notepad3				= result[3].notepad,
				opaska3					= result[3].opaska,
				slot3					= result[3].slot,
			}

			callback(data)

		elseif result[1] and result[2] and not result[3] then

			local data = {
				identifier				= result[1].identifier,
				
				--Char 1
				charid1					= result[1].charid,
				firstname1				= result[1].firstname,
				lastname1				= result[1].lastname,
				fake_firstname1			= result[1].fake_firstname,
				fake_lastname1			= result[1].fake_lastname,
				dateofbirth1			= result[1].dateofbirth,
				sex1					= result[1].sex,
				status1					= result[1].status,
				height1					= result[1].height,
				accounts1 				= result[1].accounts,
				inventory1				= result[1].inventory,
				job1					= result[1].job,
				skin1					= result[1].skin,
				job_grade1  			= result[1].job_grade,
				job_count1  			= result[1].job_count,
				loadout1				= result[1].loadout,
				isDead1 				= result[1].isDead,
				position1				= result[1].position,
				last_property1 			= result[1].last_property,
				insuranceDate1			= result[1].insuranceDate,
				mechanicyDate1			= result[1].mechanicyDate,
				tattoos1				= result[1].tattoos,
				piekarz1				= result[1].piekarz,
				sadkursy1               = result[1].sadkursy,
				zlomkursy1              = result[1].zlomkursy,
				winiarnia1				= result[1].winiarnia,
				kursy1					= result[1].kursy,
				odznaka1				= result[1].odznaka,
				phone_number1			= result[1].phone_number,
				animacje1				= result[1].animacje,
				cardsnumber1			= result[1].cardsnumber,
				job_level1				= result[1].job_level,
				kawa1					= result[1].kawa,
				hospital1				= result[1].hospital,
				notepad1				= result[1].notepad,
				opaska1					= result[1].opaska,
				slot1					= result[1].slot,
				
				--Char 2
				
				charid2					= result[2].charid,
				firstname2				= result[2].firstname,
				lastname2				= result[2].lastname,
				fake_firstname2			= result[2].fake_firstname,
				fake_lastname2			= result[2].fake_lastname,
				dateofbirth2			= result[2].dateofbirth,
				sex2					= result[2].sex,
				status2					= result[2].status,
				height2					= result[2].height,
				accounts2 				= result[2].accounts,
				inventory2				= result[2].inventory,
				job2					= result[2].job,
				skin2					= result[2].skin,
				job_grade2  			= result[2].job_grade,
				job_count2  			= result[2].job_count,
				loadout2				= result[2].loadout,
				isDead2 				= result[2].isDead,
				position2				= result[2].position,
				last_property2 			= result[2].last_property,
				insuranceDate2			= result[2].insuranceDate,
				mechanicyDate2			= result[2].mechanicyDate,
				tattoos2				= result[2].tattoos,
				piekarz2			    = result[1].piekarz,
				sadkursy2               = result[1].sadkursy,
				zlomkursy2              = result[1].zlomkursy,
				winiarnia2				= result[2].winiarnia,
				kursy2					= result[2].kursy,
				odznaka2				= result[2].odznaka,
				phone_number2			= result[2].phone_number,
				animacje2				= result[2].animacje,
				cardsnumber2			= result[2].cardsnumber,
				job_level2				= result[2].job_level,
				kawa2					= result[2].kawa,
				hospital2				= result[2].hospital,
				notepad2				= result[2].notepad,
				opaska2					= result[2].opaska,
				slot2					= result[2].slot,
				
				--Char 3
				
				charid3					= '',
				firstname3				= '',
				lastname3				= '',
				fake_firstname3			= '',
				fake_lastname3			= '',
				dateofbirth3			= '',
				sex3					= '',
				status3					= '',
				height3					= '',
				accounts3 				= '',
				inventory3				= '',
				job3					= '',
				skin3					= '',
				job_grade3  			= '',
				job_count3  			= '',
				loadout3				= '',
				isDead3					= '',
				position3				= '',
				last_property3 			= '',
				insuranceDate3			= '',
				mechanicyDate3			= '',
				tattoos3				= '',
				piekarz3			    = '',
				sadkursy3				= '',
				zlomkursy3				= '',
				winiarnia3				= '',
				kursy3					= '',
				odznaka3				= '',
				phone_number3			= '',
				animacje3				= '',
				cardsnumber3			= '',
				job_level3				= '',
				kawa3					= '',
				hospital3				= '',
				notepad3				= '',
				opaska3					= '',
				slot3					= '',
			}

			callback(data)

		elseif result[1] and not result[2] and not result[3] then

			local data = {
				identifier				= result[1].identifier,
				
				--Char 1
				charid1					= result[1].charid,
				firstname1				= result[1].firstname,
				lastname1				= result[1].lastname,
				fake_firstname1			= result[1].fake_firstname,
				fake_lastname1			= result[1].fake_lastname,
				dateofbirth1			= result[1].dateofbirth,
				sex1					= result[1].sex,
				status1					= result[1].status,
				height1					= result[1].height,
				accounts1 				= result[1].accounts,
				inventory1				= result[1].inventory,
				job1					= result[1].job,
				skin1					= result[1].skin,
				job_grade1  			= result[1].job_grade,
				job_count1  			= result[1].job_count,
				loadout1				= result[1].loadout,
				isDead1 				= result[1].isDead,
				position1				= result[1].position,
				last_property1 			= result[1].last_property,
				insuranceDate1			= result[1].insuranceDate,
				mechanicyDate1			= result[1].mechanicyDate,
				tattoos1				= result[1].tattoos,
				piekarz1				= result[1].piekarz,
				sadkursy1               = result[1].sadkursy,
				zlomkursy1              = result[1].zlomkursy,
				winiarnia1				= result[1].winiarnia,
				kursy1					= result[1].kursy,
				odznaka1				= result[1].odznaka,
				phone_number1			= result[1].phone_number,
				animacje1				= result[1].animacje,
				cardsnumber1			= result[1].cardsnumber,
				job_level1				= result[1].job_level,
				kawa1					= result[1].kawa,
				hospital1				= result[1].hospital,
				notepad1				= result[1].notepad,
				opaska1					= result[1].opaska,
				slot1					= result[1].slot,
				
				--Char 2
				
				charid2					= '',
				firstname2				= '',
				lastname2				= '',
				fake_firstname2			= '',
				fake_lastname2			= '',
				dateofbirth2			= '',
				sex2					= '',
				status2					= '',
				height2					= '',
				accounts2 				= '',
				inventory2				= '',
				job2					= '',
				skin2					= '',
				job_grade2  			= '',
				job_count2  			= '',
				loadout2				= '',
				isDead2					= '',
				position2				= '',
				last_property2 			= '',
				insuranceDate2			= '',
				mechanicyDate2			= '',
				tattoos2				= '',
				piekarz2				= '',
				sadkursy2				= '',
				zlomkursy2				= '',
				winiarnia2				= '',
				kursy2					= '',
				odznaka2				= '',
				phone_number2			= '',
				animacje2				= '',
				cardsnumber2			= '',
				job_level2				= '',
				kawa2					= '',
				hospital2				= '',
				notepad2				= '',
				opaska2					= '',
				slot2					= '',
				
				--Char 3
				
				charid3					= '',
				firstname3				= '',
				lastname3				= '',
				fake_firstname3			= '',
				fake_lastname3			= '',
				dateofbirth3			= '',
				sex3					= '',
				status3					= '',
				height3					= '',
				accounts3 				= '',
				inventory3				= '',
				job3					= '',
				skin3					= '',
				job_grade3  			= '',
				job_count3 				= '',
				loadout3				= '',
				isDead3					= '',
				position3				= '',
				last_property3 			= '',
				insuranceDate3			= '',
				mechanicyDate3			= '',
				tattoos3				= '',
				piekarz3				= '',
				sadkursy3				= '',
				zlomkursy3				= '',
				kursy3					= '',
				winiarnia3				= '',
				odznaka3				= '',
				phone_number3			= '',
				animacje3				= '',
				cardsnumber3			= '',
				job_level3				= '',
				kawa3					= '',
				hospital3				= '',
				notepad3				= '',
				opaska3					= '',
				slot3					= '',
			}	

			callback(data)

		else

			local data = {
				--Char 1
				charid1					= '',
				firstname1				= '',
				lastname1				= '',
				fake_firstname1			= '',
				fake_lastname1			= '',
				dateofbirth1			= '',
				sex1					= '',
				status1					= '',
				height1					= '',
				accounts1 				= '',
				inventory1				= '',
				skin1					= '',
				job1					= '',
				job_grade1  			= '',
				job_count1  			= '',
				loadout1				= '',
				isDead1					= '',
				position1				= '',
				last_property1 			= '',
				insuranceDate1			= '',
				mechanicyDate1			= '',
				tattoos1				= '',
				piekarz1				= '',
				sadkursy1				= '',
				zlomkursy1				= '',
				winiarnia1				= '',
				kursy1					= '',
				odznaka1				= '',
				phone_number1			= '',
				animacje1				= '',
				cardsnumber1			= '',
				job_level1				= '',
				kawa1					= '',
				hospital1				= '',
				notepad1				= '',
				opaska1					= '',
				slot1					= '',
				
				--Char 2
				
				charid2					= '',
				firstname2				= '',
				lastname2				= '',
				fake_firstname2			= '',
				fake_lastname2			= '',
				dateofbirth2			= '',
				sex2					= '',
				status2					= '',
				height2					= '',
				accounts2 				= '',
				inventory2				= '',
				job2					= '',
				skin2					= '',
				job_grade2  			= '',
				job_count2  			= '',
				loadout2				= '',
				isDead2					= '',
				position2				= '',
				last_property2 			= '',
				insuranceDate2			= '',
				mechanicyDate2			= '',
				tattoos2				= '',
				piekarz2				= '',
				sadkursy2				= '',
				zlomkursy2				= '',
				kursy2					= '',
				winiarnia2				= '',
				odznaka2				= '',
				phone_number2			= '',
				animacje2				= '',
				cardsnumber2			= '',
				job_level2				= '',
				kawa2					= '',
				hospital2				= '',
				notepad2				= '',
				opaska2					= '',
				slot2					= '',
				
				--Char 3
				
				charid3					= '',
				firstname3				= '',
				lastname3				= '',
				fake_firstname3			= '',
				fake_lastname3			= '',
				dateofbirth3			= '',
				sex3					= '',
				status3					= '',
				height3					= '',
				accounts3 				= '',
				inventory3				= '',
				job3					= '',
				skin3					= '',
				job_grade3  			= '',
				job_count3  			= '',
				loadout3				= '',
				isDead3					= '',
				position3				= '',
				last_property3 			= '',
				insuranceDate3			= '',
				mechanicyDate3			= '',
				tattoos3				= '',
				piekarz3				= '',
				sadkursy3				= '',
				zlomkursy3				= '',
				kursy3					= '',
				winiarnia3				= '',
				odznaka3				= '',
				phone_number3			= '',
				animacje3				= '',
				cardsnumber3			= '',
				job_level3				= '',
				kawa3					= '',
				hospital3				= '',
				notepad3				= '',
				opaska3					= '',
				slot3					= '',
			}

			callback(data)

		end
	end)
end)



RegisterServerEvent('setIdentity')
AddEventHandler('setIdentity', function(identifier, data, callback)
	local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	local length = 10
	local charid = ''
	charTable = {}
	for c in chars:gmatch"." do
		table.insert(charTable, c)
	end
	
	for i = 1, length do
		charid = charid .. charTable[math.random(1, #charTable)]
	end
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height, `accounts` = @accounts, `job` = @job, `job_grade` = @job_grade, `charid` = @charid, `phone_number` = @phone_number WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@fake_firstname']	= '',
		['@fake_lastname']	= '',
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height,
		['@accounts']		= '{"money":0,"bank":0,"black_money":0}',
		['@job']			= "unemployed",
		['@job_grade']		= "0",
		['@charid']			= charid,
		['@phone_number']	= '',
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
		MySQL.Async.execute('INSERT INTO characters (identifier, firstname, lastname, dateofbirth, sex, height, accounts, job, job_grade, charid, phone_number) VALUES (@identifier, @firstname, @lastname, @dateofbirth, @sex, @height, @accounts, @job, @job_grade, @charid, @phone_number)', {
			['@identifier']		= identifier,
			['@firstname']		= data.firstname,
			['@lastname']		= data.lastname,
			['@dateofbirth']	= data.dateofbirth,
			['@sex']			= data.sex,
			['@height']			= data.height,
			['@accounts']		= '{"money":0,"bank":0,"black_money":0}',
			['@job']			= "unemployed",
			['@job_grade']		= "0",
			['@charid']			= charid,
			['@phone_number']	= ""
		})
	end)	
	
end)

RegisterServerEvent('saveIdentityBeforeChange')
AddEventHandler('saveIdentityBeforeChange', function(identifier, data, callback)
	local xPlayer = ESX.GetPlayerFromId(source)
	ESX.SavePlayer(xPlayer)
	
	Citizen.Wait(2500)
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(data)
		MySQL.Async.execute('UPDATE `characters` SET `charid` = @charid, `firstname` = @firstname, `fake_firstname` = @fake_firstname, `fake_lastname` = @fake_lastname, `lastname` = @lastname, `fake_firstname` = @fake_firstname, `fake_lastname` = @fake_lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `status` = @status, `height` = @height, `accounts` = @accounts, `skin` = @skin, `inventory` = @inventory, `job` = @job, `job_grade` = @job_grade, `job_count` = @job_count, `loadout` = @loadout, `isDead` = @isDead, `insuranceDate` = @insuranceDate, `mechanicyDate` = @mechanicyDate, `tattoos` = @tattoos, `zlomkursy` = @zlomkursy, `sadkursy` = @sadkursy, `piekarz` = @piekarz, `winiarnia` = @winiarnia, `odznaka` = @odznaka, `kursy` = @kursy, `phone_number` = @phone_number, `animacje` = @animacje, `cardsnumber` = @cardsnumber, `job_level` = @job_level, `kawa` = @kawa, `hospital` = @hospital, `notepad` = @notepad, `opaska` = @opaska, `slot` = @slot WHERE identifier = @identifier AND charid = @charid', {
			['@identifier']					= xPlayer.identifier,
			['@charid']						= data[1].charid,
			['@firstname']					= data[1].firstname,
			['@lastname']					= data[1].lastname,
			['@fake_firstname']				= data[1].fake_firstname,
			['@fake_lastname']				= data[1].fake_lastname,
			['@dateofbirth']				= data[1].dateofbirth,
			['@sex']						= data[1].sex,
			['@status'] 					= data[1].status,
			['@height']						= data[1].height,
			['@accounts']					= data[1].accounts,
			['@skin']						= data[1].skin,
			['@inventory']					= data[1].inventory,
			['@job']						= data[1].job,
			['@job_grade']					= data[1].job_grade,
			['@job_count']  				= data[1].job_count,
			['@loadout']					= data[1].loadout,
			['@isDead']						= data[1].isDead,
			['@insuranceDate']				= data[1].insuranceDate,
			['@mechanicyDate']				= data[1].mechanicyDate,
			['@tattoos']					= data[1].tattoos,
			['@zlomkursy']					= data[1].zlomkursy,
			['@piekarz']					= data[1].piekarz,
			['@sadkursy']					= data[1].sadkursy,
			['@winiarnia'] 					= data[1].winiarnia,
			['@odznaka']					= data[1].odznaka,
			['@kursy']						= data[1].kursy,
			['@phone_number']				= data[1].phone_number,
			['@animacje']					= data[1].animacje,
			['@cardsnumber']				= data[1].cardsnumber,
			['@job_level']					= data[1].job_level,
			['@kawa']						= data[1].kawa,
			['@hospital'] 					= data[1].hospital,
			['@notepad'] 					= data[1].notepad,
			['@opaska']						= data[1].opaska,
			['@slot']						= data[1].slot,
			
	}, function(rowsChanged)
			if rowsChanged then
				-- ESX.SavePlayer(xPlayer)
			end
		end)
	end)	
end)

RegisterServerEvent('esx_identity:getClientInfo')
AddEventHandler('esx_identity:getClientInfo', function(identifier)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = ESX.GetPlayerFromId(source).identifier
	local source = xPlayer.source	
	TriggerEvent('getCharacters', source, function(data)
		if xPlayer ~= nil then
			local source		= source
			local firstname1 	= data.firstname1
			local lastname1 	= data.lastname1
			local firstname2 	= data.firstname2
			local lastname2 	= data.lastname2
			local firstname3 	= data.firstname3
			local lastname3 	= data.lastname3
			TriggerClientEvent('esx_identity:setCharacterInformation',  source, firstname1, lastname1, firstname2, lastname2, firstname3, lastname3)
		end
	end)	
end)

ESX.RegisterServerCallback('esx_identity:listcharacters', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = ESX.GetPlayerFromId(source).identifier
	local source = xPlayer.source	
	TriggerEvent('getCharacters', source, function(data)
		TriggerEvent('getIdentity', source, function(data2)
			if xPlayer ~= nil then
				cb(data, data2)
			end
		end)
	end)
end)

RegisterServerEvent('setCharacterData')
AddEventHandler("setCharacterData", function(xPlayer, setData)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = ESX.GetPlayerFromId(source).identifier
	MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier,
		['@loadout']	= loadout,
		['@group']		= group,
	}, function(result)
		TriggerEvent('esx:playerLoaded', xPlayer.source, xPlayer)
	end)
end)

RegisterServerEvent('setCharacterDataSwitch')
AddEventHandler("setCharacterDataSwitch", function(setData)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = ESX.GetPlayerFromId(source).identifier
	MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier,
		['@loadout']	= loadout,
		['@group']		= group,
	}, function(result)
		if result[1].firstname ~= nil and xPlayer ~= nill then
			TriggerEvent('esx:playerLoaded', xPlayer.source, xPlayer)
		end
	end)
end)

RegisterServerEvent('esx_identity:setIdentity')
AddEventHandler('esx_identity:setIdentity', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerEvent('setIdentity', xPlayer.identifier, data, function(callback)
		if callback then
			TriggerClientEvent('esx_identity:identityCheck', xPlayer.source, true)
		end
	end)
end)

ESX.RegisterServerCallback('esx_identity:characterCheck', function(source, check)
	TriggerEvent('getCharacters', source, function(data)
		if data.firstname3 == '' then
			check(true)
		elseif data.firstname3 ~= '' then
			check(false)
		end
	end)
end)


RegisterServerEvent("esx_identity:CharacterChosen")
AddEventHandler("esx_identity:CharacterChosen", function(charidd)
	local source = source
	local charNumber = tonumber(charidd)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('getCharacters', source, function(data)	
		if charNumber == 1 and xPlayer ~= nil then
			local data = {
				identifier				= data.identifier,				
				charid					= data.charid1,
				firstname				= data.firstname1,
				lastname				= data.lastname1,
				fake_firstname			= data.fake_firstname1,
				fake_lastname			= data.fake_lastname1,
				dateofbirth				= data.dateofbirth1,
				sex						= data.sex1,
				status					= data.status1,
				height					= data.height1,
				accounts 				= data.accounts1,
				inventory				= data.inventory1,
				job						= data.job1,
				skin 					= data.skin1,
				job_grade  				= data.job_grade1,
				job_count  				= data.job_count1,
				loadout					= data.loadout1,
				isDead 					= data.isDead1,
				position				= data.position1,
				last_property			= data.last_property1,
				insuranceDate			= data.insuranceDate1,
				mechanicyDate			= data.mechanicyDate1,
				tattoos					= data.tattoos1,
				zlomkursy				= data.zlomkursy1,
				piekarz					= data.piekarz1,
				sadkursy				= data.sadkursy1,
				winiarnia				= data.winiarnia1,
				kursy					= data.kursy1,
				odznaka					= data.odznaka1,
				phone_number			= data.phone_number1,
				animacje				= data.animacje1,
				cardsnumber				= data.cardsnumber1,
				job_level				= data.job_level1,
				kawa					= data.kawa1,
				hospital				= data.hospital1,
				notepad					= data.notepad1,
				opaska					= data.opaska1,
				slot					= data.slot1
			}
			if data.firstname ~= '' then
				local identifier = ESX.GetPlayerFromId(source).identifier
				MySQL.Async.execute('UPDATE users SET `charid` = @charid, `firstname` = @firstname, `lastname` = @lastname, `fake_firstname` = @fake_firstname, `fake_lastname` = @fake_lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `status` = @status, `height` = @height, `skin` = @skin, `accounts` = @accounts, `inventory` = @inventory, `job` = @job, `job_grade` = @job_grade, `job_count` = @job_count, `loadout` = @loadout, `isDead` = @isDead, `position` = @position, `last_property` = @last_property, `insuranceDate` = @insuranceDate, `mechanicyDate` = @mechanicyDate, `tattoos` = @tattoos, `zlomkursy` = @zlomkursy, `sadkursy` = @sadkursy, `piekarz` = @piekarz, `kursy` = @kursy, `winiarnia` = @winiarnia, `odznaka` = @odznaka, `phone_number` = @phone_number, `animacje` = @animacje, `cardsnumber` = @cardsnumber, `job_level` = @job_level, `kawa` = @kawa, `hospital` = @hospital, `notepad` = @notepad, `opaska` = @opaska, `slot` = @slot WHERE identifier = @identifier', {
					['@identifier']					= identifier,
					['@charid']						= data.charid,
					['@firstname']					= data.firstname,
					['@lastname']					= data.lastname,
					['@fake_firstname']				= data.fake_firstname,
					['@fake_lastname']				= data.fake_lastname,
					['@dateofbirth']				= data.dateofbirth,
					['@sex']						= data.sex,
					['@status']						= data.status,
					['@height']						= data.height,
					['@skin']						= data.skin,
					['@accounts']					= data.accounts,
					['@inventory']					= data.inventory,
					['@job']						= data.job,
					['@job_grade']					= data.job_grade,
					['@job_count']					= data.job_count,
					['@loadout']					= data.loadout,
					['@isDead']						= data.isDead,
					['@position']					= data.position,
					['@last_property']				= data.last_property,
					['@insuranceDate']				= data.insuranceDate,
					['@mechanicyDate']				= data.mechanicyDate,
					['@tattoos']					= data.tattoos,
					['@zlomkursy']					= data.zlomkursy,
					['@piekarz']					= data.piekarz,
					['@sadkursy']					= data.sadkursy,
					['@kursy']						= data.kursy,
					['@winiarnia']					= data.winiarnia,
					['@odznaka']					= data.odznaka,
					['@phone_number']				= data.phone_number,
					['@animacje']					= data.animacje,
					['@cardsnumber']				= data.cardsnumber,
					['@job_level']					= data.job_level,
					['@kawa']						= data.kawa,
					['@hospital']					= data.hospital,
					['@notepad']					= data.notepad,
					['@opaska']						= data.opaska,
					['@slot']						= data.slot
				}, function(rowsChanged)
					if rowsChanged then
						TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Aktualizacja postaci na: ^2' .. data.firstname .. ' ' .. data.lastname } })
						TriggerClientEvent('updateIdentity', source, data.skin)
					else
						TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Nie udało się zmienić postać!' } })
					end
				end)
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Nie posiadasz postaci na 1 slocie!' } })
			end
		elseif charNumber == 2 then

			local data = {
				identifier				= data.identifier,				
				charid					= data.charid2,
				firstname				= data.firstname2,
				lastname				= data.lastname2,
				fake_firstname			= data.fake_firstname2,
				fake_lastname			= data.fake_lastname2,
				dateofbirth				= data.dateofbirth2,
				sex						= data.sex2,
				status					= data.status2,
				height					= data.height2,
				accounts 				= data.accounts2,
				inventory				= data.inventory2,
				job						= data.job2,
				skin 					= data.skin2,
				job_grade  				= data.job_grade2,
				job_count				= data.job_count2,
				loadout					= data.loadout2,
				isDead 					= data.isDead2,
				position				= data.position2,
				last_property			= data.last_property2,
				insuranceDate			= data.insuranceDate2,
				mechanicyDate			= data.mechanicyDate2,
				tattoos					= data.tattoos2,
				zlomkursy				= data.zlomkursy2,
				piekarz					= data.piekarz2,
				sadkursy				= data.sadkursy2,
				winiarnia				= data.winiarnia2,
				kursy					= data.kursy2,
				odznaka					= data.odznaka2,
				phone_number			= data.phone_number2,
				animacje				= data.animacje2,
				cardsnumber				= data.cardsnumber2,
				job_level				= data.job_level2,
				kawa					= data.kawa2,
				hospital				= data.hospital2,
				notepad					= data.notepad2,
				opaska					= data.opaska2,
				slot					= data.slot2
			}

			if data.firstname ~= '' then
				local identifier = ESX.GetPlayerFromId(source).identifier
				local xPlayer = xPlayer
				MySQL.Async.execute('UPDATE users SET `charid` = @charid, `firstname` = @firstname, `lastname` = @lastname, `fake_firstname` = @fake_firstname, `fake_lastname` = @fake_lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `status` = @status, `height` = @height, `skin` = @skin, `accounts` = @accounts, `inventory` = @inventory, `job` = @job, `job_grade` = @job_grade, `job_count` = @job_count, `loadout` = @loadout, `isDead` = @isDead, `position` = @position, `last_property` = @last_property, `insuranceDate` = @insuranceDate, `mechanicyDate` = @mechanicyDate, `tattoos` = @tattoos, `zlomkursy` = @zlomkursy, `sadkursy` = @sadkursy, `piekarz` = @piekarz, `kursy` = @kursy, `winiarnia` = @winiarnia, `odznaka` = @odznaka, `phone_number` = @phone_number, `animacje` = @animacje, `cardsnumber` = @cardsnumber, `job_level` = @job_level, `kawa` = @kawa, `hospital` = @hospital, `notepad` = @notepad, `opaska` = @opaska, `slot` = @slot WHERE identifier = @identifier', {
					['@identifier']					= identifier,
					['@charid']						= data.charid,
					['@firstname']					= data.firstname,
					['@lastname']					= data.lastname,
					['@fake_firstname']				= data.fake_firstname,
					['@fake_lastname']				= data.fake_lastname,
					['@dateofbirth']				= data.dateofbirth,
					['@sex']						= data.sex,
					['@status']						= data.status,
					['@height']						= data.height,
					['@skin']						= data.skin,
					['@accounts']					= data.accounts,
					['@inventory']					= data.inventory,
					['@job']						= data.job,
					['@job_grade']					= data.job_grade,
					['@job_count']					= data.job_count,
					['@loadout']					= data.loadout,
					['@isDead']						= data.isDead,
					['@position']					= data.position,
					['@last_property']				= data.last_property,
					['@insuranceDate']				= data.insuranceDate,
					['@mechanicyDate']				= data.mechanicyDate,
					['@tattoos']					= data.tattoos,
					['@zlomkursy']					= data.zlomkursy,
					['@piekarz']					= data.piekarz,
					['@sadkursy']					= data.sadkursy,
					['@kursy']						= data.kursy,
					['@odznaka']					= data.odznaka,
					['@phone_number']				= data.phone_number,
					['@animacje']					= data.animacje,
					['@cardsnumber']				= data.cardsnumber,
					['@job_level']					= data.job_level,
					['@kawa']						= data.kawa,
					['@hospital']					= data.hospital,
					['@notepad']					= data.notepad,
					['@opaska']						= data.opaska,
					['@slot']						= data.slot
				}, function(rowsChanged)
					if rowsChanged then
						TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Aktualizacja postaci na: ^2' .. data.firstname .. ' ' .. data.lastname } })
					else
						TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Nie udało się zmienić postać!' } })
					end
					TriggerClientEvent('updateIdentity', source, data.skin)
				end)
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Nie posiadasz postaci na 2 slocie!' } })
			end

		elseif charNumber == 3 then

			local data = {
				identifier				= data.identifier,				
				charid					= data.charid3,
				firstname				= data.firstname3,
				lastname				= data.lastname3,
				fake_firstname			= data.fake_firstname3,
				fake_lastname			= data.fake_lastname3,
				dateofbirth				= data.dateofbirth3,
				sex						= data.sex3,
				status					= data.status3,
				height					= data.height3,
				accounts 				= data.accounts3,
				inventory				= data.inventory3,
				job						= data.job3,
				job_grade  				= data.job_grade3,
				job_count  				= data.job_count3,
				skin 					= data.skin3,
				loadout					= data.loadout3,
				isDead 					= data.isDead3,
				position				= data.position3,
				last_property			= data.last_property3,
				insuranceDate			= data.insuranceDate3,
				mechanicyDate			= data.mechanicyDate3,
				tattoos					= data.tattoos3,
				zlomkursy				= data.zlomkursy3,
				piekarz					= data.piekarz3,
				sadkursy				= data.sadkursy3,
				winiarnia				= data.winiarnia3,
				kursy					= data.kursy3,
				odznaka					= data.odznaka3,
				phone_number			= data.phone_number3,
				animacje				= data.animacje3,
				cardsnumber				= data.cardsnumber3,
				job_level				= data.job_level3,
				kawa					= data.kawa3,
				hospital				= data.hospital3,
				notepad					= data.notepad3,
				opaska					= data.opaska3,
				slot					= data.slot3
			}
			if data.firstname ~= '' then
				local identifier = ESX.GetPlayerFromId(source).identifier
				local xPlayer = xPlayer
				MySQL.Async.execute('UPDATE users SET `charid` = @charid, `firstname` = @firstname, `lastname` = @lastname, `fake_firstname` = @fake_firstname, `fake_lastname` = @fake_lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `status` = @status, `height` = @height, `skin` = @skin, `accounts` = @accounts, `inventory` = @inventory, `job` = @job, `job_grade` = @job_grade, `job_count` = @job_count, `loadout` = @loadout, `isDead` = @isDead, `position` = @position, `last_property` = @last_property, `insuranceDate` = @insuranceDate, `mechanicyDate` = @mechanicyDate, `tattoos` = @tattoos, `zlomkursy` = @zlomkursy, `sadkursy` = @sadkursy, `piekarz` = @piekarz, `kursy` = @kursy, `winiarnia` = @winiarnia, `odznaka` = @odznaka, `phone_number` = @phone_number, `animacje` = @animacje, `cardsnumber` = @cardsnumber, `job_level` = @job_level, `kawa` = @kawa, `hospital` = @hospital, `notepad` = @notepad, `opaska` = @opaska, `slot` = @slot WHERE identifier = @identifier', {
					['@identifier']					= identifier,
					['@charid']						= data.charid,
					['@firstname']					= data.firstname,
					['@lastname']					= data.lastname,
					['@fake_firstname']				= data.fake_firstname,
					['@fake_lastname']				= data.fake_lastname,
					['@dateofbirth']				= data.dateofbirth,
					['@sex']						= data.sex,
					['@status']						= data.status,
					['@height']						= data.height,
					['@skin']						= data.skin,
					['@accounts']					= data.accounts,
					['@inventory']					= data.inventory,
					['@job']						= data.job,
					['@job_grade']					= data.job_grade,
					['@job_count']					= data.job_count,
					['@loadout']					= data.loadout,
					['@isDead']						= data.isDead,
					['@position']					= data.position,
					['@last_property']				= data.last_property,
					['@insuranceDate']				= data.insuranceDate,
					['@mechanicyDate']				= data.mechanicyDate,
					['@tattoos']					= data.tattoos,
					['@winiarnia']					= data.winiarnia,
					['@zlomkursy']					= data.zlomkursy,
					['@piekarz']					= data.piekarz,
					['@sadkursy']					= data.sadkursy,
					['@kursy']						= data.kursy,
					['@odznaka']					= data.odznaka,
					['@phone_number']				= data.phone_number,
					['@animacje']					= data.animacje,
					['@cardsnumber']				= data.cardsnumber,
					['@job_level']					= data.job_level,
					['@kawa']						= data.kawa,
					['@hospital']					= data.hospital,
					['@notepad']					= data.notepad,
					['@opaska']						= data.opaska,
					['@slot']						= data.slot
				}, function(rowsChanged)
					if rowsChanged then
						TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Aktualizacja postaci na: ^2' .. data.firstname .. ' ' .. data.lastname } })
					else
						TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Nie udało się zmienić postać!' } })
					end
					TriggerClientEvent('updateIdentity', source, data.skin)
				end)
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Nie posiadasz postaci na 3 slocie!' } })
			end
		end
	end)
end)

--------------COMMANDS

RegisterCommand('char', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.group ~= nil then
		TriggerEvent('getIdentity', source, function(data)
			if data.firstname == '' then
				TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Nie posiadasz aktywnej postaci!' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country]', 'Aktualna postac: ^2' .. data.firstname .. ' ' .. data.lastname } })
			end
		end)
	else
		xPlayer.showNotification('Nie posiadasz permisji')
	end
end, false)

RegisterCommand('charlist', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer then
		if xPlayer.group == 'zarzad' or xPlayer.group == 'admin' then
			TriggerEvent('getCharacters', source, function(data)
				if data.firstname1 ~= '' then
					TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country] Postac 1:', data.firstname1 .. ' ' .. data.lastname1 } })
					
					if data.firstname2 ~= '' then
						TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country] Postac 2:', data.firstname2 .. ' ' .. data.lastname2 } })
						
						if data.firstname3 ~= '' then
							TriggerClientEvent('chat:addMessage', source, { args = { '^3[Country] Postac 3:', data.firstname3 .. ' ' .. data.lastname3 } })
						end
					end
				else
					TriggerClientEvent('chat:addMessage', source, { args = { '^[Country]', 'Nie posiadasz postaci' } })
				end
			end)
		else
			xPlayer.showNotification('Nie posiadasz permisji')
		end
	end
end, false)

RegisterCommand('register', function(source, id, user)
	if source == 0 then
		if id[1]== nil then
			TriggerEvent('sendMessageDiscord',  "Nie podałeś ID gracza")
			return
		elseif GetPlayerPing(id[1]) == 0 then
			TriggerEvent('sendMessageDiscord',  "Niema nikogo o takim ID")
			return
		end
			
		TriggerEvent('sendMessageDiscord', "Otwarto menu register Graczowi o ID " .. id[1])
		TriggerClientEvent('esx_identity:showRegisterIdentity', id[1], 'custom', {})
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.group == 'zarzad' or xPlayer.group == 'admin' then
			if id[1]== nil then
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie podałeś ID gracza"})
				return
			elseif GetPlayerPing(id[1]) == 0 then
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Niema nikogo o takim ID"})
				return
			end
			TriggerClientEvent("pNotify:SendNotification", source, {text = "Otwarto menu register Graczowi o ID " .. id[1]})
			TriggerClientEvent('esx_identity:showRegisterIdentity', id[1], 'custom', {})
		else
			xPlayer.showNotification('Nie posiadasz permisji')
		end
	end
end, false)
