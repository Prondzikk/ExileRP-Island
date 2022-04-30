local cam = false

RegisterNetEvent('route68:kino2')
AddEventHandler('route68:kino2', function()
    cam = not cam

    if cam then
        ESX.UI.HUD.SetDisplay(0.0)
        TriggerEvent('chat:toggleChat', true)
        TriggerServerEvent('misiaczek:kino', true)
        TriggerEvent('hungerthirst:hud_state', true)
        TriggerEvent('bodycam:state', true)
        TriggerEvent('esx_status:setDisplay', 0.0)
        TriggerEvent('radar:setHidden', true)
        TriggerEvent('carhud:display', false)
        TriggerEvent('exile:pasy', false)
        TriggerEvent('esx_customui:toggle', false)
    elseif not cam then
        ESX.UI.HUD.SetDisplay(1.0)
        TriggerEvent('chat:toggleChat', false)
        TriggerEvent('hungerthirst:hud_state', false)
        TriggerEvent('bodycam:state', false)
        TriggerEvent('esx_status:setDisplay', 1.0)
        TriggerEvent('radar:setHidden', false)
        TriggerEvent('carhud:display', true)
        TriggerEvent('exile:pasy', true)
        TriggerEvent('esx_customui:toggle', true)
    end
end)