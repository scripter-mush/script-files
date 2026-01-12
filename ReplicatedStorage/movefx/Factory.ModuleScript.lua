local v_u_3 = setmetatable({}, {
    ["__index"] = function(p1, p2)
        if p2 ~= "base" then
            return p1.base[p2]
        end
    end
})
local v_u_4 = game:GetService("Debris")
function v_u_3.Part(_, p5)
    local v6 = Instance.new("Part")
    v6.Parent = workspace.Projectiles
    v6.TopSurface = Enum.SurfaceType.SmoothNoOutlines
    v6.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
    v6.CanCollide = false
    v6.Massless = true
    for v7, v8 in pairs(p5) do
        v6[v7] = v8
    end
    return v6
end
function v_u_3.Projectile(_, p9, p10)
    local v11 = Instance.new("Part")
    v11.Parent = workspace.Projectiles
    v11.TopSurface = Enum.SurfaceType.SmoothNoOutlines
    v11.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
    v11.CanCollide = false
    v11.Massless = true
    for v12, v13 in pairs(p9) do
        v11[v12] = v13
    end
    game.Debris:AddItem(v11, p10 or 1)
    return v11, v_u_3:Velocity({
        ["Target"] = v11
    })
end
function v_u_3.Cylinder(_, p14)
    local v15 = v_u_3:Part(p14)
    local v16 = Instance.new("CylinderMesh")
    v16.Parent = v15
    return v15, v16
end
function v_u_3.Sphere(_, p17)
    local v18 = v_u_3:Part(p17)
    local v19 = Instance.new("SpecialMesh")
    v19.MeshType = Enum.MeshType.Sphere
    v19.Parent = v18
    return v18, v19
end
function v_u_3.Sound(_, p20)
    local v_u_21 = Instance.new("Sound")
    v_u_21.Parent = p20.Target or (p20.Part or workspace)
    v_u_21.Pitch = p20.Pitch or 1
    v_u_21.Volume = p20.Volume or 1
    v_u_21.Looped = p20.Looped
    v_u_21.TimePosition = p20.TimePosition or 0
    v_u_21.SoundId = "rbxassetid://" .. p20.Id
    v_u_21:Play()
    if p20.Duration then
        v_u_4:AddItem(v_u_21, p20.Duration)
        if p20.Fade or p20.Expire then
            task.delay(p20.Duration - 0.5, function()
                local v22 = {
                    ["Target"] = v_u_21,
                    ["Goal"] = {
                        ["Volume"] = 0
                    },
                    ["Time"] = 0.5
                }
                v_u_3:Tween(v22)
            end)
            return v_u_21
        end
    elseif not p20.Remain then
        v_u_4:AddItem(v_u_21, p20.TimeLength)
    end
    return v_u_21
end
function v_u_3.AngularVelocity(_, p23)
    local v24 = p23.Target
    local v25 = p23.Velocity or Vector3.new(0, 0, 0)
    local v26 = p23.Duration
    local v27 = Instance.new("BodyAngularVelocity")
    v27.MaxTorque = Vector3.new(inf, inf, inf)
    v27.AngularVelocity = v25
    v27.Parent = v24
    if v26 then
        v_u_4:AddItem(v27, v26)
    end
    return v27
end
function v_u_3.Velocity(_, p28)
    local v_u_29 = p28.Target
    local v30 = p28.Velocity or Vector3.new(0, 0, 0)
    local v31 = p28.Duration
    local v32 = p28.Name
    local v33 = Instance.new("BodyVelocity")
    v33.MaxForce = Vector3.new(10000000, 10000000, 10000000)
    v33.Velocity = v30
    v33.Parent = v_u_29
    if v32 then
        v33.Name = v32
    end
    if v31 then
        v_u_4:AddItem(v33, v31)
    end
    local v_u_34 = v_u_29:FindFirstChild("NetworkOwner")
    if v_u_34 and v_u_34.Value then
        v33.AncestryChanged:Connect(function()
            if v_u_29:IsDescendantOf(workspace) then
                v_u_29:SetNetworkOwner(v_u_34.Value)
            end
        end)
        if v_u_29:IsDescendantOf(workspace) then
            v_u_29:SetNetworkOwner(v_u_34.Value)
        end
    end
    return v33
