local v_u_3 = setmetatable({}, {
    ["__index"] = function(p1, p2)
        if p2 ~= "base" then
            return p1.base[p2]
        end
    end
})
local v_u_4 = {
    ["Flux"] = BrickColor.new("Steel blue"),
    ["Haze"] = BrickColor.new("Lavender"),
    ["Strom"] = BrickColor.new("Crimson"),
    ["Helios"] = BrickColor.new("Bright yellow"),
    ["Aether"] = BrickColor.new("Neon orange"),
    ["Stratus"] = BrickColor.new("Mulberry"),
    ["Narukami"] = BrickColor.new("Sea green")
}
local v_u_5 = {
    ["Flux"] = BrickColor.new("Medium blue"),
    ["Haze"] = BrickColor.new("Lilac"),
    ["Strom"] = BrickColor.new("Bright red"),
    ["Helios"] = BrickColor.new("Daisy orange"),
    ["Aether"] = BrickColor.new("Bright orange"),
    ["Stratus"] = BrickColor.new("Eggplant"),
    ["Narukami"] = BrickColor.new("Shamrock")
}
function v_u_3.GetFlame(_, p6, p7)
    return (p7 and v_u_5[p6] or (v_u_4[p6] or BrickColor.new("Medium stone grey"))).Color
end
function v_u_3.RandomAngle(_, p8)
    local v9 = p8 or 180
    local v10 = CFrame.Angles
    local v11 = math.random() - 0.5
    local v12 = v9 * 2
    local v13 = v11 * math.rad(v12)
    local v14 = math.random() - 0.5
    local v15 = v9 * 2
    local v16 = v14 * math.rad(v15)
    local v17 = math.random() - 0.5
    local v18 = v9 * 2
    return v10(v13, v16, v17 * math.rad(v18))
end
function v_u_3.Reflect(_, p19, p20)
    return p19 - 2 * p19:Dot(p20) * p20
end
function v_u_3.cmult(_, p21, p22)
    return Color3.new(p21.R * p22, p21.G * p22, p21.B * p22)
end
function v_u_3.NearestProjectiles(_, p23, p24)
    local v25 = {}
    for _, v26 in pairs(workspace.Projectiles:GetChildren()) do
        if v26:IsA("BasePart") and (v26.Position - p23).magnitude <= p24 then
            table.insert(v25, v26)
        end
    end
    return v25
end
function v_u_3.In(_, p27, p28)
    local v29 = {}
    for v30, v31 in pairs({ p27, p28 }) do
        for v32, v33 in pairs(v31) do
            if v32 ~= "Damage" or v30 ~= 1 then
                v29[v32] = v33
            end
        end
    end
    return v29
end
function quadBezier(p34, p35, p36, p37)
    return (1 - p34) ^ 2 * p35 + 2 * (1 - p34) * p34 * p36 + p34 ^ 2 * p37
end
function v_u_3.Beizer(_, p_u_38, p39, p40, p_u_41)
    local v_u_42 = p_u_38.Parent
    v_u_3:SetNetworkOwner(v_u_42, nil)
    local v_u_43 = p_u_38.Velocity
    local v44 = v_u_43.Magnitude
    local v_u_45 = v_u_42.Position
    local v46 = CFrame.new(v_u_45, p39).LookVector
    local v_u_47 = p40 or (v_u_45 - p39).Magnitude / v44
    local v_u_48 = {
        ["Target"] = p_u_38,
        ["Goal"] = {
            ["Velocity"] = v46 * v44
        },
        ["Direction"] = Enum.EasingDirection.Out,
        ["Style"] = p_u_41,
        ["Time"] = v_u_47 * 0.475
    }
    v_u_3:Tween(v_u_48).Completed:Connect(function()
        local v49 = (v_u_45 - v_u_42.Position).Magnitude
        local v50 = v_u_45 + v_u_43.Unit * v49 * 2
        v_u_48.Goal.Velocity = CFrame.new(v_u_42.Position, v50).LookVector * v49 * 2
        v_u_3:Tween(v_u_48).Completed:Wait()
        local v51 = v_u_3
        local v52 = {
            ["Target"] = p_u_38,
            ["Goal"] = {
                ["Velocity"] = v_u_43
            },
            ["Direction"] = Enum.EasingDirection.In,
            ["Style"] = p_u_41,
            ["Time"] = v_u_47 * 0.05
        }
        v51:Tween(v52)
    end)
end
function v_u_3.GetBladeTipPosition(_, p53)
    local v54 = p53.HandleGrip.CFrame
    local v55 = p53.Size
    local v56 = v55.X
    local v57 = v55.Y
    local v58 = v55.Z
    local v59 = math.max(v56, v57, v58)
    return v54.RightVector * (v59 / 2 - 0.5)
end
function v_u_3.GetBladeTip(_, p60)
    local v61 = p60.HandleGrip.CFrame
    local v62 = p60.Size
    local v63 = v62.X
    local v64 = v62.Y
    local v65 = v62.Z
    local v66 = math.max(v63, v64, v65)
    local v67 = v_u_3:Attachment({
        ["Target"] = p60,
        ["Name"] = "BladeTipAttachment",
        ["Position"] = v61.RightVector * (v66 / 2 - 0.5)
    })
    v67.CFrame = CFrame.new(v67.Position, v67.Position + v61.LookVector)
    return v67
end
function v_u_3.BladeTrail(_, p68)
    p68.Attachment0 = v_u_3:GetBladeTip(p68.Target)
    p68.Attachment1 = p68.Target.HandleGrip
    return v_u_3:Trail(p68), p68.Attachment0
