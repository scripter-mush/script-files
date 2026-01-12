local v1 = game:GetService("Players")
local v_u_2 = game.Workspace.CurrentCamera
local v_u_3 = math.min
local v_u_4 = math.tan
local v_u_5 = math.rad
local v_u_6 = Ray.new
local v_u_7 = nil
local v_u_8 = nil
local function v12()
    local v9 = v_u_5(v_u_2.FieldOfView)
    local v10 = v_u_2.ViewportSize
    local v11 = v10.X / v10.Y
    v_u_8 = v_u_4(v9 / 2) * 2
    v_u_7 = v11 * v_u_8
end
v_u_2:GetPropertyChangedSignal("FieldOfView"):Connect(v12)
v_u_2:GetPropertyChangedSignal("ViewportSize"):Connect(v12)
local v13 = v_u_5(v_u_2.FieldOfView)
local v14 = v_u_2.ViewportSize
local v15 = v14.X / v14.Y
v_u_8 = v_u_4(v13 / 2) * 2
v_u_7 = v15 * v_u_8
local v_u_16 = v_u_2.NearPlaneZ
v_u_2:GetPropertyChangedSignal("NearPlaneZ"):Connect(function()
    v_u_16 = v_u_2.NearPlaneZ
end)
local v_u_17 = {}
local v_u_18 = {}
local v_u_19 = game:GetService("CollectionService")
local function v22()
    v_u_17 = v_u_19:GetTagged("IgnoreCamera")
    for _, v20 in pairs(v_u_18) do
        local v21 = v_u_17
        table.insert(v21, v20)
    end
end
v_u_19:GetInstanceAddedSignal("IgnoreCamera"):Connect(v22)
v_u_19:GetInstanceRemovedSignal("IgnoreCamera"):Connect(v22)
local function v33(p_u_23)
    local function v27(p24)
        v_u_18[p_u_23] = p24
        v_u_17 = v_u_19:GetTagged("IgnoreCamera")
        for _, v25 in pairs(v_u_18) do
            local v26 = v_u_17
            table.insert(v26, v25)
        end
    end
    local function v30()
        v_u_18[p_u_23] = nil
        v_u_17 = v_u_19:GetTagged("IgnoreCamera")
        for _, v28 in pairs(v_u_18) do
            local v29 = v_u_17
            table.insert(v29, v28)
        end
    end
    p_u_23.CharacterAdded:Connect(v27)
    p_u_23.CharacterRemoving:Connect(v30)
    if p_u_23.Character then
        v_u_18[p_u_23] = p_u_23.Character
        v_u_17 = v_u_19:GetTagged("IgnoreCamera")
        for _, v31 in pairs(v_u_18) do
            local v32 = v_u_17
            table.insert(v32, v31)
        end
    end
end
local function v37(p34)
    v_u_18[p34] = nil
    v_u_17 = v_u_19:GetTagged("IgnoreCamera")
    for _, v35 in pairs(v_u_18) do
        local v36 = v_u_17
        table.insert(v36, v35)
    end
end
v1.PlayerAdded:Connect(v33)
v1.PlayerRemoving:Connect(v37)
local v_u_38 = v_u_8
local v_u_39 = v_u_7
local v_u_40 = v_u_16
for _, v41 in ipairs(v1:GetPlayers()) do
    v33(v41)
end
v_u_17 = v_u_19:GetTagged("IgnoreCamera")
local v_u_42 = v_u_17
for _, v43 in pairs(v_u_18) do
    table.insert(v_u_42, v43)
