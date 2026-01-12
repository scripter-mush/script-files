local v1 = game:GetService("ReplicatedStorage")
local v2 = script.Parent.RemoteEvent
local v_u_3 = game.Players.LocalPlayer
local v4 = v_u_3.UserId
local v_u_5 = v_u_3.Character or v_u_3.CharacterAdded:Wait()
local v_u_6 = v_u_5:WaitForChild("Humanoid")
local v7 = require(v1.DataLink)
local v_u_8 = require(v1.CombatData)
local v_u_9 = require(v1.WeaponData)
require(v1.EquipmentModule)
local v_u_10 = require(v1.AnimationService)
local v_u_11 = require(v1.CombatShared)
local v12 = game:GetService("UserInputService")
local v_u_13, v_u_14 = v_u_11:Priority()
local _ = Enum.KeyCode
local v_u_15 = {
    ["Player"] = v_u_3,
    ["UserId"] = v4,
    ["Character"] = v_u_5,
    ["Humanoid"] = v_u_6,
    ["RemoteEvent"] = v2,
    ["Anim"] = v_u_10,
    ["Stats"] = {
        ["AS"] = 1
    },
    ["Tools"] = {}
}
local v_u_16 = {}
local v_u_17, v_u_18 = v_u_11:LoadCooldownKey(v_u_15, v2)
local v_u_19 = {}
v7.CombatEvent = v2
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = {
    ["Space"] = true
}
local v_u_23 = {}
local function v_u_27()
    for _, v24 in pairs(v_u_14) do
        v_u_23[v24[2]] = true
    end
    if v_u_20 then
        for _, v25 in pairs(v_u_20:GetChildren()) do
            if v25:IsA("TextButton") then
                v25.Visible = v_u_23[v25.Text]
            end
        end
        for _, v26 in pairs(v_u_21:GetChildren()) do
            if v26:IsA("TextButton") then
                v26.Visible = v_u_23[v26.Text]
            end
        end
    end
end
local v_u_28 = {}
local v_u_29 = {}
function OnEquip(p30, p31)
    local v32 = v_u_9[p30]
    local v33 = v_u_8[p30] or v_u_8[v32.Type]
    if v33 then
        local v34 = v33(v_u_15, v_u_15.Tools[p31])
        if v34.AnimPack then
            v_u_28[p30] = { v34.AnimPack }
        end
        v_u_11:ClientMoves(v_u_15, p30, v34, v_u_10, v_u_19, v_u_18, v_u_13, v_u_14, false, v_u_29)
    end
    if v32 then
        for _, v35 in pairs(v32.Skills or {}) do
            local v36 = v_u_8[v35]
            if v36 then
                local v37 = v36(v_u_15, v_u_15.Tools[p31])
                if v37.AnimPack then
                    v_u_28[p30] = v_u_28[p30] or {}
                    local v38 = v_u_28[p30]
                    local v39 = v37.AnimPack
                    table.insert(v38, v39)
                end
                v_u_11:ClientMoves(v_u_15, p30, v37, v_u_10, v_u_19, v_u_18, v_u_13, v_u_14, v35, v_u_29)
            end
        end
    end
end
function Unequip(p40)
    local v41 = v_u_28[p40] or {}
    for _, v42 in pairs(v41) do
        v_u_10:UnloadPack(v_u_10:Get(v42))
    end
    for v43 = #v_u_14, 1, -1 do
        if v_u_14[v43][4].Key == p40 then
            table.remove(v_u_14, v43)
        end
    end
