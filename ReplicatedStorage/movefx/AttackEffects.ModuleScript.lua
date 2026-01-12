local v_u_3 = setmetatable({}, {
    ["__index"] = function(p1, p2)
        if p2 ~= "base" then
            return p1.base[p2]
        end
    end
})
local v_u_4 = game:GetService("Debris")
function v_u_3.Impact(_, p5)
    local v6 = p5.Target
    local v7 = game.ReplicatedStorage.Models.MeshParts.waveimpact:Clone()
    game.Debris:AddItem(v7, p5.Duration)
    v7.Parent = workspace.Projectiles
    v7.Color = p5.Color or v6.Color
    v_u_3:Follow({
        ["Target"] = v6,
        ["Part"] = v7
    })
    v7.Size = v6.Size
    local v8 = v_u_3
    local v9 = {
        ["Target"] = v7,
        ["Goal"] = {
            ["Transparency"] = 1,
            ["Size"] = p5.Size or v6.Size * Vector3.new(1.25, 2, 1.25)
        },
        ["Time"] = p5.Duration
    }
    v8:Tween(v9)
end
function v_u_3.SlamFX(_, p10)
    local v11 = p10.Target
    local v12 = p10.Position or v11.Position
    local v13 = p10.Shape
    local v14 = p10.Scale or 5
    local v15 = p10.Rise or 1
    local v16 = v_u_3:Part({
        ["BrickColor"] = v11.BrickColor,
        ["Shape"] = v13 or v11.Shape,
        ["Material"] = v11.Material,
        ["Transparency"] = v11.Transparency,
        ["Reflectance"] = v11.Reflectance,
        ["Size"] = Vector3.new(1, 1, 1) * v14 * math.random(4, 10) / 10
    })
    v16.CFrame = CFrame.new(v12)
    v_u_4:AddItem(v16, 1.5)
    local v17 = v_u_3
    local v18 = {
        ["Target"] = v16
    }
    local v19 = math.random(-30, 30)
    local v20 = math.random
    v18.Velocity = Vector3.new(v19, 30, v20(-30, 30)) * v15
    v18.Duration = 0.5
    v17:Velocity(v18)
    v_u_3:Tween({
        ["Target"] = v16,
        ["Direction"] = Enum.EasingDirection.In,
        ["Time"] = 1.5
    })
end
function v_u_3.TextureLace(_, p21)
    local v22 = p21.Target
    local v23 = p21.Image or "rbxassetid://8900506474"
    local v24 = p21.Size or 2
    local v25 = p21.Scale or 3
    local v26 = p21.Duration or 1
    local v27 = p21.Color or Color3.new(1, 1, 1)
    local v28 = p21.Bleach
    local v29 = p21.Transparency or 0.8
    local v30 = {}
    for _, v31 in pairs(Enum.NormalId:GetEnumItems()) do
        local v32 = Instance.new("Texture")
        v32.Texture = v23
        v32.StudsPerTileU = v24
        v32.StudsPerTileV = v22.Size.X
        v32.Face = v31
        v32.Transparency = v29
        v32.Parent = v22
        v_u_3:Tween({
            ["Target"] = v32,
            ["Goal"] = {
                ["StudsPerTileU"] = v24 * v25
            },
            ["Style"] = Enum.EasingStyle.Elastic,
            ["Time"] = v26 * 0.8
        })
        v_u_3:Tween({
            ["Target"] = v32,
            ["Goal"] = {
                ["Color3"] = v28 or v27,
                ["OffsetStudsV"] = v22.Size.X,
                ["Transparency"] = 1
            },
            ["Time"] = v26
        })
        table.insert(v30, v32)
    end
    return v30
end
function v_u_3.Rubble(_, p33)
    local v34 = p33.Target
    local v35 = p33.IgnoreList
    local v36 = p33.Ground or v_u_3:GetGround({
        ["Target"] = v34,
        ["Ignore"] = v35
    })
    local v37 = p33.Scale or 1
    local v38 = p33.CFrame or v34.CFrame
    local v39 = p33.Radius or 4
    local v40 = p33.Radial
    local v41 = p33.Offset or (v34 and -v34.Size * Vector3.new(0, 0.5, 0) or Vector3.new(0, 0, 0))
    local v42 = p33.Duration or 4
    local v43 = p33.Amount or 1
    if v36 then
        for _ = 1, v43 do
            local v44 = v_u_3:Part({
                ["Transparency"] = -v42,
                ["Color"] = v_u_3:cmult(v36.Color, 0.75 + math.random() / 4),
                ["Material"] = v36.Material,
                ["Size"] = Vector3.new(1, 1, 1) * math.random(2, 4) * v37,
                ["Anchored"] = true
            })
            game.Debris:AddItem(v44, v42)
            local v45 = v38 * CFrame.Angles(math.random() * 3, math.random() * 3, math.random() * 3)
            if v40 then
                v44.CFrame = v45 + (CFrame.new(v38.Position) * CFrame.Angles(0, 6.283185307179586 * math.random(), 0)).LookVector * v39 * math.random()
            else
                local v46 = math.random() - 0.5
                local v47 = math.random() - 0.5
                v44.CFrame = v45 + Vector3.new(v46, 0, v47) * v39 - v41
            end
            v_u_3:Tween({
                ["Target"] = v44,
                ["Time"] = v42
            })
        end
    end
end
return v_u_3