local v_u_1 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_2 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("VRService")
local v_u_5 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_6 = setmetatable({}, v_u_5)
v_u_6.__index = v_u_6
function v_u_6.new()
    local v7 = v_u_5.new()
    local v8 = v_u_6
    local v9 = setmetatable(v7, v8)
    v9.lastUpdate = tick()
    v9.changedSignalConnections = {}
    v9.refAzimuthRad = nil
    v9.curAzimuthRad = nil
    v9.minAzimuthAbsoluteRad = nil
    v9.maxAzimuthAbsoluteRad = nil
    v9.useAzimuthLimits = nil
    v9.curElevationRad = nil
    v9.minElevationRad = nil
    v9.maxElevationRad = nil
    v9.curDistance = nil
    v9.minDistance = nil
    v9.maxDistance = nil
    v9.gamepadDollySpeedMultiplier = 1
    v9.lastUserPanCamera = tick()
    v9.externalProperties = {}
    v9.externalProperties.InitialDistance = 25
    v9.externalProperties.MinDistance = 10
    v9.externalProperties.MaxDistance = 100
    v9.externalProperties.InitialElevation = 35
    v9.externalProperties.MinElevation = 35
    v9.externalProperties.MaxElevation = 35
    v9.externalProperties.ReferenceAzimuth = -45
    v9.externalProperties.CWAzimuthTravel = 90
    v9.externalProperties.CCWAzimuthTravel = 90
    v9.externalProperties.UseAzimuthLimits = false
    v9:LoadNumberValueParameters()
    return v9
end
function v_u_6.LoadOrCreateNumberValueParameter(p_u_10, p_u_11, p12, p_u_13)
    local v14 = script:FindFirstChild(p_u_11)
    if v14 and v14:isA(p12) then
        p_u_10.externalProperties[p_u_11] = v14.Value
    else
        if p_u_10.externalProperties[p_u_11] == nil then
            return
        end
        v14 = Instance.new(p12)
        v14.Name = p_u_11
        v14.Parent = script
        v14.Value = p_u_10.externalProperties[p_u_11]
    end
    if p_u_13 then
        if p_u_10.changedSignalConnections[p_u_11] then
            p_u_10.changedSignalConnections[p_u_11]:Disconnect()
        end
        p_u_10.changedSignalConnections[p_u_11] = v14.Changed:Connect(function(p15)
            p_u_10.externalProperties[p_u_11] = p15
            p_u_13(p_u_10)
        end)
    end
end
function v_u_6.SetAndBoundsCheckAzimuthValues(p16)
    local v17 = p16.externalProperties.ReferenceAzimuth
    local v18 = math.rad(v17)
    local v19 = p16.externalProperties.CWAzimuthTravel
    local v20 = math.rad(v19)
    p16.minAzimuthAbsoluteRad = v18 - math.abs(v20)
    local v21 = p16.externalProperties.ReferenceAzimuth
    local v22 = math.rad(v21)
    local v23 = p16.externalProperties.CCWAzimuthTravel
    local v24 = math.rad(v23)
    p16.maxAzimuthAbsoluteRad = v22 + math.abs(v24)
    p16.useAzimuthLimits = p16.externalProperties.UseAzimuthLimits
    if p16.useAzimuthLimits then
        local v25 = p16.curAzimuthRad
        local v26 = p16.minAzimuthAbsoluteRad
        p16.curAzimuthRad = math.max(v25, v26)
        local v27 = p16.curAzimuthRad
        local v28 = p16.maxAzimuthAbsoluteRad
        p16.curAzimuthRad = math.min(v27, v28)
    end
end
function v_u_6.SetAndBoundsCheckElevationValues(p29)
    local v30 = p29.externalProperties.MinElevation
    local v31 = math.max(v30, -80)
    local v32 = p29.externalProperties.MaxElevation
    local v33 = math.min(v32, 80)
    local v34 = math.min(v31, v33)
    p29.minElevationRad = math.rad(v34)
    local v35 = math.max(v31, v33)
    p29.maxElevationRad = math.rad(v35)
    local v36 = p29.curElevationRad
    local v37 = p29.minElevationRad
    p29.curElevationRad = math.max(v36, v37)
    local v38 = p29.curElevationRad
    local v39 = p29.maxElevationRad
    p29.curElevationRad = math.min(v38, v39)
