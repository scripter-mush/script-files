game:GetService("Players")
local v_u_1 = game:GetService("GuiService")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4.new()
    local v5 = v_u_3.new()
    local v6 = v_u_4
    local v7 = setmetatable(v5, v6)
    v7.isFollowStick = false
    v7.thumbstickFrame = nil
    v7.moveTouchObject = nil
    v7.onTouchMovedConn = nil
    v7.onTouchEndedConn = nil
    v7.screenPos = nil
    v7.stickImage = nil
    v7.thumbstickSize = nil
    return v7
end
function v_u_4.Enable(p8, p9, p10)
    if p9 == nil then
        return false
    end
    local v11 = p9 and true or false
    if p8.enabled == v11 then
        return true
    end
    p8.moveVector = Vector3.new(0, 0, 0)
    p8.isJumping = false
    if v11 then
        if not p8.thumbstickFrame then
            p8:Create(p10)
        end
        p8.thumbstickFrame.Visible = true
    else
        p8.thumbstickFrame.Visible = false
        p8:OnInputEnded()
    end
    p8.enabled = v11
end
function v_u_4.OnInputEnded(p12)
    p12.thumbstickFrame.Position = p12.screenPos
    p12.stickImage.Position = UDim2.new(0, p12.thumbstickFrame.Size.X.Offset / 2 - p12.thumbstickSize / 4, 0, p12.thumbstickFrame.Size.Y.Offset / 2 - p12.thumbstickSize / 4)
    p12.moveVector = Vector3.new(0, 0, 0)
    p12.isJumping = false
    p12.thumbstickFrame.Position = p12.screenPos
    p12.moveTouchObject = nil
