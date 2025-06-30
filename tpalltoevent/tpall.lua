local ESX = exports["es_extended"]:getSharedObject()

local locations = {
    ["arena"] = vector3(200.0, -1000.0, 30.0),
    ["bank"] = vector3(150.0, -1040.0, 29.0),
    ["human"] = vector3(3595.4719, 3767.1955, 29.971113),
    ["airport"] = vector3(-1025.41, -3460.958, 13.943338),
    ["sandy"] = vector3(75.493988, 6388.7915, 31.231935),
}

RegisterCommand("tpall", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer == nil or xPlayer.getGroup() ~= "" then -- set your server group
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^1System", "אין לך הרשאה להשתמש בפקודה הזו."}
        })
        return
    end

    local locationName = args[1]
    if not locationName or not locations[locationName] then
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^1System", "נא לבחור מיקום חוקי: " .. table.concat(GetAvailableLocations(), ", ")}
        })
        return
    end

    local coords = locations[locationName]

    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent("tpall:teleport", playerId, coords)
    end
end)

function GetAvailableLocations()
    local keys = {}
    for k in pairs(locations) do
        table.insert(keys, k)
    end
    return keys
end
