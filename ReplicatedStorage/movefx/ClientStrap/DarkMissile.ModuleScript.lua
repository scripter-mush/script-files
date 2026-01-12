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
    ["Fire"] = function(p11, p12, p13, p14, p15, p16)
        if p12 and (workspace.CurrentCamera.CFrame.Position - p12.Position).Magnitude < 600 then
            local v17 = p11.fx
            local v18 = p14 or 1
            local v19 = v17:Part({
                ["Color"] = p16 or Color3.new(),
                ["Transparency"] = 1,
                ["Anchored"] = true
            })
            v17:Mesh({
                ["Target"] = v19,
                ["MeshId"] = 982634187,
                ["Scale"] = Vector3.new(0.013, 0.013, 0.025) * (p15 or 1)
            })
            v17:EmitSet({
                ["Target"] = v17:Attachment({
                    ["Target"] = v19,
                    ["Position"] = Vector3.new(-0, -0, -1)
                }),
                ["ParticleId"] = "_DarkseedDarkSpeckle",
                ["Color"] = p16,
                ["Duration"] = v18 + 0.75,
                ["Expire"] = true
            })
            v17:Sound({
                ["Id"] = 88645777316683,
                ["Pitch"] = 0.8 + 0.4 * math.random(),
                ["Target"] = v19
            })
            v17:Trail({
                ["Target"] = v19,
                ["Range"] = Vector3.new(0, 0.5, 0),
                ["Color"] = v19.Color
            })
            v19.CFrame = p13
            v17:Tween({
                ["Target"] = v19,
                ["Goal"] = {
                    ["Transparency"] = 0
                },
                ["Time"] = 0.2
            })
            local v20 = p13 + p13.LookVector * 50 + p13.UpVector * 8 * v18
            local v21 = 0
            while v21 < v18 do
                local v22 = v21 / v18
                v19.CFrame = quadBezier(v22, p13, v20, p12.CFrame)
                v21 = v21 + task.wait()
            end
            v17:EmitSet({
                ["Position"] = p12.Position,
                ["ParticleId"] = "_DarkseedMissileHit",
                ["Duration"] = 0.75,
                ["Decay"] = true
            })
            v19.Transparency = 1
            task.wait(0.75)
            v19:Destroy()
        end
    end
}