local openChest = {}

RegisterNetEvent("lucid-treasure:DisplayTreasureUI")
AddEventHandler("lucid-treasure:DisplayTreasureUI", function(treasure, index)
    SendNUIMessage({
        action = "display",
        treasure = treasure,
        index = index
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent("lucid-treasure:dig")
AddEventHandler("lucid-treasure:dig", function(data)
    PlayDiggingAnimation(data.data)
end)

RegisterNUICallback('lucid-treasure:close', function(data, cb)
    SetNuiFocus(false, false)

    local location = vec3(data.location.x, data.location.y, data.location.z - 1)

    exports['qb-target']:AddBoxZone("lucid-treasure" .. data.index, location,
    1.5, 1.5, {
        name = "hecticTreasure" .. data.index,
        heading = 254,
        debugPoly = false,
        minZ = location.z - 0.5,
        maxZ = location.z + 0.5,
    }, {
        options = {
            {
                type = "client",
                event = "lucid-treasure:dig",
                icon = 'fas fa-receipt',
                label = 'Dig for treasure',
                data = data
            }
        },
        distance = 2.5,
    })

    cb('ok')
end)

function PlayDiggingAnimation(data)
    exports['qb-target']:RemoveZone("lucid-treasure" .. data.index)
    local ped = PlayerPedId()
    local shovelProp = `prop_tool_shovel`
    local diggingAnimationDictionary = "random@burial"
    local diggingAnimationName = "a_burial"

    RequestModel(shovelProp)
    while not HasModelLoaded(shovelProp) do
        Wait(100)
    end

    local shovel = CreateObject(shovelProp, 0, 0, 0, true, true, true)
    AttachEntityToEntity(shovel, ped, GetPedBoneIndex(ped, 28422), 0, 0, .21, 0, 0, 0, true, true, false, true, 1, true)

    RequestAnimDict(diggingAnimationDictionary)
    while not HasAnimDictLoaded(diggingAnimationDictionary) do
        Wait(100)
    end

    TaskPlayAnim(ped, diggingAnimationDictionary, diggingAnimationName, 8.0, 8.0, -1, 1, 0, false, false, false)

    Citizen.Wait(Config.DigTime)

    ClearPedTasks(ped)
    DeleteObject(shovel)

    TriggerEvent('lucid-treasure:spawnTreasureChest', data)
end

RegisterNetEvent("lucid-treasure:spawnTreasureChest")
AddEventHandler("lucid-treasure:spawnTreasureChest", function(data)
    local chestProp = `prop_drop_crate_01`

    RequestModel(chestProp)
    while not HasModelLoaded(chestProp) do
        Wait(100)
    end

    local chest = CreateObject(chestProp, data.location.x, data.location.y, data.location.z - .7, true, true, true)
    SetEntityHeading(chest, data.location.w)
    PlaceObjectOnGroundProperly(chest)

    openChest[data.index] = false

    exports['qb-target']:AddTargetEntity(chest, {
        options = {
            {
                type = "client",
                event = "lucid-treasure:openTreasureChest",
                icon = 'fas fa-box-open',
                label = 'Open Treasure Chest',
                index = data.index,
                chest = chest,
                canInteract = function()
                    return not openChest[data.index]
                end
            }
        },
        distance = 2.5
    })
end)

RegisterNetEvent("lucid-treasure:openTreasureChest")
AddEventHandler("lucid-treasure:openTreasureChest", function(data)
    local ped = PlayerPedId()
    local animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
    local animName = "weed_crouch_checkingleaves_idle_01_inspector"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(100)
    end

    openChest[data.index] = true

    TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 1, 0, false, false, false)

    Citizen.Wait(Config.OpenChestTime)

    DeleteObject(data.chest)

    ClearPedTasks(ped)

    TriggerServerEvent('lucid-treasure:server:TreasureCollected', data.index)
end)