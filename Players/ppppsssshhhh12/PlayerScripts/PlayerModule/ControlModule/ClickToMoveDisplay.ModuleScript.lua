local v1 = {}
local v_u_2 = "rbxasset://textures/ui/traildot.png"
local v_u_3 = "rbxasset://textures/ui/waypoint.png"
local v_u_4 = false
local v_u_5 = UDim2.new(0, 42, 0, 50)
local v_u_6 = Vector2.new(0, 0.5)
local v_u_7 = Vector2.new(0, 1)
local v_u_8 = Vector2.new(0, 0.5)
local v_u_9 = Vector2.new(0.1, 0.5)
local v_u_10 = Vector2.new(-0.1, 0.5)
local v_u_11 = Vector2.new(1.5, 1.5)
local v12 = game:GetService("Players")
local v_u_13 = game:GetService("TweenService")
local v_u_14 = game:GetService("RunService")
local v_u_15 = game:GetService("Workspace")
local v_u_16 = v12.LocalPlayer
local function v_u_28()
    local v17 = Instance.new("Part")
    v17.Size = Vector3.new(1, 1, 1)
    v17.Anchored = true
    v17.CanCollide = false
    v17.Name = "TrailDot"
    v17.Transparency = 1
    local v18 = Instance.new("ImageHandleAdornment")
    v18.Name = "TrailDotImage"
    v18.Size = v_u_11
    v18.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
    v18.AlwaysOnTop = v_u_4
    v18.Image = v_u_2
    v18.Adornee = v17
    v18.Parent = v17
    local v19 = Instance.new("Part")
    v19.Size = Vector3.new(2, 2, 2)
    v19.Anchored = true
    v19.CanCollide = false
    v19.Name = "EndWaypoint"
    v19.Transparency = 1
    local v20 = Instance.new("ImageHandleAdornment")
    v20.Name = "TrailDotImage"
    v20.Size = v_u_11
    v20.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
    v20.AlwaysOnTop = v_u_4
    v20.Image = v_u_2
    v20.Adornee = v19
    v20.Parent = v19
    local v21 = Instance.new("BillboardGui")
    v21.Name = "EndWaypointBillboard"
    v21.Size = v_u_5
    v21.LightInfluence = 0
    v21.SizeOffset = v_u_6
    v21.AlwaysOnTop = true
    v21.Adornee = v19
    v21.Parent = v19
    local v22 = Instance.new("ImageLabel")
    v22.Image = v_u_3
    v22.BackgroundTransparency = 1
    v22.Size = UDim2.new(1, 0, 1, 0)
    v22.Parent = v21
    local v23 = Instance.new("Part")
    v23.Size = Vector3.new(2, 2, 2)
    v23.Anchored = true
    v23.CanCollide = false
    v23.Name = "FailureWaypoint"
    v23.Transparency = 1
    local v24 = Instance.new("ImageHandleAdornment")
    v24.Name = "TrailDotImage"
    v24.Size = v_u_11
    v24.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
    v24.AlwaysOnTop = v_u_4
    v24.Image = v_u_2
    v24.Adornee = v23
    v24.Parent = v23
    local v25 = Instance.new("BillboardGui")
    v25.Name = "FailureWaypointBillboard"
    v25.Size = v_u_5
    v25.LightInfluence = 0
    v25.SizeOffset = v_u_8
    v25.AlwaysOnTop = true
    v25.Adornee = v23
    v25.Parent = v23
    local v26 = Instance.new("Frame")
    v26.BackgroundTransparency = 1
    v26.Size = UDim2.new(0, 0, 0, 0)
    v26.Position = UDim2.new(0.5, 0, 1, 0)
    v26.Parent = v25
    local v27 = Instance.new("ImageLabel")
    v27.Image = v_u_3
    v27.BackgroundTransparency = 1
    v27.Position = UDim2.new(0, -v_u_5.X.Offset / 2, 0, -v_u_5.Y.Offset)
    v27.Size = v_u_5
    v27.Parent = v26
    return v17, v19, v23
