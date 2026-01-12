return {
    ["Fire"] = function(p1, ...)
        local v_u_2 = p1.fx
        local v3, v4, v5 = ...
        local v_u_6 = v3.HumanoidRootPart
        local v_u_7 = Vector3.new(0, 1, 0) * v_u_6.Size.Y * 1.5
        local v_u_8 = math.random
        local v_u_9 = {
            ["Anchored"] = true,
            ["Size"] = Vector3.new(0.25, 0.25, 0.25),
            ["Material"] = Enum.Material.Neon,
            ["Color"] = Color3.new(1, 1, 1)
        }
        local v10 = tick()
        local function v15()
            local v11 = v_u_2:Part(v_u_9)
            local v12 = 0.4 + math.random() * 0.2
            v_u_2:Debris(v11, v12)
            v11.CFrame = v_u_6.CFrame * CFrame.Angles(6.283185307179586 * v_u_8(), 6.283185307179586 * v_u_8(), 6.283185307179586 * v_u_8()) - v_u_7
            local v13 = v_u_2
            local v14 = {
                ["Target"] = v11,
                ["Goal"] = {
                    ["CFrame"] = v11.CFrame * CFrame.Angles(6.283185307179586 * v_u_8(), 6.283185307179586 * v_u_8(), 6.283185307179586 * v_u_8()) + v11.CFrame.UpVector * 2 + v11.CFrame.LookVector * 3,
                    ["Size"] = v11.Size * 4,
                    ["Transparency"] = 1
                },
                ["Time"] = v12
            }
            v13:Tween(v14)
        end
        for v16 = -3, 5, 2 do
            local v17 = script.AscendTornado:Clone()
            v_u_2:Debris(v17, 1.25)
            local v18 = 5 * v5
            local v19 = 5 * v5
            v17.Size = Vector3.new(v18, 6, v19) * v_u_6.Size.Y / 2
            v17.Massless = true
            v17.Parent = workspace.Projectiles
            local v20 = v_u_2:Attachment({
                ["Target"] = v17,
                ["Position"] = Vector3.new(0, 1, 0) * v_u_6.Size.Y * (v16 / 3)
            })
            local v21 = {
                ["Attachment0"] = v20,
                ["Attachment1"] = v_u_2:Attachment({
                    ["Target"] = v_u_6
                })
            }
            v_u_2:RigidFollow(v21)
            local v22 = {
                ["Target"] = v20,
                ["Goal"] = {
                    ["CFrame"] = v20.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                },
                ["Style"] = Enum.EasingStyle.Linear,
                ["RepeatCount"] = 3,
                ["Time"] = 0.4
            }
            v_u_2:Tween(v22)
            local v23 = {
                ["Target"] = v17,
                ["Goal"] = {
                    ["Size"] = v17.Size * (1 + v16 / 10)
                },
                ["Reverses"] = true,
                ["RepeatCount"] = 2,
                ["Time"] = 0.3125
            }
            v_u_2:Tween(v23)
            v_u_2:Tween({
                ["Target"] = v17,
                ["Time"] = 1.25,
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Direction"] = Enum.EasingDirection.In
            })
            task.wait(0.1)
        end
        v_u_2:Kindle({
            ["Target"] = v_u_6,
            ["Color"] = v4
        })
        while tick() - v10 < 1.25 do
            v15()
            task.wait()
        end
    end
}