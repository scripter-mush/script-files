Vector2.new(0, 0)
local v_u_1 = 0
local v_u_2 = CFrame.fromOrientation(-0.2617993877991494, 0, 0)
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("VRService")
local v_u_5 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_6 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_7 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_8 = setmetatable({}, v_u_7)
v_u_8.__index = v_u_8
function v_u_8.new()
    local v9 = v_u_7.new()
    local v10 = v_u_8
    local v11 = setmetatable(v9, v10)
    v11.isFollowCamera = false
    v11.isCameraToggle = false
    v11.lastUpdate = tick()
    v11.cameraToggleSpring = v_u_6.Spring.new(5, 0)
    return v11
end
function v_u_8.GetCameraToggleOffset(p12, p13)
    if not p12.isCameraToggle then
        return Vector3.new()
    end
    local v14 = p12.currentSubjectDistance
    if v_u_5.getTogglePan() then
        local v15 = p12.cameraToggleSpring
        local v16 = v_u_6.map(v14, 0.5, p12.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1)
        v15.goal = math.clamp(v16, 0, 1)
    else
        p12.cameraToggleSpring.goal = 0
    end
    local v17 = v_u_6.map(v14, 0.5, 64, 0, 1)
    local v18 = math.clamp(v17, 0, 1) + 1
    local v19 = p12.cameraToggleSpring:step(p13) * v18
    return Vector3.new(0, v19, 0)
end
function v_u_8.SetCameraMovementMode(p20, p21)
    v_u_7.SetCameraMovementMode(p20, p21)
    p20.isFollowCamera = p21 == Enum.ComputerCameraMovementMode.Follow
    p20.isCameraToggle = p21 == Enum.ComputerCameraMovementMode.CameraToggle
