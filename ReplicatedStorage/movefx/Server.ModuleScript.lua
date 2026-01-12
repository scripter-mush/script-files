local v_u_3 = setmetatable({}, {
    ["__index"] = function(p1, p2)
        if p2 ~= "base" then
            return p1.base[p2]
        end
    end
})
local v_u_4 = game:GetService("PhysicsService")
local v5 = game:GetService("RunService")
local v_u_6 = game:GetService("Players")
function v_u_3.SetNetworkOwner(_, p_u_7, p_u_8)
    pcall(function()
        p_u_7:SetNetworkOwner(p_u_8)
    end)
end
function v_u_3.TagCollision(_, p9)
    local v10 = p9.Tag or "Hidden"
    for _, v11 in pairs(p9.Model) do
        if v11:IsA("BasePart") then
            v11.CollisionGroup = v10
        end
    end
end
function v_u_3.AvoidCollision(_, p12)
    local v13 = p12.Tag or "Hidden"
    local v14 = p12.OpposingTag or v13
    v_u_4:CreateCollisionGroup(v13)
    v_u_4:CollisionGroupSetCollidable(v13, v14, false)
    for _, v15 in pairs(p12.Models) do
        for _, v16 in pairs(v15) do
            if v16:IsA("BasePart") then
                v16.CollisionGroup = v13
            end
        end
    end
end
function v_u_3.TagModels(_, p17)
    local v18 = p17.Tag
    for _, v19 in pairs(p17.Models) do
        for _, v20 in pairs(v19) do
            if v20:IsA("BasePart") then
                v20.CollisionGroup = v18
            end
        end
    end
end
local v_u_21 = {
    100,
    20,
    5,
    2.5,
    1,
    0.5
}
function v_u_3.AdjustChance(_, p22)
    v_u_21 = p22
end
function v_u_3.CreateEnemyFromModel(_, p23)
    local v24 = p23.Name
    p23.CanCollide = false
    local v25 = p23:GetAttribute("Level")
    local v26 = p23:GetAttribute("Weapon")
    local v27 = p23:GetAttribute("Cubit")
    if p23:GetAttribute("Billion") then
        v25 = v25 * 1000000000
    end
    if p23:GetAttribute("Trillion") then
        v25 = v25 * 1000000000000
    end
    local v28 = p23:GetAttribute("Zeroes")
    if v28 then
        v25 = v25 * 10 ^ v28
    end
    local v29 = {
        ["Name"] = v24,
        ["Stubborn"] = p23:GetAttribute("Stubborn"),
        ["Tag"] = p23:GetAttribute("Tag"),
        ["Costume"] = p23:GetAttribute("Costume") or v24,
        ["Scale"] = p23.Size.Y / 5,
        ["CFrame"] = p23.CFrame,
        ["Moves"] = {},
        ["Morph"] = p23:GetAttribute("Morph"),
        ["HPScale"] = p23:GetAttribute("HPScale"),
        ["Informed"] = p23:GetAttribute("Informed"),
        ["Fair"] = p23:GetAttribute("Fair"),
        ["Cubit"] = v27,
        ["Ally"] = p23:GetAttribute("Ally"),
        ["Anchored"] = p23:GetAttribute("Anchored"),
        ["Level"] = v25,
        ["Gear"] = { v26 },
        ["Loot"] = {}
    }
    if p23:GetAttribute("Loot") then
        local v30 = v29.Loot
        table.insert(v30, { 5, "Equipment", v26 })
    end
    for v31 = 1, 6 do
        local v32 = p23:GetAttribute("Loot" .. v31)
        if v32 then
            local v33 = v29.Loot
            local v34 = { v_u_21[v31], "Equipment", v32 }
            table.insert(v33, v34)
        end
        if v31 < 4 then
            local v35 = p23:GetAttribute("Move" .. v31)
            if v35 then
                local v36 = v29.Moves
                table.insert(v36, v35)
            end
            local v37 = p23:GetAttribute("Weapon" .. v31)
            if v37 then
                local v38 = v29.Gear
                table.insert(v38, v37)
            end
        end
    end
    if #v29.Moves == 0 then
        local v39 = v29.Moves
        table.insert(v39, "Sword")
    end
    return v29
end
function v_u_3.UnTag(_, p40)
    v_u_4:RemoveCollisionGroup(p40)
end
function v_u_3.GetBuffs(_, p41)
    local v42 = {}
    local v43 = {}
    local v44 = {}
    local v45 = {
        ["HP"] = 0,
        ["SPD"] = 0,
        ["AD"] = 0,
        ["AS"] = 0,
        ["AP"] = 0,
        ["PD"] = 0,
        ["MR"] = 0,
        ["APEN"] = 0,
        ["MPEN"] = 0,
        ["REGEN"] = 0,
        ["HEAL"] = 0,
        ["CDR"] = 0,
        ["KB"] = 0,
        ["JP"] = 0,
        ["GROWTH"] = 0
    }
    for _, v46 in pairs(p41) do
        local v47 = v46.Stats
        local v48 = v46.Tag
        local v49 = v46.Cap
        if v49 and v48 then
            v42[v48] = v42[v48] and (v42[v48] + 1 or 1) or 1
        end
        if not v49 or (not v48 or v49 >= v42[v48]) then
            if v46.Set then
                for _, v50 in pairs(v47) do
                    local v51 = v50[1]
                    local v52 = v50[2]
                    if v43[v51] then
                        local v53 = v43[v51]
                        v52 = math.max(v53, v52) or v52
                    end
                    v43[v51] = v52
                end
            elseif v46.Multiplier then
                for _, v54 in pairs(v47) do
                    local v55 = v54[1]
                    local v56 = v54[2]
                    v44[v55] = v44[v55] and v44[v55] + v56 or 1 + v56
                end
            else
                for _, v57 in pairs(v47) do
                    local v58 = v57[1]
                    local v59 = v57[2]
                    if v45[v58] then
                        v59 = v45[v58] + v59 or v59
                    end
                    v45[v58] = v59
                end
            end
        end
    end
    return v45, v44, v43, p41
