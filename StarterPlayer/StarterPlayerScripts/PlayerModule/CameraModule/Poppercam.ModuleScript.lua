local v_u_1 = require(script.Parent:WaitForChild("ZoomController"))
local v_u_2 = {}
v_u_2.__index = v_u_2
local v_u_3 = CFrame.new()
function v_u_2.new()
    local v4 = v_u_2
    return setmetatable({
        ["lastCFrame"] = nil
    }, v4)
end
function v_u_2.Step(p5, p6, p7)
    local v8 = p5.lastCFrame or p7
    p5.lastCFrame = p7
    local v_u_9 = p7.Position
    local _, _, _, v10, v11, v12, v13, v14, v15, v16, v17, v18 = p7:GetComponents()
    local v_u_19 = CFrame.new(0, 0, 0, v10, v11, v12, v13, v14, v15, v16, v17, v18)
    local v20 = v8.p
    local _, _, _, v21, v22, v23, v24, v25, v26, v27, v28, v29 = v8:GetComponents()
    local v30 = CFrame.new(0, 0, 0, v21, v22, v23, v24, v25, v26, v27, v28, v29)
    local v_u_31 = (v_u_9 - v20) / p6
    local v32, v33 = (v_u_19 * v30:inverse()):ToAxisAngle()
    local v_u_34 = v32 * v33 / p6
    return {
        ["extrapolate"] = function(p35)
            local v36 = v_u_31 * p35 + v_u_9
            local v37 = v_u_34 * p35
            local v38 = v37.Magnitude
            local v39
            if v38 > 0.00001 then
                v39 = CFrame.fromAxisAngle(v37, v38)
            else
                v39 = v_u_3
            end
            return v39 * v_u_19 + v36
        end,
        ["posVelocity"] = v_u_31,
        ["rotVelocity"] = v_u_34
    }
end
function v_u_2.Reset(p40)
    p40.lastCFrame = nil
end
local v_u_41 = require(script.Parent:WaitForChild("BaseOcclusion"))
local v_u_42 = setmetatable({}, v_u_41)
v_u_42.__index = v_u_42
function v_u_42.new()
    local v43 = v_u_41.new()
    local v44 = v_u_42
    local v45 = setmetatable(v43, v44)
    v45.focusExtrapolator = v_u_2.new()
    return v45
end
function v_u_42.GetOcclusionMode(_)
    return Enum.DevCameraOcclusionMode.Zoom
end
function v_u_42.Enable(p46, _)
    p46.focusExtrapolator:Reset()
end
function v_u_42.Update(p47, p48, p49, p50, _)
    local v51 = CFrame.new(p50.p, p49.p) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    local v52 = p47.focusExtrapolator:Step(p48, v51)
    local v53 = v_u_1.Update(p48, v51, v52)
    return v51 * CFrame.new(0, 0, v53), p50
end
function v_u_42.CharacterAdded(_, _, _) end
function v_u_42.CharacterRemoving(_, _, _) end
function v_u_42.OnCameraSubjectChanged(_, _) end
return v_u_42