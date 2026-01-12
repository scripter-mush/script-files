local _ = game:GetService("RunService").Heartbeat
Color3.new(0.7, 0, 0)
local v_u_1 = tick()
local v_u_2 = Enum.Material.Neon
local v_u_3 = { 75057309307458, 86266572812434, 136934745690079 }
local v_u_4 = {
    119518876235627,
    73164849698703,
    88835145196570,
    105830860502940
}
return {
    ["Fire"] = function(p5, p6, p7, p8, p9, p10)
        local v11 = p9 or Color3.fromRGB(130, 255, 121)
        local v12 = p10 or 0.35
        if (workspace.CurrentCamera.CFrame.Position - p6.Position).Magnitude < 300 then
            local v13 = p5.fx
            local _ = p6.LookVector
            local v14 = v12 or 0.5
            local v15 = 0.6 * v14
            local v16 = v13:Projectile({
                ["Shape"] = Enum.PartType.Ball,
                ["Anchored"] = true,
                ["Size"] = Vector3.new(1, 1, 1),
                ["Material"] = v_u_2,
                ["Color"] = v11
            }, 1.5)
            v16.CFrame = p6
            v13:EmitSet({
                ["Target"] = Instance.new("Attachment", v16),
                ["Folder"] = "_Shadovis",
                ["ParticleId"] = "BeamFace"
            })
            v13:Sound({
                ["Id"] = v_u_3[math.random(#v_u_3)]
            })
            v13:Tween({
                ["Target"] = v16,
                ["Goal"] = {
                    ["Size"] = Vector3.new(1, 1, 1) * p7
                },
                ["Style"] = Enum.EasingStyle.Elastic,
                ["Direction"] = Enum.EasingDirection.Out,
                ["Time"] = v14 * 0.25
            })
            local v17 = tick()
            if v17 - v_u_1 > 0.5 then
                v_u_1 = v17
                for v18 = 1, 3 do
                    local v19 = v13:Part({
                        ["Color"] = Color3.new(1, 1, 1),
                        ["Size"] = Vector3.new(2, 2, 2),
                        ["Material"] = v_u_2,
                        ["Anchored"] = true
                    })
                    game.Debris:AddItem(v19, v15)
                    local v20 = v13:Mesh({
                        ["MeshId"] = 6026279375,
                        ["Target"] = v19
                    })
                    v19.CFrame = v16.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
                    local v21 = {
                        ["Target"] = v20
                    }
                    local v22 = {}
                    local v23 = v20.Scale
                    local v24 = 4 * v18
                    local v25 = 4 * v18
                    v22.Scale = v23 * Vector3.new(v24, 3, v25)
                    v21.Goal = v22
                    v21.Style = Enum.EasingStyle.Exponential
                    v21.Time = v15
                    v13:Tween(v21)
                    v13:Tween({
                        ["Target"] = v19,
                        ["Time"] = v15,
                        ["Direction"] = Enum.EasingDirection.In
                    })
                end
                v13:Kindle({
                    ["Target"] = v16,
                    ["Duration"] = v15
                })
            end
            local v26 = v14 * 0.75
            local v27 = v13:Projectile({
                ["Size"] = Vector3.new(0, p7, p7),
                ["Anchored"] = true,
                ["Shape"] = Enum.PartType.Cylinder,
                ["Material"] = v_u_2,
                ["Color"] = v11
            })
            v27.CFrame = v16.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
            v13:Sound({
                ["Id"] = v_u_4[math.random(#v_u_4)]
            })
            v13:EmitSet({
                ["Target"] = v27,
                ["Folder"] = "_Shadovis",
                ["ParticleId"] = "Beam"
            })
            v13:Tween({
                ["Target"] = v27,
                ["Goal"] = {
                    ["CFrame"] = v27.CFrame + v27.CFrame.RightVector * p8 / 2,
                    ["Size"] = Vector3.new(p8, p7, p7)
                },
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Time"] = v26
            })
            v13:Tween({
                ["Target"] = v16,
                ["Direction"] = Enum.EasingDirection.In,
                ["Time"] = v26
            })
            v13:Tween({
                ["Target"] = v27,
                ["Direction"] = Enum.EasingDirection.In,
                ["Time"] = v26
            })
            local v28 = v13:Projectile({
                ["Color"] = Color3.new(1, 1, 1),
                ["Size"] = Vector3.new(2, 2, 2),
                ["Material"] = Enum.Material.Neon,
                ["Anchored"] = true
            })
            local v29 = v13:Mesh({
                ["MeshId"] = 6026279375,
                ["Target"] = v28
            })
            v28.CFrame = v16.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
            v13:Tween({
                ["Target"] = v28,
                ["Goal"] = {
                    ["CFrame"] = v28.CFrame + v27.CFrame.RightVector * p8 / 2
                },
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Time"] = v26
            })
            v13:Tween({
                ["Target"] = v29,
                ["Goal"] = {
                    ["Scale"] = Vector3.new(1, 1, 1) * p7 * 1.2 + Vector3.new(0, 1, 0) * p8 * 10.5
                },
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Time"] = v26
            })
            v13:Tween({
                ["Target"] = v28,
                ["Direction"] = Enum.EasingDirection.In,
                ["Time"] = v26
            })
            v13:Kindle({
                ["Target"] = v28,
                ["Duration"] = v15
            })
        end
    end
}