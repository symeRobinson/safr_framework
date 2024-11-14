-- server.lua

-- Store active units and their members
local activeUnits = {}

RegisterServerEvent('safr:sendNotification')
AddEventHandler('safr:sendNotification', function(units, message)
    local src = source
    -- Ensure the player has permission to send notifications
    -- Implement any permission checks if needed

    -- Send notification to specified units
    for _, unitID in ipairs(units) do
        -- Get players in the unit
        local unitMembers = activeUnits[unitID] or {}
        for _, playerID in ipairs(unitMembers) do
            TriggerClientEvent('safr:receiveNotification', playerID, message)
        end
    end
end)

RegisterServerEvent('safr:sendPage')
AddEventHandler('safr:sendPage', function(unitsToPage, message)
    local src = source
    -- Implement any permission checks if needed

    -- Send page to specified units
    for _, unitID in ipairs(unitsToPage) do
        local unitMembers = activeUnits[unitID] or {}
        for _, playerID in ipairs(unitMembers) do
            TriggerClientEvent('safr:receivePage', playerID, message)
        end
    end
end)

-- Handle player joining and leaving units
RegisterServerEvent('safr:joinUnit')
AddEventHandler('safr:joinUnit', function(unitID)
    local src = source
    activeUnits[unitID] = activeUnits[unitID] or {}
    table.insert(activeUnits[unitID], src)
    -- Notify others of the change
    TriggerClientEvent('safr:updateActiveUnits', -1, activeUnits)
end)

RegisterServerEvent('safr:leaveUnit')
AddEventHandler('safr:leaveUnit', function(unitID)
    local src = source
    if activeUnits[unitID] then
        for i, playerID in ipairs(activeUnits[unitID]) do
            if playerID == src then
                table.remove(activeUnits[unitID], i)
                break
            end
        end
        -- Notify others of the change
        TriggerClientEvent('safr:updateActiveUnits', -1, activeUnits)
    end
end)

-- Provide active units to clients when they join
AddEventHandler('playerJoining', function()
    local src = source
    TriggerClientEvent('safr:updateActiveUnits', src, activeUnits)
end)
