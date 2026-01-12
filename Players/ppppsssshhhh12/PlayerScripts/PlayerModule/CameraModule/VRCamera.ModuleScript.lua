local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("VRService")
local v_u_3 = UserSettings():GetService("UserGameSettings")
local v_u_4 = require(script.Parent:WaitForChild("CameraInput"))
require(script.Parent:WaitForChild("CameraUtils"))
local v_u_5 = require(script.Parent:WaitForChild("VRBaseCamera"))
local v_u_6 = setmetatable({}, v_u_5)
v_u_6.__index = v_u_6
local v7, v8 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFlagEnableVRUpdate3")
end)
local v_u_9 = v7 and v8
function v_u_6.new()
    local v10 = v_u_5.new()
    local v11 = v_u_6
    local v12 = setmetatable(v10, v11)
    v12.lastUpdate = tick()
    v12:Reset()
    return v12
end
function v_u_6.Reset(p13)
    p13.needsReset = true
    p13.needsBlackout = true
    p13.motionDetTime = 0
    p13.blackOutTimer = 0
    p13.lastCameraResetPosition = nil
    p13.stepRotateTimeout = 0
    p13.cameraOffsetRotation = 0
    p13.cameraOffsetRotationDiscrete = 0
end
function v_u_6.Update(p14, p15)
    local v16 = workspace.CurrentCamera
    local v17 = v16.CFrame
    local v18 = v16.Focus
    local v19 = v_u_1.LocalPlayer
    p14:GetHumanoid()
    local _ = v16.CameraSubject
    if p14.lastUpdate == nil or p15 > 1 then
        p14.lastCameraTransform = nil
    end
    p14:StepZoom()
    p14:UpdateFadeFromBlack(p15)
    p14:UpdateEdgeBlur(v19, p15)
    local v20 = p14.lastSubjectPosition
    local v21 = p14:GetSubjectPosition()
    if p14.needsBlackout then
        p14:StartFadeFromBlack()
        local v22 = math.clamp(p15, 0.0001, 0.1)
        p14.blackOutTimer = p14.blackOutTimer + v22
        if p14.blackOutTimer > 0.1 and game:IsLoaded() then
            p14.needsBlackout = false
            p14.needsReset = true
        end
    end
    if v21 and (v19 and v16) then
        local v23 = p14:GetVRFocus(v21, p15)
        if p14:IsInFirstPerson() then
            v17, v18 = p14:UpdateFirstPersonTransform(p15, v17, v23, v20, v21)
        else
            v17, v18 = p14:UpdateThirdPersonTransform(p15, v17, v23, v20, v21)
        end
        p14.lastCameraTransform = v17
        p14.lastCameraFocus = v18
    end
    p14.lastUpdate = tick()
    return v17, v18
end
function v_u_6.UpdateFirstPersonTransform(p24, p25, _, p26, p27, p28)
    if p24.needsReset then
        p24:StartFadeFromBlack()
        p24.needsReset = false
        p24.stepRotateTimeout = 0.25
        p24.VRCameraFocusFrozen = true
        p24.cameraOffsetRotation = 0
        p24.cameraOffsetRotationDiscrete = 0
    end
    local v29 = v_u_1.LocalPlayer
    if (p27 - p28).magnitude > 0.01 then
        p24:StartVREdgeBlur(v29)
    end
    local v30 = p26.p
    local v31 = p24:GetCameraLookVector()
    local v32 = v31.X
    local v33 = v31.Z
    local v34 = Vector3.new(v32, 0, v33).Unit
    if p24.stepRotateTimeout > 0 then
        p24.stepRotateTimeout = p24.stepRotateTimeout - p25
    end
    local v35 = v_u_4.getRotation()
    local v36 = 0
    if v_u_9 and v_u_3.VRSmoothRotationEnabled then
        v36 = v35.X
    elseif p24.stepRotateTimeout <= 0 then
        local v37 = v35.X
        if math.abs(v37) > 0.03 then
            v36 = v35.X < 0 and -0.5 or 0.5
            p24.needsReset = true
        end
    end
    local v38 = p24:CalculateNewLookVectorFromArg(v34, Vector2.new(v36, 0))
    return CFrame.new(v30 - 0.5 * v38, v30), p26
