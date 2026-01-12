local v1 = game:GetService("RunService")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = Enum.EasingStyle.Cubic
local v_u_4 = Enum.EasingDirection.InOut
local v_u_5 = v1.Heartbeat
return {
    ["Fire"] = function(_, p6, p7, p8)
        if (workspace.CurrentCamera.CFrame.Position - p6).Magnitude < 300 then
            local v9 = 0
            local v10 = 0.8
            while v9 < p8 do
                local v11 = v9 / p8
                local v12 = v_u_2:GetValue(v11, v_u_3, v_u_4)
                for _, v13 in p7 do
                    v13.Rotation = NumberRange.new(-110 * v12)
                end
                if v10 < v11 then
                    v10 = (1 / 0)
                    for _, v14 in p7 do
                        v14.TimeScale = 0.5
                        v14.Enabled = false
                    end
                end
                v9 = v9 + v_u_5:Wait()
            end
        end
    end
}