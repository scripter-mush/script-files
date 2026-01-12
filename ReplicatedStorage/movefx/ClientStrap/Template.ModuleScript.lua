return {
    ["Fire"] = function(p1, ...)
        local v2 = p1.fx
        local v3 = v2:Part({
            ["Anchored"] = true,
            ["Size"] = Vector3.new(4, 4, 4)
        })
        game.Debris:AddItem(v3, 2)
        v3.CFrame = (...).CFrame
        v2:Tween({
            ["Target"] = v3,
            ["Time"] = 2
        })
        v2:Emit({
            ["Target"] = v3,
            ["ParticleId"] = "MusicAura",
            ["Duration"] = 3
        })
    end
}