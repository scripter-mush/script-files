return {
    ["Fire"] = function(p1, ...)
        local v2 = p1.fx
        local v3 = (...).PrimaryPart
        local v4 = script.Crystal:Clone()
        v4.Material = Enum.Material.Neon
        v4.Color = clr
        v4.Size = Vector3.new(3, 5, 3) * v3.Size.Y
        v4.Parent = workspace.Projectiles
        v2:Debris(v4, 1)
        v2:Sound({
            ["Id"] = 5855424467,
            ["Target"] = v4
        })
        local v5 = v2:Attachment({
            ["Target"] = v4
        })
        local v6 = {
            ["Attachment0"] = v5,
            ["Attachment1"] = v2:Attachment({
                ["Target"] = v3
            })
        }
        v2:RigidFollow(v6)
        local v7 = {
            ["Target"] = v5,
            ["Goal"] = {
                ["CFrame"] = v5.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            },
            ["Style"] = Enum.EasingStyle.Linear,
            ["RepeatCount"] = 2,
            ["Time"] = 0.4
        }
        v2:Tween(v7)
        local v8 = {
            ["Target"] = v4,
            ["Goal"] = {
                ["Size"] = v4.Size * 1.75
            },
            ["Reverses"] = true,
            ["RepeatCount"] = 2,
            ["Time"] = 0.25
        }
        v2:Tween(v8)
        v2:Tween({
            ["Target"] = v4,
            ["Time"] = 1,
            ["Direction"] = Enum.EasingDirection.In
        })
    end
}