local _ = game:GetService("RunService").Heartbeat
local v_u_1 = game:GetService("Lighting")
game:GetService("Debris")
return {
    ["Fire"] = function(p2, p3, p4)
        if p3 and (workspace.CurrentCamera.CFrame.Position - p3).Magnitude < p4 then
            local v5 = p2.fx
            local v6 = Instance.new("ColorCorrectionEffect")
            local v7 = Instance.new("ColorCorrectionEffect")
            local v8 = Instance.new("ColorCorrectionEffect")
            v6.Parent = v_u_1
            v7.Parent = v_u_1
            v8.Parent = v_u_1
            local v9 = {
                ["Target"] = v6,
                ["Goal"] = {
                    ["Saturation"] = -1
                },
                ["Time"] = 0.25
            }
            v5:Tween(v9)
            local v10 = {
                ["Target"] = v7,
                ["Goal"] = {
                    ["Saturation"] = -1
                },
                ["Time"] = 0.25
            }
            v5:Tween(v10)
            for _, v11 in { Color3.fromHSV(1, 1, 1), Color3.fromHSV(0.5, 1, 1), Color3.fromHSV(0.2, 1, 1) } do
                local v12 = {
                    ["Target"] = v8,
                    ["Goal"] = {
                        ["TintColor"] = v11
                    },
                    ["Time"] = 0.25
                }
                v5:Tween(v12)
                task.wait(0.25)
            end
            local v13 = {
                ["Target"] = v6,
                ["Goal"] = {
                    ["Saturation"] = 0
                },
                ["Time"] = 0.25
            }
            v5:Tween(v13)
            local v14 = {
                ["Target"] = v7,
                ["Goal"] = {
                    ["Saturation"] = 0
                },
                ["Time"] = 0.25
            }
            v5:Tween(v14)
            local v15 = {
                ["Target"] = v8,
                ["Goal"] = {
                    ["TintColor"] = Color3.new(1, 1, 1)
                },
                ["Time"] = 0.3
            }
            v5:Tween(v15).Completed:Wait()
            v6:Destroy()
            v7:Destroy()
            v8:Destroy()
        end
    end
}