end
function v_u_6.SetAndBoundsCheckDistanceValues(p40)
    p40.minDistance = p40.externalProperties.MinDistance
    p40.maxDistance = p40.externalProperties.MaxDistance
    local v41 = p40.curDistance
    local v42 = p40.minDistance
    p40.curDistance = math.max(v41, v42)
    local v43 = p40.curDistance
    local v44 = p40.maxDistance
    p40.curDistance = math.min(v43, v44)
end
function v_u_6.LoadNumberValueParameters(p45)
    p45:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil)
    p45:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil)
    p45:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", p45.SetAndBoundsCheckAzimuthValue)
    p45:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", p45.SetAndBoundsCheckAzimuthValues)
    p45:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", p45.SetAndBoundsCheckAzimuthValues)
    p45:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", p45.SetAndBoundsCheckElevationValues)
    p45:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", p45.SetAndBoundsCheckElevationValues)
    p45:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", p45.SetAndBoundsCheckDistanceValues)
    p45:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", p45.SetAndBoundsCheckDistanceValues)
    p45:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", p45.SetAndBoundsCheckAzimuthValues)
    local v46 = p45.externalProperties.ReferenceAzimuth
    p45.curAzimuthRad = math.rad(v46)
    local v47 = p45.externalProperties.InitialElevation
    p45.curElevationRad = math.rad(v47)
    p45.curDistance = p45.externalProperties.InitialDistance
    p45:SetAndBoundsCheckAzimuthValues()
    p45:SetAndBoundsCheckElevationValues()
    p45:SetAndBoundsCheckDistanceValues()
end
function v_u_6.GetModuleName(_)
    return "OrbitalCamera"
end
function v_u_6.SetInitialOrientation(p48, p49)
    if p49 and p49.RootPart then
        local v50 = p49.RootPart
        assert(v50, "")
        local v51 = (p49.RootPart.CFrame.LookVector - Vector3.new(0, 0.23, 0)).Unit
        local v52 = v_u_1.GetAngleBetweenXZVectors(v51, p48:GetCameraLookVector())
        local v53 = p48:GetCameraLookVector().Y
        local v54 = math.asin(v53)
        local v55 = v51.Y
        local v56 = v54 - math.asin(v55)
        v_u_1.IsFinite(v52)
        v_u_1.IsFinite(v56)
    else
        warn("OrbitalCamera could not set initial orientation due to missing humanoid")
    end
end
function v_u_6.GetCameraToSubjectDistance(p57)
    return p57.curDistance
end
function v_u_6.SetCameraToSubjectDistance(p58, p59)
    if v_u_3.LocalPlayer then
        local v60 = p58.minDistance
        local v61 = p58.maxDistance
        p58.currentSubjectDistance = math.clamp(p59, v60, v61)
        local v62 = p58.currentSubjectDistance
        local v63 = p58.FIRST_PERSON_DISTANCE_THRESHOLD
        p58.currentSubjectDistance = math.max(v62, v63)
    end
    p58.inFirstPerson = false
    p58:UpdateMouseBehavior()
    return p58.currentSubjectDistance
end
function v_u_6.CalculateNewLookVector(p64, p65, p66)
    local v67 = p65 or p64:GetCameraLookVector()
    local v68 = v67.Y
    local v69 = math.asin(v68)
    local v70 = p66.Y
    local v71 = v69 - 1.3962634015954636
    local v72 = v69 - -1.3962634015954636
    local v73 = math.clamp(v70, v71, v72)
    local v74 = Vector2.new(p66.X, v73)
    local v75 = CFrame.new(Vector3.new(0, 0, 0), v67)
    return (CFrame.Angles(0, -v74.X, 0) * v75 * CFrame.Angles(-v74.Y, 0, 0)).LookVector
