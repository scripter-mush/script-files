function quadBezier(p1, p2, p3, p4)
    local v5 = p2.Position
    local v6 = p3.Position
    local v7 = p4.Position
    local v8 = 1 - p1
    local v9 = v8 ^ 2 * v5 + v8 * 2 * p1 * v6 + p1 ^ 2 * v7
    local v10 = p2.Rotation:Lerp(p4.Rotation, p1)
    return CFrame.new(v9) * v10
end
return {
    ["Fire"] = function(p11, p_u_12, p_u_13, p14, p15)
        if (workspace.CurrentCamera.CFrame.Position - p_u_12.Position).Magnitude < 600 then
            local v16 = p11.fx
            if p15 then
                local v_u_17 = {}
                for _, v18 in p15 do
                    local v19 = v16:Part({
                        ["Color"] = Color3.new(),
                        ["Transparency"] = 1,
                        ["Anchored"] = true
                    })
                    v19.CFrame = v18.CFrame
                    v16:Trail({
                        ["Target"] = v19,
                        ["Range"] = Vector3.new(0, 0.5, 0),
                        ["Color"] = v19.Color
                    })
                    local v20 = { v19, v18.CFrame }
                    table.insert(v_u_17, v20)
                end
                task.spawn(function()
                    local v21 = p_u_13 - Vector3.new(0, 40, 0)
                    local v22 = 0
                    while v22 < 3 do
                        local v23 = v22 / 3
                        for _, v24 in v_u_17 do
                            local v25, v26 = table.unpack(v24)
                            v25.CFrame = quadBezier(v23, v26, v21, p_u_12)
                        end
                        v22 = v22 + task.wait()
                    end
                    for _, v27 in v_u_17 do
                        v27[1]:Destroy()
                    end
                end)
            end
            local v28 = v16:Part({
                ["Color"] = Color3.new(),
                ["Shape"] = Enum.PartType.Ball,
                ["Transparency"] = 0.5,
                ["Anchored"] = true
            })
            v16:Sound({
                ["Id"] = 88645777316683,
                ["Pitch"] = 0.2 + 0.4 * math.random(),
                ["Target"] = v28
            })
            v16:Trail({
                ["Target"] = v28,
                ["Range"] = Vector3.new(0, 1, 0) * p14 / 8,
                ["Color"] = v28.Color
            })
            v28.CFrame = p_u_12
            local v29 = v16:Attachment({
                ["Target"] = v28
            })
            v16:Tween({
                ["Target"] = v28,
                ["Goal"] = {
                    ["Size"] = Vector3.new(1, 1, 1) * p14,
                    ["Transparency"] = 1
                },
                ["Direction"] = Enum.EasingDirection.In,
                ["Time"] = 3
            })
            v16:Sound({
                ["Id"] = 88741051180703,
                ["Target"] = v28
            })
            for v30 = 1, 6 do
                local v31 = p14 * (v30 / 30)
                local v32 = v30 ~= 6
                v16:EmitSet({
                    ["Target"] = v29,
                    ["ParticleId"] = "_DarkseedMeteor",
                    ["Scale"] = v31,
                    ["Duration"] = v32 and 1,
                    ["Expire"] = v32
                })
                task.wait(0.5)
            end
            v16:Sound({
                ["Id"] = 135485273723296,
                ["Target"] = v28
            })
            local v33 = p_u_12 + p_u_12.LookVector * 50 + p_u_12.UpVector * 8 * 2
            local v34 = 0
            while v34 < 2 do
                local v35 = v34 / 2
                v28.CFrame = quadBezier(v35, p_u_12, v33, p_u_13)
                v34 = v34 + task.wait()
            end
            v28:Destroy()
            local v36 = v16:Part({
                ["CFrame"] = p_u_13,
                ["Transparency"] = 1
            })
            game.Debris:AddItem(v36, 5)
            v16:Sound({
                ["Id"] = 73110170847799,
                ["Target"] = v36
            })
            v16:Sound({
                ["Id"] = 113876254723064,
                ["Target"] = v36
            })
            v16:EmitSet({
                ["Position"] = p_u_13.Position,
                ["ParticleId"] = "_DarkseedImpact",
                ["Scale"] = p14 / 5,
                ["Duration"] = 2,
                ["Decay"] = true
            })
            v16:EmitSet({
                ["Position"] = p_u_13.Position,
                ["ParticleId"] = "_DarkseedExplosion",
                ["Scale"] = p14 / 5,
                ["Duration"] = 0.75,
                ["Decay"] = true
            })
        end
    end
}