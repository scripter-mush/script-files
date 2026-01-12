local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("GuiService")
local v_u_6 = game:GetService("Workspace")
local v_u_7 = UserSettings():GetService("UserGameSettings")
local v_u_8 = game:GetService("VRService")
local v_u_9 = require(script:WaitForChild("Keyboard"))
local v_u_10 = require(script:WaitForChild("Gamepad"))
local v_u_11 = require(script:WaitForChild("DynamicThumbstick"))
local v12, v13 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserHideControlsWhenMenuOpen")
end)
local v_u_14 = v12 and v13
local v_u_15 = require(script:WaitForChild("TouchThumbstick"))
local v_u_16 = require(script:WaitForChild("ClickToMoveController"))
local v_u_17 = require(script:WaitForChild("TouchJump"))
local v_u_18 = require(script:WaitForChild("VehicleController"))
local v_u_19 = Enum.ContextActionPriority.Default.Value
local v_u_20 = {
    [Enum.TouchMovementMode.DPad] = v_u_11,
    [Enum.DevTouchMovementMode.DPad] = v_u_11,
    [Enum.TouchMovementMode.Thumbpad] = v_u_11,
    [Enum.DevTouchMovementMode.Thumbpad] = v_u_11,
    [Enum.TouchMovementMode.Thumbstick] = v_u_15,
    [Enum.DevTouchMovementMode.Thumbstick] = v_u_15,
    [Enum.TouchMovementMode.DynamicThumbstick] = v_u_11,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = v_u_11,
    [Enum.TouchMovementMode.ClickToMove] = v_u_16,
    [Enum.DevTouchMovementMode.ClickToMove] = v_u_16,
    [Enum.TouchMovementMode.Default] = v_u_11,
    [Enum.ComputerMovementMode.Default] = v_u_9,
    [Enum.ComputerMovementMode.KeyboardMouse] = v_u_9,
    [Enum.DevComputerMovementMode.KeyboardMouse] = v_u_9,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = v_u_16,
    [Enum.DevComputerMovementMode.ClickToMove] = v_u_16
}
local v_u_21 = {
    [Enum.UserInputType.Keyboard] = v_u_9,
    [Enum.UserInputType.MouseButton1] = v_u_9,
    [Enum.UserInputType.MouseButton2] = v_u_9,
    [Enum.UserInputType.MouseButton3] = v_u_9,
    [Enum.UserInputType.MouseWheel] = v_u_9,
    [Enum.UserInputType.MouseMovement] = v_u_9,
    [Enum.UserInputType.Gamepad1] = v_u_10,
    [Enum.UserInputType.Gamepad2] = v_u_10,
    [Enum.UserInputType.Gamepad3] = v_u_10,
    [Enum.UserInputType.Gamepad4] = v_u_10
}
local v_u_22 = nil
function v_u_1.new()
    local v23 = v_u_1
    local v_u_24 = setmetatable({}, v23)
    v_u_24.controllers = {}
    v_u_24.activeControlModule = nil
    v_u_24.activeController = nil
    v_u_24.touchJumpController = nil
    v_u_24.moveFunction = v_u_2.LocalPlayer.Move
    v_u_24.humanoid = nil
    v_u_24.lastInputType = Enum.UserInputType.None
    v_u_24.controlsEnabled = true
    v_u_24.humanoidSeatedConn = nil
    v_u_24.vehicleController = nil
    v_u_24.touchControlFrame = nil
    if v_u_14 then
        v_u_5.MenuOpened:Connect(function()
            if v_u_24.touchControlFrame and v_u_24.touchControlFrame.Visible then
                v_u_24.touchControlFrame.Visible = false
            end
        end)
        v_u_5.MenuClosed:Connect(function()
            if v_u_24.touchControlFrame then
                v_u_24.touchControlFrame.Visible = true
            end
        end)
    end
    v_u_24.vehicleController = v_u_18.new(v_u_19)
    v_u_2.LocalPlayer.CharacterAdded:Connect(function(p25)
        v_u_24:OnCharacterAdded(p25)
    end)
    v_u_2.LocalPlayer.CharacterRemoving:Connect(function(p26)
        v_u_24:OnCharacterRemoving(p26)
    end)
    if v_u_2.LocalPlayer.Character then
        v_u_24:OnCharacterAdded(v_u_2.LocalPlayer.Character)
    end
    v_u_3:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p27)
        v_u_24:OnRenderStepped(p27)
    end)
    v_u_4.LastInputTypeChanged:Connect(function(p28)
        v_u_24:OnLastInputTypeChanged(p28)
    end)
    v_u_7:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
        v_u_24:OnTouchMovementModeChange()
    end)
    v_u_2.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
        v_u_24:OnTouchMovementModeChange()
    end)
    v_u_7:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function()
        v_u_24:OnComputerMovementModeChange()
    end)
    v_u_2.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
        v_u_24:OnComputerMovementModeChange()
    end)
    v_u_24.playerGui = nil
    v_u_24.touchGui = nil
    v_u_24.playerGuiAddedConn = nil
    v_u_5:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function()
        v_u_24:UpdateTouchGuiVisibility()
        v_u_24:UpdateActiveControlModuleEnabled()
    end)
    if not v_u_4.TouchEnabled then
        v_u_24:OnLastInputTypeChanged(v_u_4:GetLastInputType())
        return v_u_24
    end
    v_u_24.playerGui = v_u_2.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not v_u_24.playerGui then
        v_u_24.playerGuiAddedConn = v_u_2.LocalPlayer.ChildAdded:Connect(function(p29)
            if p29:IsA("PlayerGui") then
                v_u_24.playerGui = p29
                v_u_24:CreateTouchGuiContainer()
                v_u_24.playerGuiAddedConn:Disconnect()
                v_u_24.playerGuiAddedConn = nil
                v_u_24:OnLastInputTypeChanged(v_u_4:GetLastInputType())
            end
        end)
        return v_u_24
    end
    v_u_24:CreateTouchGuiContainer()
    v_u_24:OnLastInputTypeChanged(v_u_4:GetLastInputType())
    return v_u_24
