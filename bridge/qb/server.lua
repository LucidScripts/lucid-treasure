if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()
Framework = 'qb'

function GetPlayer(source)
    local src = source
    return QBCore.Functions.GetPlayer(src)
end


function HasItem(source, item)
    local src = source
    local player = GetPlayer(src)
    if not player then return 0 end
    local item = player.Functions.GetItemByName(item)
    if not item then return end
    return item.count or item.amount or 0
end

function AddItem(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    if not player then return end
    return player.Functions.AddItem(item, count, slot, metadata)
end

function RemoveItem(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    if not player then return end
    player.Functions.RemoveItem(item, count, slot, metadata)
end


function CreateUseableItem(source, item, useFunction)
    QBCore.Functions.CreateUseableItem(item, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end

        useFunction(Player, item)
    end)
end

