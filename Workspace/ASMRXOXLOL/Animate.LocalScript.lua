local v_u_1 = script.Parent
local v_u_2 = v_u_1:WaitForChild("Humanoid")
local v_u_3 = "Standing"
local v4, v5 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop")
end)
local v_u_6 = v4 and v5
local v7, v8 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserAnimationSpeedDampening")
end)
local v_u_9 = v7 and v8
local v10, v11 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserAnimateScriptEmoteHook")
end)
local v_u_12 = v10 and v11
local v_u_13 = script:FindFirstChild("ScaleDampeningPercent")
local v_u_14 = ""
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = 1
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = {}
local v_u_22 = {
    ["idle"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507766666",
            ["weight"] = 1
        }
    },
    ["walk"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507777826",
            ["weight"] = 10
        }
    },
    ["run"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507767714",
            ["weight"] = 10
        }
    },
    ["swim"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507784897",
            ["weight"] = 10
        }
    },
    ["swimidle"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507785072",
            ["weight"] = 10
        }
    },
    ["jump"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507765000",
            ["weight"] = 10
        }
    },
    ["fall"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507767968",
            ["weight"] = 10
        }
    },
    ["climb"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507765644",
            ["weight"] = 10
        }
    },
    ["sit"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=2506281703",
            ["weight"] = 10
        }
    },
    ["toolnone"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507768375",
            ["weight"] = 10
        }
    },
    ["toolslash"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=522635514",
            ["weight"] = 10
        }
    },
    ["toollunge"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=522638767",
            ["weight"] = 10
        }
    },
    ["wave"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507770239",
            ["weight"] = 10
        }
    },
    ["point"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507770453",
            ["weight"] = 10
        }
    },
    ["dance"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507771019",
            ["weight"] = 10
        },
        {
            ["id"] = "http://www.roblox.com/asset/?id=507771955",
            ["weight"] = 10
        },
        {
            ["id"] = "http://www.roblox.com/asset/?id=507772104",
            ["weight"] = 10
        }
    },
    ["dance2"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507776043",
            ["weight"] = 10
        },
        {
            ["id"] = "http://www.roblox.com/asset/?id=507776720",
            ["weight"] = 10
        },
        {
            ["id"] = "http://www.roblox.com/asset/?id=507776879",
            ["weight"] = 10
        }
    },
    ["dance3"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507777268",
            ["weight"] = 10
        },
        {
            ["id"] = "http://www.roblox.com/asset/?id=507777451",
            ["weight"] = 10
        },
        {
            ["id"] = "http://www.roblox.com/asset/?id=507777623",
            ["weight"] = 10
        }
    },
    ["laugh"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507770818",
            ["weight"] = 10
        }
    },
    ["cheer"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507770677",
            ["weight"] = 10
        }
    }
}
local v_u_23 = {
    ["wave"] = false,
    ["point"] = false,
    ["dance"] = true,
    ["dance2"] = true,
    ["dance3"] = true,
    ["laugh"] = false,
    ["cheer"] = false
}
local v_u_24 = false
local v_u_25 = {}
local v26, _ = pcall(function()
    v_u_24 = UserSettings():IsUserFeatureEnabled("UserPreloadAnimations")
end)
if not v26 then
    v_u_24 = false
end
math.randomseed(tick())
function findExistingAnimationInSet(p27, p28)
    if p27 == nil or p28 == nil then
        return 0
    end
    for v29 = 1, p27.count do
        if p27[v29].anim.AnimationId == p28.AnimationId then
            return v29
        end
    end
    return 0
