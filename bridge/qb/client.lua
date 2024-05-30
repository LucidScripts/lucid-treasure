if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()
Framework, PlayerLoaded, PlayerData = 'qb', nil, {}

RegisterNetEvent('lucid:Notify', function(msg, type)
    ShowNotification(msg, type)
end)

function ShowNotification(msg, type)
    QBCore.Functions.Notify(msg, type)
end