end
function v_u_1.GetMoveVector(p30)
    return not p30.activeController and Vector3.new(0, 0, 0) or p30.activeController:GetMoveVector()
end
function v_u_1.GetActiveController(p31)
    return p31.activeController
end
function v_u_1.UpdateActiveControlModuleEnabled(p_u_32)
    local function v33()
        if p_u_32.activeControlModule == v_u_16 then
            p_u_32.activeController:Enable(true, v_u_2.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, p_u_32.touchJumpController)
            return
        elseif p_u_32.touchControlFrame then
            p_u_32.activeController:Enable(true, p_u_32.touchControlFrame)
        else
            p_u_32.activeController:Enable(true)
        end
    end
    if p_u_32.activeController then
        if p_u_32.controlsEnabled then
            if v_u_5.TouchControlsEnabled or (not v_u_4.TouchEnabled or p_u_32.activeControlModule ~= v_u_16 and (p_u_32.activeControlModule ~= v_u_15 and p_u_32.activeControlModule ~= v_u_11)) then
                v33()
            else
                p_u_32.activeController:Enable(false)
                if p_u_32.moveFunction then
                    p_u_32.moveFunction(v_u_2.LocalPlayer, Vector3.new(0, 0, 0), true)
                end
            end
        else
            p_u_32.activeController:Enable(false)
            if p_u_32.moveFunction then
                p_u_32.moveFunction(v_u_2.LocalPlayer, Vector3.new(0, 0, 0), true)
            end
            return
        end
    else
        return
    end
end
function v_u_1.Enable(p34, p35)
    p34.controlsEnabled = p35 == nil and true or p35
    if p34.activeController then
        p34:UpdateActiveControlModuleEnabled()
    end
end
function v_u_1.Disable(p36)
    p36.controlsEnabled = false
    p36:UpdateActiveControlModuleEnabled()