end
local v_u_44 = nil
local v_u_45 = nil
v_u_2:GetPropertyChangedSignal("CameraSubject"):Connect(function()
    local v46 = v_u_2.CameraSubject
    if v46:IsA("Humanoid") then
        v_u_45 = v46.RootPart
        return
    elseif v46:IsA("BasePart") then
        v_u_45 = v46
    else
        v_u_45 = nil
    end
end)
local v_u_47 = {
    Vector2.new(0.4, 0),
    Vector2.new(-0.4, 0),
    Vector2.new(0, -0.4),
    Vector2.new(0, 0.4),
    Vector2.new(0, 0.2)
}
local function v_u_57(p48, p49)
    local v50 = #v_u_42
    while true do
        local v51, v52 = workspace:FindPartOnRayWithIgnoreList(v_u_6(p48, p49), v_u_42, false, true)
        if v51 then
            if v51.CanCollide then
                local v53 = v_u_42
                for v54 = #v53, v50 + 1, -1 do
                    v53[v54] = nil
                end
                return v52, true
            end
            v_u_42[#v_u_42 + 1] = v51
        end
        if not v51 then
            local v55 = v_u_42
            for v56 = #v55, v50 + 1, -1 do
                v55[v56] = nil
            end
            return p48 + p49, false
        end
    end
end
local function v_u_79(p58, p59, p60, p61)
    debug.profilebegin("queryPoint")
    local v62 = #v_u_42
    local v63 = p60 + v_u_40
    local v64 = p58 + p59 * v63
    local v65 = p58
    local v66 = 0
    local v67 = (1 / 0)
    local v68 = (1 / 0)
    while true do
        local v69, v70 = workspace:FindPartOnRayWithIgnoreList(v_u_6(p58, v64 - p58), v_u_42, false, true)
        v66 = v66 + 1
        local v71
        if v69 then
            local v72 = v66 >= 64
            local v73 = 1 - (1 - v69.Transparency) * (1 - v69.LocalTransparencyModifier) < 0.25 and v69.CanCollide
            if v73 then
                if v_u_44 == (v69:GetRootPart() or v69) then
                    v73 = false
                else
                    v73 = not v69:IsA("TrussPart")
                end
            end
            if v73 or v72 then
                local v74 = { v69 }
                local v75 = workspace:FindPartOnRayWithWhitelist(v_u_6(v64, v70 - v64), v74, true)
                v71 = (v70 - v65).Magnitude
                if v75 and not v72 then
                    local v76
                    if p61 then
                        v76 = workspace:FindPartOnRayWithWhitelist(v_u_6(p61, v64 - p61), v74, true) or workspace:FindPartOnRayWithWhitelist(v_u_6(v64, p61 - v64), v74, true)
                    else
                        v76 = false
                    end
                    if v76 then
                        v67 = v71
                        v71 = v68
                    elseif v63 >= v68 then
                        v71 = v68
                    end
                else
                    v67 = v71
                    v71 = v68
                end
            else
                v71 = v68
            end
            v_u_42[#v_u_42 + 1] = v69
            p58 = v70 - p59 * 0.001
        else
            v71 = v68
        end
        if v67 < (1 / 0) or not v69 then
            local v77 = v_u_42
            for v78 = #v77, v62 + 1, -1 do
                v77[v78] = nil
            end
            debug.profileend()
            return v71 - v_u_40, v67 - v_u_40
        end
        v68 = v71
    end
end
local function v_u_94(p80, p81)
    debug.profilebegin("queryViewport")
    local v82 = p80.p
    local v83 = p80.rightVector
    local v84 = p80.upVector
    local v85 = -p80.lookVector
    local v86 = v_u_2.ViewportSize
    local v87 = (1 / 0)
    local v88 = (1 / 0)
    for v89 = 0, 1 do
        local v90 = v83 * ((v89 - 0.5) * v_u_39)
        for v91 = 0, 1 do
            local v92, v93 = v_u_79(v82 + v_u_40 * (v90 + v84 * ((v91 - 0.5) * v_u_38)), v85, p81, v_u_2:ViewportPointToRay(v86.x * v89, v86.y * v91).Origin)
            if v93 >= v88 then
                v93 = v88
            end
            if v92 < v87 then
                v88 = v93
                v87 = v92
            else
                v88 = v93
            end
        end
    end
    debug.profileend()
    return v87, v88
end
local function v_u_108(p95, p96, p97)
    debug.profilebegin("testPromotion")
    local v98 = p95.p
    local v99 = p95.rightVector
    local v100 = p95.upVector
    local v101 = -p95.lookVector
    debug.profilebegin("extrapolate")
    local v102 = (v_u_57(v98, p97.posVelocity * 1.25) - v98).Magnitude
    local v103 = p97.posVelocity.magnitude
    for v104 = 0, v_u_3(1.25, p97.rotVelocity.magnitude + v102 / v103), 0.0625 do
        local v105 = p97.extrapolate(v104)
        if p96 <= v_u_79(v105.p, -v105.lookVector, p96) then
            return false
        end
    end
    debug.profileend()
    debug.profilebegin("testOffsets")
    for _, v106 in ipairs(v_u_47) do
        local v107 = v_u_57(v98, v99 * v106.x + v100 * v106.y)
        if v_u_79(v107, (v98 + v101 * p96 - v107).Unit, p96) == (1 / 0) then
            return false
        end
    end
    debug.profileend()
    debug.profileend()
    return true
end
return function(p109, p110, p111)
    debug.profilebegin("popper")
    v_u_44 = v_u_45 and v_u_45:GetRootPart() or v_u_45
    local v112, v113 = v_u_94(p109, p110)
    if v113 >= p110 then
        v113 = p110
    end
    if v112 < v113 then
        if not v_u_108(p109, p110, p111) then
            v112 = v113
        end
    else
        v112 = v113
    end
    v_u_44 = nil
    debug.profileend()
    return v112
end