end
if v5:IsServer() then
    local v_u_60 = {}
    local v_u_61 = {}
    function v_u_3.CancelBuffs(_, p62)
        if v_u_60[p62] then
            v_u_60[p62].Died = true
        end
    end
    function v_u_3.CleanseBuffs(_, p63)
        if v_u_60[p63] then
            v_u_60[p63].Died = false
        end
    end
    function v_u_3.GetPlayerBuffs(_, p64)
        local v65 = v_u_60
        local v66 = v_u_60[p64]
        if not v66 then
            v66 = {
                ["Buffs"] = {}
            }
        end
        v65[p64] = v66
        return v_u_3:GetBuffs(v_u_60[p64].Buffs)
    end
    function v_u_3.Buff(_, p_u_67)
        local v68 = p_u_67.Owner
        local v69 = p_u_67.Sender
        if not v69 then
            if v68 then
                v69 = v68.Name
            else
                v69 = v68
            end
        end
        p_u_67.Sender = v69
        if v68 then
            v_u_3:TriggerCounterAbility({
                ["Sender"] = v68
            }, "Enchant")
        end
        p_u_67.Targets = p_u_67.Targets or { p_u_67.Owner.UserId }
        v_u_3:UserIdAbilityTrigger({}, p_u_67.Targets, "Enchanted")
        p_u_67.Remainder = p_u_67.Duration or (p_u_67.Remainder or 90000)
        if not p_u_67.Entity then
            local v70 = v_u_61
            table.insert(v70, p_u_67)
            return p_u_67
        end
        local v71 = {}
        local v_u_72 = p_u_67.Remainder
        function v71.Destroy(_)
            p_u_67.Remainder = 0
        end
        function v71.Refresh(_, p73)
            p_u_67.Remainder = p73 or v_u_72
        end
        local v74 = v_u_61
        table.insert(v74, p_u_67)
        return v71
    end
    local v_u_75 = tick()
    function v_u_3.RefreshBuffs(_)
        local v76 = tick() - v_u_75
        v_u_75 = tick()
        local v77 = v_u_6:GetPlayers()
        local v78 = {}
        local v79 = {}
        for _, v80 in pairs(v77) do
            local v81 = v80.UserId
            local v82 = v_u_60[v81]
            if not v82 then
                v_u_60[v81] = {
                    ["Buffs"] = {}
                }
                v82 = v_u_60[v81]
            end
            v82.Buffs = {}
            v78[v81] = v82
            table.insert(v79, v81)
        end
        local v83 = {}
        for _, v84 in pairs(v_u_61) do
            v84.Remainder = v84.Remainder - v76
            if v84.Remainder > 0 and not v84.Disabled then
                local v85 = v84.Global
                local v86 = {
                    ["Sender"] = v84.Sender,
                    ["Tag"] = v84.Tag,
                    ["Set"] = v84.Set,
                    ["Multiplier"] = v84.Multiplier,
                    ["Stats"] = v84.Stats,
                    ["Remainder"] = v84.Remainder,
                    ["Cap"] = v84.Cap,
                    ["Global"] = v84.Global
                }
                local v87 = v84.Staple
                if v87 then
                    v87 = not v84.Staple:IsDescendantOf(workspace)
                end
                local v88 = v84.Connection
                if v88 then
                    v88 = v84.Connection:IsDescendantOf(workspace)
                end
                local v89 = {}
                if v85 then
                    v84.Targets = v79
                end
                if not v87 then
                    for _, v90 in pairs(v84.Targets) do
                        local v91 = nil
                        if tonumber(v90) then
                            if v_u_6:GetPlayerByUserId(v90) then
                                v91 = v_u_60[v90]
                            end
                        else
                            local v92 = v_u_60[v90]
                            if not v92 then
                                v_u_60[v90] = {
                                    ["Buffs"] = {}
                                }
                                v92 = v_u_60[v90]
                            end
                            if not v78[v90] then
                                v_u_60[v90].Buffs = {}
                                v78[v90] = v92
                            end
                        end
                        if v91 and (v85 or (v88 or not v91.Died)) then
                            table.insert(v89, v90)
                            local v93 = v91.Buffs
                            table.insert(v93, v86)
                        end
                    end
                end
                v84.Targets = v89
                if #v89 > 0 or v85 then
                    table.insert(v83, v84)
                end
            end
        end
        if #v_u_61 > 100 then
            print("memory leak", #v_u_61)
        end
        v_u_61 = v83
        for _, v94 in pairs(v77) do
            local v95 = v_u_60[v94.UserId]
            if v95 and v95.Died then
                v95.Died = false
            end
        end
        v_u_60 = v78
        game.ServerStorage.PlayerBuffTick:Fire()
    end
end
return v_u_3