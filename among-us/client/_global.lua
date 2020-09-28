STATE = AmongUsClientConfig.New(0, 0)

RegisterNetEvent('AmongUs:updateState')
AddEventHandler("AmongUs:updateState", function(t, s)
    STATE.type = t
    STATE.gameState = s

    if s == 2 then
        DoScreenFadeOut(1500)
    end
end)

RegisterNetEvent("AmongUs:setTasks")
AddEventHandler("AmongUs:setTasks", function(tasks)
    STATE.tasks = tasks
end)

AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)

--- utility functions
function drawText(_msg, x, y, size, opacity)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextScale(0.0, size or 1.0)
    SetTextColour(255, 255, 255, opacity or 255)
    SetTextDropShadow(0, 0, 0, 0)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(_msg)
    DrawText(x or 0.5, y or 0.9)
end

function drawTextCenter(_msg, x, y, size, opacity)
    SetTextCentre(true)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextScale(0.0, size or 1.0)
    SetTextColour(255, 255, 255, opacity or 255)
    SetTextDropShadow(0, 0, 0, 0)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(_msg)
    DrawText(x or 0.5, y or 0.9)
end
