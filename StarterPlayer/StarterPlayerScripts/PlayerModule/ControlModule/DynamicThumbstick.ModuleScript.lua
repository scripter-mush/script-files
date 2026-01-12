local v_u_1 = Enum.ContextActionPriority.High.Value
local v_u_2 = {
    0.10999999999999999,
    0.30000000000000004,
    0.4,
    0.5,
    0.6,
    0.7,
    0.75
}
local v_u_3 = #v_u_2
local v_u_4 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local v5 = game:GetService("Players")
local v_u_6 = game:GetService("GuiService")
local v_u_7 = game:GetService("UserInputService")
local v_u_8 = game:GetService("ContextActionService")
local v_u_9 = game:GetService("RunService")
local v_u_10 = game:GetService("TweenService")
local v_u_11 = v5.LocalPlayer
if not v_u_11 then
    v5:GetPropertyChangedSignal("LocalPlayer"):Wait()
    v_u_11 = v5.LocalPlayer
end
local v_u_12 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_13 = setmetatable({}, v_u_12)
v_u_13.__index = v_u_13
function v_u_13.new()
    local v14 = v_u_12.new()
    local v15 = v_u_13
    local v16 = setmetatable(v14, v15)
    v16.moveTouchObject = nil
    v16.moveTouchLockedIn = false
    v16.moveTouchFirstChanged = false
    v16.moveTouchStartPosition = nil
    v16.startImage = nil
    v16.endImage = nil
    v16.middleImages = {}
    v16.startImageFadeTween = nil
    v16.endImageFadeTween = nil
    v16.middleImageFadeTweens = {}
    v16.isFirstTouch = true
    v16.thumbstickFrame = nil
    v16.onRenderSteppedConn = nil
    v16.fadeInAndOutBalance = 0.5
    v16.fadeInAndOutHalfDuration = 0.3
    v16.hasFadedBackgroundInPortrait = false
    v16.hasFadedBackgroundInLandscape = false
    v16.tweenInAlphaStart = nil
    v16.tweenOutAlphaStart = nil
    return v16
end
function v_u_13.GetIsJumping(p17)
    local v18 = p17.isJumping
    p17.isJumping = false
    return v18
end
function v_u_13.Enable(p19, p20, p21)
    if p20 == nil then
        return false
    end
    local v22 = p20 and true or false
    if p19.enabled == v22 then
        return true
    end
    if v22 then
        if not p19.thumbstickFrame then
            p19:Create(p21)
        end
        p19:BindContextActions()
    else
        v_u_8:UnbindAction("DynamicThumbstickAction")
        p19:OnInputEnded()
    end
    p19.enabled = v22
    p19.thumbstickFrame.Visible = v22
    return nil
end
function v_u_13.OnInputEnded(p23)
    p23.moveTouchObject = nil
    p23.moveVector = Vector3.new(0, 0, 0)
    p23:FadeThumbstick(false)
end
function v_u_13.FadeThumbstick(p24, p25)
    if p25 or not p24.moveTouchObject then
        if p24.isFirstTouch then
            return
        else
            if p24.startImageFadeTween then
                p24.startImageFadeTween:Cancel()
            end
            if p24.endImageFadeTween then
                p24.endImageFadeTween:Cancel()
            end
            for v26 = 1, #p24.middleImages do
                if p24.middleImageFadeTweens[v26] then
                    p24.middleImageFadeTweens[v26]:Cancel()
                end
            end
            if p25 then
                p24.startImageFadeTween = v_u_10:Create(p24.startImage, v_u_4, {
                    ["ImageTransparency"] = 0
                })
                p24.startImageFadeTween:Play()
                p24.endImageFadeTween = v_u_10:Create(p24.endImage, v_u_4, {
                    ["ImageTransparency"] = 0.2
                })
                p24.endImageFadeTween:Play()
                for v27 = 1, #p24.middleImages do
                    p24.middleImageFadeTweens[v27] = v_u_10:Create(p24.middleImages[v27], v_u_4, {
                        ["ImageTransparency"] = v_u_2[v27]
                    })
                    p24.middleImageFadeTweens[v27]:Play()
                end
            else
                p24.startImageFadeTween = v_u_10:Create(p24.startImage, v_u_4, {
                    ["ImageTransparency"] = 1
                })
                p24.startImageFadeTween:Play()
                p24.endImageFadeTween = v_u_10:Create(p24.endImage, v_u_4, {
                    ["ImageTransparency"] = 1
                })
                p24.endImageFadeTween:Play()
                for v28 = 1, #p24.middleImages do
                    p24.middleImageFadeTweens[v28] = v_u_10:Create(p24.middleImages[v28], v_u_4, {
                        ["ImageTransparency"] = 1
                    })
                    p24.middleImageFadeTweens[v28]:Play()
                end
            end
        end
    else
        return
    end
