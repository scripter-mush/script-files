local v_u_1 = game:GetService("VRService")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("PathfindingService")
local v_u_6 = game:GetService("ContextActionService")
local v_u_7 = game:GetService("StarterGui")
local v_u_8 = nil
local v_u_9 = v4.LocalPlayer
local v_u_10 = Instance.new("BindableEvent")
v_u_10.Name = "MovementUpdate"
v_u_10.Parent = script
coroutine.wrap(function()
    local v11 = script.Parent:WaitForChild("PathDisplay")
    if v11 then
        v_u_8 = require(v11)
    end
end)()
local v_u_12 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_13 = setmetatable({}, v_u_12)
v_u_13.__index = v_u_13
function v_u_13.new(p14)
    local v15 = v_u_12.new()
    local v16 = v_u_13
    local v17 = setmetatable(v15, v16)
    v17.CONTROL_ACTION_PRIORITY = p14
    v17.navigationRequestedConn = nil
    v17.heartbeatConn = nil
    v17.currentDestination = nil
    v17.currentPath = nil
    v17.currentPoints = nil
    v17.currentPointIdx = 0
    v17.expectedTimeToNextPoint = 0
    v17.timeReachedLastPoint = tick()
    v17.moving = false
    v17.isJumpBound = false
    v17.moveLatch = false
    v17.userCFrameEnabledConn = nil
    return v17
end
function v_u_13.SetLaserPointerMode(_, p_u_18)
    pcall(function()
        v_u_7:SetCore("VRLaserPointerMode", p_u_18)
    end)
end
function v_u_13.GetLocalHumanoid(_)
    local v19 = v_u_9.Character
    if v19 then
        for _, v20 in pairs(v19:GetChildren()) do
            if v20:IsA("Humanoid") then
                return v20
            end
        end
        return nil
    end
end
function v_u_13.HasBothHandControllers(_)
    local v21 = v_u_1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand)
    if v21 then
        v21 = v_u_1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
    end
    return v21
end
function v_u_13.HasAnyHandControllers(_)
    return v_u_1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or v_u_1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
end
function v_u_13.IsMobileVR(_)
    return v_u_2.TouchEnabled
end
function v_u_13.HasGamepad(_)
    return v_u_2.GamepadEnabled
end
function v_u_13.ShouldUseNavigationLaser(p22)
    if p22:IsMobileVR() then
        return true
    elseif p22:HasBothHandControllers() then
        return false
    else
        return p22:HasAnyHandControllers() and true or not p22:HasGamepad()
    end
