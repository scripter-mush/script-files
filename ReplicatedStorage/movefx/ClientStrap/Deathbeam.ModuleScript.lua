local _ = game:GetService("RunService").Heartbeat
Color3.new(0.7, 0, 0)
return {
    ["Fire"] = function(p1, p2, p3, p4, p5)
        if (workspace.CurrentCamera.CFrame.Position - p2.Position).Magnitude < 300 then
            local v6 = p1.fx
            local _ = p2.LookVector
            local v7 = v6:Projectile({
                ["Shape"] = Enum.PartType.Ball,
                ["Anchored"] = true,
                ["Size"] = Vector3.new(1, 1, 1),
                ["Material"] = Enum.Material.Metal,
                ["Color"] = p5
            }, 1.5)
            v7.CFrame = p2
            local v8 = {
                ["Target"] = v7,
                ["Goal"] = {
                    ["Size"] = Vector3.new(1, 1, 1) * p3
                },
                ["Style"] = Enum.EasingStyle.Elastic,
                ["Time"] = 0.5
            }
            v6:Tween(v8).Completed:Wait()
            for v9 = 1, 3 do
                local v10 = v6:Part({
                    ["Color"] = Color3.new(1, 1, 1),
                    ["Size"] = Vector3.new(2, 2, 2),
                    ["Material"] = Enum.Material.Neon,
                    ["Anchored"] = true
                })
                game.Debris:AddItem(v10, 0.6)
                local v11 = v6:Mesh({
                    ["MeshId"] = 6026279375,
                    ["Target"] = v10
                })
                v10.CFrame = v7.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
                local v12 = {
                    ["Target"] = v11
                }
                local v13 = {}
                local v14 = v11.Scale
                local v15 = 4 * v9
                local v16 = 4 * v9
                v13.Scale = v14 * Vector3.new(v15, 3, v16)
                v12.Goal = v13
                v12.Style = Enum.EasingStyle.Exponential
                v12.Time = 0.6
                v6:Tween(v12)
                v6:Tween({
                    ["Target"] = v10,
                    ["Time"] = 0.6,
                    ["Direction"] = Enum.EasingDirection.In
                })
                v6:Kindle({
                    ["Target"] = v10,
                    ["Duration"] = 0.6
                })
            end
            local v17 = v6:Projectile({
                ["Size"] = Vector3.new(0, p3, p3),
                ["Anchored"] = true,
                ["Shape"] = Enum.PartType.Cylinder,
                ["Material"] = Enum.Material.Metal,
                ["Color"] = p5
            })
            v17.CFrame = v7.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
            local v18 = {
                ["Target"] = v17,
                ["Goal"] = {
                    ["CFrame"] = v17.CFrame + v17.CFrame.RightVector * p4 / 2,
                    ["Size"] = Vector3.new(p4, p3, p3)
                },
                ["Style"] = Enum.EasingStyle.Cubic
            }
            v6:Tween(v18)
            v6:Tween({
                ["Target"] = v7,
                ["Direction"] = Enum.EasingDirection.In
            })
            v6:Tween({
                ["Target"] = v17,
                ["Direction"] = Enum.EasingDirection.In
            })
            local v19 = v6:Projectile({
                ["Color"] = Color3.new(1, 1, 1),
                ["Size"] = Vector3.new(2, 2, 2),
                ["Material"] = Enum.Material.Neon,
                ["Anchored"] = true
            })
            local v20 = v6:Mesh({
                ["MeshId"] = 6026279375,
                ["Target"] = v19
            })
            v19.CFrame = v7.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
            local v21 = {
                ["Target"] = v19,
                ["Goal"] = {
                    ["CFrame"] = v19.CFrame + v17.CFrame.RightVector * p4 / 2
                },
                ["Style"] = Enum.EasingStyle.Cubic
            }
            v6:Tween(v21)
            local v22 = {
                ["Target"] = v20,
                ["Goal"] = {
                    ["Scale"] = Vector3.new(1, 1, 1) * p3 * 1.2 + Vector3.new(0, 1, 0) * p4 * 10.5
                },
                ["Style"] = Enum.EasingStyle.Cubic
            }
            v6:Tween(v22)
            v6:Tween({
                ["Target"] = v19,
                ["Direction"] = Enum.EasingDirection.In
            })
            v6:Kindle({
                ["Target"] = v19,
                ["Duration"] = 0.6
            })
        end
    end
}