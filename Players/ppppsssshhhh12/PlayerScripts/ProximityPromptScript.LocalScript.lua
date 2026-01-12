local v_u_1 = game:GetService("UserInputService")
local v2 = game:GetService("ProximityPromptService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("TextService")
local v_u_5 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v_u_6 = {
    [Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
    [Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
    [Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
    [Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
    [Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
    [Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
    [Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
    [Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
    [Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
    [Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png",
    [Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png"
}
local v_u_7 = {
    [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
    [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
    [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
}
local v_u_8 = {
    ["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
    [","] = "rbxasset://textures/ui/Controls/comma.png",
    ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
    ["."] = "rbxasset://textures/ui/Controls/period.png",
    [" "] = "rbxasset://textures/ui/Controls/spacebar.png"
}
local v_u_9 = {
    [Enum.KeyCode.LeftControl] = "Ctrl",
    [Enum.KeyCode.RightControl] = "Ctrl",
    [Enum.KeyCode.LeftAlt] = "Alt",
    [Enum.KeyCode.RightAlt] = "Alt",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12"
}
local v_u_10 = require(game.ReplicatedStorage.movefx)
local v_u_11 = require(game.ReplicatedStorage.Loot)
local v_u_12 = require(game.ReplicatedStorage.WeaponData)
local v_u_13 = require(game.ReplicatedStorage.CombatStats)
local function v_u_229(p_u_14, p15, p16)
    local v_u_17 = {}
    local v_u_18 = {}
    local v_u_19 = {}
    local v_u_20 = {}
    local v21 = TweenInfo.new(p_u_14.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v_u_22 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v_u_23 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local v24 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local v_u_25 = nil
    local v26 = p_u_14:GetAttribute("Theme")
    if v26 then
        local v27 = script:FindFirstChild(v26)
        if v27 then
            v_u_25 = v27:Clone()
            local v28 = p_u_14:GetAttribute("Hash")
            if v28 then
                local v29 = v_u_11:IndexHash(v28)
                if v29 then
                    local v30 = v29[2]
                    local v31 = v_u_12[v30]
                    local v32 = v_u_10
                    local v33 = v31.Stackable
                    if v33 then
                        v33 = v29[3]
                    end
                    local v34 = v32:Item(v30, v33)
                    v34.Parent = v_u_25
                    v34.Size = v_u_25.Icon.Size
                    v34.Position = v_u_25.Icon.Position
                    v34.AnchorPoint = v_u_25.Icon.AnchorPoint
                    local v35 = v_u_3
                    local v36 = {
                        ["Position"] = UDim2.new(-1, 0, 0, 0)
                    }
                    table.insert(v_u_19, v35:Create(v34, v_u_22, v36))
                    local v37 = v_u_3
                    local v38 = {
                        ["Position"] = v_u_25.Icon.Position
                    }
                    table.insert(v_u_20, v37:Create(v34, v_u_22, v38))
                    local v_u_39 = v_u_25.Reader
                    local v40 = v_u_3
                    local v41 = {
                        ["Position"] = UDim2.new(-1.5, 0, 0, 0)
                    }
                    table.insert(v_u_19, v40:Create(v_u_39, v_u_22, v41))
                    local v42 = v_u_3
                    local v43 = {
                        ["Position"] = v_u_39.Position
                    }
                    table.insert(v_u_20, v42:Create(v_u_39, v_u_22, v43))
                    local function v49(p44, p45, p46)
                        local v47 = Instance.new("TextLabel")
                        v47.BackgroundTransparency = 1
                        v47.TextColor3 = p45 or Color3.new(0.7, 0.7, 0.7)
                        v47.Font = p46 and Enum.Font.GothamBold or Enum.Font.GothamSemibold
                        v47.TextScaled = true
                        v47.Size = UDim2.new(1, 0, 0, p46 and 24 or 16)
                        v47.RichText = true
                        v47.TextXAlignment = Enum.TextXAlignment.Left
                        v47.Text = p44
                        local v48 = Instance.new("UIStroke")
                        v48.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
                        v48.Thickness = 2
                        v48.Color = Color3.new(0, 0, 0)
                        v48.Parent = v47
                        v47.Parent = v_u_39
                        return v47
                    end
                    v49(v30, Color3.new(1, 1, 1), true).Font = Enum.Font.GothamBlack
                    if v31.Stats then
                        local v50 = ""
                        for v51, v54 in pairs(v31.Stats) do
                            local v53 = v_u_13[v51] or v51
                            if v53:sub(1, 1) == "%" or v53:sub(1, 1) == "x" then
                                local v54 = v54 * 100
                            else
                                v53 = " " .. v53
                            end
                            v50 = v50 .. (v54 > 0 and "+" or "") .. string.format("%.1f", v54) .. v53 .. ","
                            if #v50 > 0 then
                                v49(v50:sub(1, #v50 - 1))
                                v50 = ""
                            end
                        end
                        v49((v50:sub(1, #v50 - 1)))
                    end
                    local v55 = v31.Abilities
                    if v55 then
                        for _, v56 in pairs(v55) do
                            if v56.Text then
                                v49(v56.Text)
                            else
                                v49("On " .. v56[1] .. " apply " .. v56[2] .. " for " .. v56[3])
                            end
                        end
                    end
                end
            end
        end
    end
    if v_u_25 == nil then
        v_u_25 = script.Default:Clone()
    end
    v_u_25.Enabled = true
    local v57 = v_u_25.PromptFrame
    local v58 = v57.InputFrame
    local v_u_59 = v57.ActionText
    local v_u_60 = v57.ObjectText
    local v61 = v57.BackgroundTransparency
    local v62 = v57.ImageTransparency
    v57.BackgroundTransparency = 1
    v57.ImageTransparency = 1
    local v63 = v_u_3
    local v64 = {
        ["Size"] = UDim2.fromScale(0.5, 0.5),
        ["BackgroundTransparency"] = 1,
        ["ImageTransparency"] = 1
    }
    table.insert(v_u_17, v63:Create(v57, v_u_22, v64))
    local v65 = v_u_3
    local v66 = {
        ["Size"] = UDim2.fromScale(1, 0.5),
        ["BackgroundTransparency"] = v61,
        ["ImageTransparency"] = v62
    }
    table.insert(v_u_18, v65:Create(v57, v_u_22, v66))
    local v67 = v_u_3
    local v68 = {
        ["Size"] = UDim2.fromScale(0.5, 0.5),
        ["BackgroundTransparency"] = 1,
        ["ImageTransparency"] = 1
    }
    table.insert(v_u_19, v67:Create(v57, v_u_22, v68))
    local v69 = v_u_3
    local v70 = {
        ["Size"] = UDim2.fromScale(1, 0.5),
        ["BackgroundTransparency"] = v61,
        ["ImageTransparency"] = v62
    }
    table.insert(v_u_20, v69:Create(v57, v_u_22, v70))
    local function v_u_85(p71)
        local v72 = p71.Transparency
        p71.Transparency = 1
        local v73 = v_u_17
        local v74 = v_u_3
        local v75 = v_u_22
        table.insert(v73, v74:Create(p71, v75, {
            ["Transparency"] = 1
        }))
        local v76 = v_u_18
        local v77 = v_u_3
        local v78 = v_u_22
        table.insert(v76, v77:Create(p71, v78, {
            ["Transparency"] = v72
        }))
        local v79 = v_u_19
        local v80 = v_u_3
        local v81 = v_u_22
        table.insert(v79, v80:Create(p71, v81, {
            ["Transparency"] = 1
        }))
        local v82 = v_u_20
        local v83 = v_u_3
        local v84 = v_u_22
        table.insert(v82, v83:Create(p71, v84, {
            ["Transparency"] = v72
        }))
    end
    local function v_u_100(p86)
        local v87 = p86.BackgroundTransparency
        p86.BackgroundTransparency = 1
        local v88 = v_u_17
        local v89 = v_u_3
        local v90 = v_u_22
        table.insert(v88, v89:Create(p86, v90, {
            ["BackgroundTransparency"] = 1
        }))
        local v91 = v_u_18
        local v92 = v_u_3
        local v93 = v_u_22
        table.insert(v91, v92:Create(p86, v93, {
            ["BackgroundTransparency"] = v87
        }))
        local v94 = v_u_19
        local v95 = v_u_3
        local v96 = v_u_22
        table.insert(v94, v95:Create(p86, v96, {
            ["BackgroundTransparency"] = 1
        }))
        local v97 = v_u_20
        local v98 = v_u_3
        local v99 = v_u_22
        table.insert(v97, v98:Create(p86, v99, {
            ["BackgroundTransparency"] = v87
        }))
    end
    local function v_u_116(p101)
        local v102 = p101.TextTransparency
        local v103 = p101.TextStrokeTransparency
        p101.TextTransparency = 1
        p101.TextStrokeTransparency = 1
        local v104 = v_u_17
        local v105 = v_u_3
        local v106 = v_u_22
        table.insert(v104, v105:Create(p101, v106, {
            ["TextTransparency"] = 1,
            ["TextStrokeTransparency"] = 1
        }))
        local v107 = v_u_18
        local v108 = v_u_3
        local v109 = v_u_22
        table.insert(v107, v108:Create(p101, v109, {
            ["TextTransparency"] = v102,
            ["TextStrokeTransparency"] = v103
        }))
        local v110 = v_u_19
        local v111 = v_u_3
        local v112 = v_u_22
        table.insert(v110, v111:Create(p101, v112, {
            ["TextTransparency"] = 1,
            ["TextStrokeTransparency"] = 1
        }))
        local v113 = v_u_20
        local v114 = v_u_3
        local v115 = v_u_22
        table.insert(v113, v114:Create(p101, v115, {
            ["TextTransparency"] = v102,
            ["TextStrokeTransparency"] = v103
        }))
    end
    local function v_u_131(p117)
        local v118 = p117.ImageTransparency
        p117.ImageTransparency = 1
        local v119 = v_u_17
        local v120 = v_u_3
        local v121 = v_u_22
        table.insert(v119, v120:Create(p117, v121, {
            ["ImageTransparency"] = 1
        }))
        local v122 = v_u_18
        local v123 = v_u_3
        local v124 = v_u_22
        table.insert(v122, v123:Create(p117, v124, {
            ["ImageTransparency"] = v118
        }))
        local v125 = v_u_19
        local v126 = v_u_3
        local v127 = v_u_22
        table.insert(v125, v126:Create(p117, v127, {
            ["ImageTransparency"] = 1
        }))
        local v128 = v_u_20
        local v129 = v_u_3
        local v130 = v_u_22
        table.insert(v128, v129:Create(p117, v130, {
            ["ImageTransparency"] = v118
        }))
    end
    local function v_u_134(p132)
        if p132:IsA("UIStroke") then
            v_u_85(p132)
        elseif not p132:IsA("UIGradient") and p132:IsA("GuiObject") then
            v_u_100(p132)
            if p132:IsA("TextLabel") then
                v_u_116(p132)
            elseif p132:IsA("ImageLabel") then
                v_u_131(p132)
            end
        end
        for _, v133 in pairs(p132:GetChildren()) do
            v_u_134(v133)
        end
    end
    local v135 = {
        [v58] = false,
        [v_u_59] = true,
        [v_u_60] = true
    }
    for _, v136 in pairs(v57:GetChildren()) do
        if v135[v136] == nil then
            v_u_134(v136)
        elseif v135[v136] == true then
            for _, v137 in pairs(v136:GetChildren()) do
                v_u_134(v137)
            end
        end
    end
    local v138 = v58.Frame
    local v139 = v138.UIScale
    local v140 = p15 == Enum.ProximityPromptInputType.Touch and 1.6 or 1.33
    local v141 = v_u_3
    table.insert(v_u_17, v141:Create(v139, v_u_22, {
        ["Scale"] = v140
    }))
    local v142 = v_u_3
    table.insert(v_u_18, v142:Create(v139, v_u_22, {
        ["Scale"] = 1
    }))
    v_u_116(v_u_59)
    v_u_116(v_u_60)
    local v143 = v138.ButtonFrame
    local v144 = v_u_3
    table.insert(v_u_19, v144:Create(v143, v_u_23, {
        ["BackgroundTransparency"] = 1,
        ["ImageTransparency"] = 1
    }))
    local v145 = v_u_3
    local v146 = {
        ["BackgroundTransparency"] = v143.BackgroundTransparency,
        ["ImageTransparency"] = v143.ImageTransparency
    }
    table.insert(v_u_20, v145:Create(v143, v_u_23, v146))
    local v_u_147 = v138.ButtonImage
    local v_u_148 = v138.ButtonText
    local v_u_149 = v138.ButtonTextImage
    local function v169()
        local v150 = v_u_148.TextTransparency
        local v151 = v_u_148.TextStrokeTransparency
        local v152 = v_u_148.BackgroundTransparency
        v_u_148.BackgroundTransparency = 1
        v_u_148.TextStrokeTransparency = 1
        v_u_148.TextTransparency = 1
        local v153 = v_u_19
        local v154 = v_u_3
        local v155 = v_u_148
        local v156 = v_u_23
        table.insert(v153, v154:Create(v155, v156, {
            ["TextTransparency"] = 1,
            ["TextStrokeTransparency"] = 1,
            ["BackgroundTransparency"] = 1
        }))
        local v157 = v_u_20
        local v158 = v_u_3
        local v159 = v_u_148
        local v160 = v_u_23
        table.insert(v157, v158:Create(v159, v160, {
            ["TextTransparency"] = v150,
            ["TextStrokeTransparency"] = v151,
            ["BackgroundTransparency"] = v152
        }))
        for _, v161 in pairs(v_u_148:getChildren()) do
            if v161:IsA("UIStroke") then
                local v162 = v_u_19
                local v163 = v_u_3
                local v164 = v_u_23
                table.insert(v162, v163:Create(v161, v164, {
                    ["Transparency"] = 1
                }))
                local v165 = v_u_20
                local v166 = v_u_3
                local v167 = v_u_23
                local v168 = {
                    ["Transparency"] = v161.Transparency
                }
                table.insert(v165, v166:Create(v161, v167, v168))
            end
        end
    end
    local function v180()
        local v170 = v_u_147.ImageTransparency
        local v171 = v_u_147.BackgroundTransparency
        v_u_147.BackgroundTransparency = 1
        v_u_147.ImageTransparency = 1
        local v172 = v_u_19
        local v173 = v_u_3
        local v174 = v_u_147
        local v175 = v_u_23
        table.insert(v172, v173:Create(v174, v175, {
            ["ImageTransparency"] = 1,
            ["BackgroundTransparency"] = 1
        }))
        local v176 = v_u_20
        local v177 = v_u_3
        local v178 = v_u_147
        local v179 = v_u_23
        table.insert(v176, v177:Create(v178, v179, {
            ["ImageTransparency"] = v170,
            ["BackgroundTransparency"] = v171
        }))
    end
    local function v191()
        local v181 = v_u_149.BackgroundTransparency
        local v182 = v_u_149.ImageTransparency
        v_u_149.BackgroundTransparency = 1
        v_u_149.ImageTransparency = 1
        local v183 = v_u_19
        local v184 = v_u_3
        local v185 = v_u_149
        local v186 = v_u_23
        table.insert(v183, v184:Create(v185, v186, {
            ["ImageTransparency"] = 1,
            ["BackgroundTransparency"] = 1
        }))
        local v187 = v_u_20
        local v188 = v_u_3
        local v189 = v_u_149
        local v190 = v_u_23
        table.insert(v187, v188:Create(v189, v190, {
            ["ImageTransparency"] = v182,
            ["BackgroundTransparency"] = v181
        }))
    end
    if p15 == Enum.ProximityPromptInputType.Gamepad then
        if v_u_6[p_u_14.GamepadKeyCode] then
            v191()
            v_u_149.Image = v_u_6[p_u_14.GamepadKeyCode]
            v_u_148.Visible = false
            v_u_147.Visible = false
            v_u_149.Visible = true
        end
    elseif p15 == Enum.ProximityPromptInputType.Touch then
        v180()
        v_u_147.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
        v_u_148.Visible = false
        v_u_149.Visible = false
        v_u_147.Visible = true
    else
        v180()
        v_u_147.Visible = true
        local v192 = v_u_1:GetStringForKeyCode(p_u_14.KeyboardKeyCode)
        local v193 = v_u_7[p_u_14.KeyboardKeyCode]
        if v193 == nil then
            v193 = v_u_8[v192]
        end
        if v193 == nil then
            v192 = v_u_9[p_u_14.KeyboardKeyCode] or v192
        end
        if v193 then
            v191()
            v_u_149.Image = v193
            v_u_148.Visible = false
            v_u_149.Visible = true
        elseif v192 == nil or v192 == "" then
            local v194 = error
            local v195 = p_u_14.Name
            local v196 = p_u_14.KeyboardKeyCode
            v194("ProximityPrompt \'" .. v195 .. "\' has an unsupported keycode for rendering UI: " .. tostring(v196))
        else
            if string.len(v192) > 2 then
                local v197 = v_u_148.TextSize * 6 / 7
                v_u_148.TextSize = math.round(v197)
            end
            v169()
            v_u_148.Text = v192
            v_u_149.Visible = false
            v_u_148.Visible = true
        end
    end
    if p15 == Enum.ProximityPromptInputType.Touch or p_u_14.ClickablePrompt then
        local v198 = v_u_25.TextButton
        local v_u_199 = false
        v198.InputBegan:Connect(function(p200)
            if (p200.UserInputType == Enum.UserInputType.Touch or p200.UserInputType == Enum.UserInputType.MouseButton1) and p200.UserInputState ~= Enum.UserInputState.Change then
                p_u_14:InputHoldBegin()
                v_u_199 = true
            end
        end)
        v198.InputEnded:Connect(function(p201)
            if (p201.UserInputType == Enum.UserInputType.Touch or p201.UserInputType == Enum.UserInputType.MouseButton1) and v_u_199 then
                v_u_199 = false
                p_u_14:InputHoldEnd()
            end
        end)
        v_u_25.Active = true
    end
    if p_u_14.HoldDuration > 0 then
        local v202 = v138.ProgressBar
        local v_u_203 = v202.LeftGradient.ProgressBarImage.UIGradient
        local v_u_204 = v202.RightGradient.ProgressBarImage.UIGradient
        v202.Progress.Changed:Connect(function(p205)
            local v206 = p205 * 360
            local v207 = math.clamp(v206, 0, 360)
            v_u_203.Rotation = math.clamp(v207, 180, 360)
            v_u_204.Rotation = math.clamp(v207, 0, 180)
        end)
        local v208 = v_u_3
        local v209 = v202.Progress
        table.insert(v_u_17, v208:Create(v209, v21, {
            ["Value"] = 1
        }))
        local v210 = v_u_3
        local v211 = v202.Progress
        table.insert(v_u_18, v210:Create(v211, v24, {
            ["Value"] = 0
        }))
    end
    local v_u_212, v_u_213
    if p_u_14.HoldDuration > 0 then
        v_u_212 = p_u_14.PromptButtonHoldBegan:Connect(function()
            for _, v214 in ipairs(v_u_17) do
                v214:Play()
            end
        end)
        v_u_213 = p_u_14.PromptButtonHoldEnded:Connect(function()
            for _, v215 in ipairs(v_u_18) do
                v215:Play()
            end
        end)
    else
        v_u_212 = nil
        v_u_213 = nil
    end
    local v_u_217 = p_u_14.Triggered:Connect(function()
        for _, v216 in ipairs(v_u_19) do
            v216:Play()
        end
    end)
    local v_u_219 = p_u_14.TriggerEnded:Connect(function()
        for _, v218 in ipairs(v_u_20) do
            v218:Play()
        end
    end)
    local function v225()
        local v220 = v_u_4:GetTextSize(p_u_14.ActionText, v_u_59.TextSize, v_u_59.Font, Vector2.new(1000, 1000))
        local v221 = v_u_4:GetTextSize(p_u_14.ObjectText, v_u_60.TextSize, v_u_60.Font, Vector2.new(1000, 1000))
        local v222 = v220.X
        local v223 = v221.X
        math.max(v222, v223)
        if (p_u_14.ActionText == nil or p_u_14.ActionText == "") and p_u_14.ObjectText ~= nil then
            local _ = p_u_14.ObjectText == ""
        end
        local v224 = (p_u_14.ObjectText == nil or p_u_14.ObjectText == "") and 0 or 9
        v_u_59.Position = UDim2.new(0.5, -28, 0, v224)
        v_u_60.Position = UDim2.new(0.5, -28, 0, -10)
        v_u_59.Text = p_u_14.ActionText
        v_u_60.Text = p_u_14.ObjectText
        v_u_59.AutoLocalize = p_u_14.AutoLocalize
        v_u_59.RootLocalizationTable = p_u_14.RootLocalizationTable
        v_u_60.AutoLocalize = p_u_14.AutoLocalize
        v_u_60.RootLocalizationTable = p_u_14.RootLocalizationTable
        v_u_25.Size = UDim2.fromOffset(200, 150)
        v_u_25.SizeOffset = Vector2.new(p_u_14.UIOffset.X / v_u_25.Size.Width.Offset, p_u_14.UIOffset.Y / v_u_25.Size.Height.Offset)
    end
    local v_u_226 = p_u_14.Changed:Connect(v225)
    v225()
    v_u_25.Adornee = p_u_14.Parent
    v_u_25.Parent = p16
    for _, v227 in ipairs(v_u_20) do
        v227:Play()
    end
    return function()
        if v_u_212 then
            v_u_212:Disconnect()
        end
        if v_u_213 then
            v_u_213:Disconnect()
        end
        v_u_217:Disconnect()
        v_u_219:Disconnect()
        v_u_226:Disconnect()
        for _, v228 in ipairs(v_u_19) do
            v228:Play()
        end
        wait(0.2)
        v_u_25.Parent = nil
    end
end
v2.PromptShown:Connect(function(p230, p231)
    if p230.Style ~= Enum.ProximityPromptStyle.Default then
        local v232 = v_u_5:FindFirstChild("ProximityPrompts")
        if v232 == nil then
            v232 = Instance.new("ScreenGui")
            v232.Name = "ProximityPrompts"
            v232.ResetOnSpawn = false
            v232.Parent = v_u_5
        end
        local v233 = v_u_229(p230, p231, v232)
        p230.PromptHidden:Wait()
        v233()
    end
end)