local v_u_1 = game:GetService("RunService").Heartbeat
local v_u_2 = Color3.new(0.7, 0, 0)
local v_u_3 = game:GetService("Debris")
return {
    ["Fire"] = function(p4, p5, p6)
        if p5 and (workspace.CurrentCamera.CFrame.Position - p5.Position).Magnitude < 300 then
            local v7 = p4.fx
            local v8 = p6 or v_u_2:Lerp(Color3.new(1, 0.3, 0.3), math.random())
            tick()
            local v9 = p5.Position
            local v10 = {}
            local v11 = {}
            local v12 = {}
            for _ = 1, 2 + math.random(3) do
                local v13 = math.random() - 0.5
                local v14 = math.random() - 0.5
                local v15 = math.random() - 0.5
                local v16 = Vector3.new(v13, v14, v15).unit
                local v17 = Instance.new("Part")
                v17.BrickColor = BrickColor.new(v8)
                local v18 = math.random() * 1.5
                local v19 = math.random() * 1.5
                local v20 = math.random() * 1.5
                v17.Size = Vector3.new(v18, v19, v20)
                v17.CFrame = CFrame.new(v9 + v16 * 2, v9 - v16)
                v17.RotVelocity = v16 * 20
                v17.Velocity = Vector3.new(0, 40, 0) + v16 * math.random(10, 20)
                v17.CanCollide = false
                v17.Anchored = true
                v17.Transparency = 0.25
                v17.Material = "Neon"
                v17.Parent = workspace
                v7:Tween({
                    ["Target"] = v17
                })
                table.insert(v10, v17)
                local v21 = math.random(-10, 10)
                local v22 = math.random(-10, 10)
                local v23 = math.random
                local v24 = Vector3.new(v21, v22, v23(-10, 10)).unit * (math.random(1, 10) * 0.9)
                table.insert(v11, v24)
                local v25 = Vector3.new(0, 10, 0) + v16 * math.random(10, 20)
                table.insert(v12, v25)
                v_u_3:AddItem(v17, 1)
            end
            for v26 = -0.25, 1, 0.016666666666666666 do
                for v27 = 1, #v10 do
                    local v28 = v12[v27]
                    local v29 = v11[v27]
                    local v30 = v10[v27]
                    local v31 = v26 * v26 - (v26 + 0.016666666666666666) * (v26 + 0.016666666666666666)
                    local v32 = CFrame.new
                    local v33 = v30.Position + v28 * 0.016666666666666666
                    local v34 = v31 * 120
                    v30.CFrame = v32(v33 + Vector3.new(0, v34, 0), v30.Position + v30.CFrame.lookVector + v29 * 0.016666666666666666)
                end
                v_u_1:Wait()
            end
        end
    end
}