end
function v_u_3.FakeAnchor(_, p35)
    local v36 = Instance.new("BodyVelocity")
    v36.MaxForce = Vector3.new(inf, inf, inf)
    v36.Velocity = Vector3.new(0, 0, 0)
    v36.Parent = p35
    return v36
end
function v_u_3.Light(_, p37)
    local v38 = Instance.new("PointLight")
    for v39, v40 in pairs(p37) do
        v38[v39] = v40
    end
    return v38
end
function v_u_3.Kindle(_, p41)
    local v_u_42 = Instance.new("PointLight")
    v_u_42.Color = p41.Color or Color3.new(1, 1, 1)
    v_u_42.Brightness = p41.Brightness or 0
    v_u_42.Range = p41.Range or 0
    local v43 = p41.Duration or 1
    local v_u_44 = p41.Span or 0
    if p41.Position then
        local v45 = v_u_3:Part({
            ["Transparency"] = 1,
            ["Anchored"] = true,
            ["Size"] = Vector3.new()
        })
        game.Debris:AddItem(v45, v43)
        v_u_42.Parent = v45
    else
        v_u_42.Parent = p41.Target or (p41.Parent or p41.Part)
        game.Debris:AddItem(v_u_42, v43)
    end
    local v46 = p41.Shine or 2
    local v47 = p41.Spread or 16
    local v_u_48 = (v43 - v_u_44) / 2
    v_u_3:Tween({
        ["Target"] = v_u_42,
        ["Goal"] = {
            ["Brightness"] = v46,
            ["Range"] = v47
        },
        ["Time"] = v_u_48
    }).Completed:Connect(function()
        if v_u_44 then
            task.wait(v_u_44)
        end
        local v49 = {
            ["Target"] = v_u_42,
            ["Goal"] = {
                ["Brightness"] = 0,
                ["Range"] = 0
            },
            ["Time"] = v_u_48
        }
        v_u_3:Tween(v49)
    end)
    return v_u_42
end
local v_u_50 = workspace.StreamingEnabled
local v_u_51 = game.ReplicatedStorage.Models.Particles
function v_u_3.EmitSet(_, p52)
    local v53 = p52.Position or p52.CFrame
    local v54 = p52.Folder
    local _ = p52.ParticleId
    local v55 = p52.Follow
    local v56 = (v54 and v_u_51:FindFirstChild(v54) or v_u_51):FindFirstChild(p52.ParticleId)
    if p52.Burst then
        p52.Duration = 0.1
        p52.Rate = p52.Rate or 1
        p52.Decay = true
    end
    if v56 then
        p52.Ancestor = v56
        local v57 = p52.Duration
        local v58
        if v53 then
            v58 = Instance.new("Part")
            v58.Anchored = true
            v58.CanCollide = false
            v58.Size = Vector3.new(0, 0, 0)
            v58.CFrame = typeof(v53) == "CFrame" and v53 and v53 or CFrame.new(v53)
            v58.Parent = workspace.Projectiles
            p52.Target = v58
            p52.Position = nil
            if v57 then
                v_u_4:AddItem(v58, v57)
            end
            if v55 then
                v58.Anchored = false
                v_u_3:FollowPart({
                    ["Follower"] = v58,
                    ["FollowTo"] = v55,
                    ["Rigid"] = true
                })
                p52.Follow = nil
            end
        else
            v58 = nil
        end
        if v53 then
            v53 = not v57
        end
        local v59 = p52.Lifetime
        local v60 = p52.TimeScale
        local v61 = {}
        for _, v62 in pairs(v56:GetChildren()) do
            if v53 then
                local v63 = v60 or v62.TimeScale
                local v64 = (v59 or v62.Lifetime.Max) / v63
                v57 = math.max(v57 or 0, v64)
            end
            p52.ParticleId = v62.Name
            local v65 = v_u_3
            table.insert(v61, v65:Emit(p52))
        end
        if v53 then
            if v_u_50 then
                v57 = v57 + 0.3
            end
            v_u_4:AddItem(v58, v57)
        end
        return v58 or v61, v61
    end
    warn("missing particle folder", p52.ParticleId)
