ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('exile:setJob')
AddEventHandler('exile:setJob', function(job, state)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local currentJob = xPlayer.job.name
    local currentOffJob = 'off'..currentJob

    if currentJob == job or currentOffJob == "off"..job or currentJob == "off"..job then
        if state then
            xPlayer.setJob(job, xPlayer.job.grade)
        else
            xPlayer.setJob('off'..job, xPlayer.job.grade)
        end
    else
        exports.exile_logs:discord(_source, 'exile:setJob, '..tostring(job)..', '..tostring(state), 'protect', true)
        print("")
        print("")
        print("")
        print("")
        print("CHEATER SPRAWDZ LOGI: EXILE_DUTY (exile:setJob)")
        print("")
        print("")
        print("")
        print("")
    end
end)
    -- if xPlayer.job.name == 'police' then
    --     xPlayer.setJob('offpolice', xPlayer.job.grade)
    -- elseif xPlayer.job.name == 'offambulance' then
    --     xPlayer.setJob('ambulance', xPlayer.job.grade)
    -- end
