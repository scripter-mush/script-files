Vector2.new(0.2617993877991494, 0)
Vector2.new(0.7853981633974483, 0)
Vector2.new(0, 0)
local v_u_1 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_2 = require(script.Parent:WaitForChild("ZoomController"))
local v_u_3 = require(script.Parent:WaitForChild("CameraToggleStateController"))
local v_u_4 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_5 = require(script.Parent:WaitForChild("CameraUI"))
local v6 = game:GetService("Players")
local v_u_7 = game:GetService("UserInputService")
game:GetService("StarterGui")
local v_u_8 = game:GetService("VRService")
local v_u_9 = UserSettings():GetService("UserGameSettings")
local v_u_10 = v6.LocalPlayer
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11.new()
    local v12 = v_u_11
    local v_u_13 = setmetatable({}, v12)
    v_u_13.FIRST_PERSON_DISTANCE_THRESHOLD = 1
    v_u_13.cameraType = nil
    v_u_13.cameraMovementMode = nil
    v_u_13.lastCameraTransform = nil
    v_u_13.lastUserPanCamera = tick()
    v_u_13.humanoidRootPart = nil
    v_u_13.humanoidCache = {}
    v_u_13.lastSubject = nil
    v_u_13.lastSubjectPosition = Vector3.new(0, 5, 0)
    v_u_13.lastSubjectCFrame = CFrame.new(v_u_13.lastSubjectPosition)
    local v14 = v_u_10.CameraMinZoomDistance
    local v15 = v_u_10.CameraMaxZoomDistance
    v_u_13.defaultSubjectDistance = math.clamp(12.5, v14, v15)
    local v16 = v_u_10.CameraMinZoomDistance
    local v17 = v_u_10.CameraMaxZoomDistance
    v_u_13.currentSubjectDistance = math.clamp(12.5, v16, v17)
    v_u_13.inFirstPerson = false
    v_u_13.inMouseLockedMode = false
    v_u_13.portraitMode = false
    v_u_13.isSmallTouchScreen = false
    v_u_13.resetCameraAngle = true
    v_u_13.enabled = false
    v_u_13.PlayerGui = nil
    v_u_13.cameraChangedConn = nil
    v_u_13.viewportSizeChangedConn = nil
    v_u_13.shouldUseVRRotation = false
    v_u_13.VRRotationIntensityAvailable = false
    v_u_13.lastVRRotationIntensityCheckTime = 0
    v_u_13.lastVRRotationTime = 0
    v_u_13.vrRotateKeyCooldown = {}
    v_u_13.cameraTranslationConstraints = Vector3.new(1, 1, 1)
    v_u_13.humanoidJumpOrigin = nil
    v_u_13.trackingHumanoid = nil
    v_u_13.cameraFrozen = false
    v_u_13.subjectStateChangedConn = nil
    v_u_13.gamepadZoomPressConnection = nil
    v_u_13.mouseLockOffset = Vector3.new(0, 0, 0)
    if v_u_10.Character then
        v_u_13:OnCharacterAdded(v_u_10.Character)
    end
    v_u_10.CharacterAdded:Connect(function(p18)
        v_u_13:OnCharacterAdded(p18)
    end)
    if v_u_13.cameraChangedConn then
        v_u_13.cameraChangedConn:Disconnect()
    end
    v_u_13.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        v_u_13:OnCurrentCameraChanged()
    end)
    v_u_13:OnCurrentCameraChanged()
    if v_u_13.playerCameraModeChangeConn then
        v_u_13.playerCameraModeChangeConn:Disconnect()
    end
    v_u_13.playerCameraModeChangeConn = v_u_10:GetPropertyChangedSignal("CameraMode"):Connect(function()
        v_u_13:OnPlayerCameraPropertyChange()
    end)
    if v_u_13.minDistanceChangeConn then
        v_u_13.minDistanceChangeConn:Disconnect()
    end
    v_u_13.minDistanceChangeConn = v_u_10:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function()
        v_u_13:OnPlayerCameraPropertyChange()
    end)
    if v_u_13.maxDistanceChangeConn then
        v_u_13.maxDistanceChangeConn:Disconnect()
    end
    v_u_13.maxDistanceChangeConn = v_u_10:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
        v_u_13:OnPlayerCameraPropertyChange()
    end)
    if v_u_13.playerDevTouchMoveModeChangeConn then
        v_u_13.playerDevTouchMoveModeChangeConn:Disconnect()
    end
    v_u_13.playerDevTouchMoveModeChangeConn = v_u_10:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
        v_u_13:OnDevTouchMovementModeChanged()
    end)
    v_u_13:OnDevTouchMovementModeChanged()
    if v_u_13.gameSettingsTouchMoveMoveChangeConn then
        v_u_13.gameSettingsTouchMoveMoveChangeConn:Disconnect()
    end
    v_u_13.gameSettingsTouchMoveMoveChangeConn = v_u_9:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
        v_u_13:OnGameSettingsTouchMovementModeChanged()
    end)
    v_u_13:OnGameSettingsTouchMovementModeChanged()
    v_u_9:SetCameraYInvertVisible()
    v_u_9:SetGamepadCameraSensitivityVisible()
    v_u_13.hasGameLoaded = game:IsLoaded()
    if not v_u_13.hasGameLoaded then
        v_u_13.gameLoadedConn = game.Loaded:Connect(function()
            v_u_13.hasGameLoaded = true
            v_u_13.gameLoadedConn:Disconnect()
            v_u_13.gameLoadedConn = nil
        end)
    end
    v_u_13:OnPlayerCameraPropertyChange()
    return v_u_13
