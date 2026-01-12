local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = game:GetService("Players")
local v_u_4 = v1:WaitForChild("ClientCast-Replication")
local v5 = v1:WaitForChild("ClientCast-Ping")
task.defer(function()
    script.Parent = v_u_3.LocalPlayer:FindFirstChildOfClass("PlayerScripts")
end)
function v5.OnClientInvoke() end
local v_u_6 = {}
local v_u_7 = {
    ["AttachmentName"] = "DmgPoint",
    ["DebugAttachmentName"] = "ClientCast-Debug",
    ["DebugMode"] = false,
    ["DebugColor"] = Color3.new(1, 0, 0),
    ["DebugLifetime"] = 1
}
v_u_6.Settings = v_u_7
v_u_6.InitiatedCasters = {}
local v_u_8 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) })
local v_u_9 = require(script.Signal)
local v_u_14 = {
    ["DisableDebug"] = function(p10)
        p10._Debug = false
        for v11 in next, p10._DebugTrails do
            v11.Enabled = false
        end
    end,
    ["StartDebug"] = function(p12)
        p12._Debug = true
        for v13 in next, p12._DebugTrails do
            v13.Enabled = true
        end
    end
}
local v_u_15 = {
    ["Collided"] = "Any",
    ["HumanoidCollided"] = "Humanoid"
}
function v_u_14.Start(p16)
    p16.Disabled = false
    v_u_6.InitiatedCasters[p16] = {}
    if p16._Debug then
        p16:StartDebug()
    end
end
function v_u_14.SetObject(p17, p18)
    p17.Object = p18
    for _, v19 in next, p17._DebugTrails do
        v19:Destroy()
    end
    table.clear(p17._DebugTrails)
    table.clear(p17._DamagePoints)
    local v20 = p17._DescendantConnection
    if v20 then
        v20:Disconnect()
    end
    local v21 = next
    local v22, v23 = p18:GetDescendants()
    for _, v24 in v21, v22, v23 do
        p17._OnDamagePointAdded(v24)
    end
    p17._DescendantConnection = p18.DescendantAdded:Connect(p17._OnDamagePointAdded)
end
function v_u_14.Destroy(p25)
    p25.Disabled = true
    v_u_6.InitiatedCasters[p25] = nil
    if p25._DescendantConnection then
        p25._DescendantConnection:Disconnect()
        p25.__DescendantConnection = nil
    end
    for _, v26 in next, p25._CollidedEvents do
        for v27 in next, v26 do
            v27:Destroy()
        end
    end
    for _, v28 in next, p25._DebugTrails do
        v28:Destroy()
    end
end
function v_u_14.Stop(p29)
    p29.Disabled = true
    v_u_6.InitiatedCasters[p29] = nil
    local v30 = p29._DescendantConnection
    if v30 then
        v30:Disconnect()
        p29._DescendantConnection = nil
    end
    local v31 = p29._Debug
    p29:DisableDebug()
    p29._Debug = v31
end
function v_u_14.__index(p32, p33)
    local v34 = v_u_15[p33]
    if not v34 then
        local v35 = v_u_14
        return rawget(v35, p33)
    end
    local v36 = v_u_9.new()
    p32._CollidedEvents[v34][v36] = true
    return v36.Invoked