end
function v_u_1.SelectComputerMovementModule(_)
    if v_u_4.KeyboardEnabled or v_u_4.GamepadEnabled then
        local v37 = v_u_2.LocalPlayer.DevComputerMovementMode
        local v38
        if v37 == Enum.DevComputerMovementMode.UserChoice then
            v38 = v_u_21[v_u_22]
            if v_u_7.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v38 == v_u_9 then
                v38 = v_u_16
            end
        else
            v38 = v_u_20[v37]
            if not v38 and v37 ~= Enum.DevComputerMovementMode.Scriptable then
                warn("No character control module is associated with DevComputerMovementMode ", v37)
            end
        end
        if v38 then
            return v38, true
        elseif v37 == Enum.DevComputerMovementMode.Scriptable then
            return nil, true
        else
            return nil, false
        end
    else
        return nil, false
    end
end
function v_u_1.SelectTouchModule(_)
    if not v_u_4.TouchEnabled then
        return nil, false
    end
    local v39 = v_u_2.LocalPlayer.DevTouchMovementMode
    local v40
    if v39 == Enum.DevTouchMovementMode.UserChoice then
        v40 = v_u_20[v_u_7.TouchMovementMode]
    else
        if v39 == Enum.DevTouchMovementMode.Scriptable then
            return nil, true
        end
        v40 = v_u_20[v39]
    end
    return v40, true
end
local function v_u_54(p41, p42)
    local v43 = v_u_6.CurrentCamera
    if not v43 then
        return p42
    end
    if p41:GetState() == Enum.HumanoidStateType.Swimming then
        return v43.CFrame:VectorToWorldSpace(p42)
    end
    local v44 = v43.CFrame
    if v_u_8.VREnabled and (p41.RootPart and (p41.RootPart.CFrame.Position - v44.Position).Magnitude < 3) then
        v44 = v44 * v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
    end
    local _, _, _, v49, v46, v47, _, _, v48, _, _, v49 = v44:GetComponents()
    if v48 >= 1 or v48 <= -1 then
        v47 = -v46 * math.sign(v48)
    end
    local v50 = v49 * v49 + v47 * v47
    local v51 = math.sqrt(v50)
    local v52 = (v49 * p42.X + v47 * p42.Z) / v51
    local v53 = (v49 * p42.Z - v47 * p42.X) / v51
    return Vector3.new(v52, 0, v53)
end
function v_u_1.OnRenderStepped(p55, p56)
    if p55.activeController and (p55.activeController.enabled and p55.humanoid) then
        p55.activeController:OnRenderStepped(p56)
        local v57 = p55.activeController:GetMoveVector()
        local v58 = p55.activeController:IsMoveVectorCameraRelative()
        local v59 = p55:GetClickToMoveController()
        if p55.activeController ~= v59 then
            if v57.magnitude > 0 then
                v59:CleanupPath()
            else
                v59:OnRenderStepped(p56)
                v57 = v59:GetMoveVector()
                v58 = v59:IsMoveVectorCameraRelative()
            end
        end
        if p55.vehicleController then
            local v60
            v57, v60 = p55.vehicleController:Update(v57, v58, p55.activeControlModule == v_u_10)
        end
        if v58 then
            v57 = v_u_54(p55.humanoid, v57)
        end
        p55.moveFunction(v_u_2.LocalPlayer, v57, false)
        local v61 = p55.humanoid
        local v62 = not p55.activeController:GetIsJumping() and p55.touchJumpController
        if v62 then
            v62 = p55.touchJumpController:GetIsJumping()
        end
        v61.Jump = v62
    end
end
function v_u_1.OnHumanoidSeated(p63, p64, p65)
    if p64 then
        if p65 and p65:IsA("VehicleSeat") then
            if not p63.vehicleController then
                p63.vehicleController = p63.vehicleController.new(v_u_19)
            end
            p63.vehicleController:Enable(true, p65)
            return
        end
    elseif p63.vehicleController then
        p63.vehicleController:Enable(false, p65)
    end