end
function v_u_11.GetModuleName(_)
    return "BaseCamera"
end
function v_u_11.OnCharacterAdded(p_u_19, p20)
    p_u_19.resetCameraAngle = p_u_19.resetCameraAngle or p_u_19:GetEnabled()
    p_u_19.humanoidRootPart = nil
    if v_u_7.TouchEnabled then
        p_u_19.PlayerGui = v_u_10:WaitForChild("PlayerGui")
        for _, v21 in ipairs(p20:GetChildren()) do
            if v21:IsA("Tool") then
                p_u_19.isAToolEquipped = true
            end
        end
        p20.ChildAdded:Connect(function(p22)
            if p22:IsA("Tool") then
                p_u_19.isAToolEquipped = true
            end
        end)
        p20.ChildRemoved:Connect(function(p23)
            if p23:IsA("Tool") then
                p_u_19.isAToolEquipped = false
            end
        end)
    end
end
function v_u_11.GetHumanoidRootPart(p24)
    local v25 = (not p24.humanoidRootPart and v_u_10.Character and true or false) and v_u_10.Character:FindFirstChildOfClass("Humanoid")
    if v25 then
        p24.humanoidRootPart = v25.RootPart
    end
    return p24.humanoidRootPart
end
function v_u_11.GetBodyPartToFollow(_, p26, _)
    if p26:GetState() == Enum.HumanoidStateType.Dead then
        local v27 = p26.Parent
        if v27 and v27:IsA("Model") then
            return v27:FindFirstChild("Head") or p26.RootPart
        end
    end
    return p26.RootPart
