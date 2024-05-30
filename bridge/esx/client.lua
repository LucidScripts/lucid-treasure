if GetResourceState('es_extended') ~= 'started' then return end
ESX = exports['es_extended']:getSharedObject()
Framework, PlayerLoaded, PlayerData = 'esx', nil, {}

RegisterNetEvent('lucid:Notify', function(msg, type)
    ShowNotification(msg, type)
end)

function ShowNotification(msg, _type)
    ESX.ShowNotification(msg)
end



