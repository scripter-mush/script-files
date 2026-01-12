local v_u_1 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_2 = {}
v_u_2.__index = v_u_2
function v_u_2.new()
    local v3 = v_u_2
    local v4 = setmetatable({}, v3)
    v4.transparencyDirty = false
    v4.enabled = false
    v4.lastTransparency = nil
    v4.descendantAddedConn = nil
    v4.descendantRemovingConn = nil
    v4.toolDescendantAddedConns = {}
    v4.toolDescendantRemovingConns = {}
    v4.cachedParts = {}
    return v4
end
function v_u_2.HasToolAncestor(p5, p6)
    if p6.Parent == nil then
        return false
    end
    local v7 = p6.Parent
    assert(v7, "")
    return p6.Parent:IsA("Tool") or p5:HasToolAncestor(p6.Parent)
end
function v_u_2.IsValidPartToModify(p8, p9)
    if p9:IsA("BasePart") or p9:IsA("Decal") then
        return not p8:HasToolAncestor(p9)
    else
        return false
    end
end
function v_u_2.CachePartsRecursive(p10, p11)
    if p11 then
        if p10:IsValidPartToModify(p11) then
            p10.cachedParts[p11] = true
            p10.transparencyDirty = true
        end
        for _, v12 in pairs(p11:GetChildren()) do
            p10:CachePartsRecursive(v12)
        end
    end
end
function v_u_2.TeardownTransparency(p13)
    for v14, _ in pairs(p13.cachedParts) do
        v14.LocalTransparencyModifier = 0
    end
    p13.cachedParts = {}
    p13.transparencyDirty = true
    p13.lastTransparency = nil
    if p13.descendantAddedConn then
        p13.descendantAddedConn:disconnect()
        p13.descendantAddedConn = nil
    end
    if p13.descendantRemovingConn then
        p13.descendantRemovingConn:disconnect()
        p13.descendantRemovingConn = nil
    end
    for v15, v16 in pairs(p13.toolDescendantAddedConns) do
        v16:Disconnect()
        p13.toolDescendantAddedConns[v15] = nil
    end
    for v17, v18 in pairs(p13.toolDescendantRemovingConns) do
        v18:Disconnect()
        p13.toolDescendantRemovingConns[v17] = nil
    end
end
function v_u_2.SetupTransparency(p_u_19, p_u_20)
    p_u_19:TeardownTransparency()
    if p_u_19.descendantAddedConn then
        p_u_19.descendantAddedConn:disconnect()
    end
    p_u_19.descendantAddedConn = p_u_20.DescendantAdded:Connect(function(p21)
        if p_u_19:IsValidPartToModify(p21) then
            p_u_19.cachedParts[p21] = true
            p_u_19.transparencyDirty = true
        elseif p21:IsA("Tool") then
            if p_u_19.toolDescendantAddedConns[p21] then
                p_u_19.toolDescendantAddedConns[p21]:Disconnect()
            end
            p_u_19.toolDescendantAddedConns[p21] = p21.DescendantAdded:Connect(function(p22)
                p_u_19.cachedParts[p22] = nil
                if p22:IsA("BasePart") or p22:IsA("Decal") then
                    p22.LocalTransparencyModifier = 0
                end
            end)
            if p_u_19.toolDescendantRemovingConns[p21] then
                p_u_19.toolDescendantRemovingConns[p21]:disconnect()
            end
            p_u_19.toolDescendantRemovingConns[p21] = p21.DescendantRemoving:Connect(function(p23)
                wait()
                if p_u_20 and (p23 and (p23:IsDescendantOf(p_u_20) and p_u_19:IsValidPartToModify(p23))) then
                    p_u_19.cachedParts[p23] = true
                    p_u_19.transparencyDirty = true
                end
            end)
        end
    end)
    if p_u_19.descendantRemovingConn then
        p_u_19.descendantRemovingConn:disconnect()
    end
    p_u_19.descendantRemovingConn = p_u_20.DescendantRemoving:connect(function(p24)
        if p_u_19.cachedParts[p24] then
            p_u_19.cachedParts[p24] = nil
            p24.LocalTransparencyModifier = 0
        end
    end)
    p_u_19:CachePartsRecursive(p_u_20)
end
function v_u_2.Enable(p25, p26)
    if p25.enabled ~= p26 then
        p25.enabled = p26
    end
end
function v_u_2.SetSubject(p27, p28)
    local v29
    if p28 and p28:IsA("Humanoid") then
        v29 = p28.Parent
    else
        v29 = nil
    end
    if p28 and (p28:IsA("VehicleSeat") and p28.Occupant) then
        v29 = p28.Occupant.Parent
    end
    if v29 then
        p27:SetupTransparency(v29)
    else
        p27:TeardownTransparency()
    end
end
function v_u_2.Update(p30, p31)
    local v32 = workspace.CurrentCamera
    if v32 and p30.enabled then
        local v33 = (v32.Focus.p - v32.CoordinateFrame.p).magnitude
        local v34 = v33 < 2 and 1 - (v33 - 0.5) / 1.5 or 0
        local v35 = v34 < 0.5 and 0 or v34
        if p30.lastTransparency and (v35 < 1 and p30.lastTransparency < 0.95) then
            local v36 = v35 - p30.lastTransparency
            local v37 = 2.8 * p31
            local v38 = -v37
            local v39 = math.clamp(v36, v38, v37)
            v35 = p30.lastTransparency + v39
        else
            p30.transparencyDirty = true
        end
        local v40 = v_u_1.Round(v35, 2)
        local v41 = math.clamp(v40, 0, 1)
        if p30.transparencyDirty or p30.lastTransparency ~= v41 then
            for v42, _ in pairs(p30.cachedParts) do
                v42.LocalTransparencyModifier = v41
            end
            p30.transparencyDirty = false
            p30.lastTransparency = v41
        end
    end
end
return v_u_2