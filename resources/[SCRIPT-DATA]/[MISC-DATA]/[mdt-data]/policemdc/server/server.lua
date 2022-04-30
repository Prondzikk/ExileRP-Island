ESX = nil

local categoriesLastUpdateMillis = nil
local categoriesData = nil
local tagsLastUpdateMillis = nil
local tagsData = nil
local citizenTagPrefix = 'lspd.citizen.tag.'
local vehicleTagPrefix = 'lspd.vehicle.tag.'

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[RegisterCommand('mdt', function(source, args, rawCommand)
	TriggerClientEvent('esx_mdc_client:runMdcTablet', source)
end, false)]]

ESX.RegisterServerCallback('esx_mdc:getAllTags', function(source, cb, target)
	if updateTimeExpired(tagsLastUpdateMillis, Config.expirationCacheMillis) then
		tagsData = MySQL.Sync.fetchAll('SELECT * FROM lspd_mdc_tag_suggestion',  {});
		tagsLastUpdateMillis = now()
	end
	cb(tagsData)
end)

ESX.RegisterServerCallback('esx_mdc:getConvictionCategories', function(source, cb, target)
	if updateTimeExpired(categoriesLastUpdateMillis, Config.expirationCacheMillis) then
		local categories = MySQL.Sync.fetchAll('SELECT id, name as categoryName, color FROM lspd_mdc_judgments_suggestion_category',  {});
		categoriesData = {}
		if categories[1] ~= nil then
			for _, catSuggestion in ipairs(categories) do
				local items = MySQL.Sync.fetchAll('SELECT * FROM lspd_mdc_judgments_suggestion WHERE categoryId = @categoryId', {
					['@categoryId'] = catSuggestion.id
				});
				catSuggestion.items = items
				table.insert(categoriesData, catSuggestion)
			end
		end
		categoriesLastUpdateMillis = now()
	end
	cb(categoriesData)
end)

function updateTimeExpired(timeMillis, expirationMillis)
	return timeMillis == nil or timeMillis <= now() - expirationMillis
end

function now()
	return os.time() * 1000 -- ms
end

ESX.RegisterServerCallback('esx_mdc:getPlayerName', function(source, cb, target, jobName, jobGrade)
	local xPlayer = ESX.GetPlayerFromId(target)
	local resultUser = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
		['@identifier'] = xPlayer.identifier
	});
	local userData = resultUser[1]
	local resultDepartment = MySQL.Sync.fetchAll('SELECT CONCAT(\'(\',job.label,\' - \', grade.label,\')\') as departmentGrade FROM `jobs` job join `job_grades` grade on job.name = grade.job_name WHERE job.name=@job and grade.grade = @job_grade', {
		['job'] = jobName,
		['job_grade'] = jobGrade
	} );
	local departmentData = resultDepartment[1]
	cb(userData.firstname .. ' ' .. userData.lastname, departmentData.departmentGrade)
end)

ESX.RegisterServerCallback('esx_mdc:getCitizensWarrantsList', function(source, cb, target)
	MySQL.Async.fetchAll('SELECT CONCAT(FIRSTNAME, \' \', LASTNAME) AS `citizenName`, \'\' AS photo, `sex`, `dateofbirth` AS birthdate FROM `users` WHERE identifier IN (SELECT userId FROM `user_properties` WHERE value = \'Poszukiwany\')',  {}, 
		function(result)
			local users = result;
			local users = {}
			for _, userData in ipairs(result) do
				if userData.sex == 'M' then
					userData.sex = "Mężczyzna"
				else
					userData.sex = "Kobieta"
				end
				table.insert(users, userData)
			end
			cb(users)
		end
	);
end)

