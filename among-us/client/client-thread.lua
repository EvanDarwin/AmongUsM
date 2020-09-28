CreateThread(function()
    while true do
        local ped = PlayerPedId()

        if STATE.gameState == 2 then
            local state = (STATE.type == 1 and true or false)
            SetCanAttackFriendly(PlayerPedId(), state, state)

            for _, taskId in pairs(STATE.tasks) do
                local isImposter = STATE.type == 1
                local taskTable = isImposter and IMPOSTER_TASKS or TASKS
                local task = taskTable[taskId]
                local taskPos = task[1]
                local x, y, z = table.unpack(taskPos)
                local g = isImposter and 0 or 255
                local b = 0
                local r = isImposter and 255 or 0
                DrawMarker(1, x, y, z - 1.25, 0.0, 0.0, 0.0, 0.0,
                        0.0, 0, 1.0, 1.0, 1.0,
                        r, g, b, 100, true)

                local coords = GetEntityCoords(ped)
                taskPos = vec3(x, y, coords[3])
                local D = #(coords - taskPos)
                if D <= 1.0 then
                    drawTextCenter("~b~[E]~c~ " .. task[3])
                    if IsControlPressed(1, 54) then
                        print("Pressed!")
                    end
                end
            end
        end

        Wait(0)
    end
end)