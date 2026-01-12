local v_u_1 = game:GetService("RunService").Heartbeat
game:GetService("Debris")
return {
    ["Fire"] = function(p2, p3, p4, p5)
        if p3 and (workspace.CurrentCamera.CFrame.Position - p3.Position).Magnitude < 300 then
            local v6 = p2.fx
            local v7 = p3.Size.Y
            local v8 = {}
            local v9 = p5 or 2
            for _ = 1, 2 do
                local v10 = v6:Part({
                    ["Size"] = Vector3.new(3, 3, 3),
                    ["Color"] = p4,
                    ["Shape"] = Enum.PartType.Ball,
                    ["CFrame"] = p3.CFrame
                })
                v6:FakeAnchor(v10)
                game.Debris:AddItem(v10, 3)
                local v11 = {
                    ["Target"] = v10,
                    ["Goal"] = {
                        ["Transparency"] = 0.2
                    },
                    ["Time"] = 0.25
                }
                v6:Tween(v11)
                v6:EmitSet({
                    ["Target"] = v10,
                    ["ParticleId"] = "Bubble",
                    ["Color"] = p4,
                    ["Lifetime"] = 0.5
                })
                v6:Trail({
                    ["TrailId"] = "ProjectileShort",
                    ["Color"] = Color3.new(0, 0, 0),
                    ["Target"] = v10,
                    ["Range"] = Vector3.new(0, 1, 0) * v10.Size.Y / 2
                })
                table.insert(v8, v10)
            end
            local v12 = tick()
            local v13 = 0
            while v13 < 3 do
                v13 = tick() - v12
                for v14, v15 in pairs(v8) do
                    local v16 = 180 * v14
                    local v17 = p3.CFrame
                    local v18 = p3.CFrame
                    local v19 = CFrame.Angles
                    local v20 = v16 + v13 * 240
                    v15.CFrame = v17 + (v18 * v19(0, math.rad(v20), 0)).LookVector * v7 * v9 * (v13 + 0.5)
                end
                v_u_1:Wait()
            end
        end
    end
}