end
function v_u_4.Create(p_u_13, p14)
    if p_u_13.thumbstickFrame then
        p_u_13.thumbstickFrame:Destroy()
        p_u_13.thumbstickFrame = nil
        if p_u_13.onTouchMovedConn then
            p_u_13.onTouchMovedConn:Disconnect()
            p_u_13.onTouchMovedConn = nil
        end
        if p_u_13.onTouchEndedConn then
            p_u_13.onTouchEndedConn:Disconnect()
            p_u_13.onTouchEndedConn = nil
        end
    end
    local v15 = p14.AbsoluteSize.X
    local v16 = p14.AbsoluteSize.Y
    local v17 = math.min(v15, v16) <= 500
    p_u_13.thumbstickSize = v17 and 70 or 120
    p_u_13.screenPos = v17 and UDim2.new(0, p_u_13.thumbstickSize / 2 - 10, 1, -p_u_13.thumbstickSize - 20) or UDim2.new(0, p_u_13.thumbstickSize / 2, 1, -p_u_13.thumbstickSize * 1.75)
    p_u_13.thumbstickFrame = Instance.new("Frame")
    p_u_13.thumbstickFrame.Name = "ThumbstickFrame"
    p_u_13.thumbstickFrame.Active = true
    p_u_13.thumbstickFrame.Visible = false
    p_u_13.thumbstickFrame.Size = UDim2.new(0, p_u_13.thumbstickSize, 0, p_u_13.thumbstickSize)
    p_u_13.thumbstickFrame.Position = p_u_13.screenPos
    p_u_13.thumbstickFrame.BackgroundTransparency = 1
    local v18 = Instance.new("ImageLabel")
    v18.Name = "OuterImage"
    v18.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    v18.ImageRectOffset = Vector2.new()
    v18.ImageRectSize = Vector2.new(220, 220)
    v18.BackgroundTransparency = 1
    v18.Size = UDim2.new(0, p_u_13.thumbstickSize, 0, p_u_13.thumbstickSize)
    v18.Position = UDim2.new(0, 0, 0, 0)
    v18.Parent = p_u_13.thumbstickFrame
    p_u_13.stickImage = Instance.new("ImageLabel")
    p_u_13.stickImage.Name = "StickImage"
    p_u_13.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    p_u_13.stickImage.ImageRectOffset = Vector2.new(220, 0)
    p_u_13.stickImage.ImageRectSize = Vector2.new(111, 111)
    p_u_13.stickImage.BackgroundTransparency = 1
    p_u_13.stickImage.Size = UDim2.new(0, p_u_13.thumbstickSize / 2, 0, p_u_13.thumbstickSize / 2)
    p_u_13.stickImage.Position = UDim2.new(0, p_u_13.thumbstickSize / 2 - p_u_13.thumbstickSize / 4, 0, p_u_13.thumbstickSize / 2 - p_u_13.thumbstickSize / 4)
    p_u_13.stickImage.ZIndex = 2
    p_u_13.stickImage.Parent = p_u_13.thumbstickFrame
    local v_u_19 = nil
    local function v_u_26(p20)
        local v21 = Vector2.new(p20.X - v_u_19.X, p20.Y - v_u_19.Y)
        local v22 = v21.magnitude
        local v23 = p_u_13.thumbstickFrame.AbsoluteSize.X / 2
        if p_u_13.isFollowStick and v23 < v22 then
            local v24 = v21.unit * v23
            p_u_13.thumbstickFrame.Position = UDim2.new(0, p20.X - p_u_13.thumbstickFrame.AbsoluteSize.X / 2 - v24.X, 0, p20.Y - p_u_13.thumbstickFrame.AbsoluteSize.Y / 2 - v24.Y)
        else
            local v25 = math.min(v22, v23)
            v21 = v21.unit * v25
        end
        p_u_13.stickImage.Position = UDim2.new(0, v21.X + p_u_13.stickImage.AbsoluteSize.X / 2, 0, v21.Y + p_u_13.stickImage.AbsoluteSize.Y / 2)
    end
    p_u_13.thumbstickFrame.InputBegan:Connect(function(p27)
        if not p_u_13.moveTouchObject and (p27.UserInputType == Enum.UserInputType.Touch and p27.UserInputState == Enum.UserInputState.Begin) then
            p_u_13.moveTouchObject = p27
            p_u_13.thumbstickFrame.Position = UDim2.new(0, p27.Position.X - p_u_13.thumbstickFrame.Size.X.Offset / 2, 0, p27.Position.Y - p_u_13.thumbstickFrame.Size.Y.Offset / 2)
            v_u_19 = Vector2.new(p_u_13.thumbstickFrame.AbsolutePosition.X + p_u_13.thumbstickFrame.AbsoluteSize.X / 2, p_u_13.thumbstickFrame.AbsolutePosition.Y + p_u_13.thumbstickFrame.AbsoluteSize.Y / 2)
            Vector2.new(p27.Position.X - v_u_19.X, p27.Position.Y - v_u_19.Y)
        end
    end)
    p_u_13.onTouchMovedConn = v_u_2.TouchMoved:Connect(function(p28, _)
        if p28 == p_u_13.moveTouchObject then
            v_u_19 = Vector2.new(p_u_13.thumbstickFrame.AbsolutePosition.X + p_u_13.thumbstickFrame.AbsoluteSize.X / 2, p_u_13.thumbstickFrame.AbsolutePosition.Y + p_u_13.thumbstickFrame.AbsoluteSize.Y / 2)
            local v29 = Vector2.new(p28.Position.X - v_u_19.X, p28.Position.Y - v_u_19.Y) / (p_u_13.thumbstickSize / 2)
            local v30 = v29.magnitude
            local v31
            if v30 < 0.05 then
                v31 = Vector3.new()
            else
                local v32 = v29.unit * ((v30 - 0.05) / 0.95)
                local v33 = v32.X
                local v34 = v32.Y
                v31 = Vector3.new(v33, 0, v34)
            end
            p_u_13.moveVector = v31
            v_u_26(p28.Position)
        end
    end)
    p_u_13.onTouchEndedConn = v_u_2.TouchEnded:Connect(function(p35, _)
        if p35 == p_u_13.moveTouchObject then
            p_u_13:OnInputEnded()
        end
    end)
    v_u_1.MenuOpened:Connect(function()
        if p_u_13.moveTouchObject then
            p_u_13:OnInputEnded()
        end
    end)
    p_u_13.thumbstickFrame.Parent = p14
end
return v_u_4