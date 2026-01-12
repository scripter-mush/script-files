local v_u_1 = game:GetService("ContextActionService")
local v_u_2 = game:GetService("UserInputService")
local v3 = game:GetService("Players")
local v4 = game:GetService("RunService")
local v_u_5 = UserSettings():GetService("UserGameSettings")
local v_u_6 = game:GetService("VRService")
game:GetService("StarterGui")
local v_u_7 = v3.LocalPlayer
local v_u_8 = Enum.ContextActionPriority.Default.Value
local v_u_9 = Vector2.new(1, 0.77) * 0.008726646259971648
local v_u_10 = Vector2.new(1, 0.77) * 0.12217304763960307
local v_u_11 = Vector2.new(1, 0.66) * 0.017453292519943295
local v_u_12 = Vector2.new(1, 0.77) * 0.06981317007977318
local v13, v14 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserResetTouchStateOnMenuOpen")
end)
local v_u_15 = v13 and v14
local v_u_16 = Instance.new("BindableEvent")
local v_u_17 = Instance.new("BindableEvent")
local v_u_18 = v_u_16.Event
local v_u_19 = v_u_17.Event
v_u_2.InputBegan:Connect(function(p20, p21)
    if not p21 and p20.UserInputType == Enum.UserInputType.MouseButton2 then
        v_u_16:Fire()
    end
end)
v_u_2.InputEnded:Connect(function(p22, _)
    if p22.UserInputType == Enum.UserInputType.MouseButton2 then
        v_u_17:Fire()
    end
end)
local function v_u_26(p23)
    local v24 = (math.abs(p23) - 0.1) / 0.9 * 2
    local v25 = (math.exp(v24) - 1) / 6.38905609893065
    return math.sign(p23) * math.clamp(v25, 0, 1)