end
function v_u_1.OnCharacterAdded(p_u_66, p67)
    p_u_66.humanoid = p67:FindFirstChildOfClass("Humanoid")
    while not p_u_66.humanoid do
        p67.ChildAdded:wait()
        p_u_66.humanoid = p67:FindFirstChildOfClass("Humanoid")
    end
    p_u_66:UpdateTouchGuiVisibility()
    if p_u_66.humanoidSeatedConn then
        p_u_66.humanoidSeatedConn:Disconnect()
        p_u_66.humanoidSeatedConn = nil
    end
    p_u_66.humanoidSeatedConn = p_u_66.humanoid.Seated:Connect(function(p68, p69)
        p_u_66:OnHumanoidSeated(p68, p69)
    end)
end
function v_u_1.OnCharacterRemoving(p70, _)
    p70.humanoid = nil
    p70:UpdateTouchGuiVisibility()
end
function v_u_1.UpdateTouchGuiVisibility(p71)
    if p71.touchGui then
        local v72 = p71.humanoid
        if v72 then
            v72 = v_u_5.TouchControlsEnabled
        end
        p71.touchGui.Enabled = v72 and true or false
    end
end
function v_u_1.SwitchToController(p73, p74)
    if p74 then
        if not p73.controllers[p74] then
            p73.controllers[p74] = p74.new(v_u_19)
        end
        if p73.activeController ~= p73.controllers[p74] then
            if p73.activeController then
                p73.activeController:Enable(false)
            end
            p73.activeController = p73.controllers[p74]
            p73.activeControlModule = p74
            if p73.touchControlFrame and (p73.activeControlModule == v_u_16 or (p73.activeControlModule == v_u_15 or p73.activeControlModule == v_u_11)) then
                if not p73.controllers[v_u_17] then
                    p73.controllers[v_u_17] = v_u_17.new()
                end
                p73.touchJumpController = p73.controllers[v_u_17]
                p73.touchJumpController:Enable(true, p73.touchControlFrame)
            elseif p73.touchJumpController then
                p73.touchJumpController:Enable(false)
            end
            p73:UpdateActiveControlModuleEnabled()
        end
    else
        if p73.activeController then
            p73.activeController:Enable(false)
        end
        p73.activeController = nil
        p73.activeControlModule = nil
    end
end
function v_u_1.OnLastInputTypeChanged(p75, p76)
    if v_u_22 == p76 then
        warn("LastInputType Change listener called with current type.")
    end
    v_u_22 = p76
    if v_u_22 == Enum.UserInputType.Touch then
        local v77, v78 = p75:SelectTouchModule()
        if v78 then
            while not p75.touchControlFrame do
                wait()
            end
            p75:SwitchToController(v77)
        end
    elseif v_u_21[v_u_22] ~= nil then
        local v79 = p75:SelectComputerMovementModule()
        if v79 then
            p75:SwitchToController(v79)
        end
    end
    p75:UpdateTouchGuiVisibility()
end
function v_u_1.OnComputerMovementModeChange(p80)
    local v81, v82 = p80:SelectComputerMovementModule()
    if v82 then
        p80:SwitchToController(v81)
    end
end
function v_u_1.OnTouchMovementModeChange(p83)
    local v84, v85 = p83:SelectTouchModule()
    if v85 then
        while not p83.touchControlFrame do
            wait()
        end
        p83:SwitchToController(v84)
    end
end
function v_u_1.CreateTouchGuiContainer(p86)
    if p86.touchGui then
        p86.touchGui:Destroy()
    end
    p86.touchGui = Instance.new("ScreenGui")
    p86.touchGui.Name = "TouchGui"
    p86.touchGui.ResetOnSpawn = false
    p86.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    p86:UpdateTouchGuiVisibility()
    p86.touchControlFrame = Instance.new("Frame")
    p86.touchControlFrame.Name = "TouchControlFrame"
    p86.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
    p86.touchControlFrame.BackgroundTransparency = 1
    p86.touchControlFrame.Parent = p86.touchGui
    p86.touchGui.Parent = p86.playerGui
end
function v_u_1.GetClickToMoveController(p87)
    if not p87.controllers[v_u_16] then
        p87.controllers[v_u_16] = v_u_16.new(v_u_19)
    end
    return p87.controllers[v_u_16]
end
return v_u_1.new()