end
function v_u_6.Update(p76, _)
    local v77 = tick()
    local v78 = v77 - p76.lastUpdate
    local v79 = v_u_2.getRotation() ~= Vector2.new()
    local v80 = workspace.CurrentCamera
    local v81 = v80.CFrame
    local v82 = v80.Focus
    local v83 = v_u_3.LocalPlayer
    local v84
    if v80 then
        v84 = v80.CameraSubject
    else
        v84 = v80
    end
    local v85
    if v84 then
        v85 = v84:IsA("VehicleSeat")
    else
        v85 = v84
    end
    local v86
    if v84 then
        v86 = v84:IsA("SkateboardPlatform")
    else
        v86 = v84
    end
    if p76.lastUpdate == nil or v78 > 1 then
        p76.lastCameraTransform = nil
    end
    if v79 then
        p76.lastUserPanCamera = tick()
    end
    local v87 = p76:GetSubjectPosition()
    if v87 and (v83 and v80) then
        if p76.gamepadDollySpeedMultiplier ~= 1 then
            p76:SetCameraToSubjectDistance(p76.currentSubjectDistance * p76.gamepadDollySpeedMultiplier)
        end
        local v88 = v_u_4.VREnabled
        v82 = v88 and p76:GetVRFocus(v87, v78) or CFrame.new(v87)
        local v89 = v_u_2.getRotation()
        local v90 = v82.p
        if v88 and not p76:IsInFirstPerson() then
            local v91 = p76:GetCameraHeight()
            local v92 = v87 - v80.CFrame.p
            local v93 = v92.Magnitude
            if p76.currentSubjectDistance < v93 or v89.X ~= 0 then
                local v94 = p76.currentSubjectDistance
                local v95 = math.min(v93, v94)
                local v96 = p76:CalculateNewLookVector(v92.Unit * Vector3.new(1, 0, 1), Vector2.new(v89.X, 0)) * v95
                local v97 = v90 - v96
                local v98 = v80.CFrame.LookVector
                if v89.X == 0 then
                    v96 = v98
                end
                local v99 = v97.X + v96.X
                local v100 = v97.Y
                local v101 = v97.Z + v96.Z
                local v102 = Vector3.new(v99, v100, v101)
                v81 = CFrame.new(v97, v102) + Vector3.new(0, v91, 0)
            end
        else
            p76.curAzimuthRad = p76.curAzimuthRad - v89.X
            if p76.useAzimuthLimits then
                local v103 = p76.curAzimuthRad
                local v104 = p76.minAzimuthAbsoluteRad
                local v105 = p76.maxAzimuthAbsoluteRad
                p76.curAzimuthRad = math.clamp(v103, v104, v105)
            else
                local v106
                if p76.curAzimuthRad == 0 then
                    v106 = 0
                else
                    local v107 = p76.curAzimuthRad
                    local v108 = math.sign(v107)
                    local v109 = p76.curAzimuthRad
                    v106 = v108 * (math.abs(v109) % 6.283185307179586) or 0
                end
                p76.curAzimuthRad = v106
            end
            local v110 = p76.curElevationRad + v89.Y
            local v111 = p76.minElevationRad
            local v112 = p76.maxElevationRad
            p76.curElevationRad = math.clamp(v110, v111, v112)
            local v113 = v87 + p76.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-p76.curElevationRad, p76.curAzimuthRad, 0) * Vector3.new(0, 0, 1))
            v81 = CFrame.new(v113, v87)
        end
        p76.lastCameraTransform = v81
        p76.lastCameraFocus = v82
        if (v85 or v86) and v84:IsA("BasePart") then
            p76.lastSubjectCFrame = v84.CFrame
        else
            p76.lastSubjectCFrame = nil
        end
    end
    p76.lastUpdate = v77
    return v81, v82
end
return v_u_6