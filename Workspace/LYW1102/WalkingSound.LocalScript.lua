local v1 = game:GetService("Players")
local v2 = game:GetService("SoundService")
local v3 = v1.LocalPlayer
local v4 = v3.Character or v3.CharacterAdded:wait()
local v_u_5 = v4.Humanoid
local v_u_6 = v2:FindFirstChild("CurrentSound") or Instance.new("Sound", v2)
v_u_6.Name = "CurrentSound"
local v_u_7 = nil
local v_u_8 = nil
local v_u_9 = {
    ["Air"] = {
        ["id"] = "rbxassetid://329997777",
        ["volume"] = 0,
        ["speed"] = 1
    },
    ["Asphalt"] = {
        ["id"] = "rbxassetid://277067660",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Basalt"] = {
        ["id"] = "rbxassetid://3190903775",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Brick"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Cobblestone"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Concrete"] = {
        ["id"] = "rbxassetid://277067660",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["CorrodedMetal"] = {
        ["id"] = "rbxassetid://177940974",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["CrackedLava"] = {
        ["id"] = "rbxassetid://3190903775",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["DiamondPlate"] = {
        ["id"] = "rbxassetid://177940974",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Fabric"] = {
        ["id"] = "rbxassetid://9083849830",
        ["volume"] = 0.4,
        ["speed"] = 1
    },
    ["Foil"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Forcefield"] = {
        ["id"] = "rbxassetid://329997777",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Glass"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Granite"] = {
        ["id"] = "rbxassetid://178054124",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Grass"] = {
        ["id"] = "rbxassetid://9064714296",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Glacier"] = {
        ["id"] = "rbxassetid://7047108275",
        ["volume"] = 0.4,
        ["speed"] = 1
    },
    ["Ground"] = {
        ["id"] = "rbxassetid://9064714296",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Ice"] = {
        ["id"] = "rbxassetid://7047108275",
        ["volume"] = 0.4,
        ["speed"] = 1
    },
    ["Limestone"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["LeafyGrass"] = {
        ["id"] = "rbxassetid://3098847639",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Marble"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Metal"] = {
        ["id"] = "rbxassetid://177940974",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Mud"] = {
        ["id"] = "rbxassetid://6441160246",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Neon"] = {
        ["id"] = "rbxassetid://177940974",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Pebble"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Plastic"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Pavement"] = {
        ["id"] = "rbxassetid://277067660",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Rock"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Sand"] = {
        ["id"] = "rbxassetid://9083846829",
        ["volume"] = 0.4,
        ["speed"] = 1
    },
    ["Slate"] = {
        ["id"] = "rbxassetid://178054124",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Snow"] = {
        ["id"] = "rbxassetid://8453425942",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Salt"] = {
        ["id"] = "rbxassetid://9083846829",
        ["volume"] = 0.4,
        ["speed"] = 1
    },
    ["Sandstone"] = {
        ["id"] = "rbxassetid://3190903775",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["SmoothPlastic"] = {
        ["id"] = "rbxassetid://178190837",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["Wood"] = {
        ["id"] = "rbxassetid://3199270096",
        ["volume"] = 0.6,
        ["speed"] = 1
    },
    ["WoodPlanks"] = {
        ["id"] = "rbxassetid://211987063",
        ["volume"] = 0.6,
        ["speed"] = 1
    }
}
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = 0
local v_u_13 = 1
for _, v14 in pairs(v4:WaitForChild("HumanoidRootPart"):GetChildren()) do
    if v14:IsA("Sound") and v14.Name == "Running" then
        v14:Destroy()
    end
end
local function v_u_17()
    for v15, v16 in pairs(v_u_9) do
        if v15 == v_u_8 then
            v_u_10 = v_u_5.WalkSpeed
            v_u_11 = v16.id
            v_u_12 = v16.volume
            v_u_13 = v_u_5.WalkSpeed / 16 * v16.speed
            return
        end
    end
end
v_u_5:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
    v_u_6:Stop()
    v_u_7 = v_u_5.FloorMaterial
    local v18 = v_u_7
    v_u_8 = string.split(tostring(v18), "Enum.Material.")[2]
    v_u_17()
    if v_u_11 then
        v_u_6.SoundId = v_u_11
    end
    v_u_6.Volume = v_u_12 / 2
    v_u_6.PlaybackSpeed = v_u_13
    if v_u_5.MoveDirection.Magnitude > 0 then
        v_u_6.Playing = true
    end
end)
v_u_5.Running:Connect(function(p19)
    if v_u_5.MoveDirection.Magnitude > 0 and (p19 > 0 and v_u_5:GetState() ~= Enum.HumanoidStateType.Climbing) then
        if v_u_10 ~= v_u_5.WalkSpeed then
            v_u_17()
            if v_u_11 then
                v_u_6.SoundId = v_u_11
            end
            v_u_6.Volume = v_u_12 / 2
            v_u_6.PlaybackSpeed = v_u_13
        end
        v_u_6.Playing = true
        v_u_6.Looped = true
    else
        v_u_6:Stop()
    end
end)
v3.CharacterAdded:Connect(function()
    task.wait(1)
    if v_u_6.IsPlaying then
        v_u_6:Stop()
    end
end)