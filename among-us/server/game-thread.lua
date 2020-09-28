CreateThread(function()
    while true do
        print("Starting new game...")
        local game = GameState.New()

        while not game:CanStartGame() do
            local connectedPlayers = GetPlayers()
            for _, id in pairs(connectedPlayers) do
                if not game:IsPlayerPlaying(id) then
                    game:AddPlayer(id)
                end
            end

            Wait(5000)
        end

        print("Starting game...")
        for _, id in pairs(game.players) do
            TriggerClientEvent('AmongUs:updateState', id, 0, 1)
        end

        Wait(5000)

        print("Picking imposters...")
        game:PickImposters(0)

        print("Picking crewmember tasks...")
        game:PickTasks()

        print("Picking imposter tasks...")
        game:PickImposterTasks()
        print(dump(game))

        for _, id in pairs(game.players) do
            local playerState = game:IsPlayerImposter(id) and 1 or 0
            TriggerClientEvent('AmongUs:updateState', id, playerState, 2)
        end

        --if #game.imposters == 0 then
        --    error("whoops")
        --end

        -- game animation has started
        Wait(1250)

        -- teleport all players to main room
        print("Teleporting players...")
        for i, id in ipairs(game.players) do
            local spawnPos = SPAWNS[i]
            local x, y, z, h = table.unpack(spawnPos)
            local ped = GetPlayerPed(id)
            SetEntityCoords(ped, x, y, z)
            SetEntityHeading(ped, h)
        end

        -- send players tasks
        for _, id in ipairs(game.players) do
            local isImposter = tableContains(game.imposters, id)
            if isImposter then
                TriggerClientEvent("AmongUs:setTasks", id, game.imposterTasks)
            else
                TriggerClientEvent("AmongUs:setTasks", id, game.tasks)
            end
        end

        Wait(5 * 60 * 1000)
    end
end)