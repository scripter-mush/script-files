local _ = game:GetService("RunService").Heartbeat
local v_u_1 = Color3.new(0.7, 0, 0)
return {
    ["Fire"] = function(p2, p3, p4, p_u_5)
        if p3 and (workspace.CurrentCamera.CFrame.Position - p3.Position).Magnitude < 300 then
            local v_u_6 = p2.fx
            local v_u_7 = p3.Position
            local v_u_8 = p4.Position
            local v_u_9 = p3.CFrame
            local v_u_10 = p3.Size.Y
            local v_u_11 = p3.Size.X
            for _ = 1, 3 do
                task.spawn(function()
                    local v12 = p_u_5 or v_u_1:Lerp(Color3.new(1, 0.3, 0.3), math.random())
                    v_u_6:BoltActive({
                        ["Start"] = v_u_7 + (v_u_10 * v_u_9.UpVector * (math.random() - 0.5) + v_u_11 * v_u_9.RightVector * (math.random() - 0.5)),
                        ["Goal"] = v_u_8 + (v_u_10 * v_u_9.UpVector * (math.random() - 0.5) + v_u_11 * v_u_9.RightVector * (math.random() - 0.5)),
                        ["Color"] = v12,
                        ["Size"] = 1 + 2 * math.random(),
                        ["Time"] = 0.16666666666666666,
                        ["Lifetime"] = 0.75
                    })
                end)
            end
        end
    end
}