---@class GameState
---@field players table<number>
---@field imposters table<number>
---@field tasks table<Task>
---@field imposterTasks table<Task>
---@field secondsUntilLaunch number
GameState = {
    players = {},
    imposters = {},

    tasks = {},
    imposterTasks = {},

    secondsUntilLaunch = 0,
}

function GameState.New()
    return setmetatable(GameState, {
        players = {},
        imposters = {},
        tasks = {},
        imposterTasks = {},
        secondsUntilLaunch = GAME_LENGTH,
    })
end

---@return boolean
function GameState:CanStartGame()
    return (#self.players >= 1)
    --return (#self.players >= 4)
end

---@param serverID number
function GameState:AddPlayer(serverID)
    print("Adding player " .. serverID)
    table.insert(self.players, serverID)
end

---@param playerId number
function GameState:IsPlayerPlaying(playerId)
    return tableContains(self.players, playerId)
end

function GameState:IsPlayerImposter(playerId)
    return tableContains(self.imposters, playerId)
end

---@param imposters number
function GameState:PickImposters(imposters)
    imposters = imposters or 0

    while #self.imposters < imposters do
        local id = self.players[math.random(1, #self.players)]
        local alreadyExists = false
        for existingId in pairs(self.imposters) do
            if existingId == id and not alreadyExists then
                alreadyExists = true
            end
        end
        if not alreadyExists then
            print("Picking player " .. id .. " as an imposter")
            table.insert(self.imposters, id)
        end
    end
end

function GameState:PickTasks()
    local total = 3
    local _tasks = {}

    while #_tasks < total do
        local i = math.random(1, #TASKS)
        if not tableContains(_tasks, i) then
            table.insert(_tasks, i)
        end
    end

    self.tasks = _tasks
end

function GameState:PickImposterTasks()
    local total = 3
    local _tasks = {}

    while #_tasks < total do
        local i = math.random(1, #IMPOSTER_TASKS)
        if not tableContains(_tasks, i) then
            table.insert(_tasks, i)
        end
    end

    self.imposterTasks = _tasks
end

function GameState:RemovePlayer(serverID)
    print("Removing player " .. serverID)
    self.players[serverID] = nil
end

function GameState:StartGame()
    if not self:CanStartGame() then
        error("Not enough players (" .. #self.players .. ")")
    end
    print("ok")
end