-- client.lua

local config = {
    departments = {
        ['safr'] = { name = 'San Andreas Fire Rescue', color = '' }
    },
    subdivisions = {
        ['safr_fiu'] = { parent = 'safr', name = 'Fire Investigation Unit', color = '' },
        ['safr_ems'] = { parent = 'safr', name = 'Emergency Medical Service', color = '' },
        ['safr_suppression'] = { parent = 'safr', name = 'Fire Suppression', color = '' }
    },
    units = {
        ['e11'] = { spawnCode = 'FD01', name = 'Engine 11', color = {255, 0, 0}, subDivision = 'safr_suppression' }
    },
    stationLocations = {
        ['station_one'] = {
            name = "Station 1",
            npcLocation = {}, 
            assignedUnits = {'e11', 'm11', 't11'}
        }
    }
}

local isOnDuty = false
local currentAssignment = nil
local recentPages = {}
local activeUnits = {}

Citizen.CreateThread(function()
    WarMenu.CreateMenu('safr_menu', 'San Andreas Fire Rescue')
    WarMenu.CreateSubMenu('select_assignment', 'safr_menu', 'Select Assignment')
    WarMenu.CreateSubMenu('view_active_units', 'safr_menu', 'Active Units')
    WarMenu.CreateSubMenu('send_notification', 'safr_menu', 'Send Notification')
    WarMenu.CreateSubMenu('modify_assignment', 'safr_menu', 'Modify Assignment')
    WarMenu.CreateSubMenu('view_recent_pages', 'safr_menu', 'Recent Pages')
    WarMenu.CreateSubMenu('main_commands', 'safr_menu', 'Main Commands')
    WarMenu.CreateSubMenu('firefighting_tools', 'main_commands', 'Firefighting Tools')
    WarMenu.CreateSubMenu('rescue_tools', 'main_commands', 'Rescue Tools')
    WarMenu.CreateSubMenu('other_commands', 'main_commands', 'Other Commands')

    while true do
        if WarMenu.IsMenuOpened('safr_menu') then
            if not isOnDuty then
                if WarMenu.MenuButton('Select Assignment', 'select_assignment') then
                elseif WarMenu.MenuButton('View Active Units', 'view_active_units') then
                elseif WarMenu.MenuButton('Send Notification', 'send_notification') then
                elseif WarMenu.Button('Close Menu') then
                    WarMenu.CloseMenu()
                end
            else
                if WarMenu.MenuButton('Modify Assignment', 'modify_assignment') then
                elseif WarMenu.MenuButton('View Active Units', 'view_active_units') then
                elseif WarMenu.MenuButton('View Recent Pages', 'view_recent_pages') then
                elseif WarMenu.MenuButton('Main Commands', 'main_commands') then
                elseif WarMenu.MenuButton('Send Notification', 'send_notification') then
                elseif WarMenu.Button('Close Menu') then
                    WarMenu.CloseMenu()
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('select_assignment') or WarMenu.IsMenuOpened('modify_assignment') then
            if WarMenu.MenuButton('Station', 'select_station') then
            elseif WarMenu.MenuButton('Unit', 'select_unit') then
            elseif WarMenu.CheckBox('Teleport me', teleportMe) then
                teleportMe = not teleportMe
            elseif WarMenu.MenuButton('Go Back', 'safr_menu') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('view_active_units') then
            for unitID, unitData in pairs(activeUnits) do
                local count = unitData.count or 0
                local max = unitData.max or 0
                local color = unitData.color or {255, 255, 255, 255}
                WarMenu.SetMenuTextColor('view_active_units', color[1], color[2], color[3], color[4])
                WarMenu.Button(unitData.name .. '    ' .. count .. '/' .. max)
            end
            WarMenu.SetMenuTextColor('view_active_units', 255, 255, 255, 255)
            if WarMenu.Button('Go Back') then
                WarMenu.OpenMenu('safr_menu')
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('send_notification') then
            for unitID, unitData in pairs(activeUnits) do
                local checked = unitData.selected or false
                if WarMenu.CheckBox(unitData.name .. '    ' .. (unitData.count or 0) .. '/' .. (unitData.max or 0), checked) then
                    unitData.selected = not checked
                end
            end
            if WarMenu.Button('Send Message') then
                local selectedUnits = {}
                for unitID, unitData in pairs(activeUnits) do
                    if unitData.selected then
                        table.insert(selectedUnits, unitID)
                    end
                end
                if #selectedUnits > 0 then
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 255)
                    while UpdateOnscreenKeyboard() == 0 do
                        DisableAllControlActions(0)
                        Wait(0)
                    end
                    if GetOnscreenKeyboardResult() then
                        local message = GetOnscreenKeyboardResult()
                        TriggerServerEvent('safr:sendNotification', selectedUnits, message)
                    end
                else
                    ShowNotification('~r~You must select at least one unit.')
                end
            end
            if WarMenu.Button('Go Back') then
                WarMenu.OpenMenu('safr_menu')
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('main_commands') then
            if WarMenu.MenuButton('Firefighting Tools', 'firefighting_tools') then
            elseif WarMenu.MenuButton('Rescue Tools', 'rescue_tools') then
            elseif WarMenu.MenuButton('Other', 'other_commands') then
            elseif WarMenu.MenuButton('Go Back', 'safr_menu') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('firefighting_tools') then
            if WarMenu.Button('Fire Hose') then ExecuteCommand('hose') end
            if WarMenu.Button('Collect Thermal Camera') then ExecuteCommand('tic collect') end
            if WarMenu.Button('Store Thermal Camera') then ExecuteCommand('tic store') end
            if WarMenu.Button('Spawn Fan') then ExecuteCommand('spawnFan') end
            if WarMenu.Button('Delete Fan') then ExecuteCommand('deleteFan') end
            if WarMenu.MenuButton('Go Back', 'main_commands') then end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('rescue_tools') then
            if WarMenu.Button('Spreader') then ExecuteCommand('spreader') end
            if WarMenu.Button('Cutter') then ExecuteCommand('cutter') end
            if WarMenu.Button('Glassmaster') then ExecuteCommand('glassmaster') end
            if WarMenu.Button('Tripod Setup') then ExecuteCommand('tripod setup') end
            if WarMenu.Button('Remove Tripod') then ExecuteCommand('tripod remove') end
            if WarMenu.MenuButton('Go Back', 'main_commands') then end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('other_commands') then
            if WarMenu.Button('Spawn Stretcher') then ExecuteCommand('stretcher') end
            if WarMenu.Button('Setup Autofire Duty') then ExecuteCommand('bookduty') end
            if WarMenu.Button('Create Fire') then ExecuteCommand('createfire') end
            if WarMenu.Button('Delete Fires') then ExecuteCommand('deletefire 100') end
            if WarMenu.MenuButton('Go Back', 'main_commands') then end
            WarMenu.Display()
        else
            if IsControlJustPressed(1, 344) then -- F11 key
                WarMenu.OpenMenu('safr_menu')
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterCommand('safr', function() WarMenu.OpenMenu('safr_menu') end, false)

