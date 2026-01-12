local v_u_1 = require(script.Parent:WaitForChild("VRBaseCamera"))
require(script.Parent:WaitForChild("CameraInput"))
local v_u_2 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_3 = require(script.Parent:WaitForChild("ZoomController"))
require(script.Parent:WaitForChild("VehicleCamera"))
local v_u_4 = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraCore"))
local v_u_5 = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraConfig"))
local v6 = game:GetService("Players")
local v_u_7 = game:GetService("RunService")
game:GetService("VRService")
local v_u_8 = v6.LocalPlayer
local v_u_9 = v_u_2.Spring
local v_u_10 = v_u_2.mapClamp
local _ = v_u_2.sanitizeAngle
local v_u_11 = 0.016666666666666666
local v_u_12 = setmetatable({}, v_u_1)
v_u_12.__index = v_u_12
function v_u_12.new()
    local v13 = v_u_1.new()
    local v14 = v_u_12
    local v15 = setmetatable(v13, v14)
    v15:Reset()
    v_u_7.Stepped:Connect(function(_, p16)
        v_u_11 = p16
    end)
    return v15
end
function v_u_12.Reset(p17)
    p17.vehicleCameraCore = v_u_4.new(p17:GetSubjectCFrame())
    local v18 = v_u_9.new
    local v19 = v_u_5.pitchBaseAngle
    p17.pitchSpring = v18(0, -math.rad(v19))
    p17.yawSpring = v_u_9.new(0, 0)
    local v20 = workspace.CurrentCamera
    local v21
    if v20 then
        v21 = v20.CameraSubject
    else
        v21 = v20
    end
    assert(v20, "VRVehicleCamera initialization error")
    assert(v21)
    assert(v21:IsA("VehicleSeat"))
    local v22 = v21:GetConnectedParts(true)
    local v23, v24 = v_u_2.getLooseBoundingSphere(v22)
    p17.assemblyRadius = math.max(v24, 0.001)
    p17.assemblyOffset = v21.CFrame:Inverse() * v23
    p17.lastCameraFocus = nil
    p17:_StepInitialZoom()
end
function v_u_12._StepInitialZoom(p25)
    local v26 = v_u_3.GetZoomRadius()
    local v27 = p25.assemblyRadius * v_u_5.initialZoomRadiusMul
    p25:SetCameraToSubjectDistance((math.max(v26, v27)))
end
function v_u_12._GetThirdPersonLocalOffset(p28)
    local v29 = p28.assemblyOffset
    local v30 = p28.assemblyRadius * v_u_5.verticalCenterOffset
    return v29 + Vector3.new(0, v30, 0)
end
function v_u_12._GetFirstPersonLocalOffset(p31, p32)
    local v33 = v_u_8.Character
    if v33 and v33.Parent then
        local v34 = v33:FindFirstChild("Head")
        if v34 and v34:IsA("BasePart") then
            return p32:Inverse() * v34.Position
        end
    end
    return p31:_GetThirdPersonLocalOffset()
end
function v_u_12.Update(p35)
    local v36 = workspace.CurrentCamera
    local v37
    if v36 then
        v37 = v36.CameraSubject
    else
        v37 = v36
    end
    local v38 = p35.vehicleCameraCore
    assert(v36)
    assert(v37)
    assert(v37:IsA("VehicleSeat"))
    local v39 = v_u_11
    v_u_11 = 0
    local v40 = p35:GetSubjectCFrame()
    local v41 = p35:GetSubjectVelocity()
    local v42 = p35:GetSubjectRotVelocity()
    local v43 = v41:Dot(v40.ZVector)
    math.abs(v43)
    local v44 = v40.YVector:Dot(v42)
    local v45 = math.abs(v44)
    local v46 = v40.XVector:Dot(v42)
    local v47 = math.abs(v46)
    local v48 = p35:StepZoom()
    local v49 = v_u_10(v48, 0.5, p35.assemblyRadius, 1, 0)
    local v50 = p35:_GetThirdPersonLocalOffset():Lerp(p35:_GetFirstPersonLocalOffset(v40), v49)
    v38:setTransform(v40)
    local v51 = v38:step(v39, v47, v45, v49)
    p35:UpdateFadeFromBlack(v39)
    local v52, v53
    if p35:IsInFirstPerson() then
        local v54 = v51.LookVector.X
        local v55 = v51.LookVector.Z
        local v56 = Vector3.new(v54, 0, v55).Unit
        local v57 = CFrame.new(v51.Position, v56)
        v52 = CFrame.new(v40 * v50) * v57
        v53 = v52 * CFrame.new(0, 0, v48)
        p35:StartVREdgeBlur(v_u_8)
    else
        v52 = CFrame.new(v40 * v50) * v51
        v53 = v52 * CFrame.new(0, 0, v48)
        if not p35.lastCameraFocus then
            p35.lastCameraFocus = v52
            p35.needsReset = true
        end
        local v58 = v52.Position - v36.CFrame.Position
        local v59 = v58.magnitude
        if v58.Unit:Dot(v36.CFrame.LookVector) > 0.56 and (v59 < 200 and not p35.needsReset) then
            v52 = p35.lastCameraFocus
            local v60 = v52.p
            local v61 = p35:GetCameraLookVector()
            local v62 = v61.X
            local v63 = v61.Z
            local v64 = p35:CalculateNewLookVectorFromArg(Vector3.new(v62, 0, v63).Unit, Vector2.new(0, 0))
            v53 = CFrame.new(v60 - v48 * v64, v60)
        else
            p35.currentSubjectDistance = 16
            p35.lastCameraFocus = p35:GetVRFocus(v40.Position, v39)
            p35.needsReset = false
            p35:StartFadeFromBlack()
            p35:ResetZoom()
        end
        p35:UpdateEdgeBlur(v_u_8, v39)
    end
    return v53, v52
end
function v_u_12.EnterFirstPerson(p65)
    p65.inFirstPerson = true
    p65:UpdateMouseBehavior()
end
function v_u_12.LeaveFirstPerson(p66)
    p66.inFirstPerson = false
    p66:UpdateMouseBehavior()
end
return v_u_12