ESX              = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Categories = {}
local Vehicles   = {}

ESX.RegisterServerCallback('esx_vehicleshop:getCategories', function (source, cb)
	cb(Categories)
end)

ESX.RegisterServerCallback('esx_vehicleshop:getVehicles', function (source, cb)
	cb(Vehicles)
end)

ESX.RegisterServerCallback('esx_vehicleshop:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('esx_vehiclekatalog:payTest', function (source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getMoney() >= 5000 then
		xPlayer.removeMoney(5000)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_vehicleshop:buyVehicle', function (source, cb, vehicleModel)
	local xPlayer     = ESX.GetPlayerFromId(source)
	local vehicleData = nil
	local vehPrice = nil

	for i=1, #Vehicles, 1 do
		if Vehicles[i].model == vehicleModel then
			vehicleData = Vehicles[i]
			break
		end
	end

	vehPrice = vehicleData.price

	if xPlayer.getMoney() >= vehPrice then
		xPlayer.removeMoney(vehPrice)
		cb(true)
	else
		cb(false)
	end
end)


ESX.RegisterServerCallback('esx_vehicleshop:getVehiclePrice', function (source, cb, vehicleModel)
	local xPlayer     = ESX.GetPlayerFromId(source)
	local vehicleData = nil
	for i=1, #Vehicles, 1 do
		if string.lower(Vehicles[i].model) == string.lower(vehicleModel) then
			vehicleData = Vehicles[i]
			break
		end
	end
	if vehicleData ~= nil then
		vehPrice = vehicleData.price
		cb(vehPrice)
	else
		cb(50000)
	end

end)

function GetVehicle(model)
    local vehicleData = nil
    
    for i=1, #Vehicles, 1 do
        if GetHashKey(Vehicles[i].model) == model then
            vehicleData = Vehicles[i]
            break
        end
    end
    
    return vehicleData
end

RegisterServerEvent('exile_vehicles:setOwned')
AddEventHandler('exile_vehicles:setOwned', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local result = MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function (rowsChanged)
		exports.exile_logs:discord(_source, 'Kupił/a pojazd z rejetracją: '..vehicleProps.plate..' ['..vehicleProps.name..']', 'vehicleshop', true)
		TriggerClientEvent('esx:showNotification', _source, 'Pojazd z rejestracją ~y~'..vehicleProps.plate..'~s~ teraz należy do ~b~ciebie~s~')
	end)
end)

MySQL.ready(function()
	Categories     = MySQL.Sync.fetchAll('SELECT * FROM vehicle_categories')
	local vehicles = MySQL.Sync.fetchAll('SELECT * FROM vehicles')

	for i=1, #vehicles, 1 do
		local vehicle = vehicles[i]

		for j=1, #Categories, 1 do
			if Categories[j].name == vehicle.category then
				vehicle.categoryLabel = Categories[j].label
				break
			end
		end

		table.insert(Vehicles, vehicle)
	end

	TriggerClientEvent('esx_vehicleshop:sendCategories', -1, Categories)
	TriggerClientEvent('esx_vehicleshop:sendVehicles', -1, Vehicles)
end)