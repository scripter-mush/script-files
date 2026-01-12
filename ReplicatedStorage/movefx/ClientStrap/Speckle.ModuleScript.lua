local v_u_1 = game:GetService("RunService").Heartbeat
local v_u_2 = {}
return {
    ["Fire"] = function(p3, p4, p5, p6)
        local v7 = p3.settings.SavedQualityLevel.Value
        local v8 = workspace.CurrentCamera
        local v9 = tick()
        for v10 = #v_u_2, 1, -1 do
            if v9 - v_u_2[v10] > 3 then
                table.remove(v_u_2, v10)
            end
        end
        if p4 and (v8.CFrame.Position - p4.Position).Magnitude < 300 then
            local v11 = v_u_2
            local v12 = tick
            table.insert(v11, v12())
            local v13 = p3.fx
            local v14 = p6 or p4.Color
            local v15 = tick()
            local v16 = p5 or 1
            while tick() - v15 < v16 do
                local v17, v18 = v13:Projectile({
                    ["Size"] = Vector3.new(1, 1, 1) * p4.Size.Z * (0.5 + math.random()) / 4,
                    ["Material"] = Enum.Material.Neon,
                    ["Color"] = v14
                }, 1)
                v18.Velocity = p4.Velocity / 5
                v17.CFrame = p4.CFrame + p4.Size * (math.random() - 0.5)
                v13:Tween({
                    ["Target"] = v17,
                    ["Style"] = Enum.EasingStyle.Exponential,
                    ["Direction"] = Enum.EasingDirection.In
                })
                v13:Tween({
                    ["Target"] = v17,
                    ["Goal"] = {
                        ["Size"] = Vector3.new(0, 0, 0)
                    }
                })
                for _ = 1, #v_u_2 + 12 - v7 do
                    v_u_1:Wait()
                end
            end
        end
    end
}