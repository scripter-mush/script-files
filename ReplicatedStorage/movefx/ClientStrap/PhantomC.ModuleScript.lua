local _ = game:GetService("RunService").Heartbeat
return {
    ["Fire"] = function(p1, p2, p3, p4)
        local v5 = workspace.CurrentCamera
        if p2 and (p2.PrimaryPart and (v5.CFrame.Position - p2.PrimaryPart.Position).Magnitude < 300) then
            local v6 = p1.fx
            tick()
            for _ = 1, 10 * (p3 or 1) do
                v6:GhostCharacter({
                    ["Character"] = p2,
                    ["Color"] = p4,
                    ["Duration"] = 0.5
                })
                task.wait(0.1)
            end
        end
    end
}