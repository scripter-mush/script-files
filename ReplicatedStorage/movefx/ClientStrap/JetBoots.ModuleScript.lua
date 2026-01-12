local v_u_1 = game:GetService("RunService").Heartbeat
return {
    ["Fire"] = function(p2, p3, _)
        local v4 = workspace.CurrentCamera
        local v5 = p3.PrimaryPart
        if v5 and (v4.CFrame.Position - v5.Position).Magnitude < 300 then
            local v6 = p2.fx
            local v7 = { p3.LeftFoot, p3.RightFoot }
            local v8 = {}
            for _ = 1, 2 do
                local v9 = v6:Part({
                    ["Size"] = Vector3.new(1, 0.8, 1),
                    ["Color"] = Color3.new(1, 0, 0),
                    ["Material"] = Enum.Material.Neon
                })
                v6:Kindle({
                    ["Target"] = v9,
                    ["Color"] = Color3.new(1, 0, 0),
                    ["Duration"] = 1.1
                })
                v6:Tween({
                    ["Target"] = v9,
                    ["Time"] = 1.1
                })
                table.insert(v8, v9)
            end
            local v10 = {}
            for _ = 1, 2 do
                local v11 = v6:Part({
                    ["Size"] = Vector3.new(0.6, 2, 0.6),
                    ["Color"] = Color3.new(1, 1, 0),
                    ["Material"] = Enum.Material.Neon
                })
                v6:Tween({
                    ["Target"] = v11,
                    ["Time"] = 1.1
                })
                table.insert(v10, v11)
            end
            local v12 = 0
            while v12 < 1.1 do
                for v13, v14 in v8 do
                    local v15 = v7[v13]
                    v14.CFrame = v15.CFrame * CFrame.Angles(0, v12 * 12, 0) - Vector3.new(0, 1, 0) * (v14.Size.Y / 2 + v15.Size.Y / 2)
                end
                for v16, v17 in v10 do
                    local v18 = v7[v16]
                    v17.CFrame = v18.CFrame * CFrame.Angles(0, v12 * -6, 0) - Vector3.new(0, 1, 0) * (v17.Size.Y / 2 + v18.Size.Y / 2)
                end
                v12 = v12 + v_u_1:Wait()
            end
            for _, v19 in v8 do
                v19:Destroy()
            end
            for _, v20 in v10 do
                v20:Destroy()
            end
        end
    end
}