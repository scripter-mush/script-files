local v1 = game:GetService("TextChatService")
local v_u_2 = game:GetService("Players")
function v1.OnIncomingMessage(p3)
    local v4 = Instance.new("TextChatMessageProperties")
    if p3.TextSource and v_u_2:GetPlayerByUserId(p3.TextSource.UserId):GetAttribute("VIP") then
        v4.PrefixText = "<font color=\'#F5CD30\'>[VIP]</font> " .. p3.PrefixText
    end
    return v4
end
local v5 = game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController")
local v6 = v5:FindFirstChild("BoundKeys")
if v6 then
    v6.Value = "LeftControl,RightControl"
else
    local v7 = Instance.new("StringValue")
    v7.Name = "BoundKeys"
    v7.Value = "LeftControl,RightControl"
    v7.Parent = v5
end