end
function configureAnimationSet(p_u_30, p_u_31)
    if v_u_21[p_u_30] ~= nil then
        for _, v32 in pairs(v_u_21[p_u_30].connections) do
            v32:disconnect()
        end
    end
    v_u_21[p_u_30] = {}
    v_u_21[p_u_30].count = 0
    v_u_21[p_u_30].totalWeight = 0
    v_u_21[p_u_30].connections = {}
    local v_u_33 = true
    local v34, _ = pcall(function()
        v_u_33 = game:GetService("StarterPlayer").AllowCustomAnimations
    end)
    v_u_33 = not v34 and true or v_u_33
    local v35 = script:FindFirstChild(p_u_30)
    if v_u_33 and v35 ~= nil then
        local v36 = v_u_21[p_u_30].connections
        local v37 = v35.ChildAdded
        table.insert(v36, v37:connect(function(_)
            configureAnimationSet(p_u_30, p_u_31)
        end))
        local v38 = v_u_21[p_u_30].connections
        local v39 = v35.ChildRemoved
        table.insert(v38, v39:connect(function(_)
            configureAnimationSet(p_u_30, p_u_31)
        end))
        for _, v40 in pairs(v35:GetChildren()) do
            if v40:IsA("Animation") then
                local v41 = v40:FindFirstChild("Weight")
                local v42 = v41 == nil and 1 or v41.Value
                v_u_21[p_u_30].count = v_u_21[p_u_30].count + 1
                local v43 = v_u_21[p_u_30].count
                v_u_21[p_u_30][v43] = {}
                v_u_21[p_u_30][v43].anim = v40
                v_u_21[p_u_30][v43].weight = v42
                v_u_21[p_u_30].totalWeight = v_u_21[p_u_30].totalWeight + v_u_21[p_u_30][v43].weight
                local v44 = v_u_21[p_u_30].connections
                local v45 = v40.Changed
                table.insert(v44, v45:connect(function(_)
                    configureAnimationSet(p_u_30, p_u_31)
                end))
                local v46 = v_u_21[p_u_30].connections
                local v47 = v40.ChildAdded
                table.insert(v46, v47:connect(function(_)
                    configureAnimationSet(p_u_30, p_u_31)
                end))
                local v48 = v_u_21[p_u_30].connections
                local v49 = v40.ChildRemoved
                table.insert(v48, v49:connect(function(_)
                    configureAnimationSet(p_u_30, p_u_31)
                end))
            end
        end
    end
    if v_u_21[p_u_30].count <= 0 then
        for v50, v51 in pairs(p_u_31) do
            v_u_21[p_u_30][v50] = {}
            v_u_21[p_u_30][v50].anim = Instance.new("Animation")
            v_u_21[p_u_30][v50].anim.Name = p_u_30
            v_u_21[p_u_30][v50].anim.AnimationId = v51.id
            v_u_21[p_u_30][v50].weight = v51.weight
            v_u_21[p_u_30].count = v_u_21[p_u_30].count + 1
            v_u_21[p_u_30].totalWeight = v_u_21[p_u_30].totalWeight + v51.weight
        end
    end
    if v_u_24 then
        for _, v52 in pairs(v_u_21) do
            for v53 = 1, v52.count do
                if v_u_25[v52[v53].anim.AnimationId] == nil then
                    v_u_2:LoadAnimation(v52[v53].anim)
                    v_u_25[v52[v53].anim.AnimationId] = true
                end
            end
        end
    end
