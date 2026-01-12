local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("GuiService")
local v_u_3 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4.new()
    local v5 = v_u_3.new()
    local v6 = v_u_4
    local v7 = setmetatable(v5, v6)
    v7.parentUIFrame = nil
    v7.jumpButton = nil
    v7.characterAddedConn = nil
    v7.humanoidStateEnabledChangedConn = nil
    v7.humanoidJumpPowerConn = nil
    v7.humanoidParentConn = nil
    v7.externallyEnabled = false
    v7.jumpPower = 0
    v7.jumpStateEnabled = true
    v7.isJumping = false
    v7.humanoid = nil
    return v7
end
function v_u_4.EnableButton(p8, p9)
    if p9 then
        if not p8.jumpButton then
            p8:Create()
        end
        local v10 = v_u_1.LocalPlayer.Character
        if v10 then
            v10 = v_u_1.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        end
        if v10 and (p8.externallyEnabled and (p8.externallyEnabled and v10.JumpPower > 0)) then
            p8.jumpButton.Visible = true
            return
        end
    else
        p8.jumpButton.Visible = false
        p8.isJumping = false
        p8.jumpButton.ImageRectOffset = Vector2.new(1, 146)
    end
end
function v_u_4.UpdateEnabled(p11)
    if p11.jumpPower > 0 and p11.jumpStateEnabled then
        p11:EnableButton(true)
    else
        p11:EnableButton(false)
    end
end
function v_u_4.HumanoidChanged(p12, p13)
    local v14 = v_u_1.LocalPlayer.Character
    if v14 then
        v14 = v_u_1.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
    if v14 then
        if p13 == "JumpPower" then
            p12.jumpPower = v14.JumpPower
            p12:UpdateEnabled()
            return
        end
        if p13 == "Parent" and not v14.Parent then
            p12.humanoidChangeConn:Disconnect()
        end
    end
end
function v_u_4.HumanoidStateEnabledChanged(p15, p16, p17)
    if p16 == Enum.HumanoidStateType.Jumping then
        p15.jumpStateEnabled = p17
        p15:UpdateEnabled()
    end
end
function v_u_4.CharacterAdded(p_u_18, p19)
    if p_u_18.humanoidChangeConn then
        p_u_18.humanoidChangeConn:Disconnect()
        p_u_18.humanoidChangeConn = nil
    end
    p_u_18.humanoid = p19:FindFirstChildOfClass("Humanoid")
    while not p_u_18.humanoid do
        p19.ChildAdded:wait()
        p_u_18.humanoid = p19:FindFirstChildOfClass("Humanoid")
    end
    p_u_18.humanoidJumpPowerConn = p_u_18.humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
        p_u_18.jumpPower = p_u_18.humanoid.JumpPower
        p_u_18:UpdateEnabled()
    end)
    p_u_18.humanoidParentConn = p_u_18.humanoid:GetPropertyChangedSignal("Parent"):Connect(function()
        if not p_u_18.humanoid.Parent then
            p_u_18.humanoidJumpPowerConn:Disconnect()
            p_u_18.humanoidJumpPowerConn = nil
            p_u_18.humanoidParentConn:Disconnect()
            p_u_18.humanoidParentConn = nil
        end
    end)
    p_u_18.humanoidStateEnabledChangedConn = p_u_18.humanoid.StateEnabledChanged:Connect(function(p20, p21)
        p_u_18:HumanoidStateEnabledChanged(p20, p21)
    end)
    p_u_18.jumpPower = p_u_18.humanoid.JumpPower
    p_u_18.jumpStateEnabled = p_u_18.humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping)
    p_u_18:UpdateEnabled()
end
function v_u_4.SetupCharacterAddedFunction(p_u_22)
    p_u_22.characterAddedConn = v_u_1.LocalPlayer.CharacterAdded:Connect(function(p23)
        p_u_22:CharacterAdded(p23)
    end)
    if v_u_1.LocalPlayer.Character then
        p_u_22:CharacterAdded(v_u_1.LocalPlayer.Character)
    end
end
function v_u_4.Enable(p24, p25, p26)
    if p26 then
        p24.parentUIFrame = p26
    end
    p24.externallyEnabled = p25
    p24:EnableButton(p25)
end
function v_u_4.Create(p_u_27)
    if p_u_27.parentUIFrame then
        if p_u_27.jumpButton then
            p_u_27.jumpButton:Destroy()
            p_u_27.jumpButton = nil
        end
        local v28 = p_u_27.parentUIFrame.AbsoluteSize.x
        local v29 = p_u_27.parentUIFrame.AbsoluteSize.y
        local v30 = math.min(v28, v29) <= 500
        local v31 = v30 and 70 or 120
        p_u_27.jumpButton = Instance.new("ImageButton")
        p_u_27.jumpButton.Name = "JumpButton"
        p_u_27.jumpButton.Visible = false
        p_u_27.jumpButton.BackgroundTransparency = 1
        p_u_27.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        p_u_27.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        p_u_27.jumpButton.ImageRectSize = Vector2.new(144, 144)
        p_u_27.jumpButton.Size = UDim2.new(0, v31, 0, v31)
        p_u_27.jumpButton.Position = v30 and UDim2.new(1, -(v31 * 1.5 - 10), 1, -v31 - 20) or UDim2.new(1, -(v31 * 1.5 - 10), 1, -v31 * 1.75)
        local v_u_32 = nil
        p_u_27.jumpButton.InputBegan:connect(function(p33)
            if not v_u_32 and (p33.UserInputType == Enum.UserInputType.Touch and p33.UserInputState == Enum.UserInputState.Begin) then
                v_u_32 = p33
                p_u_27.jumpButton.ImageRectOffset = Vector2.new(146, 146)
                p_u_27.isJumping = true
            end
        end)
        p_u_27.jumpButton.InputEnded:connect(function(p34)
            if p34 == v_u_32 then
                v_u_32 = nil
                p_u_27.isJumping = false
                p_u_27.jumpButton.ImageRectOffset = Vector2.new(1, 146)
            end
        end)
        v_u_2.MenuOpened:connect(function()
            if v_u_32 then
                v_u_32 = nil
                p_u_27.isJumping = false
                p_u_27.jumpButton.ImageRectOffset = Vector2.new(1, 146)
            end
        end)
        if not p_u_27.characterAddedConn then
            p_u_27:SetupCharacterAddedFunction()
        end
        p_u_27.jumpButton.Parent = p_u_27.parentUIFrame
    end
end
return v_u_4