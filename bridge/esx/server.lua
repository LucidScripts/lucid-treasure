if GetResourceState('es_extended') ~= 'started' then return end
ESX = exports['es_extended']:getSharedObject()
Framework = 'esx'
Items = nil


function GetPlayer(source)
    local src = source
    return ESX.GetPlayerFromId(src)
end


function HasItem(source, item)
    local src = source
    local player = GetPlayer(src)
    if not player then return 0 end
    local item = player.getInventoryItem(item)
    if not item then return end
    return item and item.count or 0
end

function AddItem(source, item, count, slot, metadata)
    local src = source
    local player = GetPlayer(src)
    if not player then return end
    return player.addInventoryItem(item, count, metadata, slot)
end

function RemoveItem(source, item, count, slot, metadata)
    local src = source
    local player = GetPlayer(source)
    if not player then return end
    player.removeInventoryItem(item, count, metadata, slot)
end



function CreateUseableItem(item, useFunction)
    ESX.RegisterUsableItem(item, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return end
        useFunction(source, item)
    end)
end