end
function configureAnimationSetOld(p_u_54, p_u_55)
    if v_u_21[p_u_54] ~= nil then
        for _, v56 in pairs(v_u_21[p_u_54].connections) do
            v56:disconnect()
        end
    end
    v_u_21[p_u_54] = {}
    v_u_21[p_u_54].count = 0
    v_u_21[p_u_54].totalWeight = 0
    v_u_21[p_u_54].connections = {}
    local v_u_57 = true
    local v58, _ = pcall(function()
        v_u_57 = game:GetService("StarterPlayer").AllowCustomAnimations
    end)
    v_u_57 = not v58 and true or v_u_57
    local v59 = script:FindFirstChild(p_u_54)
    if v_u_57 and v59 ~= nil then
        local v60 = v_u_21[p_u_54].connections
        local v61 = v59.ChildAdded
        table.insert(v60, v61:connect(function(_)
            configureAnimationSet(p_u_54, p_u_55)
        end))
        local v62 = v_u_21[p_u_54].connections
        local v63 = v59.ChildRemoved
        table.insert(v62, v63:connect(function(_)
            configureAnimationSet(p_u_54, p_u_55)
        end))
        local v64 = 1
        for _, v65 in pairs(v59:GetChildren()) do
            if v65:IsA("Animation") then
                local v66 = v_u_21[p_u_54].connections
                local v67 = v65.Changed
                table.insert(v66, v67:connect(function(_)
                    configureAnimationSet(p_u_54, p_u_55)
                end))
                v_u_21[p_u_54][v64] = {}
                v_u_21[p_u_54][v64].anim = v65
                local v68 = v65:FindFirstChild("Weight")
                if v68 == nil then
                    v_u_21[p_u_54][v64].weight = 1
                else
                    v_u_21[p_u_54][v64].weight = v68.Value
                end
                v_u_21[p_u_54].count = v_u_21[p_u_54].count + 1
                v_u_21[p_u_54].totalWeight = v_u_21[p_u_54].totalWeight + v_u_21[p_u_54][v64].weight
                v64 = v64 + 1
            end
        end
    end
    if v_u_21[p_u_54].count <= 0 then
        for v69, v70 in pairs(p_u_55) do
            v_u_21[p_u_54][v69] = {}
            v_u_21[p_u_54][v69].anim = Instance.new("Animation")
            v_u_21[p_u_54][v69].anim.Name = p_u_54
            v_u_21[p_u_54][v69].anim.AnimationId = v70.id
            v_u_21[p_u_54][v69].weight = v70.weight
            v_u_21[p_u_54].count = v_u_21[p_u_54].count + 1
            v_u_21[p_u_54].totalWeight = v_u_21[p_u_54].totalWeight + v70.weight
        end
    end
    if v_u_24 then
        for _, v71 in pairs(v_u_21) do
            for v72 = 1, v71.count do
                v_u_2:LoadAnimation(v71[v72].anim)
            end
        end
    end
end
function scriptChildModified(p73)
    local v74 = v_u_22[p73.Name]
    if v74 ~= nil then
        configureAnimationSet(p73.Name, v74)
    end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
for v75, v76 in pairs(v_u_22) do
    configureAnimationSet(v75, v76)
end
local v_u_77 = "None"
local v_u_78 = 0
local v_u_79 = 0
local v_u_80 = false
function stopAllAnimations()
    local v81 = v_u_14
    local v82 = v_u_23[v81] ~= nil and v_u_23[v81] == false and "idle" or v81
    if v_u_12 and v_u_80 then
        v82 = "idle"
        v_u_80 = false
    end
    v_u_14 = ""
    v_u_15 = nil
    if v_u_17 ~= nil then
        v_u_17:disconnect()
    end
    if v_u_16 ~= nil then
        v_u_16:Stop()
        v_u_16:Destroy()
        v_u_16 = nil
    end
    if v_u_20 ~= nil then
        v_u_20:disconnect()
    end
    if v_u_19 ~= nil then
        v_u_19:Stop()
        v_u_19:Destroy()
        v_u_19 = nil
    end
    return v82
end
function getHeightScale()
    if not v_u_2 then
        return 1
    end
    if not v_u_2.AutomaticScalingEnabled then
        return 1
    end
    local v83 = v_u_2.HipHeight / 2
    if v_u_9 then
        if v_u_13 == nil then
            v_u_13 = script:FindFirstChild("ScaleDampeningPercent")
        end
        if v_u_13 ~= nil then
            v83 = 1 + (v_u_2.HipHeight - 2) * v_u_13.Value / 2
        end
    end
    return v83
end
function setRunSpeed(p84)
    local v85 = p84 * 1.25 / getHeightScale()
    if v85 ~= v_u_18 then
        if v85 < 0.33 then
            v_u_16:AdjustWeight(1)
            v_u_19:AdjustWeight(0.0001)
        elseif v85 < 0.66 then
            local v86 = (v85 - 0.33) / 0.33
            v_u_16:AdjustWeight(1 - v86 + 0.0001)
            v_u_19:AdjustWeight(v86 + 0.0001)
        else
            v_u_16:AdjustWeight(0.0001)
            v_u_19:AdjustWeight(1)
        end
        v_u_18 = v85
        v_u_19:AdjustSpeed(v85)
        v_u_16:AdjustSpeed(v85)
    end
