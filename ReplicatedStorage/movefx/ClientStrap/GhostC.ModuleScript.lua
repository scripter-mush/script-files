local _ = game:GetService("RunService").Heartbeat
return {
    ["Fire"] = function(p1, p2, p3, p4)
        if (workspace.CurrentCamera.CFrame.Position - p2.PrimaryPart.Position).Magnitude < 300 then
            local v5 = p1.fx
            tick()
            v5:GhostCharacter({
                ["Character"] = p2,
                ["Color"] = p4,
                ["Duration"] = p3 or 1
            })
        end
    end
}