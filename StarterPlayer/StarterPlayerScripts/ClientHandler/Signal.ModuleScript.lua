local v_u_1 = nil
local function v_u_4(p2, ...)
    local v3 = v_u_1
    v_u_1 = nil
    p2(...)
    v_u_1 = v3
end
local function v_u_5(...)
    v_u_4(...)
    while true do
        v_u_4(coroutine.yield())
    end
end
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7, p8)
    local v9 = v_u_6
    return setmetatable({
        ["_connected"] = true,
        ["_signal"] = p7,
        ["_fn"] = p8,
        ["_next"] = false
    }, v9)
end
function v_u_6.Disconnect(p10)
    local v11 = p10._connected
    assert(v11, "Can\'t disconnect a connection twice.", 2)
    p10._connected = false
    if p10._signal._handlerListHead == p10 then
        p10._signal._handlerListHead = p10._next
    else
        local v12 = p10._signal._handlerListHead
        while v12 and v12._next ~= p10 do
            v12 = v12._next
        end
        if v12 then
            v12._next = p10._next
        end
    end
end
setmetatable(v_u_6, {
    ["__index"] = function(_, p13)
        error(string.format("Attempt to get Connection::%s (not a valid member)", (tostring(p13))), 2)
    end,
    ["__newindex"] = function(_, p14, _)
        error(string.format("Attempt to set Connection::%s (not a valid member)", (tostring(p14))), 2)
    end
})
local v_u_15 = {}
v_u_15.__index = v_u_15
function v_u_15.new()
    local v16 = v_u_15
    local v_u_17 = setmetatable({
        ["_handlerListHead"] = false,
        ["Invoked"] = {}
    }, v16)
    local function v20(_, p18)
        local v19 = v_u_6.new(v_u_17, p18)
        if not v_u_17._handlerListHead then
            v_u_17._handlerListHead = v19
            return v19
        end
        v19._next = v_u_17._handlerListHead
        v_u_17._handlerListHead = v19
        return v19
    end
    v_u_17.Invoked.Connect = v20
    function v_u_17.Invoked.Wait(p21)
        local v_u_22 = coroutine.running()
        local v_u_23 = getfenv(2).script
        local v_u_24 = nil
        v_u_24 = p21:Connect(function(...)
            v_u_24:Disconnect()
            if v_u_23:FindFirstAncestorOfClass("DataModel") then
                task.spawn(v_u_22, ...)
            end
        end)
        return coroutine.yield()
    end
    return v_u_17
end
function v_u_15.DisconnectAll(p25)
    p25._handlerListHead = false
end
function v_u_15.Destroy(p26)
    p26:DisconnectAll()
    table.clear(p26)
end
function v_u_15.Invoke(p27, ...)
    local v28 = p27._handlerListHead
    while v28 do
        if v28._connected then
            if not v_u_1 then
                v_u_1 = coroutine.create(v_u_5)
            end
            if getfenv(v28._fn).script:FindFirstAncestorOfClass("DataModel") then
                task.spawn(v_u_1, v28._fn, ...)
            end
        end
        v28 = v28._next
    end
end
setmetatable(v_u_15, {
    ["__index"] = function(_, p29)
        error(string.format("Attempt to get Signal::%s (not a valid member)", (tostring(p29))), 2)
    end,
    ["__newindex"] = function(_, p30, _)
        error(string.format("Attempt to set Signal::%s (not a valid member)", (tostring(p30))), 2)
    end
})
return v_u_15