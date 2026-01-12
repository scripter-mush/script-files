local _ = game:GetService("RunService").Heartbeat
Color3.new(0.7, 0, 0)
return {
    ["Fire"] = function(p1, p_u_2, p_u_3, p_u_4, p_u_5, p6, p7, p8)
        if (workspace.CurrentCamera.CFrame.Position - p_u_2.Position).Magnitude < 300 then
            local v9 = p1.fx
            local v10 = p_u_3.CFrame
            local _ = (v10.Rotation + p_u_2.Position + v10.LookVector * p_u_4 + v10.RightVector * p_u_5).LookVector
            local v_u_11 = v9:Projectile({
                ["Shape"] = Enum.PartType.Ball,
                ["Anchored"] = true,
                ["Size"] = Vector3.new(1, 1, 1),
                ["Material"] = Enum.Material.Metal,
                ["Color"] = p8
            }, 1.5)
            local v12 = p_u_3.CFrame
            v_u_11.CFrame = v12.Rotation + p_u_2.Position + v12.LookVector * p_u_4 + v12.RightVector * p_u_5
            local v_u_13 = true
            local function v16()
                while v_u_13 and v_u_11:IsDescendantOf(workspace) do
                    local v14 = v_u_11
                    local v15 = p_u_3.CFrame
                    v14.CFrame = v15.Rotation + p_u_2.Position + v15.LookVector * p_u_4 + v15.RightVector * p_u_5
                    task.wait()
                end
            end
            task.spawn(v16)
            local v17 = {
                ["Target"] = v_u_11,
                ["Goal"] = {
                    ["Size"] = Vector3.new(1, 1, 1) * p6
                },
                ["Style"] = Enum.EasingStyle.Elastic,
                ["Time"] = 0.35
            }
            v9:Tween(v17).Completed:Wait()
            for v18 = 1, 3 do
                local v19 = v9:Part({
                    ["Color"] = Color3.new(1, 1, 1),
                    ["Size"] = Vector3.new(2, 2, 2),
                    ["Material"] = Enum.Material.Neon,
                    ["Anchored"] = true
                })
                game.Debris:AddItem(v19, 0.6)
                local v20 = v9:Mesh({
                    ["MeshId"] = 6026279375,
                    ["Target"] = v19
                })
                v19.CFrame = v_u_11.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
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
                v21.Time = 0.6
                v9:Tween(v21)
                v9:Tween({
                    ["Target"] = v19,
                    ["Time"] = 0.6,
                    ["Direction"] = Enum.EasingDirection.In
                })
                v9:Kindle({
                    ["Target"] = v19,
                    ["Duration"] = 0.6
                })
            end
            local v26 = v9:Projectile({
                ["Size"] = Vector3.new(0, p6, p6),
                ["Anchored"] = true,
                ["Shape"] = Enum.PartType.Cylinder,
                ["Material"] = Enum.Material.Metal,
                ["Color"] = p8
            })
            v26.CFrame = v_u_11.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
            local v27 = {
                ["Target"] = v26,
                ["Goal"] = {
                    ["CFrame"] = v26.CFrame + v26.CFrame.RightVector * p7 / 2,
                    ["Size"] = Vector3.new(p7, p6, p6)
                },
                ["Style"] = Enum.EasingStyle.Cubic
            }
            v9:Tween(v27)
            v9:Tween({
                ["Target"] = v_u_11,
                ["Direction"] = Enum.EasingDirection.In
            })
            v9:Tween({
                ["Target"] = v26,
                ["Direction"] = Enum.EasingDirection.In
            })
            local v28 = v9:Projectile({
                ["Color"] = Color3.new(1, 1, 1),
                ["Size"] = Vector3.new(2, 2, 2),
                ["Material"] = Enum.Material.Neon,
                ["Anchored"] = true
            })
            local v29 = v9:Mesh({
                ["MeshId"] = 6026279375,
                ["Target"] = v28
            })
            v28.CFrame = v_u_11.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
            local v30 = p_u_3.CFrame
            v_u_11.CFrame = v30.Rotation + p_u_2.Position + v30.LookVector * p_u_4 + v30.RightVector * p_u_5
            v_u_13 = false
            local v31 = {
                ["Target"] = v28,
                ["Goal"] = {
                    ["CFrame"] = v28.CFrame + v26.CFrame.RightVector * p7 / 2
                },
                ["Style"] = Enum.EasingStyle.Cubic
            }
            v9:Tween(v31)
            local v32 = {
                ["Target"] = v29,
                ["Goal"] = {
                    ["Scale"] = Vector3.new(1, 1, 1) * p6 * 1.2 + Vector3.new(0, 1, 0) * p7 * 10.5
                },
                ["Style"] = Enum.EasingStyle.Cubic
            }
            v9:Tween(v32)
            v9:Tween({
                ["Target"] = v28,
                ["Direction"] = Enum.EasingDirection.In
            })
            v9:Kindle({
                ["Target"] = v28,
                ["Duration"] = 0.6
            })
        end
    end
}