end
function v_u_11.GetSubjectCFrame(p28)
    local v29 = p28.lastSubjectCFrame
    local v30 = workspace.CurrentCamera
    if v30 then
        v30 = v30.CameraSubject
    end
    if not v30 then
        return v29
    end
    if v30:IsA("Humanoid") then
        local v31 = v30:GetState() == Enum.HumanoidStateType.Dead
        local v32 = v30.RootPart
        if v31 and (v30.Parent and v30.Parent:IsA("Model")) then
            v32 = v30.Parent:FindFirstChild("Head") or v32
        end
        if v32 and v32:IsA("BasePart") then
            local v33
            if v30.RigType == Enum.HumanoidRigType.R15 then
                if v30.AutomaticScalingEnabled then
                    v33 = Vector3.new(0, 1.5, 0)
                    local v34 = v30.RootPart
                    if v32 == v34 then
                        local v35 = (v34.Size.Y - (Vector3.new(2, 2, 1)).Y) / 2
                        v33 = v33 + Vector3.new(0, v35, 0)
                    end
                else
                    v33 = Vector3.new(0, 2, 0)
                end
            else
                v33 = Vector3.new(0, 1.5, 0)
            end
            v29 = v32.CFrame * CFrame.new((v31 and Vector3.new(0, 0, 0) or v33) + v30.CameraOffset)
        end
    elseif v30:IsA("BasePart") then
        v29 = v30.CFrame
    elseif v30:IsA("Model") then
        if v30.PrimaryPart then
            v29 = v30:GetPrimaryPartCFrame()
        else
            v29 = CFrame.new()
        end
    end
    if v29 then
        p28.lastSubjectCFrame = v29
    end
    return v29
end
function v_u_11.GetSubjectVelocity(_)
    local v36 = workspace.CurrentCamera
    if v36 then
        v36 = v36.CameraSubject
    end
    if not v36 then
        return Vector3.new(0, 0, 0)
    end
    if v36:IsA("BasePart") then
        return v36.Velocity
    end
    if v36:IsA("Humanoid") then
        local v37 = v36.RootPart
        if v37 then
            return v37.Velocity
        end
    else
        local v38 = v36:IsA("Model") and v36.PrimaryPart
        if v38 then
            return v38.Velocity
        end
    end
    return Vector3.new(0, 0, 0)
end
function v_u_11.GetSubjectRotVelocity(_)
    local v39 = workspace.CurrentCamera
    if v39 then
        v39 = v39.CameraSubject
    end
    if not v39 then
        return Vector3.new(0, 0, 0)
    end
    if v39:IsA("BasePart") then
        return v39.RotVelocity
    end
    if v39:IsA("Humanoid") then
        local v40 = v39.RootPart
        if v40 then
            return v40.RotVelocity
        end
    else
        local v41 = v39:IsA("Model") and v39.PrimaryPart
        if v41 then
            return v41.RotVelocity
        end
    end
    return Vector3.new(0, 0, 0)
end
function v_u_11.StepZoom(p42)
    local v43 = p42.currentSubjectDistance
    local v44 = v_u_4.getZoomDelta()
    if math.abs(v44) > 0 then
        local v45
        if v44 > 0 then
            local v46 = v43 + v44 * (v43 * 0.5 + 1)
            local v47 = p42.FIRST_PERSON_DISTANCE_THRESHOLD
            v45 = math.max(v46, v47)
        else
            local v48 = (v43 + v44) / (1 - v44 * 0.5)
            v45 = math.max(v48, 0.5)
        end
        p42:SetCameraToSubjectDistance(v45 < p42.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v45)
    end
    return v_u_2.GetZoomRadius()
end
function v_u_11.GetSubjectPosition(p49)
    local v50 = p49.lastSubjectPosition
    local v51 = game.Workspace.CurrentCamera
    if v51 then
        v51 = v51.CameraSubject
    end
    if not v51 then
        return nil
    end
    if v51:IsA("Humanoid") then
        local v52 = v51:GetState() == Enum.HumanoidStateType.Dead
        local v53 = v51.RootPart
        if v52 and (v51.Parent and v51.Parent:IsA("Model")) then
            v53 = v51.Parent:FindFirstChild("Head") or v53
        end
        if v53 and v53:IsA("BasePart") then
            local v54
            if v51.RigType == Enum.HumanoidRigType.R15 then
                if v51.AutomaticScalingEnabled then
                    v54 = Vector3.new(0, 1.5, 0)
                    if v53 == v51.RootPart then
                        local v55 = v51.RootPart.Size.Y / 2 - (Vector3.new(2, 2, 1)).Y / 2
                        v54 = v54 + Vector3.new(0, v55, 0)
                    end
                else
                    v54 = Vector3.new(0, 2, 0)
                end
            else
                v54 = Vector3.new(0, 1.5, 0)
            end
            v50 = v53.CFrame.p + v53.CFrame:vectorToWorldSpace((v52 and Vector3.new(0, 0, 0) or v54) + v51.CameraOffset)
        end
    elseif v51:IsA("VehicleSeat") then
        v50 = v51.CFrame.p + v51.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0))
    elseif v51:IsA("SkateboardPlatform") then
        v50 = v51.CFrame.p + Vector3.new(0, 5, 0)
    elseif v51:IsA("BasePart") then
        v50 = v51.CFrame.p
    elseif v51:IsA("Model") then
        if v51.PrimaryPart then
            v50 = v51:GetPrimaryPartCFrame().p
        else
            v50 = v51:GetModelCFrame().p
        end
    end
    p49.lastSubject = v51
    p49.lastSubjectPosition = v50
    return v50
