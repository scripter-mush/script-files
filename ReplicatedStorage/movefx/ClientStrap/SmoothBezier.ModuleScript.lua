local v_u_1 = game:GetService("RunService").Heartbeat
return {
    ["Fire"] = function(_, p2, p3, p4, p5, p6)
        if p2 and (workspace.CurrentCamera.CFrame.Position - p2.Position).Magnitude < 300 then
            local v7 = tick()
            local v8 = 0
            while v8 < p6 do
                v8 = tick() - v7
                local v9 = (p6 - v8) / p6
                local v10 = v8 / p6
                p2.Position = v9 ^ 2 * p3 + 2 * v9 * v10 * p4 + v10 ^ 2 * p5
                v_u_1:Wait()
            end
        end
    end
}