end
local v_u_44 = {
    ["ButtonA"] = "Space",
    ["ButtonR2"] = "LMB",
    ["ButtonL2"] = "LeftShift",
    ["ButtonL1"] = "Q",
    ["ButtonR1"] = "E",
    ["ButtonX"] = "R",
    ["ButtonY"] = "F",
    ["ButtonB"] = "Q",
    ["ButtonR3"] = "T"
}
function CombatInput(p_u_45, p46)
    local v47 = v_u_6:FindFirstChild("Stunned") or v_u_6:FindFirstChild("Sleep")
    local v48 = p_u_45.KeyCode
    if v48 then
        v48 = p_u_45.KeyCode.Name
    end
    if p46 and v48 ~= "ButtonA" or (v_u_6.Health <= 0 or v47) then
        return
    else
        if p_u_45.UserInputType == Enum.UserInputType.MouseButton1 then
            v48 = "LMB"
        elseif p_u_45.UserInputType == Enum.UserInputType.MouseButton2 then
            v48 = "RMB"
        elseif p_u_45.UserInputType == Enum.UserInputType.Touch then
            v48 = p_u_45:GetAttribute("Key")
        end
        if p_u_45.UserInputType == Enum.UserInputType.Gamepad1 and v_u_44[v48] then
            v48 = v_u_44[v48]
        end
        if not v_u_6:FindFirstChild("Silenced") or v48 == "LMB" then
            if v_u_23[v48] then
                local v49 = v_u_13:Find(v48)
                if (v_u_22[v48] or v_u_17:GetState() == "Inactive") and v49 then
                    local v_u_50 = v49[4]
                    local v51 = v49[5]
                    local v52 = v_u_50:GetState()
                    local v53
                    if v52 == "Active" then
                        v53 = false
                    else
                        v53 = v52 ~= "Disabled"
                    end
                    if v53 then
                        task.delay(0.1, function()
                            task.wait(v_u_50.Time)
                            if v_u_17.Time > 0 then
                                task.wait(v_u_17.Time)
                            end
                            if p_u_45.UserInputState ~= Enum.UserInputState.End then
                                CombatInput(p_u_45)
                            end
                        end)
                        v51(v_u_50, p_u_45)
                        return
                    end
                end
            end
        end
    end
end
v12.InputBegan:Connect(CombatInput)
local v_u_54 = {
    "Solar Staff",
    "Superball",
    "Sentient Commander",
    "Quasar Commander",
    "Commander of Cosmos"
}
local v_u_55 = {
    ["Fireball Supreme"] = Enum.KeyCode.R
}
local v_u_56 = tick()
v12.TouchTapInWorld:Connect(function()
    local v57 = tick()
    local v58 = v57 - v_u_56
    v_u_56 = v57
    if v58 < 0.5 then
        local v59 = false
        local v60 = nil
        for _, v61 in pairs(v_u_15.Tools) do
            if table.find(v_u_54, v61.Name) then
                v60 = v61.Name
                v59 = true
            end
        end
        if v59 then
            local v_u_62 = {
                ["UserInputType"] = Enum.UserInputType.MouseButton1,
                ["UserInputState"] = Enum.UserInputState.Begin
            }
            if v_u_55[v60] then
                v_u_62.UserInputType = Enum.UserInputType.Keyboard
                v_u_62.KeyCode = v_u_55[v60]
            end
            function v_u_62.GetPropertyChangedSignal(_)
                return {
                    ["Wait"] = function(_)
                        while v_u_62 do
                            task.wait()
                        end
                    end
                }
            end
            CombatInput(v_u_62)
            task.delay(0.5, function()
                v_u_62.UserInputState = Enum.UserInputState.End
                v_u_62 = nil
            end)
        end
    end
end)
local function v_u_75()
    local v63 = v_u_3.PlayerGui
    v_u_20 = game.ReplicatedStorage.Models.Interface.MobileControls:Clone()
    v_u_20.Parent = Instance.new("ScreenGui", v63)
    v_u_21 = game.ReplicatedStorage.Models.Interface.SpecialMobileControls:Clone()
    v_u_21.Parent = v_u_20.Parent
    local v64 = v_u_20.Template
    for v65, v_u_66 in pairs({
        "LMB",
        "Q",
        "E",
        "R",
        "F"
    }) do
        local v67 = v64:Clone()
        v67.Parent = v_u_20
        v67.Text = v_u_66
        v67.Name = v65
        v67.InputBegan:Connect(function(p68)
            if p68.UserInputType == Enum.UserInputType.Touch then
                p68:SetAttribute("Key", v_u_66)
                CombatInput(p68)
            end
        end)
    end
    for v69, v_u_70 in pairs({ "T" }) do
        local v71 = v64:Clone()
        v71.Parent = v_u_21
        v71.Text = v_u_70
        v71.Name = v69
        v71.Visible = false
        v71.InputBegan:Connect(function(p72)
            if p72.UserInputType == Enum.UserInputType.Touch then
                p72:SetAttribute("Key", v_u_70)
                CombatInput(p72)
            end
        end)
    end
    v64:Destroy()
    local v_u_73 = nil
    local v_u_74 = v_u_21.Sprint
    v_u_74.InputBegan:Connect(function()
        if v_u_73 then
            v_u_74.BackgroundTransparency = 0.2
            v_u_73.UserInputState = Enum.UserInputState.End
            v_u_73 = nil
        else
            v_u_74.BackgroundTransparency = 0.7
            v_u_73 = {
                ["KeyCode"] = Enum.KeyCode.LeftShift,
                ["UserInputState"] = Enum.UserInputState.Begin,
                ["GetPropertyChangedSignal"] = function(_)
                    return {
                        ["Wait"] = function(_)
                            while v_u_73 do
                                task.wait()
                            end
                        end
                    }
                end
            }
            CombatInput(v_u_73)
        end
    end)
    v_u_27()