end
function setAnimationSpeed(p87)
    if v_u_14 == "walk" then
        setRunSpeed(p87)
    elseif p87 ~= v_u_18 then
        v_u_18 = p87
        v_u_16:AdjustSpeed(v_u_18)
    end
end
function keyFrameReachedFunc(p88)
    if p88 == "End" then
        if v_u_14 == "walk" then
            if v_u_6 ~= true then
                v_u_19.TimePosition = 0
                v_u_16.TimePosition = 0
                return
            end
            if v_u_19.Looped ~= true then
                v_u_19.TimePosition = 0
            end
            if v_u_16.Looped ~= true then
                v_u_16.TimePosition = 0
                return
            end
        else
            local v89 = v_u_14
            local v90 = v_u_23[v89] ~= nil and v_u_23[v89] == false and "idle" or v89
            if v_u_12 and v_u_80 then
                if v_u_16.Looped then
                    return
                end
                v90 = "idle"
                v_u_80 = false
            end
            local v91 = v_u_18
            playAnimation(v90, 0.15, v_u_2)
            setAnimationSpeed(v91)
        end
    end
end
function rollAnimation(p92)
    local v93 = math.random(1, v_u_21[p92].totalWeight)
    local v94 = 1
    while v_u_21[p92][v94].weight < v93 do
        v93 = v93 - v_u_21[p92][v94].weight
        v94 = v94 + 1
    end
    return v94
end
local function v_u_101(p95, p96, p97, p98, p99)
    if p95 ~= v_u_15 then
        if v_u_16 ~= nil then
            v_u_16:Stop(p97)
            v_u_16:Destroy()
        end
        if v_u_19 ~= nil then
            v_u_19:Stop(p97)
            v_u_19:Destroy()
            if v_u_6 == true then
                v_u_19 = nil
            end
        end
        v_u_18 = 1
        v_u_16 = p98:LoadAnimation(p95)
        if p99 then
            v_u_16.Priority = p99
        end
        v_u_16:Play(p97)
        v_u_14 = p96
        v_u_15 = p95
        if v_u_17 ~= nil then
            v_u_17:disconnect()
        end
        v_u_17 = v_u_16.KeyframeReached:connect(keyFrameReachedFunc)
        if p96 == "walk" then
            local v100 = rollAnimation("run")
            v_u_19 = p98:LoadAnimation(v_u_21.run[v100].anim)
            v_u_19.Priority = Enum.AnimationPriority.Core
            v_u_19:Play(p97)
            if v_u_20 ~= nil then
                v_u_20:disconnect()
            end
            v_u_20 = v_u_19.KeyframeReached:connect(keyFrameReachedFunc)
        end
    end
end
function playAnimation(p102, p103, p104)
    local v105 = rollAnimation(p102)
    v_u_101(v_u_21[p102][v105].anim, p102, p103, p104)
    v_u_80 = false
end
function playEmote(p106, p107, p108)
    v_u_101(p106, p106.Name, p107, p108, Enum.AnimationPriority.Action)
    v_u_80 = true
end
local v_u_109 = ""
local v_u_110 = nil
local v_u_111 = nil
local v_u_112 = nil
function toolKeyFrameReachedFunc(p113)
    if p113 == "End" then
        playToolAnimation(v_u_109, 0, v_u_2)
    end
end
function playToolAnimation(p114, p115, p116, p117)
    local v118 = rollAnimation(p114)
    local v119 = v_u_21[p114][v118].anim
    if v_u_111 ~= v119 then
        if v_u_110 ~= nil then
            v_u_110:Stop()
            v_u_110:Destroy()
            p115 = 0
        end
        v_u_110 = p116:LoadAnimation(v119)
        if p117 then
            v_u_110.Priority = p117
        end
        v_u_110:Play(p115)
        v_u_109 = p114
        v_u_111 = v119
        v_u_112 = v_u_110.KeyframeReached:connect(toolKeyFrameReachedFunc)
    end