end
function v_u_6.UpdateThirdPersonTransform(p39, p40, p41, p42, p43, p44)
    local v45 = p39:GetCameraToSubjectDistance()
    local v46 = v45 < 0.5 and 0.5 or v45
    if p43 ~= nil and p39.lastCameraFocus ~= nil then
        local v47 = v_u_1.LocalPlayer
        local v48 = p43 - p44
        local v49 = require(v47:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule")):GetMoveVector()
        local v50 = v48.magnitude > 0.01 and true or v49.magnitude > 0.01
        if v50 then
            p39.motionDetTime = 0.1
        end
        p39.motionDetTime = p39.motionDetTime - p40
        if (p39.motionDetTime > 0 and true or v50) and not p39.needsReset then
            local v51 = p39.lastCameraFocus
            p39.VRCameraFocusFrozen = true
            return p41, v51
        end
        local v52 = p39.lastCameraResetPosition == nil and true or (p44 - p39.lastCameraResetPosition).Magnitude > 1
        local v53 = v_u_4.getRotation()
        local v54 = v_u_9
        if v54 then
            v54 = v53 ~= Vector2.new()
        end
        local v55 = false
        if v54 and v53.X ~= 0 then
            local v56 = p39.cameraOffsetRotation + v53.X
            if v56 < -3.141592653589793 then
                v56 = 3.141592653589793 - (v56 + 3.141592653589793)
            elseif v56 > 3.141592653589793 then
                v56 = -3.141592653589793 + (v56 - 3.141592653589793)
            end
            p39.cameraOffsetRotation = math.clamp(v56, -3.141592653589793, 3.141592653589793)
            if v_u_3.VRSmoothRotationEnabled then
                p39.cameraOffsetRotationDiscrete = p39.cameraOffsetRotation
                local v57 = p39:GetHumanoid()
                local v58 = v57.Torso and v57.Torso.CFrame.lookVector or Vector3.new(1, 0, 0)
                local v59 = v58.X
                local v60 = v58.Z
                local v61 = Vector3.new(v59, 0, v60)
                local v62 = p42.Position - v61 * v46
                local v63 = p42.Position.X
                local v64 = v62.Y
                local v65 = p42.Position.Z
                local v66 = Vector3.new(v63, v64, v65)
                local v67 = v66 - (CFrame.new(v62, v66) * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), p39.cameraOffsetRotationDiscrete)).LookVector * (v66 - v62).Magnitude
                p41 = CFrame.new(v67, v66)
            else
                local v68 = p39.cameraOffsetRotation * 12 / 12
                local v69 = math.floor(v68)
                if v69 ~= p39.cameraOffsetRotationDiscrete then
                    p39.cameraOffsetRotationDiscrete = v69
                    v55 = true
                end
            end
        end
        if p39.VRCameraFocusFrozen and v52 or (p39.needsReset or v55) then
            if not v55 then
                p39.cameraOffsetRotationDiscrete = 0
                p39.cameraOffsetRotation = 0
            end
            v_u_2:RecenterUserHeadCFrame()
            p39.VRCameraFocusFrozen = false
            p39.needsReset = false
            p39.lastCameraResetPosition = p44
            p39:ResetZoom()
            p39:StartFadeFromBlack()
            local v70 = p39:GetHumanoid()
            local v71 = v70.Torso and v70.Torso.CFrame.lookVector or Vector3.new(1, 0, 0)
            local v72 = v71.X
            local v73 = v71.Z
            local v74 = Vector3.new(v72, 0, v73)
            local v75 = p42.Position - v74 * v46
            local v76 = p42.Position.X
            local v77 = v75.Y
            local v78 = p42.Position.Z
            local v79 = Vector3.new(v76, v77, v78)
            if v_u_9 and p39.cameraOffsetRotation ~= 0 then
                v75 = v79 - (CFrame.new(v75, v79) * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), p39.cameraOffsetRotationDiscrete)).LookVector * (v79 - v75).Magnitude
            end
            p41 = CFrame.new(v75, v79)
        end
    end
    return p41, p42
end
function v_u_6.EnterFirstPerson(p80)
    p80.inFirstPerson = true
    p80:UpdateMouseBehavior()
end
function v_u_6.LeaveFirstPerson(p81)
    p81.inFirstPerson = false
    p81.needsReset = true
    p81:UpdateMouseBehavior()
    if p81.VRBlur then
        p81.VRBlur.Visible = false
    end
end
return v_u_6