end
local v_u_69 = game["Run Service"]:IsStudio()
function v_u_3.Shapebox(_, p_u_70)
    local v_u_71 = p_u_70.Model
    local v72 = p_u_70.Target
    if v72 then
        v_u_71 = v72
    elseif v_u_71 then
        v_u_71 = v_u_71.PrimaryPart
    end
    assert(v_u_71, "no rootpart for shapebox, provide a .Target or .Model")
    local v_u_73 = v_u_71:GetAttribute("HarvestType")
    local v_u_74 = p_u_70.Position
    local v_u_75 = p_u_70.Offset or CFrame.new()
    local v_u_76 = p_u_70.Radius or v_u_71.Size.Magnitude / 2.5
    local v_u_77 = p_u_70.Length or 1
    local v_u_78 = p_u_70.HandleGrip
    local v_u_79 = p_u_70.Event
    assert(v_u_79, "event missing for shapecast")
    local v_u_80 = v_u_69
    local v_u_81 = p_u_70.Params
    local v_u_82 = p_u_70.Duration or 0
    local v_u_83 = p_u_70.Delta or 0.05
    local v_u_84 = 0
    local v_u_85 = {}
    task.spawn(function()
        while true do
            local v86 = v_u_74 or (v_u_71.CFrame * v_u_75).Position
            local v87 = p_u_70.Direction
            if v_u_78 then
                v87 = (v_u_71.CFrame * v_u_78.CFrame).RightVector
                v86 = v86 - v87 * v_u_77 / 2
            elseif not v87 then
                v87 = v_u_71.CFrame.LookVector * v_u_76 * 2
                v86 = v86 - v87 / 2
            end
            local v88 = v87 * v_u_77
            local v89 = workspace:Spherecast(v86, v_u_76, v88, v_u_81)
            if v_u_80 then
                v_u_3:Projectile({
                    ["Shape"] = Enum.PartType.Ball,
                    ["Size"] = Vector3.new(1, 1, 1) * v_u_76 * 2,
                    ["Color"] = v89 and Color3.new(1, 1, 0) or Color3.new(1, 1, 1),
                    ["Material"] = Enum.Material.Neon,
                    ["Transparency"] = 0.9
                }, 0.5).CFrame = CFrame.new(v86)
                if v89 then
                    v_u_3:Projectile({
                        ["Shape"] = Enum.PartType.Ball,
                        ["Size"] = Vector3.new(1, 1, 1) * v_u_76 * 2,
                        ["Color"] = v89 and Color3.new(1, 1, 0) or Color3.new(1, 1, 1),
                        ["Material"] = Enum.Material.Neon,
                        ["Transparency"] = 0.9
                    }, 0.5).CFrame = CFrame.new(v89.Position)
                end
                v_u_3:Projectile({
                    ["Shape"] = Enum.PartType.Ball,
                    ["Size"] = Vector3.new(1, 1, 1) * v_u_76 * 2,
                    ["Color"] = v89 and Color3.new(1, 1, 0) or Color3.new(1, 1, 1),
                    ["Material"] = Enum.Material.Neon,
                    ["Transparency"] = 0.9
                }, 0.5).CFrame = CFrame.new(v86 + v88)
            end
            local v90 = v89 and v89.Instance:FindFirstAncestorOfClass("Model")
            if v90 then
                if v_u_73 and (v90:HasTag("Harvestable") and not v_u_85[v90]) then
                    v_u_85[v90] = true
                    v_u_79(v90.PrimaryPart)
                else
                    local v91 = v90:FindFirstChild("Humanoid") and v90
                    if v91 and not v_u_85[v91] then
                        v_u_85[v91] = true
                        v_u_79(v91.PrimaryPart)
                    end
                end
            end
            v_u_84 = v_u_84 + task.wait(v_u_83)
            if v_u_82 < v_u_84 then
                return
            end
        end
    end)
end
function v_u_3.GetGround(_, p92)
    local v93 = p92.Target
    local v94 = p92.Position or v93.Position
    local v95 = p92.Vector or -v93.CFrame.UpVector * 6
    local v96 = Ray.new(v94, v95)
    local v97 = workspace
    local v98 = {}
    if v93.Parent ~= workspace then
        v93 = v93.Parent or v93
    end
    __set_list(v98, 1, {v93})
    return v97:FindPartOnRayWithIgnoreList(v96, v98)
end
function v_u_3.GetGroundPosition(_, p99)
    local v100 = p99.Target
    local v101 = p99.Position or v100.Position
    local v102 = RaycastParams.new()
    v102.FilterType = Enum.RaycastFilterType.Whitelist
    local v103 = { workspace:FindFirstChild("Map") }
    local v104 = #v103 == 0 and { workspace } or v103
    for _, v105 in pairs(p99.Filter or {}) do
        table.insert(v104, v105)
    end
    v102.FilterDescendantsInstances = v104
    local v106 = workspace:Raycast(v101, Vector3.new(0, -100, 0), v102)
    if v106 then
        return v106.Position
    end
    print("Nothing was hit!")
    return false
end
function v_u_3.GetRayResult(_, p107, p108, p109)
    local v110 = p109 or {}
    local v111 = RaycastParams.new()
    v111.FilterType = v110.FilterType or Enum.RaycastFilterType.Whitelist
    local v112 = v110.List or { workspace:FindFirstChild("Map"), workspace:FindFirstChild("CurrentMap"), workspace:FindFirstChild("TrainingMap") }
    if v110.Filter then
        for _, v113 in pairs(v110.Filter) do
            table.insert(v112, v113)
        end
    end
    v111.FilterDescendantsInstances = v112
    local v114 = workspace:Raycast(p107, p108, v111)
    if v114 then
        return v114
    end
    print("Nothing was hit!")
    return false
end
function v_u_3.GPS(_, p115)
    return v_u_3:GetGroundPosition({
        ["Position"] = p115
    }) or p115
end
return v_u_3