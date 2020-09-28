---@class AmongUsClientConfig
---@field type number
---@field gameState number
---@field tasks table<table>
AmongUsClientConfig = {}

---@param type number
---@param gameState number
---@return AmongUsClientConfig
function AmongUsClientConfig.New(type, gameState)
    return setmetatable({
        type = type,
        gameState = gameState,
        tasks = {}
    }, AmongUsClientConfig)
end

function AmongUsClientConfig:IsStarted()
    return (gameState > 0)
end