end
function v_u_13.StartFollowingPath(p23, p24)
    currentPath = p24
    currentPoints = currentPath:GetPointCoordinates()
    currentPointIdx = 1
    moving = true
    timeReachedLastPoint = tick()
    local v25 = p23:GetLocalHumanoid()
    if v25 and (v25.Torso and #currentPoints >= 1) then
        expectedTimeToNextPoint = (currentPoints[1] - v25.Torso.Position).magnitude / v25.WalkSpeed
    end
    v_u_10:Fire("targetPoint", p23.currentDestination)
end
function v_u_13.GoToPoint(p26, p27)
    currentPath = true
    currentPoints = { p27 }
    currentPointIdx = 1
    moving = true
    local v28 = p26:GetLocalHumanoid()
    local v29 = (v28.Torso.Position - p27).magnitude / v28.WalkSpeed
    timeReachedLastPoint = tick()
    expectedTimeToNextPoint = v29
    v_u_10:Fire("targetPoint", p27)
end
function v_u_13.StopFollowingPath(p30)
    currentPath = nil
    currentPoints = nil
    currentPointIdx = 0
    moving = false
    p30.moveVector = Vector3.new(0, 0, 0)
end
function v_u_13.TryComputePath(_, p31, p32)
    local v33 = nil
    local v34 = 0
    while not v33 and v34 < 5 do
        v33 = v_u_5:ComputeSmoothPathAsync(p31, p32, 200)
        v34 = v34 + 1
        if v33.Status == Enum.PathStatus.ClosestNoPath or v33.Status == Enum.PathStatus.ClosestOutOfRange then
            return nil
        end
        if v33 and v33.Status == Enum.PathStatus.FailStartNotEmpty then
            p31 = p31 + (p32 - p31).Unit
            v33 = nil
        end
        if v33 and v33.Status == Enum.PathStatus.FailFinishNotEmpty then
            p32 = p32 + Vector3.new(0, 1, 0)
            v33 = nil
        end
    end
    return v33
end
function v_u_13.OnNavigationRequest(p35, p36, _)
    local v37 = p36.Position
    local v38 = p35.currentDestination
    local v39 = v37.x
    local v40
    if v39 == v39 and v39 ~= (1 / 0) then
        v40 = v39 ~= (-1 / 0)
    else
        v40 = false
    end
    if v40 then
        local v41 = v37.y
        if v41 == v41 and v41 ~= (1 / 0) then
            v40 = v41 ~= (-1 / 0)
        else
            v40 = false
        end
        if v40 then
            local v42 = v37.z
            if v42 == v42 and v42 ~= (1 / 0) then
                v40 = v42 ~= (-1 / 0)
            else
                v40 = false
            end
        end
    end
    if v40 then
        p35.currentDestination = v37
        local v43 = p35:GetLocalHumanoid()
        if v43 and v43.Torso then
            local v44 = v43.Torso.Position
            if (p35.currentDestination - v44).magnitude < 12 then
                p35:GoToPoint(p35.currentDestination)
            elseif v38 and (p35.currentDestination - v38).magnitude <= 4 then
                if moving then
                    p35.currentPoints[#currentPoints] = p35.currentDestination
                    return
                end
                p35:GoToPoint(p35.currentDestination)
            else
                local v45 = p35:TryComputePath(v44, p35.currentDestination)
                if v45 then
                    p35:StartFollowingPath(v45)
                    if v_u_8 then
                        v_u_8.setCurrentPoints(p35.currentPoints)
                        v_u_8.renderPath()
                        return
                    end
                else
                    p35:StopFollowingPath()
                    if v_u_8 then
                        v_u_8.clearRenderedPath()
                        return
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
function v_u_13.OnJumpAction(p46, _, p47, _)
    if p47 == Enum.UserInputState.Begin then
        p46.isJumping = true
    end
    return Enum.ContextActionResult.Sink
end
function v_u_13.BindJumpAction(p_u_48, p49)
    if p49 then
        if not p_u_48.isJumpBound then
            p_u_48.isJumpBound = true
            v_u_6:BindActionAtPriority("VRJumpAction", function()
                return p_u_48:OnJumpAction()
            end, false, p_u_48.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA)
            return
        end
    elseif p_u_48.isJumpBound then
        p_u_48.isJumpBound = false
        v_u_6:UnbindAction("VRJumpAction")
    end
end
function v_u_13.ControlCharacterGamepad(p50, _, p51, p52)
    if p52.KeyCode == Enum.KeyCode.Thumbstick1 then
        if p51 ~= Enum.UserInputState.Cancel then
            if p51 == Enum.UserInputState.End then
                p50.moveVector = Vector3.new(0, 0, 0)
                if p50:ShouldUseNavigationLaser() then
                    p50:BindJumpAction(false)
                    p50:SetLaserPointerMode("Navigation")
                end
                if p50.moveLatch then
                    p50.moveLatch = false
                    v_u_10:Fire("offtrack")
                end
            else
                p50:StopFollowingPath()
                if v_u_8 then
                    v_u_8.clearRenderedPath()
                end
                if p50:ShouldUseNavigationLaser() then
                    p50:BindJumpAction(true)
                    p50:SetLaserPointerMode("Hidden")
                end
                if p52.Position.magnitude > 0.22 then
                    local v53 = p52.Position.X
                    local v54 = -p52.Position.Y
                    p50.moveVector = Vector3.new(v53, 0, v54)
                    if p50.moveVector.magnitude > 0 then
                        local v55 = p50.moveVector.unit
                        local v56 = p52.Position.magnitude
                        p50.moveVector = v55 * math.min(1, v56)
                    end
                    p50.moveLatch = true
                end
            end
            return Enum.ContextActionResult.Sink
        end
        p50.moveVector = Vector3.new(0, 0, 0)
    end
end
function v_u_13.OnHeartbeat(p57, p58)
    local v59 = p57.moveVector
    local v60 = p57:GetLocalHumanoid()
    if v60 and v60.Torso then
        if p57.moving and p57.currentPoints then
            local v61 = v60.Torso.Position
            local v62 = (currentPoints[1] - v61) * Vector3.new(1, 0, 1)
            local v63 = v62.magnitude
            local v64 = v62 / v63
            if v63 < 1 then
                local v65 = currentPoints[1]
                local v66 = 0
                for v67, v68 in pairs(currentPoints) do
                    if v67 ~= 1 then
                        v66 = v66 + (v68 - v65).magnitude / v60.WalkSpeed
                        v65 = v68
                    end
                end
                table.remove(currentPoints, 1)
                currentPointIdx = currentPointIdx + 1
                if #currentPoints == 0 then
                    p57:StopFollowingPath()
                    if v_u_8 then
                        v_u_8.clearRenderedPath()
                    end
                    return
                end
                if v_u_8 then
                    v_u_8.setCurrentPoints(currentPoints)
                    v_u_8.renderPath()
                end
                expectedTimeToNextPoint = (currentPoints[1] - v61).magnitude / v60.WalkSpeed
                timeReachedLastPoint = tick()
            else
                local v69 = { game.Players.LocalPlayer.Character, workspace.CurrentCamera }
                local v70 = Ray.new(v61 - Vector3.new(0, 1, 0), v64 * 3)
                local v71, v72, _ = workspace:FindPartOnRayWithIgnoreList(v70, v69)
                if v71 then
                    local v73 = Ray.new(v72 + v64 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0))
                    local _, v74, _ = workspace:FindPartOnRayWithIgnoreList(v73, v69)
                    local v75 = v74.Y - v61.Y
                    if v75 < 6 and v75 > -2 then
                        v60.Jump = true
                    end
                end
                if tick() - timeReachedLastPoint > expectedTimeToNextPoint + 2 then
                    p57:StopFollowingPath()
                    if v_u_8 then
                        v_u_8.clearRenderedPath()
                    end
                    v_u_10:Fire("offtrack")
                end
                v59 = p57.moveVector:Lerp(v64, p58 * 10)
            end
        end
        local v76 = v59.x
        local v77
        if v76 == v76 and v76 ~= (1 / 0) then
            v77 = v76 ~= (-1 / 0)
        else
            v77 = false
        end
        if v77 then
            local v78 = v59.y
            if v78 == v78 and v78 ~= (1 / 0) then
                v77 = v78 ~= (-1 / 0)
            else
                v77 = false
            end
            if v77 then
                local v79 = v59.z
                if v79 == v79 and v79 ~= (1 / 0) then
                    v77 = v79 ~= (-1 / 0)
                else
                    v77 = false
                end
            end
        end
        if v77 then
            p57.moveVector = v59
        end
    end
end
function v_u_13.OnUserCFrameEnabled(p80)
    if p80:ShouldUseNavigationLaser() then
        p80:BindJumpAction(false)
        p80:SetLaserPointerMode("Navigation")
    else
        p80:BindJumpAction(true)
        p80:SetLaserPointerMode("Hidden")
    end
end
function v_u_13.Enable(p_u_81, p82)
    p_u_81.moveVector = Vector3.new(0, 0, 0)
    p_u_81.isJumping = false
    if p82 then
        p_u_81.navigationRequestedConn = v_u_1.NavigationRequested:Connect(function(p83, p84)
            p_u_81:OnNavigationRequest(p83, p84)
        end)
        p_u_81.heartbeatConn = v_u_3.Heartbeat:Connect(function(p85)
            p_u_81:OnHeartbeat(p85)
        end)
        v_u_6:BindAction("MoveThumbstick", function(p86, p87, p88)
            return p_u_81:ControlCharacterGamepad(p86, p87, p88)
        end, false, p_u_81.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1)
        v_u_6:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
        p_u_81.userCFrameEnabledConn = v_u_1.UserCFrameEnabled:Connect(function()
            p_u_81:OnUserCFrameEnabled()
        end)
        p_u_81:OnUserCFrameEnabled()
        v_u_1:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick)
        v_u_1:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY)
        p_u_81.enabled = true
    else
        p_u_81:StopFollowingPath()
        v_u_6:UnbindAction("MoveThumbstick")
        v_u_6:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
        p_u_81:BindJumpAction(false)
        p_u_81:SetLaserPointerMode("Disabled")
        if p_u_81.navigationRequestedConn then
            p_u_81.navigationRequestedConn:Disconnect()
            p_u_81.navigationRequestedConn = nil
        end
        if p_u_81.heartbeatConn then
            p_u_81.heartbeatConn:Disconnect()
            p_u_81.heartbeatConn = nil
        end
        if p_u_81.userCFrameEnabledConn then
            p_u_81.userCFrameEnabledConn:Disconnect()
            p_u_81.userCFrameEnabledConn = nil
        end
        p_u_81.enabled = false
    end
end
return v_u_13