ESX.RegisterServerCallback('esx_mdc:getVehicleByPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE LOWER(`plate`) = LOWER(@plate) OR LOWER(REPLACE(`plate`, \' \', \'\')) like LOWER(REPLACE(\'%' .. plate .. '%\', \' \', \'\'))',  {
		['@plate'] = plate
	}, 
		function(vehicleResult)
			local vehicleData = vehicleResult[1]
			if vehicleData == nil then
				cb({})
			else
				local owner = MySQL.Sync.fetchAll('SELECT job, job_grade, CONCAT(FIRSTNAME, \' \', LASTNAME) AS fullName FROM users WHERE identifier = @owner', {
					['@owner'] = vehicleData.owner
				});
				vehicleData.ownerName = owner[1].fullName

				local notes = MySQL.Sync.fetchAll('SELECT *, DATE_FORMAT(date, "%d/%m/%Y %H:%i:%s") AS date from lspd_mdc_vehicle_notes WHERE vehicleId = @vehicleId ORDER BY date DESC', {
					['vehicleId'] = vehicleData.id
				} );
				if notes == nil then motes = {} end
				vehicleData.mdcNotes = notes

				local lspdTags = MySQL.Sync.fetchAll('SELECT value from vehicle_properties WHERE vehicleId = @vehicleId and name like \'' .. vehicleTagPrefix .. '%\'', {
					['vehicleId'] = vehicleData.id
				});

				local lspdVehicleTags = {}
				for _, tag in ipairs(lspdTags) do
					table.insert(lspdVehicleTags, tag.value)
				end
				vehicleData.lspdTags = lspdVehicleTags
				cb(vehicleData)
			end
		end
	);
end)

RegisterServerEvent('esx_mdc:addNewVehicleNote')
AddEventHandler('esx_mdc:addNewVehicleNote', function(vehicleId, noteData)
	MySQL.Sync.execute('INSERT INTO `lspd_mdc_vehicle_notes` (`addedBy`, `text`, `vehicleId`) VALUES (@addedBy, @text, @vehicle)',
	{
		['@addedBy'] = noteData.addedBy,
		['@text']    = noteData.text,
		['@vehicle'] = vehicleId
	})
end)

RegisterServerEvent('esx_mdc:addNewCitizenConviction')
AddEventHandler('esx_mdc:addNewCitizenConviction', function(playerJobName, citizenId, convictionData)
	local xCitizen = ESX.GetPlayerFromIdentifier(citizenId)
	local _source = source
	if xCitizen ~= nil then
		local citizenServerId = xCitizen.source
		local jailLength = convictionData.length
		local fee = convictionData.fee
		local crimes = convictionData.crimes
		local sentencespan = 0
		if jailLength == nil or jailLength == 0 then
			exports.exile_logs:discord(source, "Wystawił/a mandat dla ["..citizenServerId.."] w wysokości $"..convictionData.fee, "tabletpolice", true)
			TriggerEvent('esx_policejob:pay', fee, citizenServerId, crimes, true, jailLength, _source)
		else
			sentencespan = jailLength
			exports.exile_logs:discord(source, "Wystawił/a karę wiezienia dla ["..citizenServerId.."] $"..convictionData.fee.." na "..jailLength.." miesięcy", "tabletpolice", true)
			TriggerEvent('esx_policejob:pay', fee, citizenServerId, crimes, false, jailLength, _source)
			TriggerEvent('esx_grzibi:naura123', citizenServerId, jailLength * 60)
			TriggerClientEvent('esx_policejob:unrestrain', citizenServerId)
		end
		-- log history
		MySQL.Sync.execute('INSERT INTO `lspd_user_judgments` (`userId`, `crimes`, `note`, `addedBy`, `length`, `fee`) VALUES (@userId, @crimes, @note, @addedBy, @length, @fee)',
		{
			['@userId']  = citizenId,
			['@crimes']  = convictionData.crimes,
			['@note']    = convictionData.note,
			['@addedBy'] = convictionData.addedBy,
			['@length']  = convictionData.length,
			['@fee']     = convictionData.fee
		})
	else
		--print('MDC ERROR - xCitizen not found for ' .. citizenId)
	end
end)

RegisterServerEvent('esx_mdc:saveVehicle')
AddEventHandler('esx_mdc:saveVehicle', function(vehicleData)
	-- update properties
	MySQL.Sync.execute('DELETE FROM `vehicle_properties` WHERE `vehicleId` = @vehicleId and `name` like \'' .. vehicleTagPrefix .. '%\'',
	{
		['@vehicleId'] = vehicleData.id
	})

	local values = 'INSERT INTO `vehicle_properties` (`vehicleId`, `name`, `value`) VALUES '
	local count = 1
	for _, tag in ipairs(vehicleData.lspdTags) do
		if( count ~= 1 ) then
			values = values .. ', '
		end
		values = values .. '(\'' .. vehicleData.id .. '\', \'' .. vehicleTagPrefix .. count .. '\', \'' .. tag .. '\')'
		count = count + 1
	end
	if count ~= 1 then
		MySQL.Sync.execute(values, {})
	end
end)