end
function v_u_13.FadeThumbstickFrame(p29, p30, p31)
    p29.fadeInAndOutHalfDuration = p30 * 0.5
    p29.fadeInAndOutBalance = p31
    p29.tweenInAlphaStart = tick()
end
function v_u_13.InputInFrame(p32, p33)
    local v34 = p32.thumbstickFrame.AbsolutePosition
    local v35 = v34 + p32.thumbstickFrame.AbsoluteSize
    local v36 = p33.Position
    return v36.X >= v34.X and (v36.Y >= v34.Y and (v36.X <= v35.X and v36.Y <= v35.Y))
end
function v_u_13.DoFadeInBackground(p37)
    local v38 = v_u_11:FindFirstChildOfClass("PlayerGui")
    local v39 = false
    if v38 then
        if v38.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v38.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v39 = p37.hasFadedBackgroundInLandscape
            p37.hasFadedBackgroundInLandscape = true
        elseif v38.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v39 = p37.hasFadedBackgroundInPortrait
            p37.hasFadedBackgroundInPortrait = true
        end
    end
    if not v39 then
        p37.fadeInAndOutHalfDuration = 0.3
        p37.fadeInAndOutBalance = 0.5
        p37.tweenInAlphaStart = tick()
    end
end
function v_u_13.DoMove(p40, p41)
    local v42
    if p41.Magnitude < p40.radiusOfDeadZone then
        v42 = Vector3.new(0, 0, 0)
    else
        local v43 = p41.Unit
        local v44 = (p40.radiusOfMaxSpeed - p41.Magnitude) / p40.radiusOfMaxSpeed
        local v45 = v43 * (1 - math.max(0, v44))
        local v46 = v45.X
        local v47 = v45.Y
        v42 = Vector3.new(v46, 0, v47)
    end
    p40.moveVector = v42
end
function v_u_13.LayoutMiddleImages(p48, p49, p50)
    local v51 = p48.thumbstickSize / 2 + p48.middleSize
    local v52 = p50 - p49
    local v53 = v52.Magnitude - p48.thumbstickRingSize / 2 - p48.middleSize
    local v54 = v52.Unit
    local v55 = p48.middleSpacing * v_u_3
    local v56 = p48.middleSpacing
    if v55 < v53 then
        v56 = v53 / v_u_3
    end
    for v57 = 1, v_u_3 do
        local v58 = p48.middleImages[v57]
        local v59 = v51 + v56 * (v57 - 2)
        local v60 = v51 + v56 * (v57 - 1)
        if v59 < v53 then
            local v61 = p50 - v54 * v60
            local v62 = 1 - (v60 - v53) / v56
            local v63 = math.clamp(v62, 0, 1)
            v58.Visible = true
            v58.Position = UDim2.new(0, v61.X, 0, v61.Y)
            v58.Size = UDim2.new(0, p48.middleSize * v63, 0, p48.middleSize * v63)
        else
            v58.Visible = false
        end
    end
end
function v_u_13.MoveStick(p64, p65)
    local v66 = Vector2.new(p64.moveTouchStartPosition.X, p64.moveTouchStartPosition.Y) - p64.thumbstickFrame.AbsolutePosition
    local v67 = Vector2.new(p65.X, p65.Y) - p64.thumbstickFrame.AbsolutePosition
    p64.endImage.Position = UDim2.new(0, v67.X, 0, v67.Y)
    p64:LayoutMiddleImages(v66, v67)
