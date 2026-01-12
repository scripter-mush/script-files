local v_u_3 = setmetatable({}, {
    ["__index"] = function(p1, p2)
        if p2 ~= "base" then
            return p1.base[p2]
        end
    end
})
function v_u_3.ScaleTool(_, p4)
    local v5 = p4.Scale
    local v6 = p4.Target
    local v7 = v6:FindFirstChild("CharacterWeld")
    local v8 = v7 and {
        ["Part0"] = v7.Part0,
        ["Part1"] = v7.Part1,
        ["C0"] = v7.C0
    } or v7
    v6.Size = v6.Size * v5
    for _, v9 in pairs(v6:GetChildren()) do
        if v9:IsA("SpecialMesh") then
            v9.Scale = v9.Scale * v5
        elseif v9:IsA("Attachment") then
            v9.Position = v9.Position * v5
        end
    end
    if v7 then
        local v10 = v7.C0
        v7.Part0 = v8.Part0
        v7.Part1 = v8.Part1
        v7.C0 = v10 - v10.p + v10.p * v5
    end
end
function v_u_3.ApplyCharacterDimensions(_, p11)
    local v12 = p11.Target
    local v13 = p11.Scale or 1
    local v14 = p11.Height or 1
    local v15 = p11.Depth or 1
    local v16 = p11.Width or 1
    local v17 = p11.Head or (v16 + v15) / 2
    local v18 = v12:FindFirstChild("BodyDepthScale")
    if not v18 then
        v18 = Instance.new("NumberValue", v12)
        v18.Name = "BodyDepthScale"
    end
    v18.Value = v15 * v13
    local v19 = v12:FindFirstChild("BodyHeightScale")
    if not v19 then
        v19 = Instance.new("NumberValue", v12)
        v19.Name = "BodyHeightScale"
    end
    v19.Value = v14 * v13
    local v20 = v12:FindFirstChild("BodyWidthScale")
    if not v20 then
        v20 = Instance.new("NumberValue", v12)
        v20.Name = "BodyWidthScale"
    end
    v20.Value = v16 * v13
    local v21 = v12:FindFirstChild("HeadScale")
    if not v21 then
        v21 = Instance.new("NumberValue", v12)
        v21.Name = "HeadScale"
    end
    v21.Value = v17 * v13
end
function v_u_3.IncrementCharacterDimensions(_, p22)
    local v23 = p22.Target
    local v24 = p22.Scale or 0.2
    local v25 = v23:FindFirstChild("BodyDepthScale")
    if not v25 then
        v25 = Instance.new("NumberValue", v23)
        v25.Name = "BodyDepthScale"
        v25.Value = 1
    end
    local v26 = v25.Value + v24
    v25.Value = math.min(5, v26)
    local v27 = v23:FindFirstChild("BodyHeightScale")
    if not v27 then
        v27 = Instance.new("NumberValue", v23)
        v27.Name = "BodyHeightScale"
        v27.Value = 1
    end
    local v28 = v27.Value + v24
    v27.Value = math.min(5, v28)
    local v29 = v23:FindFirstChild("BodyWidthScale")
    if not v29 then
        v29 = Instance.new("NumberValue", v23)
        v29.Name = "BodyWidthScale"
        v29.Value = 1
    end
    local v30 = v29.Value + v24
    v29.Value = math.min(5, v30)
    local v31 = v23:FindFirstChild("HeadScale")
    if not v31 then
        v31 = Instance.new("NumberValue", v23)
        v31.Name = "HeadScale"
        v31.Value = 1
    end
    local v32 = v31.Value + v24
    v31.Value = math.min(5, v32)
    local v33 = v23.Parent:FindFirstChild("Equipment")
    if v33 then
        for _, v34 in pairs(v33:GetChildren()) do
            local v35 = v34:GetAttribute("BaseSize") or v34.Size
            local v36 = v24 + (v34:GetAttribute("Scale") or 1)
            local v37 = math.min(5, v36)
            v34.Size = v35 * v37
            v34:SetAttribute("BaseSize", v35)
            v34:SetAttribute("Scale", v37)
            for _, v38 in pairs(v34:GetDescendants()) do
                if v38:IsA("SpecialMesh") then
                    local v39 = v38:GetAttribute("BaseMesh") or v38.Scale
                    local v40 = v38:GetAttribute("BaseOffset") or v38.Offset
                    v38.Scale = v39 * v37
                    v38.Offset = v40 * v37
                    v38:SetAttribute("BaseMesh", v39)
                    v38:SetAttribute("BaseOffset", v40)
                end
            end
        end
    end
end
function v_u_3.Stealth(_, p41, p42)
    local v43 = p41.HumanoidRootPart
    for _, v44 in pairs(p41:GetDescendants()) do
        if (v44:IsA("BasePart") or v44:IsA("Decal")) and v44 ~= v43 then
            if not v44:GetAttribute("BaseTransparency") then
                v44:SetAttribute("BaseTransparency", v44.Transparency)
            end
            v_u_3:Tween({
                ["Target"] = v44,
                ["Time"] = p42
            })
        end
    end