end
function stopToolAnimations()
    local v120 = v_u_109
    if v_u_112 ~= nil then
        v_u_112:disconnect()
    end
    v_u_109 = ""
    v_u_111 = nil
    if v_u_110 ~= nil then
        v_u_110:Stop()
        v_u_110:Destroy()
        v_u_110 = nil
    end
    return v120
end
function onRunning(p121)
    if p121 > 0.75 then
        playAnimation("walk", 0.2, v_u_2)
        setAnimationSpeed(p121 / 16)
        v_u_3 = "Running"
    elseif v_u_23[v_u_14] == nil and not v_u_80 then
        playAnimation("idle", 0.2, v_u_2)
        v_u_3 = "Standing"
    end
end
function onDied()
    v_u_3 = "Dead"
end
function onJumping()
    playAnimation("jump", 0.1, v_u_2)
    v_u_79 = 0.31
    v_u_3 = "Jumping"
end
function onClimbing(p122)
    playAnimation("climb", 0.1, v_u_2)
    setAnimationSpeed(p122 / 5)
    v_u_3 = "Climbing"
end
function onGettingUp()
    v_u_3 = "GettingUp"
end
function onFreeFall()
    if v_u_79 <= 0 then
        playAnimation("fall", 0.2, v_u_2)
    end
    v_u_3 = "FreeFall"
end
function onFallingDown()
    v_u_3 = "FallingDown"
end
function onSeated()
    v_u_3 = "Seated"
end
function onPlatformStanding()
    v_u_3 = "PlatformStanding"
end
function onSwimming(p123)
    if p123 > 1 then
        playAnimation("swim", 0.4, v_u_2)
        setAnimationSpeed(p123 / 10)
        v_u_3 = "Swimming"
    else
        playAnimation("swimidle", 0.4, v_u_2)
        v_u_3 = "Standing"
    end
end
function animateTool()
    if v_u_77 == "None" then
        playToolAnimation("toolnone", 0.1, v_u_2, Enum.AnimationPriority.Idle)
        return
    elseif v_u_77 == "Slash" then
        playToolAnimation("toolslash", 0, v_u_2, Enum.AnimationPriority.Action)
        return
    elseif v_u_77 == "Lunge" then
        playToolAnimation("toollunge", 0, v_u_2, Enum.AnimationPriority.Action)
    end
end
function getToolAnim(p124)
    for _, v125 in ipairs(p124:GetChildren()) do
        if v125.Name == "toolanim" and v125.className == "StringValue" then
            return v125
        end
    end
    return nil
end
local v_u_126 = 0
function stepAnimate(p127)
    local v128 = p127 - v_u_126
    v_u_126 = p127
    if v_u_79 > 0 then
        v_u_79 = v_u_79 - v128
    end
    if v_u_3 == "FreeFall" and v_u_79 <= 0 then
        playAnimation("fall", 0.2, v_u_2)
    else
        if v_u_3 == "Seated" then
            playAnimation("sit", 0.5, v_u_2)
            return
        end
        if v_u_3 == "Running" then
            playAnimation("walk", 0.2, v_u_2)
        elseif v_u_3 == "Dead" or (v_u_3 == "GettingUp" or (v_u_3 == "FallingDown" or (v_u_3 == "Seated" or v_u_3 == "PlatformStanding"))) then
            stopAllAnimations()
        end
    end
    local v129 = v_u_1:FindFirstChildOfClass("Tool")
    if v129 and v129:FindFirstChild("Handle") then
        local v130 = getToolAnim(v129)
        if v130 then
            v_u_77 = v130.Value
            v130.Parent = nil
            v_u_78 = p127 + 0.3
        end
        if v_u_78 < p127 then
            v_u_78 = 0
            v_u_77 = "None"
        end
        animateTool()
    else
        stopToolAnimations()
        v_u_77 = "None"
        v_u_111 = nil
        v_u_78 = 0
    end