end
function v_u_3.Emit(_, p_u_66)
    local v67 = p_u_66.Position
    local v68 = p_u_66.CFrame
    local v69 = p_u_66.Folder
    local v70 = p_u_66.Follow
    local v71 = p_u_66.ParticleId
    if typeof(v71) == "table" then
        local v72 = {}
        if v67 or v68 then
            local v73 = Instance.new("Part")
            v73.Anchored = true
            v73.CanCollide = false
            v73.Size = Vector3.new(0, 0, 0)
            v73.CFrame = v68 or CFrame.new(v67)
            v73.Parent = workspace.Projectiles
            p_u_66.Target = v73
            p_u_66.Position = nil
            v_u_4:AddItem(v73, p_u_66.Duration)
        end
        for _, v74 in pairs(v71) do
            p_u_66.ParticleId = v74
            local v75 = v_u_3
            table.insert(v72, v75:Emit(p_u_66))
        end
        return v72
    end
    local v76 = p_u_66.Ancestor
    local v77
    if v76 then
        v77 = v76:FindFirstChild(v71)
    elseif v69 then
        v77 = v_u_51[v69]:FindFirstChild(v71)
    else
        v77 = v_u_51:FindFirstChild(v71)
    end
    if v77 then
        local v_u_78
        if v67 or v68 then
            local v79 = Instance.new("Part")
            v79.Anchored = true
            v79.CanCollide = false
            v79.Size = Vector3.new(0, 0, 0)
            v79.CFrame = v68 or CFrame.new(v67)
            v79.Parent = workspace.Projectiles
            v_u_78 = v79
            if p_u_66.CreateAttachment then
                local v80 = Instance.new("Attachment")
                v80.Name = "ParticleAttachment"
                v80.Parent = v79
            end
        else
            v_u_78 = nil
        end
        local v_u_81 = v77:Clone()
        v_u_81.Parent = p_u_66.Target or (v_u_78:FindFirstChild("ParticleAttachment") or v_u_78)
        if not v67 and (not v68 and p_u_66.Target) then
            v_u_78 = v_u_81
        end
        if p_u_66.PartLocked then
            v_u_81.LockedToPart = true
        elseif p_u_66.PartUnlocked then
            v_u_81.LockedToPart = false
        end
        if p_u_66.TimeScale then
            v_u_81.TimeScale = p_u_66.TimeScale
        end
        local v82 = p_u_66.Speed
        if p_u_66.Speed then
            local v83 = v_u_81.Speed
            v_u_81.Speed = NumberRange.new(v83.Min * v82, v83.Max * v82)
        end
        local v84 = p_u_66.Lifetime
        if v84 then
            local v85 = v_u_81.Lifetime
            v_u_81.Lifetime = NumberRange.new(v85.Min / v85.Max * v84, v84)
        end
        local v86 = p_u_66.PlaybackSpeed
        if v86 then
            local v87 = v_u_81.Lifetime
            v_u_81.Lifetime = NumberRange.new(v87.Min * v86, v87.Max * v86)
        end
        local v_u_88 = v_u_81.Lifetime.Max / v_u_81.TimeScale
        local v_u_89 = p_u_66.Enabled
        if v_u_89 ~= nil then
            v_u_81.Enabled = v_u_89
        end
        if p_u_66.Rate then
            local v_u_90 = p_u_66.Rate
            local v_u_91 = p_u_66.Duration
            local function v92()
                if p_u_66.Emit ~= false then
                    v_u_81:Emit(v_u_90)
                end
                if not v_u_91 then
                    v_u_81.Enabled = v_u_89
                    v_u_4:AddItem(v_u_78, v_u_88)
                end
            end
            if v_u_50 then
                task.delay(0.1, v92)
            else
                if p_u_66.Emit ~= false then
                    v_u_81:Emit(v_u_90)
                end
                if not v_u_91 then
                    v_u_81.Enabled = v_u_89
                    v_u_4:AddItem(v_u_78, v_u_88)
                end
            end
        end
        local v93 = p_u_66.Scale
        if v93 then
            local v94 = {}
            for _, v95 in pairs(v_u_81.Size.Keypoints) do
                local v96 = NumberSequenceKeypoint.new
                local v97 = v95.Time
                local v98 = v95.Value * v93
                table.insert(v94, v96(v97, v98))
            end
            v_u_81.Size = NumberSequence.new(v94)
        end
        if p_u_66.Color then
            v_u_81.Color = ColorSequence.new(p_u_66.Color)
            if p_u_66.Color == Color3.new() then
                v_u_81.LightEmission = 0
                v_u_81.LightInfluence = v_u_81.LightInfluence / 10
            end
        end
        if p_u_66.Duration then
            if p_u_66.Decay then
                v_u_4:AddItem(v_u_78, p_u_66.Duration + v_u_88)
                v_u_3:Tween({
                    ["Target"] = v_u_81,
                    ["Goal"] = {
                        ["Rate"] = 0
                    },
                    ["Style"] = Enum.EasingStyle.Exponential,
                    ["Direction"] = Enum.EasingDirection.In,
                    ["Time"] = p_u_66.Duration
                })
            else
                v_u_4:AddItem(v_u_78, p_u_66.Duration)
                if p_u_66.Expire then
                    v_u_3:Tween({
                        ["Target"] = v_u_81,
                        ["Goal"] = {
                            ["Rate"] = 0
                        },
                        ["Time"] = p_u_66.Duration - v_u_88
                    })
                end
            end
        end
        if v70 then
            v_u_78.Anchored = false
            v_u_3:FollowPart({
                ["Follower"] = v_u_81.Parent,
                ["FollowTo"] = v70,
                ["Rigid"] = true
            })
            p_u_66.Follow = nil
        end
        return v_u_81
    end
