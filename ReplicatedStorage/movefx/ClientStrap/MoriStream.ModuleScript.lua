local v_u_1 = game:GetService("TweenService")
local _ = game:GetService("RunService").Heartbeat
return {
    ["Fire"] = function(p2, p3, p4, p5, p6)
        local _ = p2.settings.SavedQualityLevel.Value
        if (workspace.CurrentCamera.CFrame.Position - p3.Position).Magnitude < 300 then
            local v7 = p2.fx
            local v8 = {}
            for _ = 1, 2 do
                local v9 = game.ReplicatedStorage.Models.Particles._Mori.TemplateStream:Clone()
                v9.Parent = workspace.Projectiles
                local v10 = Instance.new("Highlight")
                v10.FillColor = Color3.fromRGB(21, 0, 0)
                v10.FillTransparency = 0.3
                v10.OutlineColor = Color3.new()
                v10.Parent = v9
                table.insert(v8, v9)
            end
            local v11 = 0
            while v11 < 1.75 do
                local v12
                if v11 < 0.5 then
                    v12 = v_u_1:GetValue(v11 * 2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In) * 0.5
                else
                    v12 = v11
                end
                for v13, v14 in v8 do
                    local v15 = v13 == 1 and 3.141592653589793 or 0
                    local v16 = p3 * CFrame.Angles(0, 0, v11 * 6) + p6 * (v12 * 110)
                    local v17 = v15 + v12 * 3.141592653589793 * 4
                    local v18 = v16 + math.sin(v17) * p4
                    local v19 = v15 + v12 * 3.141592653589793 * 4
                    v14:PivotTo(v18 + math.cos(v19) * p5)
                end
                v11 = v11 + task.wait()
            end
            for _, v20 in v8 do
                v7:Emit({
                    ["Folder"] = "_Mori",
                    ["ParticleId"] = "StreamHit",
                    ["Rate"] = 8,
                    ["Scale"] = 3,
                    ["Position"] = v20.PrimaryPart.Position
                })
                v20:Destroy()
            end
        end
    end
}