end
function v_u_3.Unstealth(_, p45, p46)
    local v47 = p45.HumanoidRootPart
    for _, v48 in pairs(p45:GetDescendants()) do
        if (v48:IsA("BasePart") or v48:IsA("Decal")) and v48 ~= v47 then
            v_u_3:Tween({
                ["Target"] = v48,
                ["Goal"] = {
                    ["Transparency"] = v48:GetAttribute("BaseTransparency") or 0
                },
                ["Time"] = p46
            })
        end
    end
    local v49 = game.Players:GetPlayerFromCharacter(p45)
    if v49 then
        v_u_3:TriggerCounterAbility({
            ["Sender"] = v49,
            ["Character"] = p45
        }, "Unstealth")
    end
end
function v_u_3.WearCostume(_, p50)
    local v51 = p50.Player
    local v52 = p50.OutfitId
    local v53 = _G.SelfCostume
    if v53 and v53[v51.UserId] then
        return
    else
        local v54 = game.ServerStorage.Costumes:FindFirstChild(v52)
        if not v51:HasAppearanceLoaded() then
            v51.CharacterAppearanceLoaded:wait()
        end
        local v55 = v51.Character
        if v54 then
            for _, v56 in pairs(v55:GetChildren()) do
                if v56:IsA("Accessory") or (v56:IsA("Shirt") or v56:IsA("Pants")) then
                    v56:Destroy()
                end
            end
            for _, v57 in pairs(v54:GetChildren()) do
                local v58 = v57:Clone()
                if v58:IsA("SpecialMesh") and v55:FindFirstChild("Head") then
                    local v59 = v55.Head:FindFirstChild("Mesh")
                    if v59 then
                        v59:Destroy()
                    end
                    v58.Parent = v55.Head
                elseif v58:IsA("Decal") and v55:FindFirstChild("Head") then
                    local v60 = v55.Head:FindFirstChildOfClass("Decal")
                    if v60 then
                        v60:Destroy()
                    end
                    v58.Parent = v55.Head
                else
                    v58.Parent = v55
                end
            end
        else
            print("No outfit found!")
        end
    end
end
local function v_u_66(p61, p62)
    local v63 = Instance.new("Part")
    v63.Name = p61.Name .. "Outline"
    local v64 = Instance.new("SpecialMesh")
    local v65 = p61:IsA("MeshPart")
    v64.MeshType = v65 and Enum.MeshType.FileMesh or Enum.MeshType.Head
    v64.MeshId = v65 and (p61.MeshId or "") or ""
    v64.Parent = v63
    v63.Size = v65 and Vector3.new(0, 0, 0) or p61.Size
    v64.Scale = -(1 / p61.Size) * p61.Size * 1.05
    v63.Orientation = p61.Orientation + Vector3.new(0, 0, 180)
    v63.CanCollide = false
    v63.CanQuery = false
    v63.CanTouch = false
    v63.CastShadow = false
    v63.Massless = true
    v63.Position = p61.Position
    v63.Color = p62
    return v63
end
local v_u_67 = {
    "HeadColor",
    "LeftArmColor",
    "LeftLegColor",
    "RightArmColor",
    "RightLegColor",
    "TorsoColor"
}
function v_u_3.OutlineCharacter(_, p68)
    local v69 = p68.Target
    local v70 = p68.Color or Color3.new(1, 1, 1)
    local v71 = p68.Material or Enum.Material.Glass
    local v72 = v69:GetChildren()
    if p68.Tag and v69:FindFirstChild(p68.Tag) then
        return false
    end
    local v73 = p68.Duration
    if game.Players.NumPlayers > 6 then
        return v73
    end
    local v74 = 0
    for _, v75 in pairs(v69:GetDescendants()) do
        if v75:IsA("MeshPart") then
            v74 = v74 + 1
            if v74 > 25 then
                return false
            end
        end
    end
    local v76 = Instance.new("Folder")
    v76.Name = "ShieldFX"
    v76.Parent = v69
    if v73 then
        game.Debris:AddItem(v76, v73)
    end
    for _, v_u_77 in ipairs(v72) do
        if v_u_77:isA("MeshPart") then
            local v_u_78 = {
                ["Material"] = v_u_77.Material,
                ["Reflectance"] = v_u_77.Reflectance
            }
            v_u_77.Material = v71
            v_u_77.Reflectance = 0.1
            local v79 = v_u_66(v_u_77, v70)
            v79.Massless = true
            if v73 then
                v_u_3:Tween({
                    ["Target"] = v79,
                    ["Direction"] = Enum.EasingDirection.In,
                    ["Style"] = Enum.EasingStyle.Quint,
                    ["Time"] = v73
                }).Completed:Connect(function()
                    v_u_77.Material = v_u_78.Material
                    v_u_77.Reflectance = v_u_78.Reflectance
                end)
            end
            local v80 = Instance.new("ManualWeld")
            v80.Parent = v79
            v80.C0 = v79.CFrame:inverse() * v_u_77.CFrame
            v80.Part0 = v79
            v80.Part1 = v_u_77
            v79.Parent = v76
        end
    end
    return v73
end
function v_u_3.ShadeCharacter(_, p81)
    local v82 = p81.Target
    local v83 = p81.Color or Color3.new(0, 0, 0)
    local v84 = p81.Duration
    local v85 = p81.Length or 1
    local v86 = v82["Body Colors"]
    local v87 = {}
    for _, v88 in pairs(v_u_67) do
        v87[v88 .. "3"] = v83
    end
    v_u_3:Tween({
        ["Target"] = v86,
        ["Goal"] = { v87 },
        ["Reverses"] = v84 and true,
        ["DelayTime"] = v84,
        ["Time"] = v85
    })
end
return v_u_3