end
function v_u_3.Mesh(_, p99)
    local v100 = Instance.new("SpecialMesh")
    v100.Parent = p99.Part or (p99.Parent or p99.Target)
    v100.Scale = p99.Scale or (v100.Parent.Size or Vector3.new(1, 1, 1))
    v100.MeshId = "rbxassetid://" .. (p99.MeshId or 0)
    v100.TextureId = p99.TextureId and "rbxassetid://" .. p99.TextureId or ""
    return v100
end
function v_u_3.Attachment(_, p101)
    local v102 = p101.Target
    if v102:IsA("Attachment") then
        warn("Duped into attachment!", v102)
        return v102
    end
    local v103 = p101.Name or "NeutralAttachment"
    local v104 = v102:FindFirstChild(v103)
    if p101.Overlap or not v104 then
        v104 = Instance.new("Attachment")
        v104.Name = p101.Overlap and "CommonAttachment" or v103
        v104.Parent = v102
        v104.Position = p101.Position or v104.Position
    end
    return v104
end
function v_u_3.Beam(_, p_u_105)
    local v106 = p_u_105.Part
    local v107 = p_u_105.Target or v106
    local v108 = p_u_105.Range
    local v109 = p_u_105.Position or Vector3.new(0, 0, 0)
    local v110 = p_u_105.Position0 or v109
    local v111 = p_u_105.Position1 or v109
    if v108 then
        v110 = v110 + v108
        v111 = v111 - v108
    end
    local v112 = p_u_105.Attachment0 or v_u_3:Attachment({
        ["Target"] = v106,
        ["Position"] = v110,
        ["Overlap"] = true
    })
    local v113 = p_u_105.Attachment1 or v_u_3:Attachment({
        ["Target"] = v107,
        ["Position"] = v111,
        ["Overlap"] = true
    })
    local v_u_114 = game.ReplicatedStorage.Models.Beams:FindFirstChild(p_u_105.BeamId):Clone()
    v_u_114.Parent = v106
    v_u_114.Attachment0 = v112
    v_u_114.Attachment1 = v113
    if p_u_105.Duration then
        v_u_4:AddItem(v_u_114, p_u_105.Duration)
        if p_u_105.Expire then
            spawn(function()
                wait(p_u_105.Duration - 0.5)
                local v115 = {
                    ["Target"] = v_u_114,
                    ["Goal"] = {
                        ["Lifetime"] = 0
                    },
                    ["Time"] = 0.5
                }
                v_u_3:Tween(v115)
            end)
        end
    end
    return v_u_114
