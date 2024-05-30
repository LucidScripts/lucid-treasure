Config = {}
Config.TreasureMapItem = "treasuremap"
Config.DigTime = 5000
Config.OpenChestTime = 3000
Config.RewardAmount = math.random(1, 2)
Config.NumberOfRewards = 1
Config.RareItemChance = 10 -- 10% chance to receive a rare item

Config.Rewards = {
    "plastic",
}

Config.RareItems = {
    "gold",
    "diamond",
}

Config.Treasure = {
    [1] = {
        image = "treasure_map_image.png",
        location = vec3(-1613.312, -1127.824, 2.316)
    },
    -- [2] = {
    --     image = "treasure_map_image.png",
    --     location = vec3(-535.359, -1679.183, 19.138)
    -- }
}