RegisterCommand('page', function(source, args)
    local unitsToPage = {}
    local message = ''

    local parsingMessage = false
    for i, arg in ipairs(args) do
        if arg:sub(1, 1) == '"' then
            parsingMessage = true
            message = arg:sub(2)
            if arg:sub(-1) == '"' then parsingMessage = false message = message:sub(1, -2) end
        elseif parsingMessage then
            message = message .. ' ' .. arg
            if arg:sub(-1) == '"' then parsingMessage = false message = message:sub(1, -2) end
        else
            table.insert(unitsToPage, arg)
        end
    end

    if #unitsToPage == 0 or message == '' then
        ShowNotification('~r~Usage: /page [units] "message"')
        return
    end

    TriggerServerEvent('safr:sendPage', unitsToPage, message)
end, false)

function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
    local daleModel = GetHashKey('s_m_y_fireman_01')
    RequestModel(daleModel)
    while not HasModelLoaded(daleModel) do Wait(0) end

    local npcSpawned = false
    local npcPed = nil

    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for stationID, stationData in pairs(config.stationLocations) do
            local npcLocation = stationData.npcLocation
            if npcLocation and #(playerCoords - npcLocation) < 50.0 then
                if not npcSpawned then
                    npcPed = CreatePed(4, daleModel, npcLocation.x, npcLocation.y, npcLocation.z, npcLocation.heading or 0.0, false, true)
                    SetEntityInvincible(npcPed, true)
                    FreezeEntityPosition(npcPed, true)
                    TaskStartScenarioInPlace(npcPed, 'WORLD_HUMAN_CLIPBOARD', 0, true)
                    npcSpawned = true
                end

                if #(playerCoords - npcLocation) < 2.0 then
                    ShowHelpNotification('Press ~INPUT_CONTEXT~ to interact with Assistant Dale')
                    if IsControlJustReleased(0, 51) then
                        local messages = {
                            "You smell that? It’s not just burnt toast, it’s someone’s dreams going up in smoke—grab the hose, rookie.",
                            "EMS? Yeah, we're just glorified Uber drivers with less pay and more PTSD.",
                            "We’re not here to save lives, kid. We’re here to keep the paperwork clean and the taxpayers happy.",
                            "Fire doesn’t discriminate, but it sure loves a good meth lab—welcome to the job.",
                            "Why do firefighters wear suspenders? To keep the last shred of their dignity up while crawling through another hoarder’s crap palace.",
                            "Just remember, the faster we put out the fire, the sooner the insurance company screws them over.",
                            "This isn’t hero work. It’s cleaning up someone else’s Darwin Award entry.",
                            "You think blood smells bad? Wait until you’re bagging someone who hasn’t showered in six months and just became 'medium rare'.",
                            "We don’t save cats from trees anymore—too busy pulling idiots out of Darwin’s waiting room.",
                            "The good news is, no one died. The bad news? You’ll wish you had when you see the hazmat report."
                        }
                        TriggerEvent('chat:addMessage', { args = { '^1Assistant Dale', messages[math.random(#messages)] } })
                        WarMenu.OpenMenu('safr_menu')
                    end
                end
            else
                if npcSpawned then
                    DeleteEntity(npcPed)
                    npcSpawned = false
                end
            end
        end
        Wait(0)
    end
end)

function ShowHelpNotification(text)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end