end
function v_u_11.UpdateDefaultSubjectDistance(p56)
    if p56.portraitMode then
        local v57 = v_u_10.CameraMinZoomDistance
        local v58 = v_u_10.CameraMaxZoomDistance
        p56.defaultSubjectDistance = math.clamp(25, v57, v58)
    else
        local v59 = v_u_10.CameraMinZoomDistance
        local v60 = v_u_10.CameraMaxZoomDistance
        p56.defaultSubjectDistance = math.clamp(12.5, v59, v60)
    end
end
function v_u_11.OnViewportSizeChanged(p61)
    local v62 = game.Workspace.CurrentCamera.ViewportSize
    p61.portraitMode = v62.X < v62.Y
    local v63 = v_u_7.TouchEnabled
    if v63 then
        v63 = v62.Y < 500 and true or v62.X < 700
    end
    p61.isSmallTouchScreen = v63
    p61:UpdateDefaultSubjectDistance()
end
function v_u_11.OnCurrentCameraChanged(p_u_64)
    if v_u_7.TouchEnabled then
        if p_u_64.viewportSizeChangedConn then
            p_u_64.viewportSizeChangedConn:Disconnect()
            p_u_64.viewportSizeChangedConn = nil
        end
        local v65 = game.Workspace.CurrentCamera
        if v65 then
            p_u_64:OnViewportSizeChanged()
            p_u_64.viewportSizeChangedConn = v65:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                p_u_64:OnViewportSizeChanged()
            end)
        end
    end
    if p_u_64.cameraSubjectChangedConn then
        p_u_64.cameraSubjectChangedConn:Disconnect()
        p_u_64.cameraSubjectChangedConn = nil
    end
    local v66 = game.Workspace.CurrentCamera
    if v66 then
        p_u_64.cameraSubjectChangedConn = v66:GetPropertyChangedSignal("CameraSubject"):Connect(function()
            p_u_64:OnNewCameraSubject()
        end)
        p_u_64:OnNewCameraSubject()
    end
end
function v_u_11.OnDynamicThumbstickEnabled(p67)
    if v_u_7.TouchEnabled then
        p67.isDynamicThumbstickEnabled = true
    end
end
function v_u_11.OnDynamicThumbstickDisabled(p68)
    p68.isDynamicThumbstickEnabled = false
end
function v_u_11.OnGameSettingsTouchMovementModeChanged(p69)
    if v_u_10.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        if v_u_9.TouchMovementMode == Enum.TouchMovementMode.DynamicThumbstick or v_u_9.TouchMovementMode == Enum.TouchMovementMode.Default then
            p69:OnDynamicThumbstickEnabled()
            return
        end
        p69:OnDynamicThumbstickDisabled()
    end
end
function v_u_11.OnDevTouchMovementModeChanged(p70)
    if v_u_10.DevTouchMovementMode == Enum.DevTouchMovementMode.DynamicThumbstick then
        p70:OnDynamicThumbstickEnabled()
    else
        p70:OnGameSettingsTouchMovementModeChanged()
    end
end
function v_u_11.OnPlayerCameraPropertyChange(p71)
    p71:SetCameraToSubjectDistance(p71.currentSubjectDistance)
