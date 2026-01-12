local _ = game:GetService("RunService").Heartbeat
game:GetService("Debris")
return {
    ["Fire"] = function(p1, p2, p3, p4, p5, p6)
        if (workspace.CurrentCamera.CFrame.Position - p2.Position).Magnitude < 700 then
            local v7 = p1.fx
            local v8, v9 = v7:SlashDecal({
                ["Color"] = p6,
                ["Scale"] = p5
            })
            game.Debris:AddItem(v8, p4)
            v8.CFrame = p2
            local v10 = {
                ["Target"] = v8,
                ["Goal"] = {
                    ["CFrame"] = p3,
                    ["Transparency"] = 1
                },
                ["Time"] = p4,
                ["Direction"] = Enum.EasingDirection.InOut
            }
            v7:Tween(v10)
            for _, v11 in pairs(v9) do
                v7:Tween({
                    ["Target"] = v11,
                    ["Time"] = p4,
                    ["Direction"] = Enum.EasingDirection.In
                })
            end
        end
    end
}