end
if v12:GetLastInputType() == Enum.UserInputType.Touch or v12.TouchEnabled and not v12.KeyboardEnabled then
    v_u_75()
end
local v_u_76 = nil
local v_u_77 = nil
local function v_u_79()
    v_u_76 = v_u_3.PlayerGui:FindFirstChild("TouchGui")
    if not v_u_77 and v_u_76 then
        v_u_77 = v_u_76:WaitForChild("TouchControlFrame"):WaitForChild("JumpButton").InputBegan:Connect(function(p78)
            if p78.UserInputType == Enum.UserInputType.Touch then
                p78:SetAttribute("Key", "Space")
                CombatInput(p78)
            end
        end)
        print("jump overwrite loaded successfully :)")
    end
end
task.spawn(v_u_79)
v12.LastInputTypeChanged:Connect(function(p80)
    if p80 == Enum.UserInputType.Touch then
        if not v_u_20 then
            v_u_75()
        end
        v_u_20.Visible = true
        v_u_79()
    elseif v_u_20 and p80 == Enum.UserInputType.Keyboard then
        v_u_20.Visible = false
    end
end)
function UpdateStats(p81)
    for v82, v83 in pairs(p81) do
        v_u_15.Stats[v82] = v83
    end
end
local v_u_84 = {}
function v_u_15.ClientEvents(_, p85)
    for v86, v87 in pairs(p85) do
        print("adding event")
        print(v86, v87)
        v_u_84[v86] = v87
    end
end
v_u_5:WaitForChild("HumanoidRootPart")
local v_u_88 = v_u_5:WaitForChild("Equipment")
v_u_10:Init()
v7:Connect("UpdateStats", UpdateStats)
v2.OnClientEvent:Connect(function(p89, ...)
    print("received", p89)
    if p89 == "LoadCharacter" then
        local v90, v91 = ...
        UpdateStats(v90)
        local v92 = {}
        for _, v93 in pairs(v_u_88:GetChildren()) do
            local v94 = v93:GetAttribute("Slot")
            if v94 then
                v92[v94] = v93
            end
        end
        for _, v95 in pairs(v91) do
            OnEquip(v95)
        end
        v_u_15.Tools = v92
        for v96, v97 in pairs(v92) do
            OnEquip(v97.Name, v96)
            local v98 = v_u_16
            local v99 = v97.Name
            table.insert(v98, v99)
        end
        v_u_27()
        return
    elseif p89 == "ChangeMoves" then
        local v100 = ...
        local v101 = {}
        local v102 = {}
        for v103, v104 in pairs(v100) do
            local v105 = false
            for _, v106 in pairs(v_u_16) do
                v105 = v105 or v104 == v106
            end
            if not v105 then
                table.insert(v101, { v104, v103 })
            end
        end
        for _, v107 in pairs(v_u_16) do
            local v108 = false
            for _, v109 in pairs(v100) do
                v108 = v108 or v107 == v109
            end
            if not v108 then
                table.insert(v102, v107)
            end
        end
        for _, v110 in pairs(v102) do
            print("remove item", v110)
            Unequip(v110)
        end
        local v111 = {}
        for _, v112 in pairs(v_u_88:GetChildren()) do
            print(v112)
            local v113 = v112:GetAttribute("Slot")
            if v113 then
                v111[v113] = v112
            end
        end
        v_u_15.Tools = v111
        for _, v114 in pairs(v101) do
            local v115, v116 = table.unpack(v114)
            print("On Equip", v115, v116, v_u_15.Tools[v116])
            OnEquip(v115, v116)
        end
        v_u_16 = v100
        v_u_27()
        return
    elseif p89 == "ClientSkill" then
        local v117 = table.pack(...)
        v_u_84[v117[1]](table.unpack(v117, 2))
    elseif p89 == "Equip" then
        local v118 = ...
        for _, v119 in pairs(v_u_5.Equipment:GetChildren()) do
            local v120 = v119:GetAttribute("Slot")
            if v120 == v118 then
                OnEquip(v119.Name, v120)
            end
        end
        v_u_27()
    end
end)
local v121 = game:GetService("RunService")
local v_u_122 = tick()
v121.RenderStepped:Connect(function()
    local v123 = tick() - v_u_122
    v_u_122 = tick()
    v_u_11:ReduceCooldowns(v_u_17, v_u_14, v123)
end)
v2:FireServer("HasLoaded")