end
function v_u_11.InputTranslationToCameraAngleChange(_, p72, p73)
    return p72 * p73
end
function v_u_11.GamepadZoomPress(p74)
    local v75 = p74:GetCameraToSubjectDistance()
    if v75 > 15 then
        p74:SetCameraToSubjectDistance(10)
        return
    elseif v75 > 5 then
        p74:SetCameraToSubjectDistance(0)
    else
        p74:SetCameraToSubjectDistance(20)
    end
end
function v_u_11.Enable(p_u_76, p77)
    if p_u_76.enabled ~= p77 then
        p_u_76.enabled = p77
        if p_u_76.enabled then
            v_u_4.setInputEnabled(true)
            p_u_76.gamepadZoomPressConnection = v_u_4.gamepadZoomPress:Connect(function()
                p_u_76:GamepadZoomPress()
            end)
            if v_u_10.CameraMode == Enum.CameraMode.LockFirstPerson then
                p_u_76.currentSubjectDistance = 0.5
                if not p_u_76.inFirstPerson then
                    p_u_76:EnterFirstPerson()
                end
            end
        else
            v_u_4.setInputEnabled(false)
            if p_u_76.gamepadZoomPressConnection then
                p_u_76.gamepadZoomPressConnection:Disconnect()
                p_u_76.gamepadZoomPressConnection = nil
            end
            p_u_76:Cleanup()
        end
        p_u_76:OnEnable(p77)
    end
end
function v_u_11.OnEnable(_, _) end
function v_u_11.GetEnabled(p78)
    return p78.enabled
end
function v_u_11.Cleanup(p79)
    if p79.subjectStateChangedConn then
        p79.subjectStateChangedConn:Disconnect()
        p79.subjectStateChangedConn = nil
    end
    if p79.viewportSizeChangedConn then
        p79.viewportSizeChangedConn:Disconnect()
        p79.viewportSizeChangedConn = nil
    end
    p79.lastCameraTransform = nil
    p79.lastSubjectCFrame = nil
    v_u_1.restoreMouseBehavior()
end
function v_u_11.UpdateMouseBehavior(p80)
    local v81 = v_u_9.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
    if p80.isCameraToggle and v81 == false then
        v_u_5.setCameraModeToastEnabled(true)
        v_u_4.enableCameraToggleInput()
        v_u_3(p80.inFirstPerson)
        return
    else
        v_u_5.setCameraModeToastEnabled(false)
        v_u_4.disableCameraToggleInput()
        if p80.inFirstPerson or p80.inMouseLockedMode then
            v_u_1.setRotationTypeOverride(Enum.RotationType.CameraRelative)
            v_u_1.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
        else
            v_u_1.restoreRotationType()
            v_u_1.restoreMouseBehavior()
        end
    end
end
function v_u_11.UpdateForDistancePropertyChange(p82)
    p82:SetCameraToSubjectDistance(p82.currentSubjectDistance)
end
function v_u_11.SetCameraToSubjectDistance(p83, p84)
    local v85 = p83.currentSubjectDistance
    if v_u_10.CameraMode == Enum.CameraMode.LockFirstPerson then
        p83.currentSubjectDistance = 0.5
        if not p83.inFirstPerson then
            p83:EnterFirstPerson()
        end
    else
        local v86 = v_u_10.CameraMinZoomDistance
        local v87 = v_u_10.CameraMaxZoomDistance
        local v88 = math.clamp(p84, v86, v87)
        if v88 < 1 then
            p83.currentSubjectDistance = 0.5
            if not p83.inFirstPerson then
                p83:EnterFirstPerson()
            end
        else
            p83.currentSubjectDistance = v88
            if p83.inFirstPerson then
                p83:LeaveFirstPerson()
            end
        end
    end
    local v89 = v_u_2.SetZoomParameters
    local v90 = p83.currentSubjectDistance
    local v91 = p84 - v85
    v89(v90, (math.sign(v91)))
    return p83.currentSubjectDistance
