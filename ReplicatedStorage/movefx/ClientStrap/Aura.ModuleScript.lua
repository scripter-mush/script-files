local _ = game:GetService("RunService").Heartbeat
return {
    ["Fire"] = function(p1, p2, p3, p4, p5)
        local v6 = workspace.CurrentCamera
        local v7 = p5 or 1
        local v8 = p4 and p4:Lerp(Color3.new(1, 1, 1), math.random()) or Color3.new(1, 1, 1)
        local v9 = p3 or 0.5
        if p2 and (v6.CFrame.Position - p2.Position).Magnitude < 100 then
            local v10 = p1.fx
            local v11 = v10:Part({
                ["Color"] = v8,
                ["Transparency"] = 0.6 + math.random() * 0.3,
                ["Size"] = Vector3.new(0, 0, 0),
                ["Material"] = Enum.Material.Neon
            })
            game.Debris:AddItem(v11, v9)
            v10:FollowWeld(p2, v11)
            local v12 = v10:Mesh({
                ["MeshId"] = 6026279375,
                ["Scale"] = Vector3.new(6, 16, 6) * v7,
                ["Target"] = v11
            })
            v12.Offset = Vector3.new(-0, -1, -0) * (p2.Size.Y * 1.5)
            v10:Tween({
                ["Target"] = v12,
                ["Goal"] = {
                    ["Scale"] = v12.Scale * Vector3.new(1.2, 1, 1.2)
                },
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Direction"] = Enum.EasingDirection.InOut,
                ["Reverses"] = true,
                ["Time"] = v9 / 2
            })
            local v13 = {
                ["Target"] = v11,
                ["Time"] = v9
            }
            local v14 = {}
            local v15 = 360 * v9
            v14.Orientation = Vector3.new(0, v15, 0)
            v14.Transparency = 1
            v13.Goal = v14
            v13.Direction = Enum.EasingDirection.In
            v10:Tween(v13)
            v10:Kindle({
                ["Target"] = v11,
                ["Duration"] = v9,
                ["Color"] = v8
            })
        end
    end
}