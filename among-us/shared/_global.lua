function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

---@param t table
---@param value string|number
function tableContains(t, value)
    local found = false
    for _, v in pairs(t) do
        if not found and v == value then
            found = true
        end
    end
    return found
end

---@class Task
---@type table<vec4|vec3, string, string>
---@field completed boolean

---@type table<Task>
TASKS = {
    { vec4(118.15, -766.61, 242.15, 335.12), "copy_files", "Copy the Files" },
    { vec4(124.15, -726.59, 242.15, 359.55), "reboot_server", "Reboot the Server" },
    { vec3(129.63, -756.94, 242.15), "wash_hands", "Wash Your Hands" },
    { vec4(112.0, -750.52, 242.15, 13.92), "sort_files", "Sort Files" },
    { vec4(121.95, -740.6, 242.15, 258.73), "make_copies", "Make File Copies" },
}

---@type table<Task>
IMPOSTER_TASKS = {
    { vec4(121.95, -740.67, 242.15, 257.67), "jam_printer", "Jam The Printer" },
    { vec4(124.15, -726.59, 242.15, 359.55), "stop_server", "Shutdown the Server" },
    { vec3(129.63, -756.94, 242.15), "power_off", "Turn Power Off" },
    { vec4(112.0, -750.52, 242.15, 13.92), "clog_plumbing", "Clog the Plumbing", "Clog the Plumbing" },
    { vec4(117.03, -749.7, 242.15, 246.23), "fire_alarm", "Trigger the Fire Alarm", "Turn the Fire Alarm Off" },
}

GAME_LENGTH = 300