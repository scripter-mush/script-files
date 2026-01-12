local v_u_1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("ContextActionService")
local v_u_3 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4.new(p5)
    local v6 = v_u_3.new()
    local v7 = v_u_4
    local v8 = setmetatable(v6, v7)
    v8.CONTROL_ACTION_PRIORITY = p5
    v8.textFocusReleasedConn = nil
    v8.textFocusGainedConn = nil
    v8.windowFocusReleasedConn = nil
    v8.forwardValue = 0
    v8.backwardValue = 0
    v8.leftValue = 0
    v8.rightValue = 0
    v8.jumpEnabled = true
    return v8
end
function v_u_4.Enable(p9, p10)
    if not v_u_1.KeyboardEnabled then
        return false
    end
    if p10 == p9.enabled then
        return true
    end
    p9.forwardValue = 0
    p9.backwardValue = 0
    p9.leftValue = 0
    p9.rightValue = 0
    p9.moveVector = Vector3.new(0, 0, 0)
    p9.jumpRequested = false
    p9:UpdateJump()
    if p10 then
        p9:BindContextActions()
        p9:ConnectFocusEventListeners()
    else
        p9:UnbindContextActions()
        p9:DisconnectFocusEventListeners()
    end
    p9.enabled = p10
    return true
end
function v_u_4.UpdateMovement(p11, p12)
    if p12 == Enum.UserInputState.Cancel then
        p11.moveVector = Vector3.new(0, 0, 0)
    else
        local v13 = p11.leftValue + p11.rightValue
        local v14 = p11.forwardValue + p11.backwardValue
        p11.moveVector = Vector3.new(v13, 0, v14)
    end
end
function v_u_4.UpdateJump(p15)
    p15.isJumping = p15.jumpRequested
end
function v_u_4.BindContextActions(p_u_16)
    v_u_2:BindActionAtPriority("moveForwardAction", function(_, p17, _)
        p_u_16.forwardValue = p17 == Enum.UserInputState.Begin and -1 or 0
        p_u_16:UpdateMovement(p17)
        return Enum.ContextActionResult.Pass
    end, false, p_u_16.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterForward)
    v_u_2:BindActionAtPriority("moveBackwardAction", function(_, p18, _)
        p_u_16.backwardValue = p18 == Enum.UserInputState.Begin and 1 or 0
        p_u_16:UpdateMovement(p18)
        return Enum.ContextActionResult.Pass
    end, false, p_u_16.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterBackward)
    v_u_2:BindActionAtPriority("moveLeftAction", function(_, p19, _)
        p_u_16.leftValue = p19 == Enum.UserInputState.Begin and -1 or 0
        p_u_16:UpdateMovement(p19)
        return Enum.ContextActionResult.Pass
    end, false, p_u_16.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterLeft)
    v_u_2:BindActionAtPriority("moveRightAction", function(_, p20, _)
        p_u_16.rightValue = p20 == Enum.UserInputState.Begin and 1 or 0
        p_u_16:UpdateMovement(p20)
        return Enum.ContextActionResult.Pass
    end, false, p_u_16.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterRight)
    v_u_2:BindActionAtPriority("jumpAction", function(_, p21, _)
        local v22 = p_u_16
        local v23 = p_u_16.jumpEnabled
        if v23 then
            v23 = p21 == Enum.UserInputState.Begin
        end
        v22.jumpRequested = v23
        p_u_16:UpdateJump()
        return Enum.ContextActionResult.Pass
    end, false, p_u_16.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterJump)
end
function v_u_4.UnbindContextActions(_)
    v_u_2:UnbindAction("moveForwardAction")
    v_u_2:UnbindAction("moveBackwardAction")
    v_u_2:UnbindAction("moveLeftAction")
    v_u_2:UnbindAction("moveRightAction")
    v_u_2:UnbindAction("jumpAction")
end
function v_u_4.ConnectFocusEventListeners(p_u_24)
    local function v25()
        p_u_24.moveVector = Vector3.new(0, 0, 0)
        p_u_24.forwardValue = 0
        p_u_24.backwardValue = 0
        p_u_24.leftValue = 0
        p_u_24.rightValue = 0
        p_u_24.jumpRequested = false
        p_u_24:UpdateJump()
    end
    p_u_24.textFocusReleasedConn = v_u_1.TextBoxFocusReleased:Connect(v25)
    p_u_24.textFocusGainedConn = v_u_1.TextBoxFocused:Connect(function(_)
        p_u_24.jumpRequested = false
        p_u_24:UpdateJump()
    end)
    p_u_24.windowFocusReleasedConn = v_u_1.WindowFocused:Connect(v25)
end
function v_u_4.DisconnectFocusEventListeners(p26)
    if p26.textFocusReleasedConn then
        p26.textFocusReleasedConn:Disconnect()
        p26.textFocusReleasedConn = nil
    end
    if p26.textFocusGainedConn then
        p26.textFocusGainedConn:Disconnect()
        p26.textFocusGainedConn = nil
    end
    if p26.windowFocusReleasedConn then
        p26.windowFocusReleasedConn:Disconnect()
        p26.windowFocusReleasedConn = nil
    end
end
return v_u_4