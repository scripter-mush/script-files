Vector2.new()
require(script.Parent:WaitForChild("CameraUtils"))
local v_u_1 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_2 = game:GetService("Players")
local v_u_3 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4.new()
    local v5 = v_u_3.new()
    local v6 = v_u_4
    local v7 = setmetatable(v5, v6)
    v7.cameraType = Enum.CameraType.Fixed
    v7.lastUpdate = tick()
    v7.lastDistanceToSubject = nil
    return v7
end
function v_u_4.GetModuleName(_)
    return "LegacyCamera"
end
function v_u_4.SetCameraToSubjectDistance(p8, p9)
    return v_u_3.SetCameraToSubjectDistance(p8, p9)
end
function v_u_4.Update(p10, _)
    if not p10.cameraType then
        return nil, nil
    end
    local v11 = tick()
    local v12 = v11 - p10.lastUpdate
    local v13 = workspace.CurrentCamera
    local v14 = v13.CFrame
    local v15 = v13.Focus
    local v16 = v_u_2.LocalPlayer
    if p10.lastUpdate == nil or v12 > 1 then
        p10.lastDistanceToSubject = nil
    end
    local v17 = p10:GetSubjectPosition()
    if p10.cameraType == Enum.CameraType.Fixed then
        if v17 and (v16 and v13) then
            local v18 = p10:GetCameraToSubjectDistance()
            local v19 = p10:CalculateNewLookVectorFromArg(nil, v_u_1.getRotation())
            v15 = v13.Focus
            v14 = CFrame.new(v13.CFrame.p, v13.CFrame.p + v18 * v19)
        end
    elseif p10.cameraType == Enum.CameraType.Attach then
        local v20 = p10:GetSubjectCFrame()
        local v21 = v13.CFrame:ToEulerAnglesYXZ()
        local _, v22 = v20:ToEulerAnglesYXZ()
        local v23 = v21 - v_u_1.getRotation().Y
        local v24 = math.clamp(v23, -1.3962634015954636, 1.3962634015954636)
        v15 = CFrame.new(v20.p) * CFrame.fromEulerAnglesYXZ(v24, v22, 0)
        v14 = v15 * CFrame.new(0, 0, p10:StepZoom())
    else
        if p10.cameraType ~= Enum.CameraType.Watch then
            return v13.CFrame, v13.Focus
        end
        if v17 and (v16 and v13) then
            local v25 = nil
            if v17 == v13.CFrame.p then
                warn("Camera cannot watch subject in same position as itself")
                return v13.CFrame, v13.Focus
            end
            local v26 = p10:GetHumanoid()
            if v26 and v26.RootPart then
                local v27 = v17 - v13.CFrame.p
                v25 = v27.unit
                if p10.lastDistanceToSubject and p10.lastDistanceToSubject == p10:GetCameraToSubjectDistance() then
                    p10:SetCameraToSubjectDistance(v27.magnitude)
                end
            end
            local v28 = p10:GetCameraToSubjectDistance()
            local v29 = p10:CalculateNewLookVectorFromArg(v25, v_u_1.getRotation())
            v15 = CFrame.new(v17)
            v14 = CFrame.new(v17 - v28 * v29, v17)
            p10.lastDistanceToSubject = v28
        end
    end
    p10.lastUpdate = v11
    return v14, v15
end
return v_u_4