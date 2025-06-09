-- This script is a sysbench test for a key-value store.

-- load kv module
local kv = require("kv")
write_kv = kv.write_kv
read_kv = kv.read_kv

-- Define the range of keys
local MAX_KEY = 2047
function thread_init(thread_id)
    -- Initialize per-thread variables
    math.randomseed(os.time() + thread_id)
end
function event(thread_id)
    local k = math.random(0, MAX_KEY)
    local v = math.random()
    local operation = math.random(0, 1) -- 0 for read, 1 for write
    if operation == 1 then
        -- Write Operation
        if write_kv(k, v) == -1 then
            error("Error writing key " .. k)
        end
    else
        -- Read Operation
        local read_value = read_kv(k)
        -- if read_value == -1 then
        --     error("Error reading key " .. k)
        -- end
    end
end

-- sysbench --threads=100 --events=1000000 test2.lua run
