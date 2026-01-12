local v_u_1 = Enum.ContextActionPriority.Default.Value
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("ContextActionService")
local v_u_4 = UserSettings().GameSettings
local v_u_5 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new()
    local v7 = v_u_6
    local v_u_8 = setmetatable({}, v7)
    v_u_8.isMouseLocked = false
    v_u_8.savedMouseCursor = nil
    v_u_8.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonR2 }
    v_u_8.mouseLockToggledEvent = Instance.new("BindableEvent")
    local v9 = script:FindFirstChild("BoundKeys")
    if not (v9 and v9:IsA("StringValue")) then
        if v9 then
            v9:Destroy()
        end
        v9 = Instance.new("StringValue")
        assert(v9, "")
        v9.Name = "BoundKeys"
        v9.Value = "LeftShift,RightShift,ButtonR2"
        v9.Parent = script
    end
    if v9 then
        v9.Changed:Connect(function(p10)
            v_u_8:OnBoundKeysObjectChanged(p10)
        end)
        v_u_8:OnBoundKeysObjectChanged(v9.Value)
    end
    v_u_4.Changed:Connect(function(p11)
        if p11 == "ControlMode" or p11 == "ComputerMovementMode" then
            v_u_8:UpdateMouseLockAvailability()
        end
    end)
    v_u_2.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function()
        v_u_8:UpdateMouseLockAvailability()
    end)
    v_u_2.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
        v_u_8:UpdateMouseLockAvailability()
    end)
    v_u_8:UpdateMouseLockAvailability()
    task.spawn(function()
        local v_u_12 = v_u_2.LocalPlayer
        local v13 = game:GetService("UserInputService")
        local function v_u_15()
            local v_u_14 = Instance.new("ImageButton")
            v_u_14.Image = "rbxasset://textures/MouseLockedCursor.png"
            v_u_14.Size = UDim2.new(0, 32, 0, 32)
            v_u_14.Position = UDim2.new(1, -40, 0, -18)
            v_u_14.AnchorPoint = Vector2.new(1, 0.5)
            v_u_14.BackgroundColor3 = Color3.new(0, 0, 0)
            v_u_14.BackgroundTransparency = 0.5
            v_u_14.Parent = v_u_12:WaitForChild("PlayerGui"):WaitForChild("Interface")
            Instance.new("UICorner").Parent = v_u_14
            v_u_14.MouseButton1Click:Connect(function()
                v_u_8:DoMouseLockSwitch(v_u_14, Enum.UserInputState.Begin)
            end)
        end
        if v13:GetLastInputType() == Enum.UserInputType.Touch then
            v_u_15()
        else
            local v_u_16 = nil
            v_u_16 = v13.LastInputTypeChanged:Connect(function()
                v_u_16:Disconnect()
                v_u_15()
            end)
        end
    end)
    return v_u_8
end
function v_u_6.GetIsMouseLocked(p17)
    return p17.isMouseLocked
end
function v_u_6.GetBindableToggleEvent(p18)
    return p18.mouseLockToggledEvent.Event
end
function v_u_6.GetMouseLockOffset(_)
    local v19 = script:FindFirstChild("CameraOffset")
    if v19 and v19:IsA("Vector3Value") then
        return v19.Value
    end
    if v19 then
        v19:Destroy()
    end
    local v20 = Instance.new("Vector3Value")
    assert(v20, "")
    v20.Name = "CameraOffset"
    v20.Value = Vector3.new(1.75, 0, 0)
    v20.Parent = script
    return not (v20 and v20.Value) and Vector3.new(1.75, 0, 0) or v20.Value
end
function v_u_6.UpdateMouseLockAvailability(p21)
    local v22 = v_u_2.LocalPlayer.DevEnableMouseLock
    local v23 = v_u_2.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
    local v24 = v_u_4.ControlMode == Enum.ControlMode.MouseLockSwitch
    local v25 = v_u_4.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
    local v26
    if v22 then
        if v24 then
            v26 = not v25
            if v26 then
                v26 = not v23
            end
        else
            v26 = v24
        end
    else
        v26 = v22
    end
    print("dev", v22)
    print("move", v23)
    print("userhas", v24)
    print("userHasClickToMoveEnabled", v25)
    if v26 ~= p21.enabled then
        p21:EnableMouseLock(v26)
    end
end
function v_u_6.OnBoundKeysObjectChanged(p27, p28)
    p27.boundKeys = {}
    for v29 in string.gmatch(p28, "[^%s,]+") do
        for _, v30 in pairs(Enum.KeyCode:GetEnumItems()) do
            if v29 == v30.Name then
                p27.boundKeys[#p27.boundKeys + 1] = v30
                break
            end
        end
    end
    p27:UnbindContextActions()
    p27:BindContextActions()
end
function v_u_6.OnMouseLockToggled(p31)
    p31.isMouseLocked = not p31.isMouseLocked
    if p31.isMouseLocked then
        local v32 = script:FindFirstChild("CursorImage")
        if v32 and (v32:IsA("StringValue") and v32.Value) then
            v_u_5.setMouseIconOverride(v32.Value)
        else
            if v32 then
                v32:Destroy()
            end
            local v33 = Instance.new("StringValue")
            assert(v33, "")
            v33.Name = "CursorImage"
            v33.Value = "rbxassetid://11759579734"
            v33.Parent = script
            v_u_5.setMouseIconOverride("rbxassetid://11759579734")
        end
    else
        v_u_5.restoreMouseIcon()
    end
    p31.mouseLockToggledEvent:Fire()
end
function v_u_6.DoMouseLockSwitch(p34, _, p35, _)
    if p35 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass
    end
    p34:OnMouseLockToggled()
    return Enum.ContextActionResult.Sink
end
function v_u_6.BindContextActions(p_u_36)
    local v37 = v_u_3
    local v38 = v_u_1
    local v39 = p_u_36.boundKeys
    v37:BindActionAtPriority("MouseLockSwitchAction", function(p40, p41, p42)
        return p_u_36:DoMouseLockSwitch(p40, p41, p42)
    end, false, v38, unpack(v39))
end
function v_u_6.UnbindContextActions(_)
    v_u_3:UnbindAction("MouseLockSwitchAction")
end
function v_u_6.IsMouseLocked(p43)
    local v44 = p43.enabled
    if v44 then
        v44 = p43.isMouseLocked
    end
    return v44
end
function v_u_6.EnableMouseLock(p45, p46)
    if p46 ~= p45.enabled then
        p45.enabled = p46
        if p45.enabled then
            p45:BindContextActions()
            return
        end
        v_u_5.restoreMouseIcon()
        p45:UnbindContextActions()
        if p45.isMouseLocked then
            p45.mouseLockToggledEvent:Fire()
        end
        p45.isMouseLocked = false
    end
end
return v_u_6