end
function v_u_8.Update(p22)
    local v23 = tick()
    local v24 = v23 - p22.lastUpdate
    local v25 = workspace.CurrentCamera
    local v26 = v25.CFrame
    local v27 = v25.Focus
    local v28
    if p22.resetCameraAngle then
        local v29 = p22:GetHumanoidRootPart()
        if v29 then
            v28 = (v29.CFrame * v_u_2).lookVector
        else
            v28 = v_u_2.lookVector
        end
        p22.resetCameraAngle = false
    else
        v28 = nil
    end
    local v30 = v_u_3.LocalPlayer
    local v31 = p22:GetHumanoid()
    local v32 = v25.CameraSubject
    local v33
    if v32 then
        v33 = v32:IsA("VehicleSeat")
    else
        v33 = v32
    end
    local v34
    if v32 then
        v34 = v32:IsA("SkateboardPlatform")
    else
        v34 = v32
    end
    local v35
    if v31 then
        v35 = v31:GetState() == Enum.HumanoidStateType.Climbing
    else
        v35 = v31
    end
    if p22.lastUpdate == nil or v24 > 1 then
        p22.lastCameraTransform = nil
    end
    local v36 = v_u_5.getRotation()
    p22:StepZoom()
    local v37 = p22:GetCameraHeight()
    if v_u_5.getRotation() ~= Vector2.new() then
        v_u_1 = 0
        p22.lastUserPanCamera = tick()
    end
    local v38 = v23 - p22.lastUserPanCamera < 2
    local v39 = p22:GetSubjectPosition()
    if v39 and (v30 and v25) then
        local v40 = p22:GetCameraToSubjectDistance()
        local v41 = v40 < 0.5 and 0.5 or v40
        if p22:GetIsMouseLocked() and not p22:IsInFirstPerson() then
            local v42 = p22:CalculateNewLookCFrameFromArg(v28, v36)
            local v43 = p22:GetMouseLockOffset()
            local v44 = v43.X * v42.RightVector + v43.Y * v42.UpVector + v43.Z * v42.LookVector
            if v_u_6.IsFiniteVector3(v44) then
                v39 = v39 + v44
            end
        elseif v_u_5.getRotation() == Vector2.new() and p22.lastCameraTransform then
            local v45 = p22:IsInFirstPerson()
            if (v33 or (v34 or p22.isFollowCamera and v35)) and (p22.lastUpdate and (v31 and v31.Torso)) then
                if v45 then
                    if p22.lastSubjectCFrame and (v33 or v34) and v32:IsA("BasePart") then
                        local v46 = -v_u_6.GetAngleBetweenXZVectors(p22.lastSubjectCFrame.lookVector, v32.CFrame.lookVector)
                        if v_u_6.IsFinite(v46) then
                            v36 = v36 + Vector2.new(v46, 0)
                        end
                        v_u_1 = 0
                    end
                elseif not v38 then
                    local v47 = v31.Torso.CFrame.lookVector
                    local v48 = v_u_1 + 3.839724354387525 * v24
                    v_u_1 = math.clamp(v48, 0, 4.363323129985824)
                    local v49 = v_u_1 * v24
                    local v50 = math.clamp(v49, 0, 1)
                    local v51 = p22:IsInFirstPerson() and not (p22.isFollowCamera and p22.isClimbing) and 1 or v50
                    local v52 = v_u_6.GetAngleBetweenXZVectors(v47, p22:GetCameraLookVector())
                    if v_u_6.IsFinite(v52) and math.abs(v52) > 0.0001 then
                        v36 = v36 + Vector2.new(v52 * v51, 0)
                    end
                end
            elseif p22.isFollowCamera and not (v45 or (v38 or v_u_4.VREnabled)) then
                local v53 = -(p22.lastCameraTransform.p - v39)
                local v54 = v_u_6.GetAngleBetweenXZVectors(v53, p22:GetCameraLookVector())
                if v_u_6.IsFinite(v54) and (math.abs(v54) > 0.0001 and math.abs(v54) > 0.4 * v24) then
                    v36 = v36 + Vector2.new(v54, 0)
                end
            end
        end
        local v55
        if p22.isFollowCamera then
            local v56 = p22:CalculateNewLookVectorFromArg(v28, v36)
            if v_u_4.VREnabled then
                v55 = p22:GetVRFocus(v39, v24)
            else
                v55 = CFrame.new(v39)
            end
            v26 = CFrame.new(v55.p - v41 * v56, v55.p) + Vector3.new(0, v37, 0)
        else
            local v57 = v_u_4.VREnabled
            if v57 then
                v55 = p22:GetVRFocus(v39, v24)
            else
                v55 = CFrame.new(v39)
            end
            local v58 = v55.p
            if v57 and not p22:IsInFirstPerson() then
                local v59 = (v39 - v25.CFrame.p).magnitude
                if v41 < v59 or v36.x ~= 0 then
                    local v60 = math.min(v59, v41)
                    local v61 = p22:CalculateNewLookVectorFromArg(nil, v36) * v60
                    local v62 = v58 - v61
                    local v63 = v25.CFrame.lookVector
                    if v36.x == 0 then
                        v61 = v63
                    end
                    local v64 = v62.x + v61.x
                    local v65 = v62.y
                    local v66 = v62.z + v61.z
                    local v67 = Vector3.new(v64, v65, v66)
                    v26 = CFrame.new(v62, v67) + Vector3.new(0, v37, 0)
                end
            else
                local v68 = p22:CalculateNewLookVectorFromArg(v28, v36)
                v26 = CFrame.new(v58 - v41 * v68, v58)
            end
        end
        local v69 = p22:GetCameraToggleOffset(v24)
        v27 = v55 + v69
        v26 = v26 + v69
        p22.lastCameraTransform = v26
        p22.lastCameraFocus = v27
        if (v33 or v34) and v32:IsA("BasePart") then
            p22.lastSubjectCFrame = v32.CFrame
        else
            p22.lastSubjectCFrame = nil
        end
    end
    p22.lastUpdate = v23
    return v26, v27
end
function v_u_8.EnterFirstPerson(p70)
    p70.inFirstPerson = true
    p70:UpdateMouseBehavior()
end
function v_u_8.LeaveFirstPerson(p71)
    p71.inFirstPerson = false
    p71:UpdateMouseBehavior()
end
return v_u_8