end
local v_u_29, v_u_30, v_u_31 = v_u_28()
local function v_u_39(p32, p33)
    local v34, v35, v36 = v_u_15:FindPartOnRayWithIgnoreList(Ray.new(p33 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { v_u_15.CurrentCamera, v_u_16.Character })
    if v34 then
        p32.CFrame = CFrame.new(v35, v35 + v36)
        local v37 = v_u_15.CurrentCamera
        local v38 = v37:FindFirstChild("ClickToMoveDisplay")
        if not v38 then
            v38 = Instance.new("Model")
            v38.Name = "ClickToMoveDisplay"
            v38.Parent = v37
        end
        p32.Parent = v38
    end
end
local v_u_40 = {}
v_u_40.__index = v_u_40
function v_u_40.Destroy(p41)
    p41.DisplayModel:Destroy()
end
function v_u_40.NewDisplayModel(_, p42)
    local v43 = v_u_29:Clone()
    v_u_39(v43, p42)
    return v43
end
function v_u_40.new(p44, p45)
    local v46 = v_u_40
    local v47 = setmetatable({}, v46)
    v47.DisplayModel = v47:NewDisplayModel(p44)
    v47.ClosestWayPoint = p45
    return v47
end
local v_u_48 = {}
v_u_48.__index = v_u_48
function v_u_48.Destroy(p49)
    p49.Destroyed = true
    p49.Tween:Cancel()
    p49.DisplayModel:Destroy()
end
function v_u_48.NewDisplayModel(_, p50)
    local v51 = v_u_30:Clone()
    v_u_39(v51, p50)
    return v51
end
function v_u_48.CreateTween(p52)
    local v53 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true)
    local v54 = {
        ["SizeOffset"] = v_u_7
    }
    local v55 = v_u_13:Create(p52.DisplayModel.EndWaypointBillboard, v53, v54)
    v55:Play()
    return v55
end
function v_u_48.TweenInFrom(p56, p57)
    local v58 = p57 - p56.DisplayModel.Position
    local v59 = p56.DisplayModel.EndWaypointBillboard
    local v60 = v58.Y
    v59.StudsOffset = Vector3.new(0, v60, 0)
    local v61 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v62 = v_u_13:Create(p56.DisplayModel.EndWaypointBillboard, v61, {
        ["StudsOffset"] = Vector3.new(0, 0, 0)
    })
    v62:Play()
    return v62
end
function v_u_48.new(p63, p64, p65)
    local v66 = v_u_48
    local v_u_67 = setmetatable({}, v66)
    v_u_67.DisplayModel = v_u_67:NewDisplayModel(p63)
    v_u_67.Destroyed = false
    if p65 and (p65 - p63).Magnitude > 5 then
        v_u_67.Tween = v_u_67:TweenInFrom(p65)
        coroutine.wrap(function()
            v_u_67.Tween.Completed:Wait()
            if not v_u_67.Destroyed then
                v_u_67.Tween = v_u_67:CreateTween()
            end
        end)()
    else
        v_u_67.Tween = v_u_67:CreateTween()
    end
    v_u_67.ClosestWayPoint = p64
    return v_u_67
end
local v_u_68 = {}
v_u_68.__index = v_u_68
function v_u_68.Hide(p69)
    p69.DisplayModel.Parent = nil
end
function v_u_68.Destroy(p70)
    p70.DisplayModel:Destroy()
