local v_u_1 = {
    ["spacing"] = 8,
    ["image"] = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
    ["imageSize"] = Vector2.new(2, 2)
}
local v_u_2 = Instance.new("Model")
v_u_2.Name = "PathDisplayPoints"
local v3 = Instance.new("Part")
v3.Anchored = true
v3.CanCollide = false
v3.Transparency = 1
v3.Name = "PathDisplayAdornee"
v3.CFrame = CFrame.new(0, 0, 0)
v3.Parent = v_u_2
local v_u_4 = 30
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {}
for v8 = 1, v_u_4 do
    local v9 = Instance.new("ImageHandleAdornment")
    v9.Archivable = false
    v9.Adornee = v3
    v9.Image = v_u_1.image
    v9.Size = v_u_1.imageSize
    v_u_5[v8] = v9
end
local function v_u_19(p10, _)
    if v_u_4 == 0 then
        return nil
    end
    local v11 = Ray.new(p10 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0))
    local v12, v13, v14 = workspace:FindPartOnRayWithIgnoreList(v11, { game.Players.LocalPlayer.Character, workspace.CurrentCamera })
    if not v12 then
        return nil
    end
    local v15 = CFrame.new(v13, v13 + v14)
    local v16 = v_u_5[1]
    if v16 then
        local v17 = v_u_5
        local v18 = v_u_4
        v_u_5[1] = v_u_5[v_u_4]
        v17[v18] = nil
        v_u_4 = v_u_4 - 1
    else
        v16 = nil
    end
    v16.CFrame = v15
    v16.Parent = v_u_2
    return v16
end
function v_u_1.setCurrentPoints(p20)
    if typeof(p20) == "table" then
        v_u_6 = p20
    else
        v_u_6 = {}
    end
end
function v_u_1.clearRenderedPath()
    for _, v21 in ipairs(v_u_7) do
        v21.Parent = nil
        v_u_4 = v_u_4 + 1
        v_u_5[v_u_4] = v21
    end
    v_u_7 = {}
    v_u_2.Parent = nil
end
function v_u_1.renderPath()
    v_u_1.clearRenderedPath()
    if v_u_6 and #v_u_6 ~= 0 then
        local v22 = #v_u_6
        v_u_7[1] = v_u_19(v_u_6[v22], true)
        if v_u_7[1] then
            local v23 = 0
            while true do
                local v24 = v_u_6[v22]
                local v25 = v_u_6[v22 - 1]
                if v22 < 2 then
                    break
                end
                local v26 = v25 - v24
                local v27 = v26.magnitude
                if v27 < v23 then
                    v23 = v23 - v27
                    v22 = v22 - 1
                else
                    local v28 = v_u_19(v24 + v26.unit * v23, false)
                    if v28 then
                        v_u_7[#v_u_7 + 1] = v28
                    end
                    v23 = v23 + v_u_1.spacing
                end
            end
            v_u_2.Parent = workspace.CurrentCamera
        end
    else
        return
    end
end
return v_u_1