ESX.RegisterServerCallback('esx_mdc:getVehiclesWarrantsList', function(source, cb, target)
	MySQL.Async.fetchAll('SELECT owner, plate AS plateText, modelname AS model, CONCAT(FIRSTNAME, \' \', LASTNAME) AS owner FROM `owned_vehicles` join `users` on owner = identifier  WHERE id IN (SELECT vehicleId FROM `vehicle_properties` WHERE value = \'Poszukiwany\')',  {}, 
		function(vehicleResult)
			cb(vehicleResult)
		end
	);
end)

ESX.RegisterServerCallback('esx_mdc:getCitizenByName', function(source, cb, citizenName, citizenId)
	local whereClausure
	if citizenId ~= nil then
		whereClausure = 'T.identifier = \'' .. citizenId .. '\''
	else
		whereClausure = 'LOWER(T.fullName) like LOWER(\'%' .. citizenName .. '%\')'
	end
	MySQL.Async.fetchAll('SELECT * from (select *, CONCAT(FIRSTNAME, \' \', LASTNAME) AS fullName FROM users) as T WHERE ' .. whereClausure, {}, 
		function(resultUsers)
			local userData = resultUsers[1] -- ignore other results

			if userData == nil then
				cb({})
			else
				if #resultUsers > 1 then
					cb(resultUsers)
				else
					local licenses = MySQL.Sync.fetchAll('SELECT * from user_licenses WHERE owner = @owner', {
						['owner'] = userData.identifier
					} );
					local tempdrive = false 
					local drive = false
					local weapon = false
					for _, license in ipairs(licenses) do
						if license.type == 'drive' then
							drive = true
						end
						if license.type == 'tempdrive' then
							tempdrive = true
						end
						if license.type == 'weapon' then
							weapon = true
						end
					end
					userData.driverLicense = drive and tempdrive
					userData.weaponLicense = weapon

					local resultApartments = MySQL.Sync.fetchAll('SELECT * from owned_properties WHERE owner = @owner', {
						['owner'] = userData.identifier
					} );
					userData.houses = resultApartments


					local notes = MySQL.Sync.fetchAll('SELECT * from lspd_mdc_user_notes WHERE userId = @owner', {
						['@owner'] = userData.identifier
					} );
					if notes == nil then motes = {} end
					userData.mdcNotes = notes

					local lspdTags = MySQL.Sync.fetchAll('SELECT value from user_properties WHERE userId = @owner and name like \'' .. citizenTagPrefix .. '%\'', {
						['@owner'] = userData.identifier
					});

					local lspdUserTags = {}
					for _, tag in ipairs(lspdTags) do
						table.insert(lspdUserTags, tag.value)
					end
					userData.lspdTags = lspdUserTags

					local convictions = MySQL.Sync.fetchAll('SELECT * from lspd_user_judgments WHERE userId = @owner', {
						['@owner'] = userData.identifier
					});
					userData.convictions = convictions

					if userData.sex == 'M' then
						userData.sex = "Mężczyzna"
					else
						userData.sex = "Kobieta"
					end
					cb(userData)
				end
			end
	end)
end)

RegisterServerEvent('esx_mdc:addNewCitizenNote')
AddEventHandler('esx_mdc:addNewCitizenNote', function(citizenId, noteData)
	MySQL.Sync.execute('INSERT INTO `lspd_mdc_user_notes` (`addedBy`, `text`, `userId`) VALUES (@addedBy, @text, @citizen)',
	{
		['@addedBy'] = noteData.addedBy,
		['@text']    = noteData.text,
		['@citizen'] = citizenId
	})
end)

RegisterServerEvent('esx_mdc:saveCitizen')
AddEventHandler('esx_mdc:saveCitizen', function(citizenData)
	-- update properties
	MySQL.Sync.execute('DELETE FROM `user_properties` WHERE `userId` = @owner and `name` like \'' .. citizenTagPrefix .. '%\'',
	{
		['@owner'] = citizenData.id
	})

	local values = 'INSERT INTO `user_properties` (`userId`, `name`, `value`) VALUES '
	local count = 1
	for _, tag in ipairs(citizenData.lspdTags) do
		if( count ~= 1 ) then
			values = values .. ', '
		end
		values = values .. '(\'' .. citizenData.id .. '\', \'' .. citizenTagPrefix .. count .. '\', \'' .. tag .. '\')'
		count = count + 1
	end
	if count ~= 1 then
		MySQL.Sync.execute(values, {})
	end
end)
