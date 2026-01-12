return {
    ["Fire"] = function(p1, ...)
        local v2 = p1.fx
        local v3, v4, v5 = ...
        local v6 = Vector3.new(2, 24, 2) * v5
        local v7 = Vector3.new(12, 4, 12) * v5
        for v8 = 1, 3 do
            local v9 = 1 + v8 / 5
            local v10 = v6 * v9
            local v11 = v7 * v9
            local v12 = v2:Part({
                ["Size"] = v10,
                ["Color"] = v4,
                ["Anchored"] = true,
                ["Material"] = Enum.Material.Neon
            })
            v2:Debris(v12, 0.75)
            v12.CFrame = CFrame.new() + v3
            local v13 = {
                ["Part"] = v12,
                ["MeshId"] = 20329976,
                ["Scale"] = 0.5 * v10
            }
            v2:Sound({
                ["Id"] = 163621622,
                ["Target"] = v12,
                ["Volume"] = 1.5,
                ["Pitch"] = 1 - v8 / 15
            })
            local v14 = {
                ["Target"] = v2:Mesh(v13),
                ["Goal"] = {
                    ["Scale"] = 0.5 * v11
                },
                ["Time"] = 0.75
            }
            v2:Tween(v14)
            local v15 = {
                ["Target"] = v12,
                ["Goal"] = {
                    ["Size"] = v11
                },
                ["Time"] = 0.75
            }
            v2:Tween(v15)
            v2:Tween({
                ["Target"] = v12,
                ["Direction"] = Enum.EasingDirection.In,
                ["Time"] = 0.75
            })
            v2:Kindle({
                ["Target"] = v12,
                ["Color"] = v4,
                ["Duration"] = 0.75
            })
            task.wait(0.05 + v8 / 20)
        end
    end
}