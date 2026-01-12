local v_u_1 = game.Players.LocalPlayer
local _ = v_u_1.UserId
local v2 = game:GetService("ProximityPromptService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("CollectionService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = {}
v_u_5.RenderStepped:Connect(function()
    for _, v7 in v_u_6 do
        v7()
    end
end)
local v_u_8 = {}
function getOrSetCooldowns(p9, p10)
    local v11 = time()
    v_u_8[p9] = v_u_8[p9] or 0
    if v_u_8[p9] < v11 then
        v_u_8[p9] = v11 + p10
        return true
    end
end
local v_u_12 = v_u_3.RemoteEvent
local v_u_13 = require(v_u_3.DataLink)
require(v_u_3.CombatData)
local v_u_14 = require(v_u_3.WeaponData)
local v_u_15 = require(v_u_3.Loot)
require(v_u_3.EquipmentModule)
local v_u_16 = require(v_u_3.AnimationService)
local v_u_17 = require(v_u_3.AnimationService.Server)
local v_u_18 = require(v_u_3.movefx)
local v_u_19 = require(v_u_3.CombatShared)
local v_u_20 = nil
local function v_u_21()
    local _ = v_u_20.Level
    local _ = v_u_20.XP
end
local function v_u_22(_) end
local v_u_23 = 1
local v_u_24 = nil
local v_u_25 = {}
local v_u_26 = require(v_u_3.movefx.ClientStrap)
v_u_12.OnClientEvent:Connect(function(p27, ...)
    if p27 == "ClientFX" then
        local v28 = table.pack(...)
        v_u_26[table.remove(v28, 1)]:Fire(table.unpack(v28))
    elseif p27 == "GetData" then
        v_u_20 = ...
        v_u_13.Set(v_u_20)
        v_u_21()
        while not v_u_24 do
            task.wait()
        end
        v_u_24()
        v_u_23 = v_u_20.LoadoutCount
        if v_u_20.BoostCount then
            repeat
                task.wait()
            until v_u_25.XPBuffTimer
            v_u_25.XPBuffTimer(v_u_20.BoostCount, v_u_20.BoostTimer)
            return
        end
    else
        if p27 == "UpdateStats" then
            local v29, v30, v31, v32 = ...
            v_u_20.Level = v30
            v_u_20.XP = v31
            v_u_20.Gold = v32
            v_u_21()
            v_u_22(v29)
            v_u_13:Call("UpdateStats", v29)
            return
        end
        if p27 == "Teleport" then
            local v33 = v_u_3.Models.Interface.Teleport:Clone()
            v33.Text = ...
            v33.Transparency = 1
            v33.Parent = v_u_1.PlayerGui.Interface
            v_u_18:Tween({
                ["Target"] = v33,
                ["Goal"] = {
                    ["Transparency"] = 0
                },
                ["Time"] = 2,
                ["Direction"] = Enum.EasingDirection.In
            })
            game.Debris:AddItem(v33, 10)
            for v34 = 0, 10, 0.1 do
                local v35 = Instance.new("Frame")
                v35.BorderSizePixel = 0
                v35.BackgroundColor3 = Color3.new(1, 1, 1)
                v35.Position = UDim2.new(math.random(), 0, 1, 0)
                v35.AnchorPoint = Vector2.new(0.5, 0)
                local v36 = math.random(3, 8)
                v35.Size = UDim2.new(v36 / 10, 0, v36 / 10, 0)
                Instance.new("UIAspectRatioConstraint").Parent = v35
                v35.Parent = v33
                v35.ZIndex = v33.ZIndex
                game.Debris:AddItem(v35, 1)
                v_u_18:Tween({
                    ["Target"] = v35,
                    ["Goal"] = {
                        ["BackgroundColor3"] = Color3.new(0.3, 0.3, 0.3),
                        ["Transparency"] = 1,
                        ["Position"] = v35.Position - UDim2.new(0, 0, 0.5 + v34 / 10, 0)
                    }
                })
                task.wait(0.1)
            end
            return
        end
        if p27 == "ItemMagnet" then
            for _, v_u_37 in v_u_4:GetTagged("Loot") do
                local v_u_38 = v_u_37:GetAttribute("Hash")
                if v_u_37:IsA("BasePart") then
                    v_u_37.Anchored = true
                    v_u_18:Tween({
                        ["Target"] = v_u_37,
                        ["Goal"] = {
                            ["CFrame"] = v_u_1.Character:GetPivot()
                        },
                        ["Time"] = 0.7,
                        ["Style"] = Enum.EasingStyle.Exponential,
                        ["Direction"] = Enum.EasingDirection.In
                    }).Completed:Connect(function()
                        v_u_18:Sound({
                            ["Id"] = 550210020,
                            ["Target"] = workspace
                        })
                        v_u_37:Destroy()
                    end)
                end
                task.delay(0.25, function()
                    v_u_12:FireServer("ClaimLoot", v_u_38)
                end)
                task.wait()
            end
            return
        end
        if p27 == "DropItem" then
            local v39, v40, v41 = ...
            v_u_15:ReceiveItemDrop(v39, v40, v41)
            return
        end
        if p27 == "DropItems" then
            local v42, v43, v44 = ...
            for _, v45 in pairs(v42) do
                local v46 = v45[1]
                local v47 = v45[2]
                local v48 = tonumber(v47) and v45[1] or v45[2]
                if v46 ~= "Cubit" or not table.find(v_u_20.Cubits, v48) then
                    v_u_15:ReceiveItemDrop(v45, v43, v44)
                    v43 = v43 + 1
                end
                task.wait(0.1)
            end
            return
        end
        if p27 == "RaidPrompt" then
            local v_u_49 = v_u_3.Models.Interface.RaidPrompt:Clone()
            local v_u_50 = Instance.new("ScreenGui")
            v_u_50.Parent = v_u_1.PlayerGui
            v_u_49.Parent = v_u_50
            local v_u_51 = nil
            v_u_51 = v_u_49.MouseButton1Click:Connect(function()
                v_u_51:Disconnect()
                v_u_49.Text = "STAYING"
                v_u_12:FireServer("Stay")
            end)
            task.delay(15, function()
                local v52 = v_u_18
                local v53 = {
                    ["Target"] = v_u_49,
                    ["Goal"] = {
                        ["Position"] = v_u_49.Position + UDim2.new(0, 0, 1, 0)
                    },
                    ["Time"] = 0.75
                }
                v52:Tween(v53).Completed:Wait()
                v_u_50:Destroy()
            end)
            return
        end
        if p27 == "Cutscene" then
            v_u_18:Cutscene(...)
            return
        end
        if v_u_25[p27] then
            v_u_25[p27](...)
        end
    end
end)
local v_u_54 = v_u_23
local v_u_55 = v_u_24
while not v_u_20 do
    task.wait()
end
print("player data received!")
local v56 = require(v_u_3.CubitGlossary)
local v_u_57 = v_u_3.Chips
local v_u_58 = nil
if v_u_57 then
    local v_u_59 = v_u_3.Models.Cubit
    local v_u_60 = Instance.new("Folder")
    v_u_60.Parent = workspace
    v_u_60.Name = "Client Cubits"
    local function v_u_67()
        warn("loading cubits")
        v_u_60:ClearAllChildren()
        for _, v61 in pairs(v_u_57:GetChildren()) do
            local v62 = v61.Name
            if not table.find(v_u_20.Cubits, v62) then
                local v63 = v_u_59:Clone()
                v63.CFrame = v61.CFrame
                v63.Parent = v_u_60
                local v64 = Instance.new("ProximityPrompt")
                v64.Name = v62
                v64.ObjectText = "Cubit"
                v64.ActionText = "Unlock Cubit"
                v64.GamepadKeyCode = Enum.KeyCode.ButtonA
                v64.Parent = v63
                local v65 = v_u_18
                local v66 = {
                    ["Target"] = v63,
                    ["Goal"] = {
                        ["CFrame"] = v63.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                    },
                    ["RepeatCount"] = 9000000000
                }
                v65:Tween(v66)
                v63:AddTag("ActiveCubit")
            end
        end
        if v_u_58 then
            v_u_58.ActiveCubit:OnWarp()
        end
    end
    v_u_67()
    function v_u_25.RefreshCubits(...)
        local v68 = v_u_20
        local v69 = v_u_20
        local v70 = v_u_20
        local v71, v72, v73, v74 = ...
        v_u_20.Level = v71
        v68.XP = v72
        v69.Cubits = v73
        v70.Rebirths = v74
        v_u_67()
    end
    v_u_57.Parent = game.ReplicatedStorage
end
local v_u_75 = v_u_1:WaitForChild("PlayerGui"):WaitForChild("Interface")
local function v_u_82(p76)
    local v_u_77 = v_u_75:FindFirstChild("WarningLabel")
    if v_u_77 then
        v_u_77.Name = "FadingLabel"
        local v78 = v_u_18
        local v79 = {
            ["Target"] = v_u_77,
            ["Goal"] = {
                ["TextTransparency"] = 1
            },
            ["Time"] = 0.75 * (1 - v_u_77.TextTransparency)
        }
        v78:Tween(v79).Completed:Connect(function()
            v_u_77:Destroy()
        end)
    end
    local v80 = Instance.new("TextLabel")
    v80.Name = "WarningLabel"
    v80.Size = UDim2.new(0.7, 0, 0.05, 24)
    v80.AnchorPoint = Vector2.new(0.5, 0.5)
    v80.Position = UDim2.new(0.5, 0, 0.9, -12)
    v80.Font = Enum.Font.GothamBlack
    v80.TextScaled = true
    v80.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    v80.BackgroundTransparency = 1
    v80.Text = p76
    v80.Transparency = 1
    v80.Parent = v_u_75
    local v81 = {
        ["Target"] = v80,
        ["Goal"] = {
            ["TextTransparency"] = 0
        },
        ["Reverses"] = true,
        ["DelayTime"] = 0.25
    }
    v_u_18:Tween(v81)
    game.Debris:AddItem(v80, 2.25)
end
v_u_25.DisplayMessage = v_u_82
local v_u_83 = v_u_75.Shop
local v_u_84 = v_u_75.Store
local v_u_85 = v_u_75.Container
local v_u_86 = v_u_75.Menubar
local v_u_87 = Color3.fromRGB(148, 148, 148)
local v_u_88 = Color3.fromRGB(45, 45, 45)
function v_u_25.Message(p89)
    local v90 = Instance.new("TextLabel")
    v90.Text = p89
    v90.BackgroundTransparency = 0.7
    v90.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    v90.TextColor3 = Color3.new(1, 1, 1)
    v90.AnchorPoint = Vector2.new(0.5, 0.5)
    v90.Position = UDim2.new(0.5, 0, -1, 0)
    v90.Size = UDim2.new(0.5, 0, 0.05, 20)
    v90.TextScaled = true
    local v91 = Instance.new("UICorner")
    v91.CornerRadius = UDim.new(0.25, 0)
    v91.Parent = v90
    local v92 = Instance.new("UIStroke")
    v92.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    v92.Thickness = 2
    v92.Color = Color3.new(0, 0, 0)
    v92.Parent = v90
    v90.Parent = v_u_75
    game.Debris:AddItem(v90, 6)
    local v93 = v_u_18
    local v94 = {
        ["Target"] = v90,
        ["Goal"] = {
            ["Position"] = UDim2.new(0.5, 0, 0.25, 0)
        }
    }
    v93:Tween(v94).Completed:Wait()
    task.wait(4)
    local v95 = v_u_18
    local v96 = {
        ["Target"] = v90,
        ["Goal"] = {
            ["Position"] = UDim2.new(0.5, 0, -1, 0)
        }
    }
    v95:Tween(v96)
end
local v97 = game:GetService("UserInputService")
local v_u_98 = game:GetService("GuiService")
local v_u_99 = {}
local v_u_100 = workspace.CurrentCamera
v2.PromptTriggered:Connect(function(p101)
    if p101.ActionText == "Collect" then
        v_u_12:FireServer("ClaimLoot", p101:GetAttribute("Hash"))
        v_u_18:Sound({
            ["Id"] = 550210020,
            ["Target"] = workspace
        })
        p101.Parent:Destroy()
    elseif p101.ActionText == "Unlock Cubit" then
        local v102 = p101.Name
        if table.find(v_u_20.Cubits, v102) then
            p101.Parent:Destroy()
            return
        end
        v_u_12:FireServer("CollectCubit", v102)
        local v103 = v_u_1.Character
        local v104 = v103:FindFirstChild("Humanoid")
        if v103 then
            v103 = v103:WaitForChild("HumanoidRootPart")
        end
        if v103 and (v104 and (v104.Health > 0 and p101:IsDescendantOf(workspace))) then
            local v_u_105 = p101.Parent
            p101:Destroy()
            v_u_18:Kindle({
                ["Target"] = v_u_105
            })
            v_u_18:Sound({
                ["Id"] = 9060040486
            })
            local v106 = v_u_18
            local v107 = {
                ["Target"] = v_u_105,
                ["Goal"] = {
                    ["CFrame"] = v_u_105.CFrame + Vector3.new(0, 6, 0),
                    ["Orientation"] = v_u_105.Orientation + Vector3.new(0, 720, 0)
                },
                ["Time"] = 3,
                ["Reverses"] = true,
                ["RepeatCount"] = 4
            }
            v106:Tween(v107)
            v_u_100.CameraType = Enum.CameraType.Scriptable
            local v108 = v_u_18
            local v109 = {
                ["Target"] = v_u_100,
                ["Goal"] = {
                    ["FieldOfView"] = 60
                },
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Direction"] = Enum.EasingDirection.In,
                ["Time"] = 0.5,
                ["Reverses"] = true
            }
            v108:Tween(v109)
            v_u_16:Play("CubitCollect")
            local v_u_110 = v_u_3.Models.Interface.BottomText:Clone()
            v_u_110.Position = v_u_110.Position + UDim2.new(0, 0, 1, 0)
            v_u_110.Parent = v_u_75
            v_u_110.Name = "CubitUnlock"
            local v111 = v_u_110.Description
            local v112 = v_u_110.Subtext
            local v113 = v_u_18
            local v114 = {
                ["Target"] = v_u_110,
                ["Goal"] = {
                    ["Position"] = v_u_110.Position - UDim2.new(0, 0, 1, 0)
                },
                ["Time"] = 0.5
            }
            v113:Tween(v114)
            local v_u_115 = nil
            local function v121()
                if not v_u_115 then
                    v_u_115 = true
                    v_u_99.ButtonA = nil
                    v_u_18:Sound({
                        ["Id"] = 2390691299
                    })
                    local v116 = v_u_18
                    local v117 = {
                        ["Target"] = v_u_110,
                        ["Goal"] = {
                            ["Position"] = v_u_110.Position + UDim2.new(0, 0, 1, 0)
                        },
                        ["Time"] = 0.5
                    }
                    v116:Tween(v117).Completed:Wait()
                    v_u_110:Destroy()
                    v_u_16:Stop("CubitCollect")
                    local v118 = {
                        ["Target"] = v_u_100,
                        ["Goal"] = {
                            ["FieldOfView"] = 70
                        },
                        ["Time"] = 0.25
                    }
                    v_u_18:Tween(v118)
                    v_u_100.CameraType = Enum.CameraType.Custom
                    local v119 = v_u_18
                    local v120 = {
                        ["Target"] = v_u_105,
                        ["Goal"] = {
                            ["Transparency"] = 1,
                            ["Size"] = v_u_105.Size * 1.5
                        },
                        ["Time"] = 0.5
                    }
                    v119:Tween(v120).Completed:Wait()
                    v_u_18:Emit({
                        ["Position"] = v_u_105.Position,
                        ["ParticleId"] = "HitEffect",
                        ["Rate"] = 1
                    })
                    v_u_105:Destroy()
                end
            end
            v_u_99.ButtonA = v121
            task.delay(15, v121)
            v111.Text = "You have unlocked the Cubit \'" .. v102 .. "\'"
            v111.MaxVisibleGraphemes = 0
            v112.Text = "+" .. 10 * (1 + v_u_20.Rebirths) .. "% XP GAIN"
            v112.MaxVisibleGraphemes = 0
            local function v126(p122, p123)
                local v124 = v_u_18
                local v125 = {
                    ["Target"] = p122,
                    ["Goal"] = {
                        ["MaxVisibleGraphemes"] = #p122.ContentText
                    },
                    ["Time"] = p123 or 0.7
                }
                return v124:Tween(v125)
            end
            v126(v111).Completed:Wait()
            v_u_18:Sound({
                ["Id"] = 3807011731
            })
            v126(v112)
            v_u_18:UIWRAP(v_u_110.Button)
            v_u_110.Button.MouseButton1Click:Connect(v121)
            local v127 = v_u_18
            local v128 = {
                ["Target"] = v_u_100,
                ["Goal"] = {
                    ["FieldOfView"] = 80
                },
                ["Style"] = Enum.EasingStyle.Cubic,
                ["Direction"] = Enum.EasingDirection.InOut,
                ["Time"] = 10
            }
            v127:Tween(v128)
        end
    end
end)
local v_u_129 = v_u_86.Inventory
v97.InputBegan:Connect(function(p130)
    local v131 = p130.UserInputType == Enum.UserInputType.Gamepad1 and v_u_99[p130.KeyCode.Name]
    if v131 then
        v131()
    end
end)
local v_u_132 = v_u_20
local function v_u_134()
    for _, v133 in pairs(v_u_75:GetChildren()) do
        if v133:IsA("Frame") and (v133.Name ~= "CubitUnlock" and (v133.Name ~= "MobileControls" and v133:FindFirstChild("Close"))) then
            v133.Visible = v133 == v_u_86
        end
    end
end
local function v_u_137(p135)
    for _, v136 in pairs(p135:GetChildren()) do
        if v136.ClassName:sub(1, 2) ~= "UI" then
            v136:Destroy()
        end
    end
end
for _, v138 in pairs({
    { v_u_129, v_u_85, "DPadUp" },
    { v_u_86.Store, v_u_84, "DPadRight" }
}) do
    local v_u_139, v_u_140, v141 = table.unpack(v138)
    local v_u_142 = v_u_140.Position - UDim2.new(0, 0, 1, 0)
    local v_u_143 = v_u_140.Position
    local function v_u_146()
        v_u_139.Alert.Visible = false
        v_u_140.Position = v_u_142
        local v144 = {
            ["Target"] = v_u_140,
            ["Goal"] = {
                ["Position"] = v_u_143
            },
            ["Time"] = 0.2
        }
        if not v144.Time then
            v144.Time = 0.5
        end
        v_u_18:Tween(v144)
        local v145 = {
            ["Target"] = v_u_139,
            ["Goal"] = {
                ["BackgroundColor3"] = v_u_87
            },
            ["Time"] = 0.4
        }
        if not v145.Time then
            v145.Time = 0.5
        end
        v_u_18:Tween(v145)
    end
    local function v_u_149()
        local v147 = {
            ["Target"] = v_u_140,
            ["Goal"] = {
                ["Position"] = v_u_142
            },
            ["Time"] = 0.2
        }
        if not v147.Time then
            v147.Time = 0.5
        end
        v_u_18:Tween(v147)
        local v148 = {
            ["Target"] = v_u_139,
            ["Goal"] = {
                ["BackgroundColor3"] = v_u_88
            },
            ["Time"] = 0.4
        }
        if not v148.Time then
            v148.Time = 0.5
        end
        v_u_18:Tween(v148)
    end
    local function v_u_151()
        v_u_140.Visible = not v_u_140.Visible
        if v_u_140.Visible then
            v_u_134()
            v_u_140.Visible = true
            v_u_146()
        else
            v_u_149()
        end
        local v150 = v_u_1.PlayerGui:FindFirstChild("TouchGui")
        if v150 then
            v150:WaitForChild("TouchControlFrame"):WaitForChild("JumpButton").Visible = not v_u_140.Visible
        end
    end
    v_u_99[v141] = function()
        v_u_151()
        local v152 = v_u_140:FindFirstChild("Inventory")
        if v152 then
            v_u_98:Select(v152.Items)
        end
    end
    v_u_140.Close.MouseButton1Click:Connect(v_u_151)
    v_u_139.MouseButton1Click:Connect(v_u_151)
    v_u_18:UIWRAP(v_u_140.Close)
    v_u_18:UIWRAP(v_u_139)
end
local v_u_153 = v_u_85.CharacterView
local v_u_154 = require(v_u_3.CombatStats)
local v_u_155 = 0
local v156 = {}
for _, v_u_157 in pairs({ v_u_85.Reader, v_u_83.Reader, v_u_75.Crafting.Blurb }) do
    local v_u_158 = v_u_157:FindFirstChild("Icon")
    local v_u_159 = v_u_157.Boosts
    local v_u_160 = v_u_157:FindFirstChild("Rarity")
    local function v_u_169(p161, p162, p163)
        local v164 = Instance.new("TextLabel")
        v164.BackgroundTransparency = 1
        v164.TextColor3 = p162 or Color3.new(0.7, 0.7, 0.7)
        v164.Font = p163 and Enum.Font.GothamBold or Enum.Font.GothamSemibold
        v164.TextScaled = true
        local v165 = v_u_75.AbsoluteSize.Y
        local v166 = UDim2.new
        local v167 = v165 / 25
        v164.Size = v166(1, 0, 0, (math.min(p163 and 24 or 16, v167)))
        v164.RichText = true
        v164.Text = p161
        local v168 = Instance.new("UIStroke")
        v168.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
        v168.Thickness = 2
        v168.Color = Color3.new(0, 0, 0)
        v168.Parent = v164
        v164.Parent = v_u_159
        return v164
    end
    local v_u_170 = {}
    v156[v_u_157] = function(p171, p172)
        local v173 = p171[1]
        if p172 then
            v_u_155 = p172
        end
        local v174 = v_u_14[v173]
        if v_u_158 then
            v_u_137(v_u_158)
            local v175 = v_u_18
            local v176 = v174.Stackable
            if v176 then
                v176 = p171[2]
            end
            local v177 = v175:Item(v173, v176)
            v177.Parent = v_u_158
            v177.Size = UDim2.new(1, 0, 1, 0)
            local v178 = v177:FindFirstChildOfClass("UIGradient")
            for _, v179 in pairs(v_u_160:GetChildren()) do
                if v179:IsA("UIGradient") then
                    v179:Destroy()
                end
            end
            if v178 then
                v178:Clone().Parent = v_u_160
                v_u_160.Text = v178.Name:upper()
            else
                v_u_160.Text = "Material"
            end
            v_u_157.ItemName.Text = v173
        end
        v_u_137(v_u_159)
        v_u_169("Stats", Color3.new(0.4, 0.7, 1), true)
        local v180 = ""
        for v181, v184 in pairs(v174.Stats) do
            local v183 = v_u_154[v181] or v181
            if v183:sub(1, 1) == "%" or v183:sub(1, 1) == "x" then
                local v184 = v184 * 100
            else
                v183 = " " .. v183
            end
            v180 = v180 .. (v184 > 0 and "+" or "") .. string.format("%.1f", v184) .. v183 .. ","
            if #v180 > 28 then
                v_u_169(v180:sub(1, #v180 - 1))
                v180 = ""
            end
        end
        local v185 = v180:sub(1, #v180 - 1)
        print(#v185)
        v_u_169(v185)
        local v186 = v174.Variance
        if v186 and #p171 > 1 then
            v_u_169("Bonuses", Color3.new(1, 0.7, 0.4), true)
            v_u_170 = {}
            print("applying variance stats")
            for v187, v188 in pairs(v186) do
                local v189 = p171[v187 + 1]
                print("val", v189)
                if v189 then
                    local v190 = v189 * (1 - v188[1]) + v188[1]
                    local v191 = v190 * 100
                    local v192 = math.ceil(v191) / 100
                    print("ratio:", v190)
                    print("NUM:", v192)
                    local v193 = {}
                    for v194, v195 in pairs(v188) do
                        if not tonumber(v194) then
                            v193[v194] = v195 * v192
                        end
                    end
                    for v196, v199 in pairs(v193) do
                        local v198 = v_u_170
                        if v_u_170[v196] then
                            local v199 = v_u_170[v196] + v199 or v199
                        end
                        v198[v196] = v199
                    end
                end
            end
            local v200 = ""
            for v201, v204 in pairs(v_u_170) do
                local v203 = v_u_154[v201] or v201
                if v203:sub(1, 1) == "%" or v203:sub(1, 1) == "x" then
                    local v204 = v204 * 100
                else
                    v203 = " " .. v203
                end
                local v205 = v204 > 1000000000 and v_u_18:Abbreviate(v204) or string.format("%.1f", v204)
                v200 = v200 .. (v204 > 0 and "+" or "") .. v205 .. v203 .. ","
                if #v200 > 28 then
                    v_u_169(v200:sub(1, #v200 - 1))
                    v200 = ""
                end
            end
            v_u_169((v200:sub(1, #v200 - 1)))
        end
        local v206 = v174.Abilities
        if v206 then
            for _, v207 in pairs(v206) do
                if v207.Text then
                    v_u_169(v207.Text)
                else
                    v_u_169("On " .. v207[1] .. " apply " .. v207[2] .. " for " .. v207[3])
                end
            end
        end
    end
end
local v208 = v_u_86.Event
local v_u_209 = v_u_86.Rebirth
local v_u_210 = v_u_75.Rebirth
v_u_210.Claim.MouseButton1Click:Connect(function()
    v_u_12:FireServer("Rebirth")
    v_u_210.Visible = false
end)
local function v211()
    v_u_210.Visible = not v_u_210.Visible
    if v_u_210.Visible then
        v_u_134()
        v_u_210.Visible = true
    end
end
local v_u_212 = v_u_210.Progress
local v_u_213 = v_u_210.Progression.Level
local v214 = v_u_210.Holder.Frame
local v_u_215 = v214.Before
local v_u_216 = v214.After
local v_u_217 = {
    { "Access to the \'Hub of Rebirth\'", "Including the EPIC weapon store" },
    { "Access to the \'Realm of Athenia\'", "Includes LEGENDARY weapon store" },
    { "Access to the mysterious portal" },
    { "Mysterious locations open up..." }
}
local function v_u_229()
    local v218 = v_u_132.Rebirths
    local v219 = v_u_132.Level
    local v220 = v_u_18:GetMaxLvl(v218)
    local v221 = v219 / v220
    local v222 = math.clamp(v221, 0, 1)
    local v223 = v220 <= v219
    if v218 > 0 or v219 >= 50 then
        v_u_209.Visible = true
    end
    v_u_212.Visible = v223
    v_u_213.Bar.Size = UDim2.new(v222, 0, 1, 0)
    v_u_213.TextLabel.Text = v219 .. " / " .. v220 .. string.format(" (%.f%%)", v222 * 100)
    v_u_209.Alert.Visible = v223
    local v224 = "\226\151\137 " .. "Max Level " .. v_u_18:Abbreviate(v_u_18:GetMaxLvl(v218))
    for _, v225 in pairs(v_u_217[v218] or {}) do
        v224 = v224 .. "\n" .. "\226\151\137 " .. v225
    end
    v_u_215.Description.Text = v224
    local v226 = "\226\151\137 " .. "Max Level " .. v_u_18:Abbreviate(v_u_18:GetMaxLvl(v218)) .. " -> " .. v_u_18:Abbreviate(v_u_18:GetMaxLvl(v218 + 1))
    local v227 = v218 + 1
    for _, v228 in pairs(v_u_217[v227] or {}) do
        v226 = v226 .. "\n" .. "\226\151\137 " .. v228
    end
    v_u_216.Description.Text = v226
end
v_u_210.Close.MouseButton1Click:Connect(v211)
v_u_209.MouseButton1Click:Connect(v211)
v_u_18:UIWRAP(v_u_210.Close)
v_u_18:UIWRAP(v_u_209)
local v_u_230 = v_u_75.LevelStow
local v_u_231 = v_u_230.Custom
v_u_230.Close.MouseButton1Click:Connect(function()
    v_u_230.Visible = not v_u_230.Visible
    if v_u_230.Visible then
        v_u_134()
        v_u_230.Visible = true
    end
end)
v_u_18:UIWRAP(v_u_230.Close)
local v_u_232 = false
local v_u_233 = {
    "K",
    "M",
    "B",
    "T",
    "Qd",
    "Qn",
    "Sx",
    "Sp",
    "O",
    "N",
    "De",
    "Ud",
    "DD",
    "tdD",
    "qdD",
    "QnD",
    "sxD",
    "SpD",
    "OcD",
    "NvD",
    "Vgn",
    "UVg",
    "DVg",
    "TVg",
    "qtV",
    "QnV",
    "SeV",
    "SPG",
    "OVG",
    "NVG",
    "TGN",
    "UTG",
    "DTG",
    "tsTG",
    "qtTG",
    "QnTG",
    "ssTG",
    "SpTG",
    "OcTG",
    "NoTG",
    "QdDR",
    "uQDR",
    "dQDR",
    "tQDR",
    "qdQDR",
    "QnQDR",
    "sxQDR",
    "SpQDR",
    "OQDDr",
    "NQDDr",
    "qQGNT",
    "uQGNT",
    "dQGNT",
    "tQGNT",
    "qdQGNT",
    "QnQGNT",
    "sxQGNT",
    "SpQGNT",
    "OQQGNT",
    "NQQGNT",
    "SXGNTL"
}
local function v_u_241(p234)
    local v235 = v_u_231.Text:lower()
    local v236 = string.match(v235, "%a+")
    local v237 = string.match(v235, "%d+")
    local v238 = 0
    for v239, v240 in pairs(v_u_233) do
        if v240:lower() == v236 then
            v238 = v239 * 3
            break
        end
    end
    if v237 then
        v237 = tonumber(v237) * 10 ^ v238
    end
    if v237 then
        p234 = math.clamp(v237, 1, p234) or p234
    end
    return p234
end
local v_u_242 = v_u_230.Claim
local function v_u_247()
    v_u_132.StoredLevel = v_u_132.StoredLevel or 0
    local v243 = v_u_132.Level
    if v243 > 1 then
        local v244 = v_u_241(v243 - 1)
        local v245 = v_u_132
        v245.StoredLevel = v245.StoredLevel + v244
        local v246 = v_u_132
        v246.Level = v246.Level - v244
        v_u_12:FireServer("StowLevel", v244)
        v_u_230.Progress.Text = "You are currently level " .. (v_u_132.Level or 0) .. "."
        v_u_230.Storage.Text = "You have " .. (v_u_132.StoredLevel or 0) .. " levels stored."
        v_u_230.Prohibition.Visible = v_u_132.Rebirths < 3
    end
end
local v_u_248 = v_u_242.BackgroundColor3
v_u_242.MouseButton1Click:Connect(function()
    if v_u_232 or v_u_132.Rebirths < 3 then
        v_u_242.BackgroundColor3 = v_u_248
        v_u_18:Sound({
            ["Id"] = 138090596,
            ["Target"] = v_u_242,
            ["Pitch"] = 0.5 + math.random() / 2,
            ["Volume"] = 0.25
        })
        local v249 = v_u_18
        local v250 = {
            ["Target"] = v_u_242,
            {
                ["BackgroundColor3"] = Color3.new(0.3, 0.3, 0.3)
            },
            ["Time"] = 0.25,
            ["Reverses"] = true
        }
        v249:Tween(v250)
    else
        v_u_232 = true
        v_u_247()
        task.wait(0.25)
        v_u_232 = false
    end
end)
v_u_18:UIWRAP(v_u_242)
local v_u_251 = v_u_230.Retrieve
local function v_u_256()
    v_u_132.StoredLevel = v_u_132.StoredLevel or 0
    local v252 = v_u_132.StoredLevel
    if v252 > 1 then
        local v253 = v_u_241(v252)
        local v254 = v_u_132
        v254.Level = v254.Level + v253
        local v255 = v_u_132
        v255.StoredLevel = v255.StoredLevel - v253
        v_u_12:FireServer("RetrieveLevel", v253)
        v_u_230.Progress.Text = "You are currently level " .. (v_u_132.Level or 0) .. "."
        v_u_230.Storage.Text = "You have " .. (v_u_132.StoredLevel or 0) .. " levels stored."
        v_u_230.Prohibition.Visible = v_u_132.Rebirths < 3
    end
end
local v_u_257 = v_u_251.BackgroundColor3
v_u_251.MouseButton1Click:Connect(function()
    if v_u_232 or v_u_132.Rebirths < 3 then
        v_u_251.BackgroundColor3 = v_u_257
        v_u_18:Sound({
            ["Id"] = 138090596,
            ["Target"] = v_u_251,
            ["Pitch"] = 0.5 + math.random() / 2,
            ["Volume"] = 0.25
        })
        local v258 = v_u_18
        local v259 = {
            ["Target"] = v_u_251,
            {
                ["BackgroundColor3"] = Color3.new(0.3, 0.3, 0.3)
            },
            ["Time"] = 0.25,
            ["Reverses"] = true
        }
        v258:Tween(v259)
    else
        v_u_232 = true
        v_u_256()
        task.wait(0.25)
        v_u_232 = false
    end
end)
v_u_18:UIWRAP(v_u_251)
function AltarActivate(p260)
    if not v_u_230.Visible and game.Players:GetPlayerFromCharacter(p260.Parent) == v_u_1 then
        v_u_230.Progress.Text = "You are currently level " .. (v_u_132.Level or 0) .. "."
        v_u_230.Storage.Text = "You have " .. (v_u_132.StoredLevel or 0) .. " levels stored."
        v_u_230.Prohibition.Visible = v_u_132.Rebirths < 3
        v_u_230.Visible = not v_u_230.Visible
        if v_u_230.Visible then
            v_u_134()
            v_u_230.Visible = true
        end
    end
end
local v261 = v_u_75.Topbar
local v262 = v_u_153.XPBar
local v_u_263 = v262.Frame
local v_u_264 = v262.Amount
local v_u_265 = v262.Level
local v_u_266 = v156[v_u_85.Reader]
v_u_153.Username.Text = v_u_1.DisplayName
local v267 = v261.Progression
if not v_u_98:IsTenFootInterface() then
    v261.Position = v261.Position - UDim2.new(0, 0, 0, 38)
end
local v_u_268 = v267.Experience.Bar
local v_u_269 = v267.Experience.TextLabel
local v_u_270 = v261.TextLabel
local v_u_271 = v261.Gold
v_u_21 = function()
    local v272 = v_u_132.Level
    local v273 = v_u_132.XP
    v_u_265.Text = "LVL " .. v272
    local v274 = v_u_18:CalculateXP(v272)
    local v275 = math.floor(v274)
    v_u_264.Text = math.floor(v273) .. " / " .. v275
    v_u_263.Size = UDim2.new(math.min(v273, v275) / v274, 0, 1, 0)
    v_u_268.Size = v_u_263.Size
    local v276 = v_u_269
    local v277 = 100 * (math.min(v273, v275) / v274)
    v276.Text = math.floor(v277) .. "%"
    v_u_270.Text = v_u_18:Abbreviate(v272)
    v_u_271.Text = v_u_18:Abbreviate(v_u_132.Gold)
    v_u_229()
end
if v_u_132 then
    v_u_21()
end
local v_u_278 = v_u_153.Equipped
local v_u_279 = v_u_278.Items
function generateStand(p280, p_u_281, p_u_282)
    local v283 = Instance.new("ViewportFrame")
    v283.BackgroundTransparency = 1
    v283.Parent = p280
    v283.Size = UDim2.new(1, 0, 1, 0)
    v283.ZIndex = 2
    local v_u_284 = v_u_3.Models.WorldModel:Clone()
    v_u_284.Parent = v283
    local v285 = Instance.new("Camera")
    v285.FieldOfView = 70
    v285.Parent = v283
    local v286 = v_u_284.PrimaryPart
    v285.CFrame = CFrame.new(v286.Position + v286.CFrame.LookVector * v286.Size.Magnitude * 2 + Vector3.new(0, 2, 0), v286.Position)
    v283.CurrentCamera = v285
    local v287 = v_u_17(v_u_284.Humanoid)
    v287:Init()
    v287:Play("Idle")
    v_u_284.Name = ""
    local v_u_288 = Instance.new("Folder")
    v_u_288.Name = "Equipment"
    v_u_288.Parent = v_u_284
    local function v_u_298()
        if not v_u_1:HasAppearanceLoaded() then
            task.delay(0.5, v_u_298)
            return
        end
        local v289 = v_u_1.Character
        for _, v290 in pairs(v289:GetChildren()) do
            if v290:IsA("Shirt") or (v290:IsA("BodyColors") or v290:IsA("Pants")) then
                v290:Clone().Parent = v_u_284
            elseif v290:IsA("Accessory") then
                local v291 = v290:Clone()
                local v292 = v291:FindFirstChildOfClass("BasePart") or v291:FindFirstChild("Handle")
                if v292 then
                    v292.Parent = v_u_284
                    v292.Name = v291.Name
                    v291:Destroy()
                    local v293 = v292:FindFirstChildOfClass("Attachment")
                    if not v293 then
                        v293 = Instance.new("Attachment")
                        v293.Name = "HatAttachment"
                        v293.Parent = v292
                        v293.CFrame = v291.AttachmentPoint + Vector3.new(0, 0.1, 0)
                    end
                    for _, v294 in pairs({ v_u_284.Head, v_u_284:FindFirstChild("UpperTorso") }) do
                        local v295 = v294:FindFirstChild(v293.Name)
                        if v293 and v295 then
                            v292.CFrame = v293.CFrame:inverse() * v295.CFrame + v294.Position
                            local v296 = Instance.new("Weld")
                            v296.Name = "ModelWeld"
                            v296.Parent = v295.Parent.Parent.Head
                            v296.Part0 = v295.Parent
                            v296.Part1 = v293.Parent
                            v296.C0 = v295.CFrame * v293.CFrame:inverse()
                            break
                        end
                    end
                end
            elseif v290.Name == "Head" then
                local v297 = v290:FindFirstChildOfClass("Decal")
                if v297 then
                    v_u_284.Head:FindFirstChildOfClass("Decal"):Destroy()
                    v297:Clone().Parent = v_u_284.Head
                end
            end
        end
    end
    task.spawn(v_u_298)
    return v283, function()
        local v299 = p_u_282 or v_u_132
        v_u_288:ClearAllChildren()
        for _, v300 in pairs(v299.Equipped) do
            v_u_19:EquipTool(v_u_284, v299.Inventory[v300][1], {})
        end
        if not p_u_281 then
            for _, v301 in pairs(v_u_279:GetChildren()) do
                if v301:IsA("TextButton") then
                    v301:Destroy()
                end
            end
            for _, v_u_302 in pairs(v299.Equipped) do
                local v_u_303 = v299.Inventory[v_u_302]
                local v304 = v_u_18:Item(v_u_303[1])
                v304.Parent = v_u_279
                v_u_18:UIWRAP(v304, 0.65)
                v304.Activated:Connect(function()
                    display(isEquipped(v_u_302))
                    v_u_266(v_u_303, v_u_302)
                end)
            end
        end
    end
end
local v305, v306 = generateStand(v_u_153.Frame)
port = v305
UpdateEquipped = v306
local v_u_307 = {
    {
        ["X"] = { 0, 0.35 },
        ["Y"] = { 0.3, 0.8 },
        ["Slot"] = "Primary"
    },
    {
        ["X"] = { 0.65, 1 },
        ["Y"] = { 0.3, 0.8 },
        ["Slot"] = "Defensive"
    },
    {
        ["X"] = { 0.4, 0.6 },
        ["Y"] = { 0, 0.3 },
        ["Slot"] = "Helmet"
    },
    {
        ["X"] = { 0.35, 0.65 },
        ["Y"] = { 0.3, 0.65 },
        ["Slot"] = "Chest"
    },
    {
        ["X"] = { 0.35, 0.65 },
        ["Y"] = { 0.7, 1 },
        ["Slot"] = "Legs"
    }
}
local v_u_308 = v_u_1:GetMouse()
port.InputBegan:Connect(function(p309)
    if p309.UserInputType == Enum.UserInputType.MouseButton1 then
        local v310 = Vector2.new(v_u_308.X, v_u_308.Y)
        local v311 = port.AbsolutePosition
        local v312 = port.AbsoluteSize
        local v313 = v312.X
        local v314 = v312.Y
        local v315 = v310 - v311
        for _, v316 in pairs(v_u_307) do
            local v317 = v316.X[1] * v313
            local v318 = v316.X[2] * v313
            local v319 = v316.Y[1] * v314
            local v320 = v316.Y[2] * v314
            if v317 < v315.X and (v315.X < v318 and (v319 < v315.Y and v315.Y < v320)) then
                local v321 = v316.Slot
                local v322 = v_u_132.Equipped[v321]
                if v322 then
                    v_u_18:Sound({
                        ["Id"] = 177266782
                    })
                    v_u_155 = v322
                    v_u_266(v_u_132.Inventory[v_u_155])
                end
                return
            end
        end
    end
end)
v_u_153.EquipToggle.MouseButton1Click:Connect(function()
    v_u_278.Visible = not v_u_278.Visible
end)
local v_u_323 = nil
local function v_u_324()
    v_u_323 = false
end
local v_u_325 = 1
v_u_153.LoadoutChange.MouseButton1Click:Connect(function()
    if v_u_323 then
        if v_u_323 == 1 then
            v_u_18:Sound({
                ["Id"] = 550209561
            })
            v_u_18:Tween({
                ["Target"] = v_u_153.LoadoutChange,
                ["Goal"] = {
                    ["BackgroundColor3"] = Color3.new(1, 0, 0)
                },
                ["Reverses"] = true,
                ["Time"] = 0.125
            })
        end
        v_u_323 = 2
    else
        v_u_323 = 1
        task.delay(0.5, v_u_324)
        v_u_325 = v_u_325 % v_u_54 + 1
        if v_u_54 > 1 then
            v_u_153.LoadoutChange.Text = "Change Loadout (#" .. v_u_325 + 1 .. ")"
        end
        local v326 = v_u_132.Loadouts[v_u_325]
        local v327 = v_u_132.Equipped
        v_u_132.Equipped = v326 or {}
        v_u_132.Loadouts[v_u_325] = v327
        v_u_12:FireServer("LoadoutChange", v_u_325)
        UpdateEquipped()
    end
end)
function v_u_25.UpdateLoadoutCount(...)
    v_u_132.LoadoutCount = ...
    v_u_54 = v_u_132.LoadoutCount
end
v_u_18:UIWRAP(v_u_153.EquipToggle)
v_u_18:UIWRAP(v_u_153.LoadoutChange)
local v_u_328 = v_u_85.Inventory
local v_u_329 = v_u_328.Items
local v_u_330 = v_u_86.Sacrifice
local v331 = v_u_85.Reader
local v_u_332 = v156[v331]
local v_u_333 = v331.Equip
local v_u_334 = v331.Trash
local v_u_335 = v331.Warning
function display(p336)
    v_u_333.TextLabel.Text = p336 and "UNEQUIP" or "EQUIP"
    v_u_335.Visible = false
end
function isEquipped(p337)
    for _, v338 in pairs(v_u_132.Equipped) do
        if p337 == v338 then
            return true
        end
    end
    return false
end
local v_u_339 = tick()
v_u_334.MouseButton1Click:Connect(function()
    local v340 = v_u_14[v_u_132.Inventory[v_u_155]]
    local v341 = v340 and v340.Rarity
    if v341 then
        v341 = v340.Rarity > 900
    end
    if tick() - v_u_339 < 0.5 or (v341 or (not v_u_155 or v_u_155 <= 1)) then
        v_u_18:Sound({
            ["Id"] = 138090596,
            ["Target"] = v_u_334,
            ["Pitch"] = 0.75 + math.random() / 2
        })
        v_u_18:Tween({
            ["Target"] = v_u_334,
            ["Goal"] = {
                ["BackgroundColor3"] = Color3.new(1, 0, 0)
            },
            ["Time"] = 0.25,
            ["Reverses"] = true
        })
    else
        v_u_18:Tween({
            ["Target"] = v_u_334,
            ["Goal"] = {
                ["BackgroundColor3"] = Color3.fromRGB(45, 45, 45)
            },
            ["Time"] = 0.25
        })
        v_u_335.Visible = not v_u_335.Visible
        if not v_u_335.Visible then
            v_u_339 = tick()
            v_u_12:FireServer("TrashEquipment", v_u_155)
            table.remove(v_u_132.Inventory, v_u_155)
            for v342, v343 in pairs(v_u_132.Equipped) do
                if v_u_155 == v343 then
                    v_u_132.Equipped[v342] = nil
                elseif v_u_155 < v343 then
                    local v344 = v_u_132.Equipped
                    v344[v342] = v344[v342] - 1
                end
            end
            for _, v345 in pairs(v_u_132.Loadouts) do
                for v346, v347 in pairs(v345) do
                    if v347 == v_u_155 then
                        v345[v346] = nil
                    elseif v_u_155 < v347 then
                        v345[v346] = v345[v346] - 1
                    end
                end
            end
            UpdateEquipped()
            v_u_55()
            if not v_u_132.Inventory[v_u_155] then
                v_u_155 = v_u_155 - 1
            end
            display(isEquipped(v_u_155))
            v_u_332(v_u_132.Inventory[v_u_155], v_u_155)
        end
    end
end)
v_u_18:UIWRAP(v_u_334)
local v_u_348 = nil
local function v_u_349()
    v_u_348 = false
end
v_u_333.MouseButton1Click:Connect(function()
    if v_u_348 then
        if v_u_348 == 1 then
            v_u_18:Sound({
                ["Id"] = 550209561
            })
            local v350 = v_u_18
            local v351 = {
                ["Target"] = v_u_333,
                ["Goal"] = {
                    ["BackgroundColor3"] = Color3.new(1, 0, 0)
                },
                ["Reverses"] = true,
                ["Time"] = 0.125
            }
            v350:Tween(v351)
        end
        v_u_348 = 2
        return
    else
        v_u_348 = 1
        task.delay(0.25, v_u_349)
        local v352 = v_u_132.Inventory[v_u_155][1]
        local v353 = v_u_19:GetSlot(v352)
        print("weapon", v_u_155, v352, v353)
        local v354 = isEquipped(v_u_155)
        display(not v354)
        if v354 then
            v_u_12:FireServer("ChangeEquipment", v_u_155, true)
            v_u_132.Equipped[v353] = nil
            UpdateEquipped()
        else
            v_u_12:FireServer("ChangeEquipment", v_u_155)
            v_u_19:HandleEquipmentExceptions(v_u_132, v352)
            v_u_132.Equipped[v353] = v_u_155
            UpdateEquipped()
        end
    end
end)
v_u_18:UIWRAP(v_u_333)
local v_u_355 = v_u_328.Filter.Access
local v_u_356 = v_u_328.Filter.Query
local v_u_357 = {
    ["attack"] = "ad",
    ["power"] = "ad",
    ["pen"] = "apen",
    ["melee pen"] = "apen",
    ["magic pen"] = "mpen",
    ["armor shred"] = "shred",
    ["melee shred"] = "pd shred",
    ["magic shred"] = "mr shred",
    ["ap mult"] = "apmult",
    ["ad mult"] = "admult",
    ["apx"] = "apmult",
    ["adx"] = "admult",
    ["dx"] = "mult",
    ["magic"] = "ap",
    ["melee"] = "ad",
    ["damage"] = "ad",
    ["dmg"] = "ad",
    ["jump"] = "jp",
    ["ls"] = "lifesteal",
    ["attack spd"] = "as",
    ["attack speed"] = "as",
    ["dmg reduction"] = "reduction"
}
local v_u_358 = ""
local v_u_359 = 1
local v_u_360 = {
    ["NewFirst"] = "Newest",
    ["RarityUP"] = "Rarity \226\134\145",
    ["RarityDN"] = "Rarity \226\134\147"
}
local v_u_361 = {
    "Date",
    "NewFirst",
    "RarityUP",
    "RarityDN",
    "Type",
    "Power"
}
for v362, v363 in pairs(v_u_154) do
    v_u_357[v362:lower()] = v362:lower()
    v_u_357[v363:lower()] = v362:lower()
end
function UpdateFilter()
    local v364 = #v_u_358 > 0
    local v365 = v_u_361[v_u_359]
    for _, v366 in pairs(v_u_329:GetChildren()) do
        if v366:IsA("TextButton") then
            if v364 then
                local v367 = v_u_357[v_u_358]
                local v368 = v366:GetAttribute("Name")
                if v367 then
                    local v369 = v_u_14[v368]
                    v366.Visible = false
                    if v369 then
                        for v370, _ in pairs(v369.Stats or {}) do
                            if v367 == v370:lower() then
                                v366.Visible = true
                            end
                        end
                        for _, v371 in pairs(v369.Variance or {}) do
                            for v372, _ in pairs(v371) do
                                if type(v372) == "string" and v367 == v372:lower() then
                                    v366.Visible = true
                                end
                            end
                        end
                    end
                elseif v368:lower():find(v_u_358) then
                    v366.Visible = true
                else
                    v366.Visible = false
                end
            else
                v366.Visible = true
            end
            v366.Name = v366:GetAttribute(v365)
        end
    end
end
v_u_355.FocusLost:Connect(function(_)
    v_u_358 = v_u_355.Text:lower()
    UpdateFilter()
end)
v_u_356.MouseButton1Click:Connect(function()
    v_u_359 = v_u_359 % #v_u_361 + 1
    local v373 = v_u_361[v_u_359]
    v_u_356.Text = v_u_360[v373] or v373
    UpdateFilter()
end)
v_u_18:UIWRAP(v_u_356)
local v_u_374 = math.floor
local _ = table.insert
function basen(p375, p376)
    local v377 = v_u_374(p375)
    local v378 = {}
    while v377 > 62 do
        v377 = v377 - 62
        if v377 > 0 then
            if p376 then
                table.insert(v378, 1, "0")
            else
                table.insert(v378, 1, "z")
            end
        end
    end
    if p376 then
        local v379 = 63 - v377
        table.insert(v378, ("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"):sub(v379, v379))
    else
        table.insert(v378, ("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"):sub(v377, v377))
    end
    return table.concat(v378, "")
end
local function v_u_388(p380, p381, p382)
    local v383 = p381[1]
    local v384 = v_u_14[v383] or {}
    local v385 = v384.Stats or {}
    local v386 = (v385.AD or 0) + (v385.AP or 0) + (v385.HP or 0) + (v385.PD or 0) + (v385.MR or 0)
    if #p381 > 1 then
        for v387 = 2, #p381 do
            v386 = v386 + (p381[v387] or 0) * 10
        end
    end
    p380:SetAttribute("Name", v383)
    p380:SetAttribute("Slot", p382)
    p380:SetAttribute("Date", basen(p382))
    p380:SetAttribute("NewFirst", basen(p382, true))
    p380:SetAttribute("RarityUP", basen(v384.Rarity or 1))
    p380:SetAttribute("RarityDN", basen(v384.Rarity or 1, true))
    p380:SetAttribute("Type", v384.Type or "Sword")
    p380:SetAttribute("Power", basen(v386))
    p380.Name = p380:GetAttribute(v_u_361[v_u_359])
    if #v_u_358 > 0 then
        if v383:lower():find(v_u_358) then
            p380.Visible = true
            return
        end
        p380.Visible = false
    end
end
v_u_24 = function()
    v_u_330.Visible = v_u_132.Flagged
    v_u_137(v_u_329)
    for v_u_389, v_u_390 in pairs(v_u_132.Inventory) do
        local v391 = v_u_390[1]
        local v392 = v_u_18
        local v393 = (v_u_14[v391] or {}).Stackable
        if v393 then
            v393 = v_u_390[2]
        end
        local v394 = v392:Item(v391, v393)
        v394.Parent = v_u_329
        v_u_388(v394, v_u_390, v_u_389)
        v_u_18:UIWRAP(v394, 0.65)
        v394.Activated:Connect(function()
            display(isEquipped(v_u_389))
            v_u_332(v_u_390, v_u_389)
        end)
    end
    UpdateEquipped()
end
function IncrementInventory()
    local v395 = #v_u_329:GetChildren() - 1
    local v396 = #v_u_132.Inventory
    if v396 == v395 - 1 then
        for _, v397 in pairs(v_u_329:GetChildren()) do
            local v398 = v397:FindFirstChild("Quantity")
            if v398 then
                local v399 = v397:GetAttribute("Name")
                for _, v400 in pairs(v_u_132.Inventory) do
                    if v400[1] == v399 then
                        v398.Text = "x" .. v400[2]
                    end
                end
            end
        end
    end
    for v_u_401 = v395, v396 do
        local v_u_402 = v_u_132.Inventory[v_u_401]
        local v403 = v_u_402[1]
        local v404 = v_u_18
        local v405 = (v_u_14[v403] or {}).Stackable
        if v405 then
            v405 = v_u_402[2]
        end
        local v406 = v404:Item(v403, v405)
        v406.Parent = v_u_329
        v_u_388(v406, v_u_402, v_u_401)
        v406.Activated:Connect(function()
            display(isEquipped(v_u_401))
            v_u_332(v_u_402, v_u_401)
        end)
    end
end
function v_u_25.RefreshInventory(...)
    v_u_132.Inventory = ...
    v_u_24()
end
function v_u_25.UpdateInventory(...)
    v_u_132.Inventory = ...
    local v_u_407 = v_u_129.Alert
    v_u_407.Visible = true
    v_u_407.Rotation = 0
    local v408 = {
        ["Target"] = v_u_407,
        ["Goal"] = {
            ["Rotation"] = -5
        },
        ["Time"] = 0.2
    }
    v_u_18:Tween(v408).Completed:Connect(function()
        local v409 = {
            ["Target"] = v_u_407,
            ["Goal"] = {
                ["Rotation"] = 5
            },
            ["Time"] = 0.2
        }
        v_u_18:Tween(v409).Completed:Wait()
        local v410 = {
            ["Target"] = v_u_407,
            ["Goal"] = {
                ["Rotation"] = 0
            },
            ["Time"] = 0.2
        }
        v_u_18:Tween(v410)
    end)
    IncrementInventory()
end
local v_u_411 = v_u_85.Stats
local v_u_412 = v_u_411.Frame
local v_u_413 = v_u_411.MetaData
local v_u_414 = nil
local function v_u_420(p415, p416, p417)
    local v418 = Instance.new("TextLabel")
    v418.BackgroundTransparency = 1
    v418.TextColor3 = p416 or Color3.new(0.7, 0.7, 0.7)
    v418.Font = p417 and Enum.Font.GothamBold or Enum.Font.GothamSemibold
    v418.TextScaled = true
    v418.Size = UDim2.new(1, 0, 0, p417 and 24 or 16)
    v418.RichText = true
    v418.TextXAlignment = Enum.TextXAlignment.Left
    v418.Text = p415
    local v419 = Instance.new("UIStroke")
    v419.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    v419.Thickness = 2
    v419.Color = Color3.new(0, 0, 0)
    v419.Parent = v418
    v418.Parent = v_u_414
    return v418
end
v_u_22 = function(p421)
    if v_u_411.Visible and (v_u_411.Parent.Visible and getOrSetCooldowns("UpdateStats", 1)) then
        v_u_414 = v_u_412
        v_u_137(v_u_414)
        v_u_420("Stats", Color3.new(0.4, 0.7, 1), true)
        local v422 = ""
        for v423, v426 in pairs(p421) do
            if v426 ~= 0 then
                local v425 = v_u_154[v423] or v423
                if v425:sub(1, 1) == "%" or v425:sub(1, 1) == "x" then
                    local v426 = v426 * 100
                else
                    v425 = " " .. v425
                end
                local v427 = v426 > 0 and "+" or ""
                local v428 = v426 * 10
                v422 = v422 .. v427 .. math.floor(v428) / 10 .. v425 .. ", "
                if #v422 > 45 then
                    v_u_420(v422:sub(1, #v422 - 2))
                    v422 = ""
                end
            end
        end
        v_u_420((v422:sub(1, #v422 - 2)))
    end
end
v_u_414 = v_u_412
local v_u_429 = v_u_411.GlossaryFrame
local v_u_430 = {}
local function v_u_437()
    local v431 = v_u_132.Cubits
    for _, v432 in pairs(v_u_430) do
        local v433, v434, v435 = table.unpack(v432)
        local v436 = table.find(v431, v434)
        v433.Text = v436 and v434 and v434 or ((v435 == "Enemies" or not v434) and "???" or v434)
        v433.BackgroundColor3 = v436 and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(30, 30, 30)
    end
end
local v_u_438 = 0
local function v_u_442()
    v_u_414 = v_u_413
    v_u_137(v_u_414)
    local v439 = #v_u_132.Cubits
    v_u_420("Time Played: " .. v_u_132.TimePlayed)
    local v440 = v_u_420
    local v441 = v_u_132.TotalXP
    v440("Total XP Gained: " .. math.floor(v441))
    v_u_420("Total Gold Gained: " .. v_u_132.TotalGold)
    v_u_420("Cubits Found: " .. v439)
    v_u_420("Rebirths: " .. v_u_132.Rebirths)
    v_u_420("Bonus XP Gain: +" .. v439 * 10 * (1 + v_u_132.Rebirths) .. "%")
    if v_u_438 < v439 then
        v_u_438 = v439
        v_u_437()
    end
end
task.delay(1, function()
    while not v_u_132 do
        task.wait()
    end
    v_u_442()
end)
local v443 = v_u_429.ScrollingFrame
local v444 = v443.Section
local v445 = v_u_132.Cubits
local v_u_446 = v_u_24
local v447 = {
    ["Default"] = "Overworld",
    ["Mines"] = "Mines of Stamog",
    ["Underwater"] = "Depths",
    ["Depths"] = "Deepsea Temple",
    ["Void Tower"] = "Tower of Sanctity",
    ["Mirage"] = "Realm of Mirage",
    ["Grandia"] = "Fallen Grandia"
}
for _, v448 in pairs({
    "Default",
    "Mines",
    "Hub of Rebirth",
    "Athenia",
    "Hall of Time",
    "Underwater",
    "Depths",
    "Citadel",
    "Void",
    "Void Tower",
    "Mirage",
    "Grandia"
}) do
    for v449, v450 in pairs(v56) do
        local v451 = v450[v448]
        if v451 then
            local v452 = v444:Clone()
            v452.Title.Text = (v447[v448] or v448) .. " " .. v449
            v452.Parent = v443
            local v453 = v452.Cubits
            local v454 = v453.Template
            for _, v455 in pairs(v451) do
                local v456 = v454:Clone()
                v456.Parent = v453
                local v457 = table.find(v445, v455)
                table.insert(v_u_430, { v456, v455, v449 })
                v456.Text = v457 and v455 and v455 or ((v449 == "Enemies" or not v455) and "???" or v455)
                v456.BackgroundColor3 = v457 and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(30, 30, 30)
            end
            v454:Destroy()
        end
    end
end
v444:Destroy()
local v_u_458 = v_u_411.Settings.Text
local v_u_459 = nil
v_u_411.Settings.MouseButton1Click:Connect(function()
    if not v_u_459 then
        v_u_459 = true
        v_u_411.Settings.Text = "PROCESSING..."
        local function v467(p460)
            table.remove(v_u_132.Inventory, p460)
            for v461, v462 in pairs(v_u_132.Equipped) do
                if p460 == v462 then
                    v_u_132.Equipped[v461] = nil
                elseif p460 < v462 then
                    local v463 = v_u_132.Equipped
                    v463[v461] = v463[v461] - 1
                end
            end
            for _, v464 in pairs(v_u_132.Loadouts) do
                for v465, v466 in pairs(v464) do
                    if v466 == p460 then
                        v464[v465] = nil
                    elseif p460 < v466 then
                        v464[v465] = v464[v465] - 1
                    end
                end
            end
        end
        local v468 = {}
        local v469 = {}
        for _ = 1, 2 do
            local v470 = {}
            for v471 = #v_u_132.Inventory, 1, -1 do
                local v472 = v_u_132.Inventory[v471]
                local v473 = v472[1]
                local v474 = not v468[v473]
                v468[v473] = v468[v473] or {}
                local v475 = v468[v473]
                local v476 = 0
                for v477, v478 in pairs(v472) do
                    if v477 ~= 1 then
                        v476 = v476 + 1
                        v469[v473] = true
                        v475[v477] = v475[v477] or 0
                        if v475[v477] <= v478 then
                            v475[v477] = v478
                            v474 = true
                        end
                    end
                end
                v470[v473] = v470[v473] or -1
                if v470[v473] < v476 then
                    v470[v473] = v476
                    v474 = true
                end
                if v469[v473] then
                    if not v474 then
                        v467(v471)
                    end
                end
            end
        end
        v_u_12:FireServer("ClearJunk")
        UpdateEquipped()
        v_u_446()
        if not v_u_132.Inventory[v_u_155] then
            v_u_155 = #v_u_132.Inventory
        end
        display(isEquipped(v_u_155))
        v_u_411.Settings.Text = v_u_458
        task.wait(3)
        v_u_459 = false
    end
end)
v_u_411.Glossary.MouseButton1Click:Connect(function()
    v_u_429.Visible = not v_u_429.Visible
end)
v_u_18:UIWRAP(v_u_411.Glossary)
function v_u_25.UpdateFlavor(...)
    local v479 = v_u_132
    local v480 = v_u_132
    local v481 = v_u_132
    local v482, v483, v484, v485 = ...
    v_u_132.TimePlayed = v482
    v479.TotalXP = v483
    v480.TotalGold = v484
    v481.Cubits = v485
    v_u_442()
end
local v_u_486 = v_u_85.Menubar
v_u_486.Inventory.MouseButton1Click:Connect(function()
    v_u_85.Reader.Visible = true
    v_u_328.Visible = true
    v_u_411.Visible = false
    local v487 = {
        ["Target"] = v_u_486.Inventory,
        ["Goal"] = {
            ["BackgroundColor3"] = v_u_87
        }
    }
    if not v487.Time then
        v487.Time = 0.5
    end
    v_u_18:Tween(v487)
    local v488 = {
        ["Target"] = v_u_486.Stats,
        ["Goal"] = {
            ["BackgroundColor3"] = v_u_88
        }
    }
    if not v488.Time then
        v488.Time = 0.5
    end
    v_u_18:Tween(v488)
end)
v_u_486.Stats.MouseButton1Click:Connect(function()
    v_u_85.Reader.Visible = false
    v_u_328.Visible = false
    v_u_411.Visible = true
    local v489 = {
        ["Target"] = v_u_486.Inventory,
        ["Goal"] = {
            ["BackgroundColor3"] = v_u_88
        }
    }
    if not v489.Time then
        v489.Time = 0.5
    end
    v_u_18:Tween(v489)
    local v490 = {
        ["Target"] = v_u_486.Stats,
        ["Goal"] = {
            ["BackgroundColor3"] = v_u_87
        }
    }
    if not v490.Time then
        v490.Time = 0.5
    end
    v_u_18:Tween(v490)
end)
for _, v491 in pairs(v_u_486:GetChildren()) do
    if v491:IsA("TextButton") then
        v_u_18:UIWRAP(v491)
    end
end
local v_u_492 = require(v_u_3.Shops)
local v_u_493 = nil
local v_u_494 = 0
local v_u_495 = tick()
local v_u_496 = v_u_83.RefreshTime
local v497 = v_u_83.Reader
local v_u_498 = v156[v497]
local v_u_499 = 0
local v_u_500 = v_u_83.Pattern.Frame
function UpdateStore()
    local v501 = v_u_493.Title
    local v502 = v_u_493.Items
    local v503 = v_u_493.RefreshTime
    v_u_83.Title.Text = v501
    v_u_137(v_u_500)
    for v_u_504, v505 in pairs(v502) do
        local v506 = v505.ID
        local v507 = v_u_18:Abbreviate(v505.Cost)
        local _ = v505.type
        local _ = v505.Variance
        local v_u_508 = v_u_18:StoreToInventory(v505)
        local v509 = Instance.new("Frame")
        v509.BackgroundTransparency = 1
        v509.Parent = v_u_500
        local v510 = Instance.new("TextLabel")
        v510.BackgroundTransparency = 1
        v510.Font = Enum.Font.GothamBlack
        Instance.new("UIStroke").Parent = v510
        v510.Size = UDim2.new(1, 0, 0.2, 0)
        v510.Position = UDim2.new(0, 0, 1, 0)
        v510.AnchorPoint = Vector2.new(0, 1)
        v510.Text = "Cost: " .. v507
        v510.TextColor3 = Color3.new(0.9, 0.8, 0.45)
        v510.TextScaled = true
        v510.Parent = v509
        local v511 = v505.Currency
        if v511 then
            local v512 = v_u_18:Icon(v511)
            v512.Parent = v510
            v512.Position = UDim2.new(1, 0, 0.5, 0)
            v512.AnchorPoint = Vector2.new(0, 0.5)
            v512.Size = UDim2.new(0, 20, 0, 20)
            v512.BackgroundTransparency = 1
            Instance.new("UIAspectRatioConstraint").Parent = v512
            v510.TextXAlignment = Enum.TextXAlignment.Left
            v510.TextColor3 = Color3.new(1, 0.5, 0.15)
            v510.Size = v510.Size - UDim2.new(0, 20, 0, 0)
        end
        local v513 = v_u_14[v506] or {}
        local v514 = v_u_18:Item(v506)
        v514.Parent = v509
        local v515 = v513.Rarity or 1
        if v515 > 255 then
            v509.Name = "\255"
            while v515 > 255 do
                v515 = v515 - 255
                v509.Name = v509.Name .. "\255"
            end
            v509.Name = v509.Name .. string.char(v515) .. 10 - v_u_504
        else
            v509.Name = string.char(v515)
        end
        v514.Size = UDim2.new(1, 0, 1, 0)
        Instance.new("UIAspectRatioConstraint").Parent = v514
        v_u_18:UIWRAP(v514, 0.65)
        v514.Activated:Connect(function()
            v_u_498(v_u_508)
            v_u_499 = v_u_504
        end)
    end
    v_u_494 = v503
    v_u_495 = tick()
    local v516 = v_u_494 - (tick() - v_u_495)
    v_u_496.Text = "Refreshes in " .. (os.date("%X", v516 + 46800) or "NOW!")
end
v497.Buy.MouseButton1Click:Connect(function()
    local _ = v_u_493.Items[v_u_499].ID
    v_u_12:FireServer("ShopPurchase", v_u_493.Title, v_u_499)
end)
v_u_18:UIWRAP(v497.Buy)
v_u_83.Close.MouseButton1Click:Connect(function()
    v_u_83.Visible = false
end)
v_u_18:UIWRAP(v_u_83.Close)
local function v_u_518()
    local v517 = v_u_494 - (tick() - v_u_495)
    v_u_496.Text = "Refreshes in " .. (os.date("%X", v517 + 46800) or "NOW!")
    task.wait(1)
    v_u_518()
end
task.spawn(v_u_518)
function v_u_25.OpenShop(...)
    if not v_u_83.Visible or (...).Title ~= v_u_493.Title then
        v_u_493 = ...
        v_u_134()
        v_u_83.Visible = true
        UpdateStore()
    end
end
local v_u_519 = v_u_84.Chest
local v_u_520 = v_u_132.LastClaim or 0
v_u_132.Offering = v_u_132.Offering or 42069
local v_u_521 = nil
local v_u_522 = 0
local v_u_523 = v_u_75.XPCombo
local function v525()
    if v_u_521 and getOrSetCooldowns("XP Refresh", 1) then
        local v524 = tick() - v_u_521 + v_u_522
        v_u_523.Timer.Text = os.date("%X", 50400 - v524)
        if v524 > 3600 then
            v_u_521 = nil
            v_u_523.Visible = false
        end
    end
end
table.insert(v_u_6, v525)
function v_u_25.XPBuffTimer(...)
    local v526, v527 = ...
    if v526 then
        v_u_522 = v527
        v_u_523.Combo.Text = "x" .. 1 + v526
        v_u_521 = tick()
        if not v_u_523.Visible then
            v_u_523.Visible = true
            return
        end
    else
        v_u_521 = nil
        v_u_523.Visible = false
    end
end
local v_u_528 = true
local function v530()
    local v529 = tick() - v_u_520
    if v_u_528 and (v529 < 900 and getOrSetCooldowns("Chest Refresh", 1)) then
        v_u_519.Timer.Text = "Refreshes in " .. os.date("%X", 900 - v529)
    elseif v_u_528 and v529 >= 900 then
        v_u_528 = nil
        v_u_519.Timer.Text = "Claim NOW!"
    end
end
table.insert(v_u_6, v530)
local v_u_531 = v_u_132.RebirthPassDisabled
local v_u_532 = v_u_84.Settings.Gradient
v_u_532.RebirthPass.Button.MouseButton1Click:Connect(function()
    v_u_531 = not v_u_531
    v_u_12:FireServer("RebirthPassDisabled", v_u_531)
    v_u_532.RebirthPass.Button.Text = v_u_531 and "OFF" or "ON"
end)
v_u_519.Claim.MouseButton1Click:Connect(function()
    if tick() - v_u_520 >= 900 then
        v_u_12:FireServer("ClaimOffering")
    end
end)
v_u_519.GoldClaim.Text = "Claim your <b>FREE</b> " .. v_u_132.Offering .. " Gold!"
function v_u_25.UpdateOffering(...)
    v_u_132.Offering = ...
    v_u_520 = tick()
    v_u_519.GoldClaim.Text = "Claim your <b>FREE</b> " .. v_u_132.Offering .. " Gold!"
    v_u_528 = true
end
local v_u_533 = game:GetService("MarketplaceService")
local v_u_534 = { 1294860608, 1280288070 }
local v_u_535 = {
    71295330,
    84035273,
    69648816,
    69665025
}
local v_u_536 = v_u_84.DevProduct.Gradient
local v_u_537 = v_u_536.Template
task.spawn(function()
    for _, v_u_538 in pairs(v_u_534) do
        local v539 = v_u_533:GetProductInfo(v_u_538, Enum.InfoType.Product)
        local v540 = v_u_537:Clone()
        v540.ImageLabel.Image = "rbxassetid://" .. v539.IconImageAssetId
        v540.Title.Text = v539.Name
        v540.Description.Text = v539.Description .. " " .. v539.PriceInRobux .. "R$"
        v540.Buy.MouseButton1Click:Connect(function()
            v_u_533:PromptProductPurchase(v_u_1, v_u_538)
        end)
        v_u_18:UIWRAP(v540.Buy)
        v540.Parent = v_u_536
    end
    v_u_537:Destroy()
    local v541 = v_u_84.GamepassGrid.Gradient
    for _, v_u_542 in pairs(v_u_535) do
        local v543 = v_u_533:GetProductInfo(v_u_542, Enum.InfoType.GamePass)
        local v544 = Instance.new("ImageButton")
        v544.BackgroundTransparency = 1
        v544.Image = "rbxassetid://" .. v543.IconImageAssetId
        Instance.new("UIAspectRatioConstraint").Parent = v544
        local v_u_545 = Instance.new("UIScale")
        v_u_545.Parent = v544
        v544.MouseEnter:Connect(function()
            local v546 = {
                ["Target"] = v_u_545,
                ["Goal"] = {
                    ["Scale"] = 1.25
                },
                ["Time"] = 0.5
            }
            v_u_18:Tween(v546)
        end)
        v544.MouseLeave:Connect(function()
            local v547 = {
                ["Target"] = v_u_545,
                ["Goal"] = {
                    ["Scale"] = 1
                },
                ["Time"] = 0.25
            }
            v_u_18:Tween(v547)
        end)
        v544.MouseButton1Click:Connect(function()
            v_u_533:PromptGamePassPurchase(v_u_1, v_u_542)
        end)
        v544.Parent = v541
    end
end)
local v_u_548 = v_u_84.CodeBox
local v_u_549 = v_u_3.RemoteFunction
v_u_548.FocusLost:Connect(function()
    local v550 = v_u_548.Text
    v_u_548.Text = "..."
    v_u_548.Text = v_u_549:InvokeServer("Code", v550:lower())
end)
local v551 = v_u_84.WeaponScale.Gradient
local v_u_552 = v551.Frame
local v_u_553 = v_u_552.Marker
local v554 = v_u_132.WeaponScaleMAX and 2 or 1
local v555 = v_u_132.WeaponLimit
v_u_552.Right.TextLabel.Text = v554 * (1.25 + (0.5 * v555 or 0)) .. "X"
v_u_552.Centre.TextLabel.Text = v554 * (1 + (0.5 * v555 or 0)) .. "X"
function v_u_25.UpdateWeaponMAX(...)
    v_u_132.WeaponScaleMAX = ...
    local v556 = v_u_132.WeaponScaleMAX and 2 or 1
    local v557 = v_u_132.WeaponLimit
    v_u_552.Right.TextLabel.Text = v556 * (1.25 + (0.5 * v557 or 0)) .. "X"
    v_u_552.Centre.TextLabel.Text = v556 * (1 + (0.5 * v557 or 0)) .. "X"
end
function v_u_25.UpdateWeaponLimit(...)
    v_u_132.WeaponLimit = ...
    local v558 = v_u_132.WeaponScaleMAX and 2 or 1
    local v559 = v_u_132.WeaponLimit
    v_u_552.Right.TextLabel.Text = v558 * (1.25 + (0.5 * v559 or 0)) .. "X"
    v_u_552.Centre.TextLabel.Text = v558 * (1 + (0.5 * v559 or 0)) .. "X"
end
local v_u_560 = v_u_1:GetMouse()
local function v_u_566()
    local v561 = v_u_560.X
    local v562 = v_u_552.AbsolutePosition.X
    local v563 = v_u_552.AbsoluteSize.X
    local v564 = (v561 - v562) / v563
    local v565 = math.clamp(v564, 0, 1)
    v_u_553.Position = UDim2.new(v565, 0, 0, 0)
end
v_u_552.InputBegan:Connect(function(p_u_567)
    if p_u_567.UserInputType == Enum.UserInputType.MouseButton1 or p_u_567.UserInputType == Enum.UserInputType.Touch then
        local v568 = v_u_560.X
        local v569 = v_u_552.AbsolutePosition.X
        local v570 = v_u_552.AbsoluteSize.X
        local v571 = (v568 - v569) / v570
        local v572 = math.clamp(v571, 0, 1)
        v_u_553.Position = UDim2.new(v572, 0, 0, 0)
        local v_u_573 = v_u_560.Move:Connect(v_u_566)
        local v_u_574 = nil
        v_u_574 = p_u_567.Changed:Connect(function()
            if p_u_567.UserInputState == Enum.UserInputState.End then
                v_u_573:Disconnect()
                v_u_574:Disconnect()
            end
        end)
    end
end)
v551.Add.MouseButton1Click:Connect(function()
    v_u_533:PromptProductPurchase(v_u_1, 1280325462)
end)
v551.Apply.MouseButton1Click:Connect(function()
    v_u_12:FireServer("UpdateWeaponScale", v_u_553.Position.X.Scale)
end)
local v_u_575 = v_u_75.Crafting
local v_u_576 = require(v_u_3.Crafting)
local v_u_577 = v_u_575.Orator
local v_u_578 = v_u_575.Blurb
local v_u_579 = v_u_575.Settings
local v580 = v_u_575.Selection
local v_u_581 = v_u_575.Result
local v_u_582 = v_u_575.Selected
local v_u_583 = v580.Inventory.Items
local v584 = v580.Inventory.Filter
local v585 = v_u_579.Clear
local v586 = v_u_578.Craft
local v_u_587 = v_u_577.Text
local v_u_588 = Instance.new("Folder")
v_u_588.Parent = workspace
v_u_588.Name = "Screen2D"
local v_u_589 = {}
local v_u_590 = v_u_581["1"]:Clone()
local v_u_591 = v_u_582["1"]:Clone()
local function v_u_594(p592)
    for _, v593 in pairs(p592:GetChildren()) do
        if v593:IsA("GuiObject") then
            v593:Destroy()
        end
    end
end
local function v_u_598()
    v_u_589 = {}
    v_u_578.Visible = false
    v_u_594(v_u_582)
    local v595 = v_u_591:Clone()
    v595.Name = 1
    v595.Parent = v_u_582
    local v596 = v_u_591:Clone()
    v596.Name = 2
    v596.Parent = v_u_582
    local v597 = v_u_591:Clone()
    v597.Name = 3
    v597.Parent = v_u_582
end
local v_u_599 = nil
local function v_u_604()
    if v_u_599 then
        v_u_599:Disconnect()
        v_u_599 = nil
    end
    for _, v600 in pairs(v_u_588:GetChildren()) do
        local v601 = 0
        for _, v602 in pairs(v600:GetChildren()) do
            v602.Enabled = false
            local v603 = v602.Lifetime.Max
            v601 = math.max(v603, v601)
        end
        game.Debris:AddItem(v600, v601)
    end
end
local function v_u_625(p605, p606, p607, p608, p609)
    local v610 = Vector2.new(p605.X, p605.Y) - p606.AbsolutePosition
    local v611 = Vector2.new(p606.AbsoluteSize.X, p606.AbsoluteSize.Y - (p609 or 0))
    local v612 = v611.Y
    local v613 = v611.X
    local v614 = v611.X / v611.Y
    local _ = p607.CFrame.Position
    local v615 = p608 or 1
    local v616 = p607.FieldOfView
    local v617 = math.rad(v616) / 2
    local v618 = math.tan(v617)
    local v619 = 2 * v615 * (v610.x / (v613 - 1)) - v615 * 1
    local v620 = 2 * v615 * (v610.y / (v612 - 1)) - v615 * 1
    local v621 = v614 * v618 * v619
    local v622 = -v618 * v620
    local v623 = -v615
    local v624 = p607.CFrame * CFrame.new((Vector3.new(v621, v622, v623)))
    return CFrame.new(v624.Position, p607.CFrame.Position)
end
local function v_u_627()
    for _, v626 in pairs(v_u_588:GetChildren()) do
        v626.CFrame = v_u_625(v626:GetAttribute("ScreenPosition"), v_u_75, v_u_100, 8)
    end
end
local function v_u_632(p628, p629, p630)
    if not v_u_599 then
        v_u_599 = v_u_5.RenderStepped:Connect(v_u_627)
    end
    local v631 = v_u_18:Part({
        ["Anchored"] = true,
        ["Transparency"] = 1,
        ["Size"] = Vector3.new(1, 1, 1)
    })
    v631:SetAttribute("ScreenPosition", p628.AbsolutePosition + p628.AbsoluteSize / 2)
    v631.Parent = v_u_588
    v631.Name = p629
    if p630 then
        p630.Target = v631
        if p630.Set then
            v_u_18:EmitSet(p630)
        else
            v_u_18:Emit(p630)
        end
    else
        v_u_18:EmitSet({
            ["Target"] = v631,
            ["ParticleId"] = "BazookaFire2D",
            ["Color"] = Color3.new(1, 1, 1)
        })
        return
    end
end
v585.MouseButton1Click:Connect(function()
    v_u_578.Visible = false
    v_u_594(v_u_581)
    v_u_590:Clone().Parent = v_u_581
    local v633 = v_u_588:FindFirstChild("r1")
    if v633 then
        v633:Destroy()
    end
    v_u_598()
    v_u_579.Visible = false
    v_u_604()
    local v_u_634 = v_u_587
    v_u_577.MaxVisibleGraphemes = 0
    v_u_577.Text = v_u_634
    task.spawn(function()
        local v635 = v_u_634:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
        local v636 = 0
        for v637, v638 in utf8.graphemes(v635) do
            v635:sub(v637, v638)
            v636 = v636 + 1
            v_u_577.MaxVisibleGraphemes = v636
            task.wait()
        end
    end)
end)
v_u_18:UIWRAP(v585)
local v_u_639 = v584.Access
local v_u_640 = v584.Query
local v_u_641 = v584.Filter
local v_u_642 = v_u_589
local v_u_643 = {
    ["attack"] = "ad",
    ["power"] = "ad",
    ["pen"] = "apen",
    ["melee pen"] = "apen",
    ["magic pen"] = "mpen",
    ["armor shred"] = "shred",
    ["melee shred"] = "pd shred",
    ["magic shred"] = "mr shred",
    ["ap mult"] = "apmult",
    ["ad mult"] = "admult",
    ["apx"] = "apmult",
    ["adx"] = "admult",
    ["dx"] = "mult",
    ["magic"] = "ap",
    ["melee"] = "ad",
    ["damage"] = "ad",
    ["dmg"] = "ad",
    ["jump"] = "jp",
    ["ls"] = "lifesteal",
    ["attack spd"] = "as",
    ["attack speed"] = "as",
    ["dmg reduction"] = "reduction"
}
local v_u_644 = {
    ["NewFirst"] = "Newest",
    ["RarityUP"] = "Rarity \226\134\145",
    ["RarityDN"] = "Rarity \226\134\147"
}
local v_u_645 = {
    "Date",
    "NewFirst",
    "RarityUP",
    "RarityDN",
    "Type",
    "Power"
}
local v_u_646 = ""
local v_u_647 = 1
local v_u_648 = false
for v649, v650 in pairs(v_u_154) do
    v_u_643[v649:lower()] = v649:lower()
    v_u_643[v650:lower()] = v649:lower()
end
local function v_u_661()
    local v651 = #v_u_646 > 0 and true or v_u_648
    local v652 = v_u_645[v_u_647]
    for _, v653 in pairs(v_u_583:GetChildren()) do
        if v653:IsA("TextButton") then
            if v651 then
                local v654 = v_u_643[v_u_646]
                local v655 = v653:GetAttribute("Name")
                if v654 then
                    local v656 = v_u_14[v655]
                    v653.Visible = false
                    if v656 then
                        for v657, _ in pairs(v656.Stats or {}) do
                            if v654 == v657:lower() then
                                v653.Visible = true
                            end
                        end
                        for _, v658 in pairs(v656.Variance or {}) do
                            for v659, _ in pairs(v658) do
                                if type(v659) == "string" and v654 == v659:lower() then
                                    v653.Visible = true
                                end
                            end
                        end
                    end
                elseif v655:lower():find(v_u_646) then
                    v653.Visible = true
                else
                    v653.Visible = false
                end
                if v_u_648 then
                    local v660 = v653.Visible
                    if v660 then
                        v660 = v_u_576.Components[v655]
                    end
                    v653.Visible = v660
                end
            else
                v653.Visible = true
            end
            v653.Name = v653:GetAttribute(v652)
        end
    end
end
v_u_639.FocusLost:Connect(function(_)
    v_u_646 = v_u_639.Text:lower()
    v_u_661()
end)
v_u_640.MouseButton1Click:Connect(function()
    v_u_647 = v_u_647 % #v_u_645 + 1
    local v662 = v_u_645[v_u_647]
    v_u_640.Text = v_u_644[v662] or v662
    v_u_661()
end)
v_u_18:UIWRAP(v_u_640)
v_u_641.MouseButton1Click:Connect(function()
    v_u_648 = not v_u_648
    v_u_641.Text = v_u_648 and "Ingredients Only" or "All Items"
    v_u_661()
end)
v_u_18:UIWRAP(v_u_641)
local function v_u_671(p663, p664, p665)
    local v666 = p664[1]
    local v667 = v_u_14[v666] or {}
    local v668 = v667.Stats or {}
    local v669 = (v668.AD or 0) + (v668.AP or 0) + (v668.HP or 0) + (v668.PD or 0) + (v668.MR or 0)
    if #p664 > 1 then
        for v670 = 2, #p664 do
            v669 = v669 + (p664[v670] or 0) * 10
        end
    end
    p663:SetAttribute("Name", v666)
    p663:SetAttribute("Slot", p665)
    p663:SetAttribute("Date", basen(p665))
    p663:SetAttribute("NewFirst", basen(p665, true))
    p663:SetAttribute("RarityUP", basen(v667.Rarity or 1))
    p663:SetAttribute("RarityDN", basen(v667.Rarity or 1, true))
    p663:SetAttribute("Type", v667.Type or "Sword")
    p663:SetAttribute("Power", basen(v669))
    p663.Name = p663:GetAttribute(v_u_645[v_u_647])
    if #v_u_646 > 0 then
        if v666:lower():find(v_u_646) then
            p663.Visible = true
            return
        end
        p663.Visible = false
    end
end
local v_u_672 = v156[v_u_578]
local function v_u_680(p673, p674)
    local v675 = not p674
    local v676 = p674 or 1
    local v677 = v_u_18:Item(p673)
    local v678 = Instance.new("UISizeConstraint")
    v678.MaxSize = Vector2.new(200, 200)
    v678.Parent = v677
    local v679 = v_u_581:FindFirstChild((tostring(v676)))
    if v679 then
        v679:Destroy()
    end
    v677.Name = v676
    v677.Parent = v_u_581
    if v675 then
        v_u_632(v677, "r" .. v676)
    end
    if v_u_14[p673] then
        v_u_578.Visible = true
        v_u_672({ p673 })
    end
end
local function v_u_752(p_u_681, p682)
    local v683 = p682[1]
    if #v_u_642 == 3 then
        v_u_577.MaxVisibleGraphemes = 0
        v_u_577.Text = "I see no good coming out of this"
        local v_u_684 = "I see no good coming out of this"
        task.spawn(function()
            local v685 = v_u_684:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
            local v686 = 0
            for v687, v688 in utf8.graphemes(v685) do
                v685:sub(v687, v688)
                v686 = v686 + 1
                v_u_577.MaxVisibleGraphemes = v686
                task.wait()
            end
        end)
        return
    else
        for _, v689 in pairs(v_u_642) do
            if v689[1] == p_u_681 then
                v_u_577.MaxVisibleGraphemes = 0
                v_u_577.Text = "You shant speak twice, fool"
                local v_u_690 = "You shant speak twice, fool"
                task.spawn(function()
                    local v691 = v_u_690:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
                    local v692 = 0
                    for v693, v694 in utf8.graphemes(v691) do
                        v691:sub(v693, v694)
                        v692 = v692 + 1
                        v_u_577.MaxVisibleGraphemes = v692
                        task.wait()
                    end
                end)
                return
            end
        end
        local v695 = v_u_642
        table.insert(v695, { p_u_681, v683 })
        for _, v696 in pairs(v_u_642) do
            print(v696[2])
        end
        local v697 = #v_u_642
        local v_u_698 = v_u_18:Item(v683)
        local v699 = Instance.new("UISizeConstraint")
        v699.MaxSize = Vector2.new(100, 100)
        v699.Parent = v_u_698
        local v700 = v_u_582:FindFirstChild((tostring(v697)))
        if v700 then
            v700:Destroy()
        end
        v_u_698.Name = v697
        v_u_698.Parent = v_u_582
        v_u_18:UIWRAP(v_u_698, 0.65)
        v_u_698.Activated:Connect(function()
            local v701 = #v_u_642
            print("Pressed", v701)
            for v702 = v701, 1, -1 do
                if v_u_642[v702][1] == p_u_681 then
                    table.remove(v_u_642, v702)
                    v_u_698:Destroy()
                    local v703 = v_u_588:FindFirstChild("s" .. tostring(v701))
                    if v703 then
                        v703:Destroy()
                    end
                    for v704 = v702 + 1, v701 do
                        local v705 = v_u_582:FindFirstChild((tostring(v704)))
                        if v705 then
                            local v706 = v704 - 1
                            v705.Name = tostring(v706)
                        end
                    end
                    local v707 = v_u_591:Clone()
                    v707.Name = v701
                    v707.Parent = v_u_582
                    v_u_578.Visible = false
                    v_u_594(v_u_581)
                    v_u_590:Clone().Parent = v_u_581
                    local v708 = v_u_588:FindFirstChild("r1")
                    if v708 then
                        v708:Destroy()
                    end
                    v_u_577.MaxVisibleGraphemes = 0
                    v_u_577.Text = "..."
                    local v_u_709 = "..."
                    task.spawn(function()
                        local v710 = v_u_709:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
                        local v711 = 0
                        for v712, v713 in utf8.graphemes(v710) do
                            v710:sub(v712, v713)
                            v711 = v711 + 1
                            v_u_577.MaxVisibleGraphemes = v711
                            task.wait()
                        end
                    end)
                    v_u_579.Visible = v701 > 1
                end
            end
        end)
        v_u_632(v_u_698, "s" .. v697)
        v_u_579.Visible = true
        local v714 = v_u_576:PruneEnchants(v_u_642)
        local v715 = #v714
        local v716
        if v715 > 0 then
            v716 = v697 ~= v715
        else
            v716 = false
        end
        if v715 == 1 and v716 then
            v_u_578.Visible = false
            v_u_594(v_u_581)
            v_u_590:Clone().Parent = v_u_581
            local v717 = v_u_588:FindFirstChild("r1")
            if v717 then
                v717:Destroy()
            end
            v_u_680(v714[1][1])
            v_u_577.MaxVisibleGraphemes = 0
            v_u_577.Text = "You seek great power.."
            local v_u_718 = "You seek great power.."
            task.spawn(function()
                local v719 = v_u_718:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
                local v720 = 0
                for v721, v722 in utf8.graphemes(v719) do
                    v719:sub(v721, v722)
                    v720 = v720 + 1
                    v_u_577.MaxVisibleGraphemes = v720
                    task.wait()
                end
            end)
            return
        elseif v715 == 1 then
            v_u_577.MaxVisibleGraphemes = 0
            v_u_577.Text = "This item has potential..."
            local v_u_723 = "This item has potential..."
            task.spawn(function()
                local v724 = v_u_723:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
                local v725 = 0
                for v726, v727 in utf8.graphemes(v724) do
                    v724:sub(v726, v727)
                    v725 = v725 + 1
                    v_u_577.MaxVisibleGraphemes = v725
                    task.wait()
                end
            end)
            return
        else
            local v728, v_u_729 = v_u_576:FindRecipe(v_u_132, v_u_642)
            if v728 then
                v_u_578.Visible = false
                v_u_594(v_u_581)
                v_u_590:Clone().Parent = v_u_581
                local v730 = v_u_588:FindFirstChild("r1")
                if v730 then
                    v730:Destroy()
                end
                local v731 = v728.Reward[1]
                if typeof(v731) == "table" then
                    for v732, v733 in pairs(v728.Reward) do
                        v_u_680(v733[2], v732)
                    end
                else
                    v_u_680(v728.Reward[2])
                end
                if tonumber(v_u_729) then
                    v_u_577.MaxVisibleGraphemes = 0
                    v_u_577.Text = "Your choice shall bring you great power..."
                    local v_u_734 = "Your choice shall bring you great power..."
                    task.spawn(function()
                        local v735 = v_u_734:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
                        local v736 = 0
                        for v737, v738 in utf8.graphemes(v735) do
                            v735:sub(v737, v738)
                            v736 = v736 + 1
                            v_u_577.MaxVisibleGraphemes = v736
                            task.wait()
                        end
                    end)
                else
                    v_u_577.MaxVisibleGraphemes = 0
                    v_u_577.Text = v_u_729
                    task.spawn(function()
                        local v739 = v_u_729:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
                        local v740 = 0
                        for v741, v742 in utf8.graphemes(v739) do
                            v739:sub(v741, v742)
                            v740 = v740 + 1
                            v_u_577.MaxVisibleGraphemes = v740
                            task.wait()
                        end
                    end)
                end
            elseif v_u_729 then
                v_u_577.MaxVisibleGraphemes = 0
                v_u_577.Text = v_u_729
                task.spawn(function()
                    local v743 = v_u_729:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
                    local v744 = 0
                    for v745, v746 in utf8.graphemes(v743) do
                        v743:sub(v745, v746)
                        v744 = v744 + 1
                        v_u_577.MaxVisibleGraphemes = v744
                        task.wait()
                    end
                end)
                return
            elseif v697 ~= 2 then
                v_u_577.MaxVisibleGraphemes = 0
                v_u_577.Text = "... Unexpected forces have intervened"
                local v_u_747 = "... Unexpected forces have intervened"
                task.spawn(function()
                    local v748 = v_u_747:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
                    local v749 = 0
                    for v750, v751 in utf8.graphemes(v748) do
                        v748:sub(v750, v751)
                        v749 = v749 + 1
                        v_u_577.MaxVisibleGraphemes = v749
                        task.wait()
                    end
                end)
            end
        end
    end
end
v586.MouseButton1Click:Connect(function()
    print("Craft!", #v_u_642)
    v_u_12:FireServer("Craft", v_u_642)
    v_u_577.MaxVisibleGraphemes = 0
    v_u_577.Text = "..."
    local v_u_753 = "..."
    task.spawn(function()
        local v754 = v_u_753:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
        local v755 = 0
        for v756, v757 in utf8.graphemes(v754) do
            v754:sub(v756, v757)
            v755 = v755 + 1
            v_u_577.MaxVisibleGraphemes = v755
            task.wait()
        end
    end)
end)
local v758 = v_u_579.Help
local v_u_759 = {
    "Consider including",
    "Perhaps try..",
    "Ah! Use",
    "Why not",
    "Try",
    "Suggesting",
    "..",
    "\240\159\152\130\240\159\152\130",
    "Hmmmm...",
    "Do",
    "Use",
    "Consider",
    "Go for",
    "AHH!",
    "Shadovians preferred",
    "SUMMON THEE:",
    "Wise choice"
}
v758.MouseButton1Click:Connect(function()
    local v760 = v_u_576.Components[v_u_642[1][2]]
    local v761 = #v_u_642
    local v762 = {}
    for _, v763 in pairs(v760) do
        local v764 = 0
        for _, v765 in pairs(v_u_642) do
            local v766 = v765[2]
            local v767 = false
            for _, v768 in pairs(v763.Components) do
                if v768[2] == v766 then
                    v767 = true
                end
            end
            if v767 then
                v764 = v764 + 1
            end
        end
        if v764 == v761 then
            table.insert(v762, v763)
        end
    end
    local v769 = {}
    for _, v770 in pairs(v762) do
        for _, v771 in pairs(v770.Components) do
            local v772 = v771[2]
            local v773 = false
            for _, v774 in pairs(v_u_642) do
                if v774[2] == v772 then
                    v773 = true
                end
            end
            if not v773 then
                table.insert(v769, v772)
            end
        end
    end
    if #v769 == 0 then
        print("no options open")
    else
        print(table.concat(v769, ", "), "yes those smart enough to press f9 can just see all possibilities. haha.")
        local v_u_775 = table.concat({ v_u_759[math.random(#v_u_759)], v769[math.random(#v769)] }, " ")
        v_u_577.MaxVisibleGraphemes = 0
        v_u_577.Text = v_u_775
        task.spawn(function()
            local v776 = v_u_775:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
            local v777 = 0
            for v778, v779 in utf8.graphemes(v776) do
                v776:sub(v778, v779)
                v777 = v777 + 1
                v_u_577.MaxVisibleGraphemes = v777
                task.wait()
            end
        end)
    end
end)
v_u_18:UIWRAP(v758)
local function v_u_790()
    v_u_594(v_u_583)
    for v_u_780, v_u_781 in pairs(v_u_132.Inventory) do
        local v_u_782 = v_u_781[1]
        local v783 = v_u_18:Item(v_u_782)
        v783.Parent = v_u_583
        v_u_671(v783, v_u_781, v_u_780)
        v_u_18:UIWRAP(v783, 0.65)
        v783.Activated:Connect(function()
            print("pressed", v_u_782)
            v_u_752(v_u_780, v_u_781)
        end)
    end
    v_u_661()
    v_u_578.Visible = false
    v_u_594(v_u_581)
    v_u_590:Clone().Parent = v_u_581
    local v784 = v_u_588:FindFirstChild("r1")
    if v784 then
        v784:Destroy()
    end
    v_u_598()
    v_u_579.Visible = false
    v_u_604()
    local v_u_785 = v_u_587
    v_u_577.MaxVisibleGraphemes = 0
    v_u_577.Text = v_u_785
    task.spawn(function()
        local v786 = v_u_785:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
        local v787 = 0
        for v788, v789 in utf8.graphemes(v786) do
            v786:sub(v788, v789)
            v787 = v787 + 1
            v_u_577.MaxVisibleGraphemes = v787
            task.wait()
        end
    end)
end
local _ = v580.Inventory.Pattern
function openCrafting()
    if v_u_575.Visible then
        return false
    end
    local v_u_791 = v_u_587
    v_u_577.MaxVisibleGraphemes = 0
    v_u_577.Text = v_u_791
    task.spawn(function()
        local v792 = v_u_791:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
        local v793 = 0
        for v794, v795 in utf8.graphemes(v792) do
            v792:sub(v794, v795)
            v793 = v793 + 1
            v_u_577.MaxVisibleGraphemes = v793
            task.wait()
        end
    end)
    v_u_578.Visible = false
    v_u_577.BackgroundTransparency = v_u_75.AbsoluteSize.Y < 400 and 0 or 1
    v_u_790()
    v_u_575.Visible = true
    v_u_18:Tween({
        ["Target"] = game.Players.LocalPlayer.Character.Humanoid,
        ["Goal"] = {
            ["CameraOffset"] = Vector3.new(0, 2.5, 0)
        },
        ["Time"] = 0.75
    })
end
function v_u_25.FullRefresh(...)
    local v796, v797, v798 = ...
    v_u_132.Equipped = v797
    v_u_132.Loadouts = v798
    v_u_25.RefreshInventory(v796)
    v_u_790()
    v_u_577.MaxVisibleGraphemes = 0
    v_u_577.Text = "Crafting Completed!"
    local v_u_799 = "Crafting Completed!"
    task.spawn(function()
        local v800 = v_u_799:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
        local v801 = 0
        for v802, v803 in utf8.graphemes(v800) do
            v800:sub(v802, v803)
            v801 = v801 + 1
            v_u_577.MaxVisibleGraphemes = v801
            task.wait()
        end
    end)
end
local v804 = v580.Close
v804.MouseButton1Click:Connect(function()
    v_u_578.Visible = false
    v_u_594(v_u_581)
    v_u_590:Clone().Parent = v_u_581
    local v805 = v_u_588:FindFirstChild("r1")
    if v805 then
        v805:Destroy()
    end
    v_u_598()
    v_u_579.Visible = false
    v_u_604()
    local v_u_806 = v_u_587
    v_u_577.MaxVisibleGraphemes = 0
    v_u_577.Text = v_u_806
    task.spawn(function()
        local v807 = v_u_806:gsub("<br%s*/>", "\n"):gsub("<[^<>]->", "")
        local v808 = 0
        for v809, v810 in utf8.graphemes(v807) do
            v807:sub(v809, v810)
            v808 = v808 + 1
            v_u_577.MaxVisibleGraphemes = v808
            task.wait()
        end
    end)
    v_u_575.Visible = false
    local v811 = v_u_18
    local v812 = {
        ["Target"] = game.Players.LocalPlayer.Character.Humanoid,
        ["Goal"] = {
            ["CameraOffset"] = Vector3.new(0, 0, 0)
        },
        ["Time"] = 0.25
    }
    v811:Tween(v812)
end)
v_u_18:UIWRAP(v804)
local v_u_813 = v_u_3.Environments
local v_u_814 = {
    ["Volume"] = 0
}
local v_u_815 = {
    ["Volume"] = 0.5
}
local v_u_816 = v_u_75.Mute
local v_u_817 = { 166377448, 6413981913 }
local v_u_818 = 1
v_u_816.MouseButton1Click:Connect(function()
    v_u_818 = v_u_818 % 2 + 1
    v_u_816.Image = "rbxassetid://" .. v_u_817[v_u_818]
    v_u_815.Volume = (2 - v_u_818) / 2
    v_u_18:Tween({
        ["Target"] = workspace:FindFirstChild("Song") or workspace:FindFirstChildOfClass("Sound"),
        ["Goal"] = v_u_815,
        ["Time"] = 0.2
    })
end)
local v_u_819 = game.Lighting
local v_u_820 = nil
local function v_u_821()
    v_u_820 = false
end
local v_u_822 = v_u_3:FindFirstChild("UnloadedMaps")
if not v_u_822 then
    v_u_822 = Instance.new("Folder")
    v_u_822.Parent = game.ReplicatedStorage
    v_u_822.Name = "UnloadedMaps"
end
local v_u_823 = Instance.new("Folder")
v_u_823.Parent = game.ReplicatedStorage
v_u_823.Name = "UnloadedEnemies"
local v_u_824 = workspace.Maps
local v_u_825 = workspace.NPCs
local v_u_826 = v56.Cores
local v_u_827 = nil
local _ = not v_u_3:GetAttribute("Raid")
local function v_u_835(p828)
    local v829 = p828:FindFirstChild("LastGrouping")
    if v829 then
        v829 = v829.Value
    end
    if not v829 then
        local v830 = p828.WorldPivot.Position
        local v831 = 9000000000
        for _, v832 in pairs(v_u_826) do
            local v833 = (v832[2] - v830).Magnitude
            if v833 < v831 then
                v829 = v832[1]
                v831 = v833
            end
        end
        local v834 = Instance.new("StringValue")
        v834.Name = "LastGrouping"
        v834.Value = tostring(v829)
        v834.Parent = p828
    end
    return v829
end
local v_u_836 = Instance.new("Folder")
v_u_836.Parent = game.ReplicatedStorage
local function v_u_851(p_u_837, p838)
    local v_u_839 = {}
    for _, v840 in pairs(p_u_837:GetChildren()) do
        v840.Parent = v_u_836
        table.insert(v_u_839, v840)
    end
    local v_u_841 = v_u_1.Character.PrimaryPart.Position
    table.sort(v_u_839, function(p842, p843)
        local v844 = not (p842:IsA("BasePart") and p842) and p842:IsA("Model")
        if v844 then
            v844 = p842.PrimaryPart
        end
        local v845 = ((v844 and v844.Position or Vector3.new(0, 0, 0)) - v_u_841).Magnitude
        local v846 = not (p843:IsA("BasePart") and p843) and p843:IsA("Model")
        if v846 then
            v846 = p843.PrimaryPart
        end
        return ((v846 and v846.Position or Vector3.new(0, 0, 0)) - v_u_841).Magnitude < v845
    end)
    p_u_837.Parent = p838
    local v_u_847 = #v_u_839 / 30 + 1
    local function v_u_850()
        local v848 = v_u_847
        local v849 = #v_u_839
        for _ = 1, math.min(v848, v849) do
            table.remove(v_u_839).Parent = p_u_837
        end
        if #v_u_839 > 0 then
            task.wait()
            v_u_850()
        end
    end
    v_u_850()
end
local function v_u_856(p852, p853)
    v_u_827 = p852
    for _, v854 in pairs(v_u_824:GetChildren()) do
        if v854.Name ~= p852 then
            if p853 then
                v854.Parent = v_u_822
            else
                v_u_851(v854, v_u_822)
            end
        end
    end
    for _, v855 in pairs(v_u_825:GetChildren()) do
        if v_u_835(v855) ~= p852 and not v855:GetAttribute("Stubborn") then
            v855.Parent = v_u_823
        end
    end
end
local v_u_857 = "Default"
local function v_u_867(p858)
    local v859 = not v_u_824:FindFirstChild(p858) and v_u_822:FindFirstChild(p858)
    if v859 then
        v_u_857 = p858
        v_u_851(v859, v_u_824)
        task.spawn(v_u_856, p858)
        v859.Parent = v_u_824
        for _, v860 in pairs(v_u_823:GetChildren()) do
            local v861 = v860:FindFirstChild("LastGrouping")
            if v861 then
                v861 = v861.Value
            end
            if not v861 then
                local v862 = v860.WorldPivot.Position
                local v863 = 9000000000
                for _, v864 in pairs(v_u_826) do
                    local v865 = (v864[2] - v862).Magnitude
                    if v865 < v863 then
                        v861 = v864[1]
                        v863 = v865
                    end
                end
                local v866 = Instance.new("StringValue")
                v866.Name = "LastGrouping"
                v866.Value = tostring(v861)
                v866.Parent = v860
            end
            if v861 == p858 then
                v860.Parent = v_u_825
            end
        end
    end
end
local v_u_868 = game.Lighting:GetAttribute("DefaultZone") or "Default"
local function v_u_878(p869)
    if v_u_132.Flagged then
        v_u_856("Default")
        p869 = "Darkness"
    end
    local v870 = type(p869) == "string" and p869 and p869 or v_u_868
    local v871 = v_u_813:FindFirstChild(v870)
    if v871 and (v870 ~= v_u_819:GetAttribute("Ambient") and not v_u_820) then
        v_u_820 = true
        task.delay(0.25, v_u_821)
        v_u_819:SetAttribute("Ambient", v870)
        v_u_819:ClearAllChildren()
        for _, v872 in pairs(v871:GetChildren()) do
            local v873 = v872:Clone()
            v873.Parent = v_u_819
            if v873.Name == "GlowingBloom" then
                v_u_18:Tween({
                    ["Target"] = v873,
                    ["Goal"] = {
                        ["Size"] = 56
                    },
                    ["Time"] = 8,
                    ["Style"] = Enum.EasingStyle.Cubic,
                    ["Direction"] = Enum.EasingDirection.In,
                    ["Reverses"] = true,
                    ["DelayTime"] = 2,
                    ["RepeatCount"] = -1
                })
            end
        end
        local v874 = v871:GetAttribute("Song") or 9039332474
        local v875 = workspace:FindFirstChild("Song") or workspace:FindFirstChildOfClass("Sound")
        local v876 = "rbxassetid://" .. v874
        if v876 == v875.SoundId then
            return
        end
        local v877 = Instance.new("Sound")
        v877.Volume = 0
        v877.SoundId = v876
        v877.PlaybackSpeed = v871:GetAttribute("Pitch") or 1
        v877.Name = "Song"
        v877.Looped = true
        v877.Parent = workspace
        v877:Play()
        v_u_18:Tween({
            ["Target"] = v877,
            ["Goal"] = v_u_815,
            ["Time"] = 0.5
        })
        v_u_18:Tween({
            ["Target"] = v875,
            ["Goal"] = v_u_814,
            ["Time"] = 0.5
        })
        v875.Name = "decaying"
        game.Debris:AddItem(v875, 1)
    end
    if v_u_58 then
        v_u_58.ActiveCubit:OnWarp()
    end
end
local v_u_879 = v_u_75.RaidWindow
local v_u_880 = false
local v_u_881 = require(v_u_3.Raids)
local v_u_882 = nil
v_u_879.Embark.MouseButton1Click:Connect(function()
    v_u_12:FireServer("StartRaid", v_u_882)
end)
v_u_879.Matchmake.MouseButton1Click:Connect(function()
    v_u_12:FireServer("PostRaid", v_u_882)
end)
local v_u_883 = v_u_879.Ready
v_u_883.MouseButton1Click:Connect(function()
    v_u_880 = not v_u_880
    local v884 = v_u_12
    local v885 = "ChangeReady"
    local v886 = v_u_880
    if v886 then
        v886 = v_u_882
    end
    v884:FireServer(v885, v886)
    if v_u_880 then
        v_u_883.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
        v_u_883.Text = "X"
        v_u_879.ReadyFlavor.Text = "READY"
    else
        v_u_883.BackgroundColor3 = Color3.new(1, 1, 1)
        v_u_883.Text = "O"
        v_u_879.ReadyFlavor.Text = "NOT READY"
    end
end)
if v_u_880 then
    v_u_883.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
    v_u_883.Text = "X"
    v_u_879.ReadyFlavor.Text = "READY"
else
    v_u_883.BackgroundColor3 = Color3.new(1, 1, 1)
    v_u_883.Text = "O"
    v_u_879.ReadyFlavor.Text = "NOT READY"
end
v_u_13:Connect("GetZone", function()
    v_u_12:FireServer("GetZone")
    return v_u_857, game.Lighting:GetAttribute("Ambient")
end)
v_u_13:Connect("SetZone", function(p887, p888)
    v_u_867(p887)
    v_u_878(p888 or p887)
    v_u_12:FireServer("SetZone")
end)
local v889 = v_u_822.Fools.ActionItems
local v_u_890 = nil
local v_u_891 = nil
local v_u_892 = nil
local v893 = v889.Portal
local v_u_894 = v893.CFrame + v893.CFrame.LookVector * 8
v208.MouseButton1Click:Connect(function()
    if v_u_857 ~= "Fools" then
        v_u_12:FireServer("GetZone")
        local v895 = v_u_857
        local v896 = game.Lighting:GetAttribute("Ambient")
        v_u_890 = v895
        v_u_891 = v896
        v_u_892 = v_u_1.Character.PrimaryPart.CFrame
        v_u_867("Fools")
        v_u_878("Beater")
        v_u_12:FireServer("SetZone")
        v_u_1.Character.PrimaryPart.CFrame = v_u_894
        v_u_18:Sound({
            ["Id"] = 5530025800,
            ["Target"] = v_u_75,
            ["Volume"] = 1.2
        })
    end
end)
v889.Portal.Touched:Connect(function(p897)
    if p897.Parent == v_u_1.Character then
        if v_u_879.Visible then
            v_u_880 = false
            v_u_879.Visible = false
            v_u_12:FireServer("ChangeReady", false)
            if v_u_880 then
                v_u_883.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
                v_u_883.Text = "X"
                v_u_879.ReadyFlavor.Text = "READY"
            else
                v_u_883.BackgroundColor3 = Color3.new(1, 1, 1)
                v_u_883.Text = "O"
                v_u_879.ReadyFlavor.Text = "NOT READY"
            end
        end
        local v898 = v_u_1.Character.PrimaryPart
        v898.Anchored = true
        local v899 = v_u_890
        local v900 = v_u_891
        v_u_867(v899)
        v_u_878(v900 or v899)
        v_u_12:FireServer("SetZone")
        v898.CFrame = v_u_892
        v898.Anchored = false
    end
end)
local v_u_901 = {}
game:GetService("Players")
local v_u_902 = tick()
local v_u_903 = CFrame.Angles(0, 0, 0.1)
table.insert(v_u_6, function()
    if getOrSetCooldowns("TurnPortal", 0.15) then
        local v904 = getOrSetCooldowns("Spew", 0.275)
        for _, v905 in pairs(v_u_901) do
            if v904 then
                local v906 = v_u_18:Part({
                    ["Size"] = Vector3.new(1, 1, 1),
                    ["Color"] = v905.Color,
                    ["Transparency"] = 0.5 + 0.4 * math.random(),
                    ["Shape"] = Enum.PartType.Ball,
                    ["Anchored"] = true
                })
                game.Debris:AddItem(v906, 1)
                v906.CFrame = v905.CFrame * CFrame.new(math.random() * v905.Size.X / 2, math.random() * v905.Size.Y / 2, 0)
                local v907 = v_u_18
                local v908 = {
                    ["Target"] = v906,
                    ["Goal"] = {
                        ["CFrame"] = v906.CFrame + v905.CFrame.LookVector * 3,
                        ["Transparency"] = 1
                    }
                }
                v907:Tween(v908)
            end
            v905.CFrame = v905.CFrame * v_u_903
        end
    end
end)
RaycastParams.new()
local _ = math.random
local v909 = nil
local v_u_910 = nil
local v_u_911 = {}
local function v_u_917(p912, p913)
    local v914 = p912.Mesh
    v914.Scale = Vector3.new(1, 1, 1)
    local v915 = v_u_18
    local v916 = {
        ["Target"] = v914,
        ["Goal"] = {
            ["Scale"] = Vector3.new(1.5, 0.8, 1.5)
        }
    }
    if p913 then
        p913 = Enum.EasingDirection.In
    end
    v916.Direction = p913
    v916.Reverses = true
    v915:Tween(v916)
end
local function v_u_929(p918)
    for _, v_u_919 in pairs(p918) do
        v_u_919:GetAttribute("DebrisSpin")
        v_u_919:GetAttribute("Bounce")
        if v_u_919.Name == "Clouds" then
            for _, v920 in pairs(v_u_919:GetChildren()) do
                local v921 = v920.Transparency
                v920.Transparency = 1
                v_u_18:Tween({
                    ["Target"] = v920,
                    ["Goal"] = {
                        ["Transparency"] = v921
                    },
                    ["Reverses"] = true,
                    ["RepeatCount"] = -1,
                    ["Time"] = 25
                })
                v_u_18:Tween({
                    ["Target"] = v920,
                    ["Goal"] = {
                        ["CFrame"] = v920.CFrame + Vector3.new(0, 0, 2000) * (0.8 + math.random())
                    },
                    ["Time"] = 50,
                    ["RepeatCount"] = -1
                })
            end
        end
        if v_u_919:GetAttribute("Store") then
            local v_u_922 = v_u_919:GetAttribute("Id")
            local v923
            if v_u_922 then
                v923 = v_u_492[v_u_922]
            else
                v923 = v_u_922
            end
            if v923 then
                local v_u_924 = nil
                local function v_u_926(p925)
                    if p925:IsDescendantOf(v_u_1.Character) and not v_u_924 then
                        v_u_924 = true
                        v_u_12:FireServer("ShopPrompt", v_u_922)
                        task.wait(2)
                        v_u_924 = false
                    end
                end
                if v_u_919.PrimaryPart then
                    v_u_919.PrimaryPart.Touched:Connect(v_u_926)
                else
                    v_u_919:GetPropertyChangedSignal("PrimaryPart"):Connect(function(_)
                        v_u_919.PrimaryPart.Touched:Connect(v_u_926)
                    end)
                end
            end
        end
        if v_u_919:GetAttribute("Shimmer") then
            local v927 = v_u_18:Part({
                ["Size"] = v_u_919.Size + Vector3.new(10, 10, 10),
                ["Transparency"] = 1,
                ["Color"] = Color3.new(0, 1, 0),
                ["CFrame"] = v_u_919.CFrame
            })
            v_u_18:FakeAnchor(v927)
            v927.Touched:Connect(function(p928)
                if p928.Parent == v_u_1.Character then
                    openCrafting()
                end
            end)
            v_u_910 = v_u_919.Position
        end
    end
end
local v_u_930 = v_u_75.SaveSlot
local v_u_931 = v_u_930.Saves
local v_u_932 = v_u_931.Template
v_u_932.Parent = v_u_931.UIListLayout
local v_u_933 = false
function openSaveSlots()
    v_u_930.Visible = true
    if not v_u_933 then
        v_u_933 = true
        v_u_930.Loading.Visible = true
        v_u_931.Visible = false
        v_u_12:FireServer("GetSaveSlots")
    end
end
if v_u_132.SaveSlot ~= 1 then
    v_u_86.Saves.Visible = true
end
v_u_86.Saves.MouseButton1Click:Connect(openSaveSlots)
v_u_18:UIWRAP(v_u_86.Saves)
v_u_930.Close.MouseButton1Click:Connect(function()
    v_u_930.Visible = false
end)
v_u_18:UIWRAP(v_u_930.Close)
function v_u_25.NewSave()
    v_u_86.Saves.Visible = true
end
function v_u_25.GetSaveSlots(p934)
    local v935 = v_u_132.SaveSlot or 1
    for _, v936 in v_u_931:GetChildren() do
        if v936:IsA("Frame") then
            v936:Destroy()
        end
    end
    local v_u_937 = false
    for v_u_938, v_u_939 in p934 do
        local v_u_940 = v_u_932:Clone()
        v_u_940.Name = "Slot" .. v_u_938
        v_u_940.Slot.Text = "Slot " .. v_u_938
        v_u_940.Level.Text = "Level " .. v_u_18:Abbreviate(v_u_939.Level)
        v_u_940.Rebirth.Text = "Rebirth " .. v_u_939.Rebirths
        if v935 == v_u_938 then
            v_u_940.Play.Visible = false
        else
            v_u_940.Play.MouseButton1Click:Connect(function()
                if not v_u_937 then
                    v_u_937 = true
                    v_u_933 = false
                    v_u_930.Visible = false
                    v_u_18:Sound({
                        ["Id"] = 12221967
                    })
                    v_u_12:FireServer("SwitchSave", v_u_938)
                end
            end)
            v_u_18:UIWRAP(v_u_940.Play)
        end
        v_u_940.Parent = v_u_931
        task.spawn(function()
            local _, v941 = generateStand(v_u_940, true, v_u_939)
            v941()
        end)
    end
    v_u_930.Loading.Visible = false
    v_u_931.Visible = true
end
local v1018 = {
    ["SpinModel"] = {
        ["Added"] = function(p_u_942)
            local v_u_943 = nil
            local function v947()
                local v944 = v_u_58.SpinModel.Set
                if p_u_942:IsDescendantOf(workspace) then
                    v_u_943 = true
                    if not table.find(v944, p_u_942) then
                        local v945 = p_u_942
                        table.insert(v944, v945)
                        return
                    end
                elseif v_u_943 then
                    v_u_943 = false
                    for v946 = #v944, 1, -1 do
                        if v944[v946] == p_u_942 then
                            table.remove(v944, v946)
                            return
                        end
                    end
                end
            end
            p_u_942.AncestryChanged:Connect(v947)
            v947()
        end,
        ["Removed"] = function(p948)
            local v949 = v_u_58.SpinModel.Set
            for v950 = #v949, 1, -1 do
                if v949[v950] == p948 then
                    table.remove(v949, v950)
                end
            end
        end,
        ["Set"] = {},
        ["Update"] = function(p951)
            if #p951.Set > 0 then
                local v952 = CFrame.Angles(0, 0.017453292519943295, 0)
                for _, v953 in p951.Set do
                    v953:PivotTo(v953.WorldPivot * v952)
                end
            end
        end
    },
    ["Voidlinks"] = {
        ["Added"] = function(p954)
            for _, v955 in p954:GetChildren() do
                local v956 = v955:GetChildren()
                local v_u_957 = v955:GetAttribute("Speed") or 1
                local v_u_958 = 0
                for v959, v_u_960 in pairs(v956) do
                    local v_u_961 = v956[v959 % #v956 + 1]
                    v_u_960.PrimaryPart.Touched:Connect(function(p962)
                        if p962.Parent == v_u_1.Character and tick() - v_u_958 > 3 then
                            v_u_958 = tick()
                            local v_u_963 = Instance.new("Frame")
                            v_u_963.BackgroundTransparency = 1
                            v_u_963.BackgroundColor3 = Color3.new()
                            v_u_963.BorderSizePixel = 0
                            v_u_963.Size = UDim2.new(1, 0, 1, 50)
                            v_u_963.Position = UDim2.new(0, 0, 1, 0)
                            v_u_963.AnchorPoint = Vector2.new(0, 1)
                            v_u_963.Parent = v_u_75
                            game.Debris:AddItem(v_u_963, 2)
                            local v964 = v_u_18
                            local v965 = {
                                ["Target"] = v_u_963,
                                ["Goal"] = {
                                    ["Transparency"] = 0
                                },
                                ["DelayTime"] = 0.25 / v_u_957,
                                ["Time"] = 1 / v_u_957,
                                ["Reverses"] = true
                            }
                            v964:Tween(v965)
                            v_u_917(v_u_960.PrimaryPart)
                            local function v971()
                                for v966 = 0, 1 / v_u_957, 0.06666666666666667 do
                                    local v967 = Instance.new("Frame")
                                    v967.BorderSizePixel = 0
                                    v967.BackgroundColor3 = Color3.new(1, 1, 1)
                                    v967.Position = UDim2.new(math.random(), 0, 1, 0)
                                    v967.AnchorPoint = Vector2.new(0.5, 0)
                                    local v968 = math.random(3, 8)
                                    v967.Size = UDim2.new(v968 / 10, 0, v968 / 10, 0)
                                    Instance.new("UIAspectRatioConstraint").Parent = v967
                                    v967.Parent = v_u_963
                                    v967.ZIndex = v_u_963.ZIndex
                                    game.Debris:AddItem(v967, 0.5)
                                    local v969 = v_u_18
                                    local v970 = {
                                        ["Target"] = v967,
                                        ["Goal"] = {
                                            ["BackgroundColor3"] = Color3.new(0.3, 0.3, 0.3),
                                            ["Transparency"] = 1,
                                            ["Position"] = v967.Position - UDim2.new(0, 0, 0.5 + v966 / 3, 0)
                                        },
                                        ["Time"] = 0.5 / v_u_957
                                    }
                                    v969:Tween(v970)
                                    task.wait(0.06666666666666667)
                                end
                            end
                            v971()
                            local v972 = v_u_1.Character.PrimaryPart
                            v_u_18:Sound({
                                ["Id"] = 12221831,
                                ["Target"] = v972,
                                ["Pitch"] = 0.4
                            })
                            local v973 = v_u_961.PrimaryPart
                            v972.CFrame = v973.CFrame + v972.Size * Vector3.new(0, 1, 0) * 3
                            v_u_917(v973, true)
                            v971()
                        end
                    end)
                end
            end
        end
    },
    ["Altar"] = {
        ["Added"] = function(p974)
            p974.Touched:Connect(AltarActivate)
        end
    },
    ["Zone"] = {
        ["Added"] = function(p975)
            local v_u_976 = p975.Name
            local v_u_977 = false
            p975.Touched:Connect(function(p978)
                if p978.Parent == v_u_1.Character and not v_u_977 then
                    v_u_977 = true
                    task.delay(1, function()
                        v_u_977 = false
                    end)
                    v_u_878(v_u_976)
                end
            end)
        end
    },
    ["ActiveCubit"] = {
        ["Added"] = function(p979)
            local v980 = v_u_58.ActiveCubit.Set
            table.insert(v980, p979)
            print("Added active cubit")
            if ((v_u_1.Character and (v_u_1.Character.PrimaryPart and v_u_1.Character.PrimaryPart.Position) or Vector3.new(-15, 0.01, -623)) - p979.Position).Magnitude < 512 then
                local v981 = Instance.new("Highlight")
                v981.DepthMode = Enum.HighlightDepthMode.Occluded
                v981.FillColor = Color3.fromRGB(255, 255, 127)
                v981.FillTransparency = 0.55
                v981.Parent = p979
            end
        end,
        ["Removed"] = function(p982)
            local v983 = v_u_58.ActiveCubit.Set
            for v984 = #v983, 1, -1 do
                if v983[v984] == p982 then
                    table.remove(v983, v984)
                end
            end
        end,
        ["Set"] = {},
        ["OnStart"] = function(p985)
            p985:OnWarp()
        end,
        ["OnWarp"] = function(p986)
            print("warp check!")
            local v987 = v_u_1.Character and (v_u_1.Character.PrimaryPart and v_u_1.Character.PrimaryPart.Position) or Vector3.new(-15, 0.01, -623)
            local v988 = Color3.fromRGB(255, 255, 127)
            for _, v989 in p986.Set do
                local v990 = v989:FindFirstChild("Highlight")
                if (v987 - v989.Position).Magnitude < 512 then
                    if not v990 then
                        local v991 = Instance.new("Highlight")
                        v991.DepthMode = Enum.HighlightDepthMode.Occluded
                        v991.FillColor = v988
                        v991.FillTransparency = 0.55
                        v991.Parent = v989
                    end
                elseif v990 then
                    v990:Destroy()
                end
            end
        end
    },
    ["SaveMenu"] = {
        ["Added"] = function(p992)
            p992.Touched:Connect(openSaveSlots)
        end
    },
    ["Teleporter"] = {
        ["Added"] = function(p993)
            local v_u_994 = p993:FindFirstChild("Link")
            local v_u_995 = v_u_994 and p993 and p993 or p993.Parent
            local v_u_996 = v_u_995:GetAttribute("Level") or 0
            local v_u_997 = v_u_995:GetAttribute("Rebirth")
            local v_u_998 = v_u_995:GetAttribute("CubitTag")
            local v999 = workspace.StreamingEnabled and { p993 } or v_u_995:GetChildren()
            for v1000, v_u_1001 in pairs(v999) do
                local v_u_1002 = v_u_1001:GetAttribute("Raid")
                local v_u_1003 = v999[v1000 % #v999 + 1]
                local function v1013(p1004)
                    if p1004.Parent == v_u_1.Character then
                        local v1005 = v_u_998 and table.find(v_u_132.Cubits, v_u_998) or not v_u_998
                        if tick() - v_u_902 > 2 and (v_u_132.Corrupted or v_u_996 <= (v_u_997 and v_u_132.Rebirths or v_u_132.Level)) and v1005 then
                            v_u_902 = tick()
                            print("Hit Fired")
                            local v1006 = v_u_1001.Name
                            v_u_867(v1006)
                            local v1007 = v_u_1.Character.PrimaryPart
                            local v1008 = v_u_100.CFrame.Position - v1007.Position
                            if v_u_1002 then
                                v_u_879.Visible = true
                                local v1009 = v_u_1002
                                local v1010 = v_u_881[v1009] or v_u_881.Banland
                                v_u_879.Title.Text = v1010.Title
                                v_u_879.Restriction.Text = "Your level will be set to " .. v_u_18:Abbreviate(v1010.LevelStage)
                                v_u_882 = v1009
                            elseif v_u_879.Visible then
                                v_u_880 = false
                                v_u_879.Visible = false
                                v_u_12:FireServer("ChangeReady", false)
                                if v_u_880 then
                                    v_u_883.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
                                    v_u_883.Text = "X"
                                    v_u_879.ReadyFlavor.Text = "READY"
                                else
                                    v_u_883.BackgroundColor3 = Color3.new(1, 1, 1)
                                    v_u_883.Text = "O"
                                    v_u_879.ReadyFlavor.Text = "NOT READY"
                                end
                            end
                            v_u_12:FireServer("Teleport", v_u_995:GetAttribute("Id"), v_u_1001:GetAttribute("Hash"), v_u_994)
                            if not workspace.StreamingEnabled then
                                local v1011 = (v_u_1003.CFrame.LookVector - Vector3.new(0, 1, 0)).Magnitude > 1.5 and Vector3.new(-0, -3, -0) or Vector3.new(0, 0, 0)
                                v1007.CFrame = v_u_1003.CFrame + v_u_1003.CFrame.LookVector * 7 * v1007.Size.Y / 2 + v1011
                            end
                            if v_u_1003 then
                                v_u_100.CFrame = v_u_1003.CFrame - v_u_1003.Position + v1007.Position + v1008
                            end
                            v1007.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            for _, v1012 in pairs(v1007:GetChildren()) do
                                if v1012:IsA("BodyVelocity") then
                                    v1012:Destroy()
                                end
                            end
                            v_u_878(v1006)
                            v_u_18:Sound({
                                ["Id"] = 289556450,
                                ["Target"] = v1007,
                                ["Volume"] = 0.2,
                                ["Pitch"] = 0.8 + math.random() / 5
                            })
                            v_u_18:OutlineCharacter({
                                ["Tag"] = "ShieldFX",
                                ["Target"] = v_u_1.Character,
                                ["Color"] = Color3.new(0.7, 0.3, 1),
                                ["Material"] = Enum.Material.Neon,
                                ["Duration"] = 0.5
                            })
                            v_u_902 = tick()
                            return
                        end
                        if v_u_998 and not (v1005 or v_u_75:FindFirstChild("WarningLabel")) then
                            v_u_82("You need the Cubit \'" .. v_u_998 .. "\' to enter...")
                        end
                    end
                end
                if v_u_1001.Transparency < 1 then
                    v_u_901[v_u_1001] = v_u_1001
                    local v1014 = v_u_901
                    table.insert(v1014, v_u_1001)
                end
                v_u_1001.Touched:Connect(v1013)
            end
        end,
        ["Removed"] = function(p1015)
            v_u_901[p1015] = nil
        end
    },
    ["Sconce"] = {
        ["Added"] = function(p1016)
            v_u_911[p1016] = p1016
        end,
        ["Removed"] = function(p1017)
            v_u_911[p1017] = nil
        end
    }
}
local v_u_1019 = v_u_857
local v_u_1020 = v_u_910
local v_u_1021 = v909
local v_u_1022 = v_u_880
local v_u_1023 = v1018
for _, v1024 in {
    "DebrisSpin",
    "ActiveCubit",
    "SpinModel",
    "Voidlinks",
    "Bounce",
    "Voidlink",
    "Store",
    "Sconce",
    "Shimmer",
    "Altar",
    "SaveMenu",
    "Clouds",
    "Teleporter",
    "Zone"
} do
    local v_u_1025 = v_u_1023[v1024]
    local v_u_1026
    if v_u_1025 then
        v_u_1026 = v_u_1025.Added
    else
        v_u_1026 = v_u_1025
    end
    v_u_1025 = v_u_1025
    if v_u_1025 then
        local v_u_1027 = v_u_1025.Removed
    end
    v_u_4:GetInstanceAddedSignal(v1024):Connect(function(p1028)
        task.wait(0.5)
        if v_u_1026 then
            v_u_1026(p1028)
        else
            v_u_929({ p1028 })
        end
    end)
    if v_u_1025 and v_u_1025.Update then
        table.insert(v_u_6, function()
            v_u_1025:Update()
        end)
    end
    if v_u_1027 then
        v_u_4:GetInstanceRemovedSignal(v1024):Connect(function(p1029)
            v_u_1027(p1029)
        end)
    end
    for _, v_u_1030 in v_u_4:GetTagged(v1024) do
        task.delay(0.5, function()
            if v_u_1026 then
                v_u_1026(v_u_1030)
            else
                v_u_929({ v_u_1030 })
            end
        end)
    end
    if v_u_1025 and v_u_1025.OnStart then
        v_u_1025:OnStart()
    end
end
v_u_929(workspace.Maps:GetDescendants())
v_u_929(v_u_3.UnloadedMaps:GetDescendants())
for _, v1031 in pairs(v_u_824:GetChildren()) do
    if v1031.Name ~= "Default" then
        v1031.Parent = v_u_822
    end
end
v_u_856("Default")
local v_u_1032 = game:GetService("TweenService")
local v_u_1033 = TweenInfo.new(0.5)
local v_u_1034 = {
    ["Brightness"] = 0
}
table.insert(v_u_6, function()
    if getOrSetCooldowns("FlickerSconces", 0.25) then
        local v1035 = v_u_75.AbsoluteSize.Y / 4
        local v1036 = v_u_100.CFrame.Position
        for _, v1037 in pairs(v_u_911) do
            if (v1037.Position - v1036).Magnitude < v1035 then
                local v1038 = v1037.Size.Z
                local v1039 = v_u_18:Part({
                    ["CFrame"] = v1037.CFrame,
                    ["Size"] = Vector3.new(1, 1, 1) * v1038,
                    ["Color"] = v1037.Color,
                    ["Transparency"] = v1037.Transparency,
                    ["Material"] = v1037.Material,
                    ["TopSurface"] = v1037.TopSurface,
                    ["BottomSurface"] = v1037.BottomSurface,
                    ["LeftSurface"] = v1037.LeftSurface,
                    ["RightSurface"] = v1037.RightSurface,
                    ["FrontSurface"] = v1037.FrontSurface,
                    ["BackSurface"] = v1037.BackSurface
                })
                game.Debris:AddItem(v1039, 0.5)
                local v1040 = v1039:FindFirstChild("PointLight")
                if v1040 then
                    v1040.Brightness = v1040.Brightness / 2
                    v_u_1032:Create(v1040, v_u_1033, v_u_1034):Play()
                end
                v_u_1032:Create(v1039, v_u_1033, {
                    ["CFrame"] = v1039.CFrame + (Vector3.new(0, 5, 0) + Vector3.new(3, 3, 3) * (math.random() - 0.5)) * v1038,
                    ["Transparency"] = 1
                }):Play()
            end
        end
        if v_u_1021 then
            local v1041 = v_u_1.Character
            if v1041 then
                v1041 = v_u_1.Character.PrimaryPart
            end
            if v1041 and (v1041.Position - v_u_1020).Magnitude > 100 then
                print(" far away now ")
                v_u_1021 = false
            end
        end
    end
end)
local v1042 = v261.Combat
local v_u_1043 = v1042.Health.Recent
local v_u_1044 = v1042.Health.Bar
local v_u_1045 = v1042.Health.TextLabel
local v_u_1046 = 0
local v_u_1047 = 1
local function v1059(p1048)
    if v_u_879.Visible then
        v_u_1022 = false
        v_u_879.Visible = false
        v_u_12:FireServer("ChangeReady", false)
        if v_u_1022 then
            v_u_883.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
            v_u_883.Text = "X"
            v_u_879.ReadyFlavor.Text = "READY"
        else
            v_u_883.BackgroundColor3 = Color3.new(1, 1, 1)
            v_u_883.Text = "O"
            v_u_879.ReadyFlavor.Text = "NOT READY"
        end
    end
    v_u_878()
    local v1049 = p1048:WaitForChild("HumanoidRootPart")
    v1049.Anchored = true
    v_u_867("Default")
    v_u_1019 = "Default"
    v1049.Anchored = false
    local v_u_1050 = p1048:WaitForChild("Humanoid")
    local function v1058()
        local v1051 = v_u_1050.Health / v_u_1050.MaxHealth
        local v_u_1052
        if v1051 < v_u_1047 then
            v_u_1047 = v1051
            v_u_1046 = v_u_1046 + 1
            v_u_1052 = true
        else
            v_u_1052 = nil
        end
        local v_u_1053 = v_u_1046
        v_u_18:Tween({
            ["Target"] = v_u_1044,
            ["Goal"] = {
                ["Size"] = UDim2.new(v1051, 0, 1, 0)
            },
            ["Style"] = Enum.EasingStyle.Linear,
            ["Time"] = 0.25
        }).Completed:Connect(function()
            if v_u_1052 and v_u_1046 == v_u_1053 then
                local v1054 = v_u_18
                local v1055 = {
                    ["Target"] = v_u_1043,
                    ["Goal"] = {
                        ["Size"] = v_u_1044.Size
                    },
                    ["Time"] = 0.25,
                    ["Style"] = Enum.EasingStyle.Linear
                }
                v1054:Tween(v1055)
            end
        end)
        local v1056 = v_u_1050:GetAttribute("scale")
        local v1057 = (not v1056 or v1056 == 0) and 1 or 10 ^ v1056
        v_u_1045.Text = v_u_18:Abbreviate(v_u_1050.Health * v1057) .. "/" .. v_u_18:Abbreviate(v_u_1050.MaxHealth * v1057)
        v_u_1045.TextColor3 = Color3.new(1, 1, 1):Lerp(Color3.new(1, 0, 0), 1 - v1051)
    end
    v_u_1050:GetAttributeChangedSignal("scale"):Connect(v1058)
    v_u_1050.HealthChanged:Connect(v1058)
    v1058()
    if v_u_1023 then
        v_u_1023.ActiveCubit:OnWarp()
    end
end
v1059(v_u_1.Character or v_u_1.CharacterAdded:Wait())
v_u_1.CharacterAdded:Connect(v1059)
local v_u_1060 = v_u_75.Sacrifice
local function v1061()
    v_u_1060.Visible = not v_u_1060.Visible
    if v_u_1060.Visible then
        v_u_134()
        v_u_1060.Visible = true
    end
end
v_u_330.MouseButton1Click:Connect(v1061)
v_u_1060.Close.MouseButton1Click:Connect(v1061)
v_u_1060.Claim.MouseButton1Click:Connect(function()
    v_u_12:FireServer("Unflag")
    v_u_1060.Claim:Destroy()
end)
v_u_18:UIWRAP(v_u_1060.Close)
v_u_18:UIWRAP(v_u_1060.Claim)
function v_u_25.CleanseFlag()
    v_u_132.Flagged = false
    v_u_878("Default")
end
local v_u_1062 = v_u_75.LoadScreen
local v_u_1063 = nil
v_u_98:SetGameplayPausedNotificationEnabled(false)
local function v1073()
    if v_u_1.GameplayPaused then
        local v1064 = {
            ["Target"] = v_u_1062,
            ["Goal"] = {
                ["Transparency"] = 0
            },
            ["Time"] = 0.2
        }
        v_u_18:Tween(v1064)
        v_u_1062.Core.ImageTransparency = 1
        local v1065 = v_u_18
        local v1066 = {
            ["Target"] = v_u_1062.Core,
            ["Goal"] = {
                ["ImageTransparency"] = 0
            }
        }
        v1065:Tween(v1066)
        v_u_1062.Core.Rotation = 0
        local v1067 = v_u_18
        local v1068 = {
            ["Target"] = v_u_1062.Core,
            ["Goal"] = {
                ["Rotation"] = 360
            },
            ["RepeatCount"] = 5
        }
        v_u_1063 = v1067:Tween(v1068)
        if v_u_132.Rebirths and v_u_132.Rebirths > 16 then
            v_u_1062.Glare.ImageTransparency = 1
            v_u_1062.Glare.Size = UDim2.new(0.2, 0, 0.2, 0)
            v_u_1062.Glare.Visible = true
            local v1069 = v_u_18
            local v1070 = {
                ["Target"] = v_u_1062.Glare,
                ["Goal"] = {
                    ["ImageTransparency"] = 0
                },
                ["Time"] = 2,
                ["Reverses"] = true
            }
            v1069:Tween(v1070)
        end
        v_u_1062.Visible = true
    else
        task.wait(0.1)
        v_u_18:Tween({
            ["Target"] = v_u_1062,
            ["Time"] = 0.25
        })
        if v_u_1062.Glare.Visible then
            local v1071 = v_u_18
            local v1072 = {
                ["Target"] = v_u_1062.Glare,
                ["Goal"] = {
                    ["Size"] = UDim2.new(0.4, 0, 0.4, 0),
                    ["ImageTransparency"] = 1
                },
                ["Time"] = 0.25
            }
            v1071:Tween(v1072)
        end
        task.wait(0.25)
        v_u_1062.Visible = false
        if v_u_1063 then
            v_u_1063:Cancel()
            v_u_1063 = nil
        end
    end
end
v_u_1:GetPropertyChangedSignal("GameplayPaused"):Connect(v1073)