end
function v_u_6.new(p37, p38)
    if typeof(p37) ~= "Instance" then
        error(string.format("Unexpected argument #1 to \'CastObject.new\' (%s expected, got %s)", "Instance", (typeof(p37))), 3)
    end
    local v_u_39 = nil
    local v_u_40 = {}
    local v_u_41 = {}
    local function v47(p_u_42)
        if p_u_42.ClassName == "Attachment" and (p_u_42.Name == v_u_7.AttachmentName and not v_u_41[p_u_42]) then
            local v43 = p_u_42.Parent == v_u_39.Object
            v_u_41[p_u_42] = v43
            local v_u_44 = Instance.new("Trail")
            local v_u_45 = Instance.new("Attachment")
            v_u_45.Name = v_u_7.DebugAttachmentName
            v_u_45.Position = p_u_42.Position - Vector3.new(0, 0, 0.1)
            v_u_44.Color = ColorSequence.new(v_u_7.DebugColor)
            local v46 = v_u_39._Debug
            if v46 then
                v46 = v43 or v_u_39.Recursive
            end
            v_u_44.Enabled = v46
            v_u_44.LightEmission = 1
            v_u_44.Transparency = v_u_8
            v_u_44.FaceCamera = true
            v_u_44.Lifetime = v_u_7.DebugLifetime
            v_u_44.Attachment0 = p_u_42
            v_u_44.Attachment1 = v_u_45
            v_u_44.Parent = v_u_45
            v_u_45.Parent = p_u_42.Parent
            task.spawn(function()
                repeat
                    p_u_42.AncestryChanged:Wait()
                until not p_u_42:IsDescendantOf(v_u_39.Object)
                v_u_45:Destroy()
                v_u_40[v_u_44] = nil
                v_u_41[p_u_42] = nil
            end)
            v_u_40[v_u_44] = v_u_45
        end
    end
    local v48 = {
        ["RaycastParams"] = p38,
        ["Object"] = p37,
        ["Disabled"] = true,
        ["Recursive"] = false,
        ["_CollidedEvents"] = {
            ["Humanoid"] = {},
            ["Any"] = {}
        },
        ["_DamagePoints"] = v_u_41,
        ["_Debug"] = false,
        ["_ToClean"] = {},
        ["_DebugTrails"] = v_u_40,
        ["_OnDamagePointAdded"] = v47
    }
    local v49 = v_u_14
    v_u_39 = setmetatable(v48, v49)
    local v50 = next
    local v51, v52 = p37:GetDescendants()
    local v53 = v_u_39
    for _, v54 in v50, v51, v52 do
        v47(v54)
    end
    v53._DescendantConnection = p37.DescendantAdded:Connect(v47)
    return v53
end
local function v_u_57(p55)
    if p55 then
        v_u_4:FireServer("Any", {
            ["Instance"] = p55.Instance,
            ["Position"] = p55.Position,
            ["Material"] = p55.Material,
            ["Normal"] = p55.Normal
        })
        local v56 = p55.Instance:FindFirstAncestorOfClass("Model")
        if v56 then
            v56 = v56:FindFirstChildOfClass("Humanoid")
        end
        if v56 then
            v_u_4:FireServer("Humanoid", {
                ["Instance"] = p55.Instance,
                ["Position"] = p55.Position,
                ["Material"] = p55.Material,
                ["Normal"] = p55.Normal
            })
        end
    end
end
local v_u_58 = {}
v2.Heartbeat:Connect(function()
    for v59, v60 in next, v_u_6.InitiatedCasters do
        if v59.Object then
            local v61 = v59.Recursive
            for v62, v63 in next, v59._DamagePoints do
                if v63 or v61 then
                    local v64 = v62.WorldPosition
                    local v65 = v60[v62] or v64
                    if v64 ~= v65 then
                        v_u_57((workspace:Raycast(v65, v64 - v65, v59.RaycastParams)))
                    end
                    v60[v62] = v64
                end
            end
        end
    end
end)
v_u_4.OnClientEvent:Connect(function(p66, p67, p68)
    if p66 == "Start" then
        local v69 = v_u_58[p67.Id]
        if not v69 then
            local v70 = v_u_6.new
            local v71 = p67.Object
            local v72 = p67.RaycastParams
            local v73 = RaycastParams.new()
            for v74, v76 in next, v72 do
                if v74 == "FilterType" then
                    local v76 = Enum.RaycastFilterType[v76]
                end
                v73[v74] = v76
            end
            v69 = v70(v71, v73)
            v_u_58[p67.Id] = v69
            v69._Debug = p67.Debug
        end
        v69:Start()
    elseif p66 == "Destroy" then
        local v77 = v_u_58[p67.Id]
        if v77 then
            v77:Destroy()
            v_u_58[p67.Id] = nil
            return
        end
    elseif p66 == "Stop" then
        local v78 = v_u_58[p67.Id]
        if v78 then
            v78:Stop()
            return
        end
    elseif p66 == "Update" then
        local v79 = v_u_58[p67.Id]
        if not v79 then
            local v80 = v_u_6.new
            local v81 = p67.Object
            local v82 = p67.RaycastParams
            local v83 = RaycastParams.new()
            for v84, v86 in next, v82 do
                if v84 == "FilterType" then
                    local v86 = Enum.RaycastFilterType[v86]
                end
                v83[v84] = v86
            end
            v79 = v80(v81, v83)
            v_u_58[p67.Id] = v79
            v79._Debug = p67.Debug
        end
        for v87, v88 in next, p68 do
            if v87 == "Object" then
                v79:SetObject(v88)
            elseif v87 == "Debug" then
                v79[(v88 and "Start" or "Disable") .. "Debug"](v79)
            else
                v79[v87] = v88
            end
        end
    end
end)