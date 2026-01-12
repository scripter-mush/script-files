local _ = game:GetService("RunService").Heartbeat
Color3.new(0.7, 0, 0)
local v_u_1 = tick()
return {
    ["Fire"] = function(p2, p3, p4, p5, p6, p7)
        if (workspace.CurrentCamera.CFrame.Position - p3.Position).Magnitude < 300 then
            local v8 = p2.fx
            local _ = p3.LookVector
            local v9 = p7 or 0.5
            local v10 = 0.6 * v9
            local v11 = v8:Projectile({
                ["Shape"] = Enum.PartType.Ball,
                ["Anchored"] = true,
                ["Size"] = Vector3.new(1, 1, 1),
                ["Material"] = Enum.Material.Metal,
                ["Color"] = p6
            }, 1.5)
            v11.CFrame = p3
            local v12 = {
                ["Target"] = v11,
                ["Goal"] = {
                    ["Size"] = Vector3.new(1, 1, 1) * p4
                },
                ["Style"] = Enum.EasingStyle.Elastic,
                ["Direction"] = Enum.EasingDirection.Out,
                ["Time"] = v9 * 0.25
            }
            v8:Tween(v12)
            local v13 = tick()
            if v13 - v_u_1 > 0.5 then
                v_u_1 = v13
                for v14 = 1, 3 do
                    local v15 = v8:Part({
                        ["Color"] = Color3.new(1, 1, 1),
                        ["Size"] = Vector3.new(2, 2, 2),
                        ["Material"] = Enum.Material.Neon,
                        ["Anchored"] = true
                    })
                    game.Debris:AddItem(v15, v10)
                    local v16 = v8:Mesh({
                        ["MeshId"] = 6026279375,
                        ["Target"] = v15
                    })
                    v15.CFrame = v11.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
                    local v17 = {
                        ["Target"] = v16
                    }
                    local v18 = {}
                    local v19 = v16.Scale
                    local v20 = 4 * v14
                    local v21 = 4 * v14
                    v18.Scale = v19 * Vector3.new(v20, 3, v21)
                    v17.Goal = v18
                    v17.Style = Enum.EasingStyle.Exponential
                    v17.Time = v10
                    v8:Tween(v17)
                    v8:Tween({
                        ["Target"] = v15,
                        ["Time"] = v10,
                        ["Direction"] = Enum.EasingDirection.In
                    })
                end
                v8:Kindle({
                    ["Target"] = v11,
                    ["Duration"] = v10
                })
            end
            local v22 = v9 * 0.75
            local v23 = v8:Projectile({
                ["Size"] = Vector3.new(0, p4, p4),
                ["Anchored"] = true,
                ["Shape"] = Enum.PartType.Cylinder,
                ["Material"] = Enum.Material.Metal,
                ["Color"] = p6
            })
            v23.CFrame = v11.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
            local v24 = {
                ["Target"] = v23,
                ["Goal"] = {
                    ["CFrame"] = v23.CFrame + v23.CFrame.RightVector * p5 / 2,
                    ["Size"] = Vector3.new(p5, p4, p4)
                },
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Time"] = v22
            }
            v8:Tween(v24)
            v8:Tween({
                ["Target"] = v11,
                ["Direction"] = Enum.EasingDirection.In,
                ["Time"] = v22
            })
            v8:Tween({
                ["Target"] = v23,
                ["Direction"] = Enum.EasingDirection.In,
                ["Time"] = v22
            })
            local v25 = v8:Projectile({
                ["Color"] = Color3.new(1, 1, 1),
                ["Size"] = Vector3.new(2, 2, 2),
                ["Material"] = Enum.Material.Neon,
                ["Anchored"] = true
            })
            local v26 = v8:Mesh({
                ["MeshId"] = 6026279375,
                ["Target"] = v25
            })
            v25.CFrame = v11.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
            local v27 = {
                ["Target"] = v25,
                ["Goal"] = {
                    ["CFrame"] = v25.CFrame + v23.CFrame.RightVector * p5 / 2
                },
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Time"] = v22
            }
            v8:Tween(v27)
            local v28 = {
                ["Target"] = v26,
                ["Goal"] = {
                    ["Scale"] = Vector3.new(1, 1, 1) * p4 * 1.2 + Vector3.new(0, 1, 0) * p5 * 10.5
                },
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Time"] = v22
            }
            v8:Tween(v28)
            v8:Tween({
                ["Target"] = v25,
                ["Direction"] = Enum.EasingDirection.In,
                ["Time"] = v22
            })
            v8:Kindle({
                ["Target"] = v25,
                ["Duration"] = v10
            })
        end
    end
}