end
v_u_2.Died:connect(onDied)
v_u_2.Running:connect(onRunning)
v_u_2.Jumping:connect(onJumping)
v_u_2.Climbing:connect(onClimbing)
v_u_2.GettingUp:connect(onGettingUp)
v_u_2.FreeFalling:connect(onFreeFall)
v_u_2.FallingDown:connect(onFallingDown)
v_u_2.Seated:connect(onSeated)
v_u_2.PlatformStanding:connect(onPlatformStanding)
v_u_2.Swimming:connect(onSwimming)
local v_u_131 = Instance.new("Folder")
v_u_131.Parent = script
local v_u_132 = {}
for _, _ in pairs(script:GetDescendants()) do
    local v133 = {}
    for _, v134 in pairs(script:GetChildren()) do
        local v135 = {}
        for _, v136 in pairs(v134:GetChildren()) do
            table.insert(v135, v136)
        end
        if #v135 > 0 then
            v133[v134.name] = v135
        end
    end
end
game.ReplicatedStorage.Animations.SetAnim.Event:Connect(function(p137, p138)
    local v139 = type(p137) ~= "table" and { p137 } or p137
    local v140 = v139[1].Parent.Name
    if p138 then
        warn("Clearing", v140)
        local v141 = {}
        local v142 = 0
        for v143 = #v_u_132, 1, -1 do
            local v144 = v_u_132[v143]
            if v144.Tag == v140 then
                for v145, v146 in pairs(v144) do
                    if v145 ~= "Tag" then
                        v141[v145] = true
                        v142 = v142 + 1
                        for _, v147 in pairs(v146) do
                            v147:Destroy()
                        end
                    end
                end
                table.remove(v_u_132)
            end
        end
        for v148, _ in pairs(v141) do
            local v149 = script:FindFirstChild(v148)
            if v149 and #v149:GetChildren() > 0 then
                v141[v148] = nil
            end
        end
        local v150 = #v_u_132
        while v142 > 0 and v150 > 0 do
            local v151 = v_u_132[v150]
            for v152, _ in pairs(v141) do
                local v153 = v151[v152]
                if v153 then
                    v141[v152] = nil
                    v142 = v142 - 1
                    local v154 = script:FindFirstChild(v152)
                    for _, v155 in pairs(v153) do
                        v155.Parent = v154
                    end
                end
            end
            v150 = v150 - 1
        end
    else
        local v156 = {
            ["Tag"] = v140
        }
        for _, v157 in pairs(v139) do
            local v158 = string.lower(v157.Name)
            local v159 = script:FindFirstChild(v158)
            local v160 = {}
            v156[v158] = v160
            if v159 then
                for _, v161 in pairs(v159:GetChildren()) do
                    v161.Parent = v_u_131
                end
                table.insert(v160, v157:Clone())
                v160[#v160].Parent = v159
            end
        end
        local v162 = v_u_132
        table.insert(v162, v156)
    end
end)
game:GetService("Players").LocalPlayer.Chatted:connect(function(p163)
    local v164 = ""
    if string.sub(p163, 1, 3) == "/e " then
        v164 = string.sub(p163, 4)
    elseif string.sub(p163, 1, 7) == "/emote " then
        v164 = string.sub(p163, 8)
    end
    if v_u_3 == "Standing" and v_u_23[v164] ~= nil then
        playAnimation(v164, 0.1, v_u_2)
    end
end)
if v_u_12 then
    script:WaitForChild("PlayEmote").OnInvoke = function(p165)
        if v_u_3 == "Standing" then
            if v_u_23[p165] ~= nil then
                playAnimation(p165, 0.1, v_u_2)
                return true
            end
            if typeof(p165) ~= "Instance" or not p165:IsA("Animation") then
                return false
            end
            playEmote(p165, 0.1, v_u_2)
            return true
        end
    end
end
playAnimation("idle", 0.1, v_u_2)
local _ = "Standing"
while v_u_1.Parent ~= nil do
    local _, v166 = wait(0.1)
    stepAnimate(v166)
end