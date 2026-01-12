local v1 = game:GetService("TeleportService")
local v2 = v1:GetLocalPlayerTeleportData()
if v2 then
    print("teleportData:", v2)
    game.ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer("TeleportData", v2)
    local v3 = v1:GetArrivingTeleportGui()
    if v3 then
        local v4 = game:GetService("TweenService")
        v3.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        game.Debris:AddItem(v3, 1)
        v4:Create(v3.Label, TweenInfo.new(0.5), {
            ["Transparency"] = 1
        })
    end
end