end
local function v_u_31(p27)
    local v28 = workspace.CurrentCamera
    if not v28 then
        return p27
    end
    local v29 = v28.CFrame:ToEulerAnglesYXZ()
    if p27.Y * v29 >= 0 then
        return p27
    end
    local v30 = (1 - (math.abs(v29) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25
    return Vector2.new(1, v30) * p27
end
local function v_u_38(p32)
    local v33 = v_u_7:FindFirstChildOfClass("PlayerGui")
    if v33 then
        v33 = v33:FindFirstChild("TouchGui")
    end
    local v34
    if v33 then
        v34 = v33:FindFirstChild("TouchControlFrame")
    else
        v34 = v33
    end
    if v34 then
        v34 = v34:FindFirstChild("DynamicThumbstickFrame")
    end
    if not v34 then
        return false
    end
    if not v33.Enabled then
        return false
    end
    local v35 = v34.AbsolutePosition
    local v36 = v35 + v34.AbsoluteSize
    local v37
    if p32.X >= v35.X and (p32.Y >= v35.Y and p32.X <= v36.X) then
        v37 = p32.Y <= v36.Y
    else
        v37 = false
    end
    return v37
end
local v_u_39 = 0.016666666666666666
v4.Stepped:Connect(function(_, p40)
    v_u_39 = p40
end)
local v41 = {}
local v_u_42 = {}
local v_u_43 = 0
local v_u_44 = {
    ["Thumbstick2"] = Vector2.new()
}
local v_u_45 = {
    ["Left"] = 0,
    ["Right"] = 0,
    ["I"] = 0,
    ["O"] = 0
}
local v_u_46 = {
    ["Movement"] = Vector2.new(),
    ["Wheel"] = 0,
    ["Pan"] = Vector2.new(),
    ["Pinch"] = 0
}
local v_u_47 = {
    ["Move"] = Vector2.new(),
    ["Pinch"] = 0
}
local v_u_48 = Instance.new("BindableEvent")
v41.gamepadZoomPress = v_u_48.Event
local v_u_49 = v_u_6.VREnabled and Instance.new("BindableEvent") or nil
if v_u_6.VREnabled then
    v41.gamepadReset = v_u_49.Event
end
function v41.getRotationActivated()
    return v_u_43 > 0 and true or v_u_44.Thumbstick2.Magnitude > 0
end
function v41.getRotation(p50)
    local v51 = Vector2.new(1, v_u_5:GetCameraYInvertValue())
    local v52 = Vector2.new(v_u_45.Right - v_u_45.Left, 0) * v_u_39
    local v53 = v_u_44.Thumbstick2
    local v54 = v_u_46.Movement
    local v55 = v_u_46.Pan
    local v56 = v_u_31(v_u_47.Move)
    if p50 then
        v52 = Vector2.new()
    end
    return (v52 * 2.0943951023931953 + v53 * v_u_12 + v54 * v_u_9 + v55 * v_u_10 + v56 * v_u_11) * v51
end
function v41.getZoomDelta()
    local v57 = v_u_45.O - v_u_45.I
    local v58 = -v_u_46.Wheel + v_u_46.Pinch
    local v59 = -v_u_47.Pinch
    return v57 * 0.1 + v58 * 1 + v59 * 0.04
end
local function v_u_62(_, _, p60)
    local v61 = p60.Position
    v_u_44[p60.KeyCode.Name] = Vector2.new(v_u_26(v61.X), -v_u_26(v61.Y))
    return Enum.ContextActionResult.Pass
end
local function v_u_65(_, p63, p64)
    v_u_45[p64.KeyCode.Name] = p63 == Enum.UserInputState.Begin and 1 or 0
end
local function v_u_67(_, p66, _)
    if p66 == Enum.UserInputState.Begin then
        v_u_48:Fire()
    end
end
local function v_u_69(_, p68, _)
    if p68 == Enum.UserInputState.Begin then
        v_u_49:Fire()
    end
end
local function v_u_74()
    local v70 = {
        v_u_44,
        v_u_45,
        v_u_46,
        v_u_47
    }
    for _, v71 in pairs(v70) do
        for v72, v73 in pairs(v71) do
            if type(v73) == "boolean" then
                v71[v72] = false
            else
                v71[v72] = v71[v72] * 0
            end
        end
    end
end
local v_u_75 = {}
local v_u_76 = nil
local v_u_77 = nil
local function v_u_83(p78, p79)
    local v80 = p78.UserInputType == Enum.UserInputType.Touch
    assert(v80)
    local v81 = p78.UserInputState == Enum.UserInputState.Begin
    assert(v81)
    if v_u_76 == nil and (v_u_38(p78.Position) and not p79) then
        v_u_76 = p78
    else
        if not p79 then
            local v82 = v_u_43 + 1
            v_u_43 = math.max(0, v82)
        end
        v_u_75[p78] = p79
    end
end
local function v_u_88(p84, _)
    local v85 = p84.UserInputType == Enum.UserInputType.Touch
    assert(v85)
    local v86 = p84.UserInputState == Enum.UserInputState.End
    assert(v86)
    if p84 == v_u_76 then
        v_u_76 = nil
    end
    if v_u_75[p84] == false then
        v_u_77 = nil
        local v87 = v_u_43 - 1
        v_u_43 = math.max(0, v87)
    end
    v_u_75[p84] = nil
end
local function v_u_100(p89, p90)
    local v91 = p89.UserInputType == Enum.UserInputType.Touch
    assert(v91)
    local v92 = p89.UserInputState == Enum.UserInputState.Change
    assert(v92)
    if p89 == v_u_76 then
        return
    else
        if v_u_75[p89] == nil then
            v_u_75[p89] = p90
        end
        local v93 = {}
        for v94, v95 in pairs(v_u_75) do
            if not v95 then
                table.insert(v93, v94)
            end
        end
        if #v93 == 1 and v_u_75[p89] == false then
            local v96 = p89.Delta
            local v97 = v_u_47
            v97.Move = v97.Move + Vector2.new(v96.X, v96.Y)
        end
        if #v93 == 2 then
            local v98 = (v93[1].Position - v93[2].Position).Magnitude
            if v_u_77 then
                local v99 = v_u_47
                v99.Pinch = v99.Pinch + (v98 - v_u_77)
            end
            v_u_77 = v98
        else
            v_u_77 = nil
        end
    end
end
local function v_u_101()
    v_u_75 = {}
    v_u_76 = nil
    v_u_77 = nil
    if v_u_15 then
        v_u_43 = 0
    end
end
local function v_u_106(p102, p103, p104, p105)
    if not p105 then
        v_u_46.Wheel = p102
        v_u_46.Pan = p103
        v_u_46.Pinch = -p104
    end
end
local function v_u_110(p107, p108)
    if p107.UserInputType == Enum.UserInputType.Touch then
        v_u_83(p107, p108)
    elseif p107.UserInputType == Enum.UserInputType.MouseButton2 and not p108 then
        local v109 = v_u_43 + 1
        v_u_43 = math.max(0, v109)
    end
end
local function v_u_114(p111, p112)
    if p111.UserInputType == Enum.UserInputType.Touch then
        v_u_100(p111, p112)
    elseif p111.UserInputType == Enum.UserInputType.MouseMovement then
        local v113 = p111.Delta
        v_u_46.Movement = Vector2.new(v113.X, v113.Y)
    end
end
local function v_u_118(p115, p116)
    if p115.UserInputType == Enum.UserInputType.Touch then
        v_u_88(p115, p116)
    elseif p115.UserInputType == Enum.UserInputType.MouseButton2 then
        local v117 = v_u_43 - 1
        v_u_43 = math.max(0, v117)
    end
end
local v_u_119 = false
function v41.setInputEnabled(p120)
    if v_u_119 ~= p120 then
        v_u_119 = p120
        v_u_74()
        v_u_101()
        if v_u_119 then
            v_u_1:BindActionAtPriority("RbxCameraThumbstick", v_u_62, false, v_u_8, Enum.KeyCode.Thumbstick2)
            v_u_1:BindActionAtPriority("RbxCameraKeypress", v_u_65, false, v_u_8, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O)
            if v_u_6.VREnabled then
                v_u_1:BindAction("RbxCameraGamepadReset", v_u_69, false, Enum.KeyCode.ButtonL3)
            end
            v_u_1:BindAction("RbxCameraGamepadZoom", v_u_67, false, Enum.KeyCode.ButtonR3)
            local v121 = v_u_42
            local v122 = v_u_2.InputBegan
            local v123 = v_u_110
            table.insert(v121, v122:Connect(v123))
            local v124 = v_u_42
            local v125 = v_u_2.InputChanged
            local v126 = v_u_114
            table.insert(v124, v125:Connect(v126))
            local v127 = v_u_42
            local v128 = v_u_2.InputEnded
            local v129 = v_u_118
            table.insert(v127, v128:Connect(v129))
            local v130 = v_u_42
            local v131 = v_u_2.PointerAction
            local v132 = v_u_106
            table.insert(v130, v131:Connect(v132))
            if v_u_15 then
                local v133 = v_u_42
                local v134 = game:GetService("GuiService").MenuOpened
                local v135 = v_u_101
                table.insert(v133, v134:connect(v135))
                return
            end
        else
            v_u_1:UnbindAction("RbxCameraThumbstick")
            v_u_1:UnbindAction("RbxCameraMouseMove")
            v_u_1:UnbindAction("RbxCameraMouseWheel")
            v_u_1:UnbindAction("RbxCameraKeypress")
            v_u_1:UnbindAction("RbxCameraGamepadZoom")
            if v_u_6.VREnabled then
                v_u_1:UnbindAction("RbxCameraGamepadReset")
            end
            for _, v136 in pairs(v_u_42) do
                v136:Disconnect()
            end
            v_u_42 = {}
        end
    end
end
function v41.getInputEnabled()
    return v_u_119
end
function v41.resetInputForFrameEnd()
    v_u_46.Movement = Vector2.new()
    v_u_47.Move = Vector2.new()
    v_u_47.Pinch = 0
    v_u_46.Wheel = 0
    v_u_46.Pan = Vector2.new()
    v_u_46.Pinch = 0
end
v_u_2.WindowFocused:Connect(v_u_74)
v_u_2.WindowFocusReleased:Connect(v_u_74)
local v_u_137 = false
local v_u_138 = false
local v_u_139 = 0
function v41.getHoldPan()
    return v_u_137
end
function v41.getTogglePan()
    return v_u_138
end
function v41.getPanning()
    return v_u_138 or v_u_137
end
function v41.setTogglePan(p140)
    v_u_138 = p140
end
local v_u_141 = false
local v_u_142 = nil
local v_u_143 = nil
function v41.enableCameraToggleInput()
    if not v_u_141 then
        v_u_141 = true
        v_u_137 = false
        v_u_138 = false
        if v_u_142 then
            v_u_142:Disconnect()
        end
        if v_u_143 then
            v_u_143:Disconnect()
        end
        v_u_142 = v_u_18:Connect(function()
            v_u_137 = true
            v_u_139 = tick()
        end)
        v_u_143 = v_u_19:Connect(function()
            v_u_137 = false
            if tick() - v_u_139 < 0.3 and (v_u_138 or v_u_2:GetMouseDelta().Magnitude < 2) then
                v_u_138 = not v_u_138
            end
        end)
    end
end
function v41.disableCameraToggleInput()
    if v_u_141 then
        v_u_141 = false
        if v_u_142 then
            v_u_142:Disconnect()
            v_u_142 = nil
        end
        if v_u_143 then
            v_u_143:Disconnect()
            v_u_143 = nil
        end
    end
end
return v41