end
function v_u_13.BindContextActions(p_u_68)
    local function v_u_71(p69)
        if p_u_68.moveTouchObject then
            return Enum.ContextActionResult.Pass
        end
        if not p_u_68:InputInFrame(p69) then
            return Enum.ContextActionResult.Pass
        end
        if p_u_68.isFirstTouch then
            p_u_68.isFirstTouch = false
            local v70 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            v_u_10:Create(p_u_68.startImage, v70, {
                ["Size"] = UDim2.new(0, 0, 0, 0)
            }):Play()
            v_u_10:Create(p_u_68.endImage, v70, {
                ["Size"] = UDim2.new(0, p_u_68.thumbstickSize, 0, p_u_68.thumbstickSize),
                ["ImageColor3"] = Color3.new(0, 0, 0)
            }):Play()
        end
        p_u_68.moveTouchLockedIn = false
        p_u_68.moveTouchObject = p69
        p_u_68.moveTouchStartPosition = p69.Position
        p_u_68.moveTouchFirstChanged = true
        p_u_68:DoFadeInBackground()
        return Enum.ContextActionResult.Pass
    end
    local function v_u_77(p72)
        if p72 ~= p_u_68.moveTouchObject then
            return Enum.ContextActionResult.Pass
        end
        if p_u_68.moveTouchFirstChanged then
            p_u_68.moveTouchFirstChanged = false
            local v73 = Vector2.new(p72.Position.X - p_u_68.thumbstickFrame.AbsolutePosition.X, p72.Position.Y - p_u_68.thumbstickFrame.AbsolutePosition.Y)
            p_u_68.startImage.Visible = true
            p_u_68.startImage.Position = UDim2.new(0, v73.X, 0, v73.Y)
            p_u_68.endImage.Visible = true
            p_u_68.endImage.Position = p_u_68.startImage.Position
            p_u_68:FadeThumbstick(true)
            p_u_68:MoveStick(p72.Position)
        end
        p_u_68.moveTouchLockedIn = true
        local v74 = Vector2.new(p72.Position.X - p_u_68.moveTouchStartPosition.X, p72.Position.Y - p_u_68.moveTouchStartPosition.Y)
        local v75 = v74.X
        if math.abs(v75) <= 0 then
            local v76 = v74.Y
            if math.abs(v76) <= 0 then
                ::l7::
                return Enum.ContextActionResult.Sink
            end
        end
        p_u_68:DoMove(v74)
        p_u_68:MoveStick(p72.Position)
        goto l7
    end
    v_u_8:BindActionAtPriority("DynamicThumbstickAction", function(_, p78, p79)
        if p78 == Enum.UserInputState.Begin then
            return v_u_71(p79)
        end
        if p78 == Enum.UserInputState.Change then
            return v_u_77(p79)
        end
        if p78 == Enum.UserInputState.End then
            if p79 == p_u_68.moveTouchObject then
                p_u_68:OnInputEnded()
                if p_u_68.moveTouchLockedIn then
                    return Enum.ContextActionResult.Sink
                end
            end
            return Enum.ContextActionResult.Pass
        end
        if p78 == Enum.UserInputState.Cancel then
            p_u_68:OnInputEnded()
        end
    end, false, v_u_1, Enum.UserInputType.Touch)
