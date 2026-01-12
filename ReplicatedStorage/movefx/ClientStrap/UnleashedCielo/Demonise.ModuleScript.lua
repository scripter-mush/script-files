return {
    ["Fire"] = function(p1, ...)
        local v_u_2 = p1.fx
        local v3 = ...
        local v4 = v3.PrimaryPart
        local v5 = v_u_2:Attachment({
            ["Target"] = v4
        })
        v_u_2:Sound({
            ["Id"] = 9065783664,
            ["Target"] = v4,
            ["Pitch"] = 0.94
        })
        local v6 = v_u_2:Part({
            ["Size"] = Vector3.new(0, 0, 0)
        })
        local v7 = v_u_2:Mesh({
            ["Target"] = v6,
            ["MeshId"] = 7769957857,
            ["TextureId"] = 14356042062,
            ["Scale"] = Vector3.new(1, 1.161, 2.442)
        })
        local v8 = v_u_2:Attachment({
            ["Target"] = v6
        })
        v_u_2:RigidFollow({
            ["Attachment0"] = v8,
            ["Attachment1"] = v5
        })
        local v9 = {
            ["Target"] = v8,
            ["Goal"] = {
                ["CFrame"] = v8.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            },
            ["Style"] = Enum.EasingStyle.Linear,
            ["RepeatCount"] = 4,
            ["Time"] = 1
        }
        v_u_2:Tween(v9)
        local v10 = {
            ["Target"] = v7,
            ["Goal"] = {
                ["Scale"] = v7.Scale * 1.4
            },
            ["Style"] = Enum.EasingStyle.Cubic,
            ["Direction"] = Enum.EasingDirection.InOut,
            ["Reverses"] = true,
            ["RepeatCount"] = 5,
            ["Time"] = 3.1
        }
        v_u_2:Tween(v10)
        v_u_2:Tween({
            ["Target"] = v6,
            ["Direction"] = Enum.EasingDirection.In,
            ["Time"] = 31
        })
        local v11 = v_u_2:Part({
            ["Size"] = Vector3.new(0, 0, 0)
        })
        v_u_2:Mesh({
            ["Target"] = v11,
            ["MeshId"] = 7669486470,
            ["Scale"] = Vector3.new(6, 2, 6) / Vector3.new(4, 2, 4)
        })
        local v12 = v_u_2:Attachment({
            ["Target"] = v11,
            ["Position"] = Vector3.new(0, 1, 0) * v4.Size.Y
        })
        v_u_2:RigidFollow({
            ["Attachment0"] = v12,
            ["Attachment1"] = v5
        })
        local v13 = {
            ["Target"] = v12,
            ["Goal"] = {
                ["CFrame"] = v12.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            },
            ["Style"] = Enum.EasingStyle.Linear,
            ["RepeatCount"] = 3,
            ["Time"] = 1
        }
        v_u_2:Tween(v13)
        v_u_2:Tween({
            ["Target"] = v11,
            ["Direction"] = Enum.EasingDirection.In,
            ["Time"] = 3
        })
        local v14 = v_u_2:Part({
            ["Size"] = Vector3.new(0, 0, 0)
        })
        local v15 = v_u_2:Mesh({
            ["Target"] = v14,
            ["MeshId"] = 6065944963,
            ["Scale"] = Vector3.new(4, 4, 4)
        })
        local v16 = v_u_2:Attachment({
            ["Target"] = v14
        })
        v_u_2:RigidFollow({
            ["Attachment0"] = v16,
            ["Attachment1"] = v5
        })
        local v17 = {
            ["Target"] = v16,
            ["Goal"] = {
                ["CFrame"] = v16.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            },
            ["Style"] = Enum.EasingStyle.Linear,
            ["Time"] = 1
        }
        v_u_2:Tween(v17)
        local v18 = {
            ["Target"] = v15,
            ["Goal"] = {
                ["Scale"] = v15.Scale * 3
            }
        }
        v_u_2:Tween(v18)
        v_u_2:Tween({
            ["Target"] = v14,
            ["Direction"] = Enum.EasingDirection.In
        })
        local v19 = v_u_2:Part({
            ["Size"] = Vector3.new(0, 0, 0)
        })
        local v20 = v_u_2:Mesh({
            ["Target"] = v19,
            ["MeshId"] = 13515364746,
            ["Scale"] = Vector3.new(6, 1, 6)
        })
        local v21 = v_u_2:Attachment({
            ["Target"] = v19,
            ["Position"] = Vector3.new(0, 1, 0) * v4.Size.Y * 1.45
        })
        v_u_2:RigidFollow({
            ["Attachment0"] = v21,
            ["Attachment1"] = v5
        })
        local v22 = {
            ["Target"] = v21,
            ["Goal"] = {
                ["CFrame"] = v21.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            },
            ["Style"] = Enum.EasingStyle.Linear,
            ["RepeatCount"] = 3,
            ["Time"] = 0.6666666666666666
        }
        v_u_2:Tween(v22)
        v_u_2:Tween({
            ["Target"] = v19,
            ["Direction"] = Enum.EasingDirection.In,
            ["Time"] = 2
        })
        local v23 = {
            ["Target"] = v20,
            ["Goal"] = {
                ["Scale"] = v20.Scale * 2
            },
            ["Style"] = Enum.EasingStyle.Cubic,
            ["Direction"] = Enum.EasingDirection.InOut,
            ["Reverses"] = true
        }
        v_u_2:Tween(v23)
        task.wait(0.5)
        local v24 = { v3.LeftHand, v3.RightHand }
        for v25, v26 in pairs(v24) do
            local v27 = v25 * 2 - 3
            local v28 = v26.CFrame
            local v_u_29 = script.DivineClaw:Clone()
            v_u_29.Transparency = 1
            local v30 = CFrame.Angles
            local v31 = -90 * v27
            v_u_29.CFrame = v28 * v30(0, math.rad(v31), 0) + v28.RightVector * v27 + v28.UpVector * 0.75
            v_u_29.Parent = workspace.Projectiles
            v_u_2:FollowWeld(v26, v_u_29, true)
            v_u_2:Debris(v_u_29, 31)
            task.delay(30, function()
                v_u_2:Tween({
                    ["Target"] = v_u_29
                })
            end)
            local v32 = {
                ["Target"] = v_u_29,
                ["Goal"] = {
                    ["Transparency"] = 0
                }
            }
            v_u_2:Tween(v32)
        end
        v_u_2:Sound({
            ["Id"] = 7742895970,
            ["Target"] = v4,
            ["Pitch"] = 0.65
        })
    end
}