end
function v_u_3.Ring(_, p116)
    local v_u_117 = v_u_3:Beam(p116)
    p116.Attachment0 = v_u_117.Attachment0
    p116.Attachment1 = v_u_117.Attachment1
    local v_u_118 = v_u_3:Beam(p116)
    local v_u_119 = p116.Range
    local v_u_120 = p116.Position
    local v121 = 0.25 + v_u_119.magnitude * 1.35
    v_u_117.CurveSize0 = v121
    v_u_117.CurveSize1 = -v121
    v_u_118.CurveSize0 = -v121
    v_u_118.CurveSize1 = v121
    local v_u_125 = {
        ["beam0"] = v_u_117,
        ["beam1"] = v_u_118,
        ["Destroy"] = function(_)
            v_u_117:Destroy()
            v_u_118:Destroy()
        end,
        ["Update"] = function(_)
            v_u_117.Attachment0.Position = v_u_120 + v_u_119
            v_u_117.Attachment1.Position = v_u_120 - v_u_119
        end,
        ["Move"] = function(_, p122, p123)
            if p122 then
                v_u_120 = p122
            end
            if p123 then
                v_u_119 = v_u_120
                local v124 = 0.25 + v_u_119.magnitude * 1.35
                v_u_117.CurveSize0 = v124
                v_u_117.CurveSize1 = -v124
                v_u_118.CurveSize0 = -v124
                v_u_118.CurveSize1 = v124
            end
            v_u_125:Update()
        end
    }
    return v_u_125
end
function v_u_3.Trail(_, p_u_126)
    local v127 = p_u_126.Target
    local v128 = p_u_126.Range
    local v129 = p_u_126.Base or Vector3.new(0, 0, 0)
    local v130 = p_u_126.TrailId or "Slash"
    local v131 = p_u_126.Position0 or v129
    local v132 = p_u_126.Position1 or v129
    if v128 then
        v131 = v131 + v128
        v132 = v132 - v128
    end
    local v133 = p_u_126.Attachment0 or v_u_3:Attachment({
        ["Target"] = v127,
        ["Position"] = v131,
        ["Overlap"] = true
    })
    local v134 = p_u_126.Attachment1 or v_u_3:Attachment({
        ["Target"] = v127,
        ["Position"] = v132,
        ["Overlap"] = true
    })
    local v_u_135 = game.ReplicatedStorage.Models.Trails:FindFirstChild(v130):Clone()
    v_u_135.Parent = v127
    v_u_135.Attachment0 = v133
    v_u_135.Attachment1 = v134
    local v136 = p_u_126.Color
    if v136 then
        v_u_135.Color = typeof(v136) == "ColorSequence" and v136 and v136 or ColorSequence.new(v136)
    end
    if p_u_126.Duration then
        v_u_4:AddItem(v_u_135, p_u_126.Duration)
        if p_u_126.Expire then
            task.spawn(function()
                task.wait(p_u_126.Duration - 0.5)
                local v137 = {
                    ["Target"] = v_u_135,
                    ["Goal"] = {
                        ["Lifetime"] = 0
                    },
                    ["Time"] = 0.5
                }
                v_u_3:Tween(v137)
            end)
        end
    end
    return v_u_135
end
function v_u_3.AttachmentCurve(_, p138)
    local v139 = p138.Part
    local v140 = p138.Steepness or v139.Size.Z
    local v141 = p138.Count
    local v142 = v139.Size.X
    local v143 = v139.Size.Z / 2
    local _ = v139.CFrame
    local v144 = v142 / v141
    local _ = math.sin
    local v145 = {}
    for v146 = 0, v141 do
        local v147 = v146 * v144 - v142 / 2
        local v148 = v140 * 2
        local v149 = v147 / v142
        local v150 = v148 * (0.5 - math.abs(v149) ^ 2.25)
        local v151 = v_u_3
        local v152 = {
            ["Target"] = v139,
            ["Name"] = "SwingCurve" .. v146
        }
        local v153 = -v150 + v143
        v152.Position = Vector3.new(v147, 0, v153)
        local v154 = v151:Attachment(v152)
        table.insert(v145, v154)
    end
    return v145
end
function v_u_3.CurvedTrail(_, p155)
    local v156 = p155.Color
    local v157 = v_u_3:AttachmentCurve(p155)
    for v158 = 1, #v157 - 1 do
        local v159 = v157[v158]
        local v160 = v157[v158 + 1]
        local v161 = v_u_3:Trail({
            ["Target"] = p155.Part,
            ["TrailId"] = p155.TrailId,
            ["Attachment0"] = v159,
            ["Attachment1"] = v160
        })
        if v156 then
            v161.Color = v156
        end
    end
