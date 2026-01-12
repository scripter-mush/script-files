return {
    ["Fire"] = function(p1, ...)
        local v2 = p1.fx
        local v3, v4 = ...
        local v5 = v3.PrimaryPart
        local v6 = script.Crystal:Clone()
        v6.Material = Enum.Material.Metal
        v6.Color = Color3.new(1, 1, 1)
        v6.Size = Vector3.new(3, 5, 3) * v5.Size.Y * 1.25
        v6.Parent = workspace.Projectiles
        v2:Debris(v6, 0.75)
        v2:Sound({
            ["Id"] = 2674547670,
            ["Target"] = v6,
            ["Pitch"] = 0.95
        })
        local v7 = v2:Attachment({
            ["Target"] = v6
        })
        local v8 = {
            ["Attachment0"] = v7,
            ["Attachment1"] = v2:Attachment({
                ["Target"] = v5
            })
        }
        v2:RigidFollow(v8)
        local v9 = {
            ["Target"] = v7,
            ["Goal"] = {
                ["CFrame"] = v7.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            },
            ["Style"] = Enum.EasingStyle.Linear,
            ["RepeatCount"] = 1,
            ["Time"] = 0.4
        }
        v2:Tween(v9)
        v2:Tween({
            ["Target"] = v6,
            ["Time"] = 0.75,
            ["Direction"] = Enum.EasingDirection.InOut
        })
        local v10 = 16 * v4
        for v11 = 0, 5 do
            local v12 = 0.6 - v11 / 10
            local v13 = script.AscendTornado:Clone()
            v2:Debris(v13, v12)
            v13.Size = Vector3.new(2, 2, 2)
            v13.Massless = true
            v13.Parent = workspace.Projectiles
            local v14 = v2:Attachment({
                ["Target"] = v13,
                ["Position"] = Vector3.new(0, 1, 0) * v5.Size.Y * 1.5
            })
            local v15 = {
                ["Attachment0"] = v14,
                ["Attachment1"] = v2:Attachment({
                    ["Target"] = v5
                })
            }
            v2:RigidFollow(v15)
            local v16 = {
                ["Target"] = v14,
                ["Goal"] = {
                    ["CFrame"] = v14.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                },
                ["Style"] = Enum.EasingStyle.Linear,
                ["Time"] = 0.3
            }
            v2:Tween(v16)
            local v17 = {
                ["Target"] = v13,
                ["Goal"] = {
                    ["Size"] = Vector3.new(v10, 2, v10)
                },
                ["Time"] = v12
            }
            v2:Tween(v17)
            v2:Tween({
                ["Target"] = v13,
                ["Time"] = v12,
                ["Direction"] = Enum.EasingDirection.InOut
            })
            v2:Sound({
                ["Id"] = 138098523,
                ["Target"] = v5,
                ["Pitch"] = 0.4,
                ["Volume"] = 0.1
            })
            task.wait(0.1)
        end
    end
}