end
function v_u_13.Create(p_u_80, p81)
    if p_u_80.thumbstickFrame then
        p_u_80.thumbstickFrame:Destroy()
        p_u_80.thumbstickFrame = nil
        if p_u_80.onRenderSteppedConn then
            p_u_80.onRenderSteppedConn:Disconnect()
            p_u_80.onRenderSteppedConn = nil
        end
    end
    p_u_80.thumbstickSize = 45
    p_u_80.thumbstickRingSize = 20
    p_u_80.middleSize = 10
    p_u_80.middleSpacing = p_u_80.middleSize + 4
    p_u_80.radiusOfDeadZone = 2
    p_u_80.radiusOfMaxSpeed = 20
    local v82 = p81.AbsoluteSize
    local v83 = v82.X
    local v84 = v82.Y
    if math.min(v83, v84) > 500 then
        p_u_80.thumbstickSize = p_u_80.thumbstickSize * 2
        p_u_80.thumbstickRingSize = p_u_80.thumbstickRingSize * 2
        p_u_80.middleSize = p_u_80.middleSize * 2
        p_u_80.middleSpacing = p_u_80.middleSpacing * 2
        p_u_80.radiusOfDeadZone = p_u_80.radiusOfDeadZone * 2
        p_u_80.radiusOfMaxSpeed = p_u_80.radiusOfMaxSpeed * 2
    end
    local function v_u_86(p85)
        if p85 then
            p_u_80.thumbstickFrame.Size = UDim2.new(1, 0, 0.4, 0)
            p_u_80.thumbstickFrame.Position = UDim2.new(0, 0, 0.6, 0)
        else
            p_u_80.thumbstickFrame.Size = UDim2.new(0.4, 0, 0.6666666666666666, 0)
            p_u_80.thumbstickFrame.Position = UDim2.new(0, 0, 0.3333333333333333, 0)
        end
    end
    p_u_80.thumbstickFrame = Instance.new("Frame")
    p_u_80.thumbstickFrame.BorderSizePixel = 0
    p_u_80.thumbstickFrame.Name = "DynamicThumbstickFrame"
    p_u_80.thumbstickFrame.Visible = false
    p_u_80.thumbstickFrame.BackgroundTransparency = 1
    p_u_80.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    p_u_80.thumbstickFrame.Active = false
    v_u_86(false)
    p_u_80.startImage = Instance.new("ImageLabel")
    p_u_80.startImage.Name = "ThumbstickStart"
    p_u_80.startImage.Visible = true
    p_u_80.startImage.BackgroundTransparency = 1
    p_u_80.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
    p_u_80.startImage.ImageRectOffset = Vector2.new(1, 1)
    p_u_80.startImage.ImageRectSize = Vector2.new(144, 144)
    p_u_80.startImage.ImageColor3 = Color3.new(0, 0, 0)
    p_u_80.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
    p_u_80.startImage.Position = UDim2.new(0, p_u_80.thumbstickRingSize * 3.3, 1, -p_u_80.thumbstickRingSize * 2.8)
    p_u_80.startImage.Size = UDim2.new(0, p_u_80.thumbstickRingSize * 3.7, 0, p_u_80.thumbstickRingSize * 3.7)
    p_u_80.startImage.ZIndex = 10
    p_u_80.startImage.Parent = p_u_80.thumbstickFrame
    p_u_80.endImage = Instance.new("ImageLabel")
    p_u_80.endImage.Name = "ThumbstickEnd"
    p_u_80.endImage.Visible = true
    p_u_80.endImage.BackgroundTransparency = 1
    p_u_80.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
    p_u_80.endImage.ImageRectOffset = Vector2.new(1, 1)
    p_u_80.endImage.ImageRectSize = Vector2.new(144, 144)
    p_u_80.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
    p_u_80.endImage.Position = p_u_80.startImage.Position
    p_u_80.endImage.Size = UDim2.new(0, p_u_80.thumbstickSize * 0.8, 0, p_u_80.thumbstickSize * 0.8)
    p_u_80.endImage.ZIndex = 10
    p_u_80.endImage.Parent = p_u_80.thumbstickFrame
    for v87 = 1, v_u_3 do
        p_u_80.middleImages[v87] = Instance.new("ImageLabel")
        p_u_80.middleImages[v87].Name = "ThumbstickMiddle"
        p_u_80.middleImages[v87].Visible = false
        p_u_80.middleImages[v87].BackgroundTransparency = 1
        p_u_80.middleImages[v87].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        p_u_80.middleImages[v87].ImageRectOffset = Vector2.new(1, 1)
        p_u_80.middleImages[v87].ImageRectSize = Vector2.new(144, 144)
        p_u_80.middleImages[v87].ImageTransparency = v_u_2[v87]
        p_u_80.middleImages[v87].AnchorPoint = Vector2.new(0.5, 0.5)
        p_u_80.middleImages[v87].ZIndex = 9
        p_u_80.middleImages[v87].Parent = p_u_80.thumbstickFrame
    end
    local v_u_88 = nil
    local function v93()
        if v_u_88 then
            v_u_88:Disconnect()
            v_u_88 = nil
        end
        local v_u_89 = workspace.CurrentCamera
        if v_u_89 then
            local function v91()
                local v90 = v_u_89.ViewportSize
                v_u_86(v90.X < v90.Y)
            end
            v_u_88 = v_u_89:GetPropertyChangedSignal("ViewportSize"):Connect(v91)
            local v92 = v_u_89.ViewportSize
            v_u_86(v92.X < v92.Y)
        end
    end
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(v93)
    if workspace.CurrentCamera then
        v93()
    end
    p_u_80.moveTouchStartPosition = nil
    p_u_80.startImageFadeTween = nil
    p_u_80.endImageFadeTween = nil
    p_u_80.middleImageFadeTweens = {}
    p_u_80.onRenderSteppedConn = v_u_9.RenderStepped:Connect(function()
        if p_u_80.tweenInAlphaStart == nil then
            if p_u_80.tweenOutAlphaStart ~= nil then
                local v94 = tick() - p_u_80.tweenOutAlphaStart
                local v95 = p_u_80.fadeInAndOutHalfDuration * 2 - p_u_80.fadeInAndOutHalfDuration * 2 * p_u_80.fadeInAndOutBalance
                local v96 = p_u_80.thumbstickFrame
                local v97 = v94 / v95
                v96.BackgroundTransparency = math.min(v97, 1) * 0.35 + 0.65
                if v95 < v94 then
                    p_u_80.tweenOutAlphaStart = nil
                end
            end
        else
            local v98 = tick() - p_u_80.tweenInAlphaStart
            local v99 = p_u_80.fadeInAndOutHalfDuration * 2 * p_u_80.fadeInAndOutBalance
            local v100 = p_u_80.thumbstickFrame
            local v101 = v98 / v99
            v100.BackgroundTransparency = 1 - math.min(v101, 1) * 0.35
            if v99 < v98 then
                p_u_80.tweenOutAlphaStart = tick()
                p_u_80.tweenInAlphaStart = nil
                return
            end
        end
    end)
    p_u_80.onTouchEndedConn = v_u_7.TouchEnded:connect(function(p102)
        if p102 == p_u_80.moveTouchObject then
            p_u_80:OnInputEnded()
        end
    end)
    v_u_6.MenuOpened:connect(function()
        if p_u_80.moveTouchObject then
            p_u_80:OnInputEnded()
        end
    end)
    local v_u_103 = v_u_11:FindFirstChildOfClass("PlayerGui")
    while not v_u_103 do
        v_u_11.ChildAdded:wait()
        v_u_103 = v_u_11:FindFirstChildOfClass("PlayerGui")
    end
    local v_u_104 = nil
    local v_u_105 = v_u_103.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or v_u_103.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight
    local _ = v_u_103:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function()
        if v_u_105 and v_u_103.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait or not v_u_105 and v_u_103.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
            v_u_104:disconnect()
            p_u_80.fadeInAndOutHalfDuration = 2.5
            p_u_80.fadeInAndOutBalance = 0.05
            p_u_80.tweenInAlphaStart = tick()
            if v_u_105 then
                p_u_80.hasFadedBackgroundInPortrait = true
                return
            end
            p_u_80.hasFadedBackgroundInLandscape = true
        end
    end)
    p_u_80.thumbstickFrame.Parent = p81
    if game:IsLoaded() then
        p_u_80.fadeInAndOutHalfDuration = 2.5
        p_u_80.fadeInAndOutBalance = 0.05
        p_u_80.tweenInAlphaStart = tick()
    else
        coroutine.wrap(function()
            game.Loaded:Wait()
            p_u_80.fadeInAndOutHalfDuration = 2.5
            p_u_80.fadeInAndOutBalance = 0.05
            p_u_80.tweenInAlphaStart = tick()
        end)()
    end
end
return v_u_13