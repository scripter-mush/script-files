local v1 = game.Players.LocalPlayer
local v2 = v1.Character or v1.CharacterAdded:wait()
local v3 = workspace.CurrentCamera
local v4 = v2:WaitForChild("HumanoidRootPart")
local v5 = v2:WaitForChild("Humanoid")
v3.CameraSubject = v5
v5.AutoRotate = false
v5.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
v5:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
v5:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
local v_u_6 = {
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
function Abbreviate(p7)
    local v8 = p7 < 0
    local v9 = math.floor(p7)
    local v10 = math.abs(v9)
    if v10 < 1000000 then
        return v10
    end
    local v11 = false
    for v12, _ in pairs(v_u_6) do
        if 10 ^ (3 * v12) > v10 then
            local v13 = v10 / 10 ^ (3 * (v12 - 1))
            local v14 = string.find(tostring(v13), ".")
            if v14 then
                local v15 = tostring(v13)
                v14 = string.sub(v15, 4, 4) ~= "."
            end
            local v16 = tostring(v13)
            v10 = string.sub(v16, 1, v14 and 4 or 3) .. (v_u_6[v12 - 1] or "")
            v11 = true
            break
        end
    end
    if not v11 then
        local v17 = math.floor(v10)
        v10 = tostring(v17)
    end
    if v8 then
        return "-" .. v10
    else
        return v10
    end
end
local v18 = game:GetService("UserInputService")
local v19 = game:GetService("UserInputService")
local v20 = game:GetService("GuiService")
local v21 = v19.TouchEnabled and not v19.KeyboardEnabled and not (v19.MouseEnabled or v19.GamepadEnabled)
if v21 then
    v21 = not v20:IsTenFootInterface()
end
local v22 = v1:GetMouse()
v22.TargetFilter = workspace.Projectiles
local v23 = game:GetService("RunService").RenderStepped
while v23:wait() do
    v5.AutoRotate = v18.MouseBehavior == Enum.MouseBehavior.LockCenter
    if not v4.Anchored and v18.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        local v24 = v4.CFrame.LookVector
        local v25 = v4.Position
        if v21 then
            v4.CFrame = CFrame.new(v25, v25 + v24 + v3.CFrame.LookVector * Vector3.new(1, 0, 1))
        elseif v22.Y >= v22.ViewSizeY * 0.95 then
            v4.CFrame = CFrame.new(v25, v25 + v24 - v22.UnitRay.Direction * Vector3.new(-0.1, 0, 0.1))
        else
            v4.CFrame = CFrame.new(v25, v25 + v24 + v22.UnitRay.Direction * Vector3.new(1, 0, 1))
        end
    end
end