end
function v_u_3.RigidFollow(_, p162)
    local v163 = p162.Part
    local v164 = p162.Target
    local v165 = Instance.new("RigidConstraint")
    v165.Attachment0 = p162.Attachment0 or v_u_3:Attachment({
        ["Target"] = v163,
        ["Name"] = p162.Name,
        ["Overlap"] = p162.Overlap
    })
    if v163 and v163.Anchored then
        v165.Parent = v163
        return v165
    end
    v165.Attachment1 = p162.Attachment1 or v_u_3:Attachment({
        ["Target"] = v164,
        ["Name"] = p162.Name,
        ["Overlap"] = p162.Overlap
    })
    v165.Parent = v163 or p162.Attachment0
    if p162.Duration then
        v_u_3:Debris(v165, p162.Duration)
    end
    return v165
end
function v_u_3.Follow(_, p166)
    local v167 = v_u_3:FollowPart(p166)
    local v168 = v_u_3:FollowPartAxis(p166)
    if p166.Offset then
        p166.Part.CFrame = p166.Target.CFrame - p166.Offset
    end
    if p166.CFrame and not p166.Part.Anchored then
        for _, v169 in pairs({ v167, v168 }) do
            v169.Attachment0.CFrame = p166.CFrame
        end
    end
    return v167, v168
end
function v_u_3.FollowPart(_, p170)
    local v171 = p170.Target
    local v172 = p170.Part
    local v173 = p170.AttachmentName or p170.Name
    local v174 = p170.Duration
    local v175 = Instance.new("AlignPosition")
    local v176 = v172:IsA("Attachment")
    if p170.MoverName then
        v175.Name = p170.MoverName
    end
    if v174 then
        game.Debris:AddItem(v175, v174)
    end
    v175.Attachment0 = v176 and v172 and v172 or (p170.Attachment0 or v_u_3:Attachment({
        ["Name"] = v173,
        ["Target"] = v172,
        ["Position"] = p170.Offset
    }))
    if v171 then
        v175.Attachment1 = v171:IsA("Attachment") and v171 and v171 or (p170.Attachment1 or v_u_3:Attachment({
            ["Name"] = v173,
            ["Target"] = v171
        }))
    end
    v175.Responsiveness = p170.Loose and 100 or 200
    v175.MaxForce = 90000000
    v175.MaxVelocity = (1 / 0)
    if p170.Rigid then
        v175.RigidityEnabled = true
    elseif v171 and not v172.Anchored then
        v172.CFrame = v171.CFrame
    end
    if v176 then
        v172 = v172.Parent or v172
    end
    v175.Parent = v172
    return v175
end
function v_u_3.FollowPartAxis(_, p177)
    local v178 = p177.Target
    local v179 = p177.Part
    local v180 = p177.AttachmentName or p177.Name
    local v181 = Instance.new("AlignOrientation")
    if p177.MoverName then
        v181.Name = p177.MoverName
    end
    if p177.Duration then
        game.Debris:AddItem(v181, p177.Duration)
    end
    v181.Attachment0 = p177.Attachment0 or v_u_3:Attachment({
        ["Name"] = v180,
        ["Target"] = v179
    })
    v181.Attachment1 = p177.Attachment1 or v_u_3:Attachment({
        ["Name"] = v180,
        ["Target"] = v178
    })
    v181.Responsiveness = p177.Loose and 100 or 200
    v181.MaxTorque = 9000000
    v181.MaxAngularVelocity = (1 / 0)
    if p177.Rigid then
        v181.RigidityEnabled = true
    elseif v178 and not v179.Anchored then
        v179.CFrame = v178.CFrame
    end
    v181.Parent = v179
    return v181
end
function v_u_3.Weld(_, p182)
    local v183 = p182.Root or p182.Part
    local v184 = p182.Target
    local v185 = p182.Offset
    local v186 = Instance.new("ManualWeld")
    v186.Parent = v184
    v186.C0 = v185 or CFrame.new(0, 0, 0)
    v186.Part0 = v183
    v186.Part1 = v184
    return v186
