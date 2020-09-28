local msg = "hello"

CreateThread(function()
    while true do
        Wait(250)
        print(dump(STATE))
        if STATE.gameState == 0 then
            msg = "Waiting for more players..."
        elseif STATE.gameState == 1 then
            msg = "The round is starting soon..."
        elseif STATE.gameState == 2 then
        elseif STATE.gameState == 3 then

        elseif STATE.gameState == 4 then
        end
    end
end)

local timerStarted = false
local timer = GAME_LENGTH
function startTimerThread()
    CreateThread(function()
        timer = GAME_LENGTH
        timerStarted = true
        while timer > 0 do
            Wait(1000)
            timer = timer - 1
        end
        timerStarted = false
    end)
end

CreateThread(function()
    while true do
        if STATE.gameState == 2 and timerStarted then
            drawTextCenter(timer .. " seconds", 0.5, 0.05)
        else
            Wait(250)
        end
        Wait(0)
    end
end)

local opacity = 255
CreateThread(function()
    local lastState = 0
    while true do
        if STATE.gameState <= 1 then
            drawTextCenter(msg, 0.5, 0.85, 1.0, opacity)
        elseif STATE.gameState == 2 then
            if lastState ~= STATE.gameState then
                msg = ""
                startTimerThread()
            end

            drawTextCenter(msg, 0.5, 0.5, 1.25, opacity)

            if lastState ~= STATE.gameState then
                if STATE.type == 1 then
                    local ped = PlayerPedId()
                    local weapon = GetHashKey('WEAPON_CROWBAR')

                    if not HasPedGotWeapon(ped, weapon) then
                        GiveWeaponToPed(PlayerPedId(), GetHashKey('WEAPON_CROWBAR'), 0, false, false)
                    end
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                end

                while #STATE.tasks == 0 do Wait(5) end
                for i, taskId in pairs(STATE.tasks) do
                    local task
                    if STATE.type > 0 then
                        task = IMPOSTER_TASKS[taskId]
                    else
                        task = TASKS[taskId]
                    end
                    local x, y, z = table.unpack(task[1])
                    print(dump({ x, y, z }))
                    local blip = AddBlipForCoord(x, y, z)
                    SetBlipSprite(blip, 1)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, 1.0)
                    SetBlipColour(blip, 1)
                    SetBlipAsShortRange(blip, false)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(task[3])
                    EndTextCommandSetBlipName(blip)
                    --STATE.tasks[i].blip = blip
                end

                CreateThread(function()
                    Wait(1750)
                    msg = "You are " .. (STATE.type == 1 and "~r~The Imposter" or "~b~A Crewmember")
                    DoScreenFadeIn(2500)
                    Wait(2000)
                    for i = 1, 255 do
                        opacity = 255 - i
                        Wait(2)
                    end
                end)
            end

            -- draw tasks
            drawText("Tasks:", 0.8, 0.8, 1.1, 255)
            for i = 1, #STATE.tasks do
                local dataTable = STATE.type > 0 and IMPOSTER_TASKS or TASKS
                local task = dataTable[STATE.tasks[i]]
                local taskText = task[3]
                drawText("~y~" .. taskText, 0.8, 0.825 + (i * 0.035), 0.5, 255)
            end
        elseif STATE.gameState == 3 then
        elseif STATE.gameState == 4 then
        end

        lastState = STATE.gameState
        Wait(0)
    end
end)

