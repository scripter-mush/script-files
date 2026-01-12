local v_u_1 = game:GetService("RunService").Heartbeat
local v_u_2 = {}
return {
    ["Fire"] = function(p3, p4, p5)
        local v6 = p3.settings.SavedQualityLevel.Value
        local v7 = workspace.CurrentCamera
        local v8 = tick()
        for v9 = #v_u_2, 1, -1 do
            if v8 - v_u_2[v9] > 3 then
                table.remove(v_u_2, v9)
            end
        end
        if p4 and (v7.CFrame.Position - p4.Position).Magnitude < 300 then
            local v10 = v_u_2
            local v11 = tick
            table.insert(v10, v11())
            local v12 = p3.fx
            local v13 = tick()
            local v14 = p5 or 1
            while tick() - v13 < v14 do
                local v15, v16 = v12:Projectile({
                    ["Size"] = p4.Size * (0.5 + math.random()) / 4,
                    ["Material"] = Enum.Material.Neon,
                    ["Color"] = p4.Color
                }, 1)
                v16.Velocity = p4.Velocity / 5
                v15.CFrame = p4.CFrame + p4.Size * (math.random() - 0.5)
                v12:Tween({
                    ["Target"] = v15,
                    ["Style"] = Enum.EasingStyle.Exponential,
                    ["Direction"] = Enum.EasingDirection.In
                })
                local v17 = {
                    ["Target"] = v15,
                    ["Goal"] = {
                        ["Size"] = Vector3.new(0, 0, 0)
                    }
                }
                v12:Tween(v17)
                for _ = 1, #v_u_2 + 12 - v6 do
                    v_u_1:Wait()
                end
            end
        end
    end
}