end
function v_u_68.NewDisplayModel(_, p71)
    local v72 = v_u_31:Clone()
    v_u_39(v72, p71)
    local v73, v74, v75 = v_u_15:FindPartOnRayWithIgnoreList(Ray.new(p71 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { v_u_15.CurrentCamera, v_u_16.Character })
    if v73 then
        v72.CFrame = CFrame.new(v74, v74 + v75)
        local v76 = v_u_15.CurrentCamera
        local v77 = v76:FindFirstChild("ClickToMoveDisplay")
        if not v77 then
            v77 = Instance.new("Model")
            v77.Name = "ClickToMoveDisplay"
            v77.Parent = v76
        end
        v72.Parent = v77
    end
    return v72
end
function v_u_68.RunFailureTween(p78)
    wait(0.125)
    local v79 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v80 = {
        ["SizeOffset"] = v_u_9
    }
    local v81 = v_u_13:Create(p78.DisplayModel.FailureWaypointBillboard, v79, v80)
    v81:Play()
    v_u_13:Create(p78.DisplayModel.FailureWaypointBillboard.Frame, v79, {
        ["Rotation"] = 10
    }):Play()
    v81.Completed:wait()
    local v82 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
    local v83 = {
        ["SizeOffset"] = v_u_10
    }
    local v84 = v_u_13:Create(p78.DisplayModel.FailureWaypointBillboard, v82, v83)
    v84:Play()
    local v85 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
    v_u_13:Create(p78.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, v85, {
        ["ImageColor3"] = Color3.new(0.75, 0.75, 0.75)
    }):Play()
    v_u_13:Create(p78.DisplayModel.FailureWaypointBillboard.Frame, v85, {
        ["Rotation"] = -10
    }):Play()
    v84.Completed:wait()
    local v86 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v87 = {
        ["SizeOffset"] = v_u_8
    }
    local v88 = v_u_13:Create(p78.DisplayModel.FailureWaypointBillboard, v86, v87)
    v88:Play()
    v_u_13:Create(p78.DisplayModel.FailureWaypointBillboard.Frame, v86, {
        ["Rotation"] = 0
    }):Play()
    v88.Completed:wait()
    wait(0.125)
end
function v_u_68.new(p89)
    local v90 = v_u_68
    local v91 = setmetatable({}, v90)
    v91.DisplayModel = v91:NewDisplayModel(p89)
    return v91
end
local v_u_92 = Instance.new("Animation")
v_u_92.AnimationId = "rbxassetid://2874840706"
local v_u_93 = nil
local function v_u_105(p94, p95)
    local v96 = {}
    local v97 = 1
    for v98 = 1, #p94 - 1 do
        local v99 = (p94[v98].Position - p94[#p94].Position).Magnitude < 3
        local v100
        if v98 % 2 == 0 then
            v100 = not v99
        else
            v100 = false
        end
        if v100 then
            v96[v97] = v_u_40.new(p94[v98].Position, v98)
            v97 = v97 + 1
        end
    end
    local v101 = v_u_48.new(p94[#p94].Position, #p94, p95)
    table.insert(v96, v101)
    local v102 = {}
    local v103 = 1
    for v104 = #v96, 1, -1 do
        v102[v103] = v96[v104]
        v103 = v103 + 1
    end
    return v102
end
local v_u_106 = 0
function v1.CreatePathDisplay(p_u_107, p108)
    v_u_106 = v_u_106 + 1
    local v_u_109 = v_u_105(p_u_107, p108)
    local function v_u_113(p110)
        for v111 = #v_u_109, 1, -1 do
            local v112 = v_u_109[v111]
            if v112.ClosestWayPoint > p110 then
                break
            end
            v112:Destroy()
            v_u_109[v111] = nil
        end
    end
    local v_u_114 = "ClickToMoveResizeTrail" .. v_u_106
    local function v120()
        if #v_u_109 == 0 then
            v_u_14:UnbindFromRenderStep(v_u_114)
        else
            local v115 = v_u_15.CurrentCamera.CFrame.p
            for v116 = 1, #v_u_109 do
                local v117 = v_u_109[v116].DisplayModel:FindFirstChild("TrailDotImage")
                if v117 then
                    local v118 = v_u_11
                    local v119 = (v_u_109[v116].DisplayModel.Position - v115).Magnitude - 10
                    v117.Size = v118 * (math.clamp(v119, 0, 90) / 90 * 1.5 + 1)
                end
            end
        end
    end
    v_u_14:BindToRenderStep(v_u_114, Enum.RenderPriority.Camera.Value - 1, v120)
    return function()
        v_u_113(#p_u_107)
    end, v_u_113
end
local v_u_121 = nil
function v1.DisplayFailureWaypoint(p122)
    if v_u_121 then
        v_u_121:Hide()
    end
    local v_u_123 = v_u_68.new(p122)
    v_u_121 = v_u_123
    coroutine.wrap(function()
        v_u_123:RunFailureTween()
        v_u_123:Destroy()
        v_u_123 = nil
    end)()
end
function v1.CreateEndWaypoint(p124)
    return v_u_48.new(p124)
end
function v1.PlayFailureAnimation()
    local v125 = v_u_16.Character
    local v126
    if v125 then
        v126 = v125:FindFirstChildOfClass("Humanoid")
    else
        v126 = nil
    end
    if v126 then
        local v127
        if v126 == nil then
            v127 = v_u_93
        else
            v_u_93 = v126:LoadAnimation(v_u_92)
            local v128 = v_u_93
            assert(v128, "")
            v_u_93.Priority = Enum.AnimationPriority.Action
            v_u_93.Looped = false
            v127 = v_u_93
        end
        v127:Play()
    end
end
function v1.CancelFailureAnimation()
    if v_u_93 ~= nil and v_u_93.IsPlaying then
        v_u_93:Stop()
    end
end
function v1.SetWaypointTexture(p129)
    v_u_2 = p129
    local v130, v131, v132 = v_u_28()
    v_u_29 = v130
    v_u_30 = v131
    v_u_31 = v132
end
function v1.GetWaypointTexture()
    return v_u_2
end
function v1.SetWaypointRadius(p133)
    v_u_11 = Vector2.new(p133, p133)
    local v134, v135, v136 = v_u_28()
    v_u_29 = v134
    v_u_30 = v135
    v_u_31 = v136
end
function v1.GetWaypointRadius()
    return v_u_11.X
end
function v1.SetEndWaypointTexture(p137)
    v_u_3 = p137
    local v138, v139, v140 = v_u_28()
    v_u_29 = v138
    v_u_30 = v139
    v_u_31 = v140
end
function v1.GetEndWaypointTexture()
    return v_u_3
end
function v1.SetWaypointsAlwaysOnTop(p141)
    v_u_4 = p141
    local v142, v143, v144 = v_u_28()
    v_u_29 = v142
    v_u_30 = v143
    v_u_31 = v144
end
function v1.GetWaypointsAlwaysOnTop()
    return v_u_4
end
return v1