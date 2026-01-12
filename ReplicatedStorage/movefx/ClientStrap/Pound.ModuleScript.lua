local _ = game:GetService("RunService").Heartbeat
local v_u_1 = Color3.new(1, 1, 1)
return {
    ["Fire"] = function(p2, p3, p4, p5)
        if (workspace.CurrentCamera.CFrame.Position - p3).Magnitude < 100 then
            local v6 = p2.fx
            local v7 = CFrame.new(p3, p3 + p4)
            local v8 = v6:Part({
                ["Color"] = p5 or v_u_1,
                ["Size"] = Vector3.new(2, 2, 2),
                ["Material"] = Enum.Material.Neon,
                ["Anchored"] = true
            })
            game.Debris:AddItem(v8, 0.75)
            local v9 = v6:Mesh({
                ["MeshId"] = 6026279375,
                ["Target"] = v8
            })
            v8.CFrame = v7 * CFrame.Angles(1.5707963267948966, 0, 0)
            local v10 = {
                ["Target"] = v9
            }
            local v11 = {}
            local v12 = v9.Scale
            local v13 = 40 * p4.Magnitude
            v11.Scale = v12 * Vector3.new(4, v13, 4)
            v10.Goal = v11
            v10.Time = 0.75
            v6:Tween(v10)
            v6:Tween({
                ["Target"] = v8,
                ["Time"] = 0.75,
                ["Direction"] = Enum.EasingDirection.In
            })
            v6:Kindle({
                ["Target"] = v8,
                ["Duration"] = 0.75
            })
        end
    end
}