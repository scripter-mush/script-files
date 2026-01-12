local v_u_1 = game:GetService("TweenService")
return {
    ["Fire"] = function(p2, p3, p4, p5)
        local _ = workspace.CurrentCamera
        if p3 then
            local _ = p2.fx
            local v_u_6 = table.clone(p3.Size.Keypoints)
            local v7 = 0
            local function v15(p8)
                local v9 = {}
                for _, v10 in v_u_6 do
                    local v11 = NumberSequenceKeypoint.new
                    local v12 = v10.Time
                    local v13 = v10.Value * p8
                    local v14 = v10.Envelope * p8
                    table.insert(v9, v11(v12, v13, v14))
                end
                return NumberSequence.new(v9)
            end
            while v7 < p5 do
                v7 = v7 + task.wait()
                p3.Size = v15(v_u_1:GetValue(v7 / p5, Enum.EasingStyle.Quad, Enum.EasingDirection.In) * p4)
            end
        end
    end
}