end
function v_u_3.FollowWeld(_, p187, p188, p189)
    p187.Massless = false
    p188.Massless = true
    if not p189 then
        p188.CFrame = p187.CFrame
    end
    local v190 = Instance.new("WeldConstraint")
    v190.Part0 = p187
    v190.Part1 = p188
    v190.Parent = p188
    return v190
end
function v_u_3.RootSelf(_, p191)
    local v192 = v_u_3:Velocity(p191)
    local v193 = p191.Target
    if p191.Anchor then
        local v194 = v_u_3
        local v195 = {
            ["Target"] = v193,
            ["Goal"] = {
                ["CFrame"] = v193.CFrame + Vector3.new(0, 0.1, 0)
            }
        }
        local v196 = p191.Anchor
        v195.Time = tonumber(v196) or p191.Duration
        v194:Tween(v195)
    end
    return v192
end
function v_u_3.HitBox(_, p197)
    local v198 = p197.PartData or {
        ["Shape"] = Enum.PartType.Ball
    }
    v198.Anchored = false
    v198.CanCollide = false
    v198.Massless = true
    v198.Transparency = 1
    v198.Material = Enum.Material.Neon
    local v199 = p197.Position or (v198.Position or Vector3.new(0, 0, 0))
    local v200 = p197.Size or 1
    v198.Size = (p197.Form or Vector3.new(1, 1, 1)) * v200
    local v201 = v_u_3:Part(v198)
    local v202 = p197.Follow
    if v202 then
        v_u_3:Follow({
            ["Target"] = v202,
            ["Part"] = v201
        })
        v_u_3:Tween({
            ["Target"] = v201,
            ["Goal"] = {
                ["CFrame"] = v202.CFrame
            },
            ["Time"] = 0.022222222222222223
        })
    elseif not p197.Custom then
        v201.CFrame = CFrame.new(v199)
        v_u_3:FakeAnchor(v201)
    end
    if p197.Lifetime then
        v_u_4:AddItem(v201, p197.Lifetime)
    end
    if _G.HitboxShow then
        v201.Transparency = 0.5
    end
    return v201
end
function v_u_3.GhostPart(_, p203)
    local v204 = p203.Target
    local v205 = p203.Parent or workspace.Projectiles
    local v206 = p203.Duration
    local v207 = p203.Scale or 1
    local v208 = p203.Color or Color3.new(1, 1, 1)
    local v209 = p203.Transparency or 0.5
    local v210 = v204:Clone()
    local v211 = v210:FindFirstChildOfClass("SpecialMesh")
    if v211 then
        v211.Parent = v210.Parent
        v210:ClearAllChildren()
        v211.Parent = v210
        v211.TextureId = ""
    else
        v210:ClearAllChildren()
    end
    v210.Material = p203.Material or Enum.Material.Neon
    v210.Color = v208
    v210.Transparency = v209
    v210.Anchored = true
    v210.CanCollide = false
    v210.Massless = true
    v210.Size = v204.Size * v207
    v210.CFrame = v204.CFrame
    v210.Parent = v205
    if v206 then
        v_u_3:Tween({
            ["Target"] = v210,
            ["Time"] = v206
        })
        v_u_4:AddItem(v210, v206)
    end
    return v210
end
function v_u_3.GhostCharacter(_, p212)
    local v213 = p212.Duration
    local v214 = p212.Character
    local v215 = p212.Transparency or 0
    local v216 = p212.Scale
    local v217 = p212.Color
    local v218 = p212.Material
    local v219 = Instance.new("Model")
    v219.Parent = workspace.Projectiles
    game.Debris:AddItem(v219, v213)
    local v220 = {}
    for _, v221 in pairs(v214:GetChildren()) do
        if v221:IsA("BasePart") and v221.Transparency < 1 then
            local v222 = v_u_3
            table.insert(v220, v222:GhostPart({
                ["Target"] = v221,
                ["Duration"] = v213,
                ["Color"] = v217,
                ["Scale"] = v216,
                ["Material"] = v218,
                ["Parent"] = v219,
                ["Transparency"] = v215
            }))
        end
    end
    return v220
end
return v_u_3