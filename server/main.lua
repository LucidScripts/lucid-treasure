local treasureMapItem = Config.TreasureMapItem

CreateUseableItem(treasureMapItem, function(source, item)
    local Player = GetPlayer(source)
    if Player == nil then return end
    if HasItem(source, treasureMapItem) then
        local index = math.random(1, #Config.Treasure)
        local treasure = Config.Treasure[index]
        
        local location = {
            x = treasure.location.x,
            y = treasure.location.y,
            z = treasure.location.z
        }
        
        TriggerClientEvent("lucid-treasure:DisplayTreasureUI", source, {
            image = "images/" .. treasure.image,
            location = location
        }, index)
        
        RemoveItem(source, treasureMapItem, 1)
        TriggerClientEvent('lucid:Notify', source, 'Coupon code is not valid or has expired.', 'error')
    else
        TriggerClientEvent('lucid:Notify', source, "You don't have a treasure map to use.", "error")
    end
end)



RegisterServerEvent('lucid-treasure:server:TreasureCollected')
AddEventHandler('lucid-treasure:server:TreasureCollected', function(index)
    local Player = GetPlayer(source)
    if Player == nil then return end

    local rewardedItems = {}

    for i = 1, Config.NumberOfRewards do
        local randomItem = Config.Rewards[math.random(1, #Config.Rewards)]
        AddItem(source, randomItem, Config.RewardAmount)
        table.insert(rewardedItems, randomItem)
    end

    local rareChance = math.random(1, 100)
    if rareChance <= Config.RareItemChance then
        local rareItem = Config.RareItems[math.random(1, #Config.RareItems)]
        AddItem(source, rareItem, 1)
        table.insert(rewardedItems, rareItem)
    end

    local rewardMessage = "Congratulations! You've found the treasure and received: " .. table.concat(rewardedItems, ", ")
    TriggerClientEvent('lucid:Notify', source, rewardMessage, "success")
end)