end
function v_u_11.SetCameraType(p92, p93)
    p92.cameraType = p93
end
function v_u_11.GetCameraType(p94)
    return p94.cameraType
end
function v_u_11.SetCameraMovementMode(p95, p96)
    p95.cameraMovementMode = p96
end
function v_u_11.GetCameraMovementMode(p97)
    return p97.cameraMovementMode
end
function v_u_11.SetIsMouseLocked(p98, p99)
    p98.inMouseLockedMode = p99
end
function v_u_11.GetIsMouseLocked(p100)
    return p100.inMouseLockedMode
end
function v_u_11.SetMouseLockOffset(p101, p102)
    p101.mouseLockOffset = p102
end
function v_u_11.GetMouseLockOffset(p103)
    return p103.mouseLockOffset
end
function v_u_11.InFirstPerson(p104)
    return p104.inFirstPerson
end
function v_u_11.EnterFirstPerson(_) end
function v_u_11.LeaveFirstPerson(_) end
function v_u_11.GetCameraToSubjectDistance(p105)
    return p105.currentSubjectDistance
end
function v_u_11.GetMeasuredDistanceToFocus(_)
    local v106 = game.Workspace.CurrentCamera
    if v106 then
        return (v106.CoordinateFrame.p - v106.Focus.p).magnitude
    else
        return nil
    end
end
function v_u_11.GetCameraLookVector(_)
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1)
end
function v_u_11.CalculateNewLookCFrameFromArg(p107, p108, p109)
    local v110 = p108 or p107:GetCameraLookVector()
    local v111 = v110.Y
    local v112 = math.asin(v111)
    local v113 = p109.Y
    local v114 = v112 + -1.3962634015954636
    local v115 = v112 + 1.3962634015954636
    local v116 = math.clamp(v113, v114, v115)
    local v117 = Vector2.new(p109.X, v116)
    local v118 = CFrame.new(Vector3.new(0, 0, 0), v110)
    return CFrame.Angles(0, -v117.X, 0) * v118 * CFrame.Angles(-v117.Y, 0, 0)
end
function v_u_11.CalculateNewLookVectorFromArg(p119, p120, p121)
    return p119:CalculateNewLookCFrameFromArg(p120, p121).LookVector
end
function v_u_11.CalculateNewLookVectorVRFromArg(p122, p123)
    local v124 = ((p122:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit
    local v125 = Vector2.new(p123.X, 0)
    local v126 = CFrame.new(Vector3.new(0, 0, 0), v124)
    return ((CFrame.Angles(0, -v125.X, 0) * v126 * CFrame.Angles(-v125.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit
end
function v_u_11.GetHumanoid(p127)
    local v128 = v_u_10
    if v128 then
        v128 = v_u_10.Character
    end
    if not v128 then
        return nil
    end
    local v129 = p127.humanoidCache[v_u_10]
    if v129 and v129.Parent == v128 then
        return v129
    end
    p127.humanoidCache[v_u_10] = nil
    local v130 = v128:FindFirstChildOfClass("Humanoid")
    if v130 then
        p127.humanoidCache[v_u_10] = v130
    end
    return v130
end
function v_u_11.GetHumanoidPartToFollow(_, p131, p132)
    if p132 == Enum.HumanoidStateType.Dead then
        local v133 = p131.Parent
        if v133 then
            return v133:FindFirstChild("Head") or p131.Torso
        else
            return p131.Torso
        end
    else
        return p131.Torso
    end
end
function v_u_11.OnNewCameraSubject(p134)
    if p134.subjectStateChangedConn then
        p134.subjectStateChangedConn:Disconnect()
        p134.subjectStateChangedConn = nil
    end
end
function v_u_11.IsInFirstPerson(p135)
    return p135.inFirstPerson
end
function v_u_11.Update(_, _)
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
end
function v_u_11.GetCameraHeight(p136)
    return (not v_u_8.VREnabled or p136.inFirstPerson) and 0 or 0.25881904510252074 * p136.currentSubjectDistance
end
return v_u_11