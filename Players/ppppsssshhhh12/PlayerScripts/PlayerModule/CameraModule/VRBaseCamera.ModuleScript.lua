local v_u_1 = game:GetService("VRService")
local v_u_2 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_3 = require(script.Parent:WaitForChild("ZoomController"))
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = game:GetService("Lighting")
local v_u_6 = game:GetService("RunService")
local v_u_7 = UserSettings():GetService("UserGameSettings")
local v8, v9 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserVRApplyHeadScaleToHandPositions")
end)
local v_u_10 = v8 and v9
local v_u_11 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_12 = setmetatable({}, v_u_11)
v_u_12.__index = v_u_12
function v_u_12.new()
    local v13 = v_u_11.new()
    local v14 = v_u_12
    local v15 = setmetatable(v13, v14)
    v15.defaultDistance = 7
    local v16 = v15.defaultDistance
    local v17 = v_u_4.CameraMinZoomDistance
    local v18 = v_u_4.CameraMaxZoomDistance
    v15.defaultSubjectDistance = math.clamp(v16, v17, v18)
    local v19 = v15.defaultDistance
    local v20 = v_u_4.CameraMinZoomDistance
    local v21 = v_u_4.CameraMaxZoomDistance
    v15.currentSubjectDistance = math.clamp(v19, v20, v21)
    v15.VRFadeResetTimer = 0
    v15.VREdgeBlurTimer = 0
    v15.gamepadResetConnection = nil
    v15.needsReset = true
    return v15
end
function v_u_12.GetModuleName(_)
    return "VRBaseCamera"
end
function v_u_12.GamepadZoomPress(p22)
    if p22:GetCameraToSubjectDistance() > 3.5 then
        p22:SetCameraToSubjectDistance(0)
        p22.currentSubjectDistance = 0
    else
        p22:SetCameraToSubjectDistance(7)
        p22.currentSubjectDistance = 7
    end
    p22:GamepadReset()
    p22:ResetZoom()
end
function v_u_12.GamepadReset(p23)
    p23.needsReset = true
end
function v_u_12.ResetZoom(p24)
    v_u_3.SetZoomParameters(p24.currentSubjectDistance, 0)
    v_u_3.ReleaseSpring()
end
function v_u_12.OnEnable(p_u_25, p26)
    if p26 then
        p_u_25.gamepadResetConnection = v_u_2.gamepadReset:Connect(function()
            p_u_25:GamepadReset()
        end)
    else
        if p_u_25.inFirstPerson then
            p_u_25:GamepadZoomPress()
        end
        if p_u_25.gamepadResetConnection then
            p_u_25.gamepadResetConnection:Disconnect()
            p_u_25.gamepadResetConnection = nil
        end
        p_u_25.VREdgeBlurTimer = 0
        p_u_25:UpdateEdgeBlur(v_u_4, 1)
        local v27 = v_u_5:FindFirstChild("VRFade")
        if v27 then
            v27.Brightness = 0
        end
    end
end
function v_u_12.UpdateDefaultSubjectDistance(p28)
    local v29 = v_u_4.CameraMinZoomDistance
    local v30 = v_u_4.CameraMaxZoomDistance
    p28.defaultSubjectDistance = math.clamp(7, v29, v30)
end
function v_u_12.GetCameraToSubjectDistance(p31)
    return p31.currentSubjectDistance
end
function v_u_12.SetCameraToSubjectDistance(p32, p33)
    local v34 = p32.currentSubjectDistance
    local v35 = v_u_4.CameraMaxZoomDistance
    local v36 = math.clamp(p33, 0, v35)
    if v36 < 1 then
        p32.currentSubjectDistance = 0.5
        if not p32.inFirstPerson then
            p32:EnterFirstPerson()
        end
    else
        p32.currentSubjectDistance = v36
        if p32.inFirstPerson then
            p32:LeaveFirstPerson()
        end
    end
    local v37 = v_u_3.SetZoomParameters
    local v38 = p32.currentSubjectDistance
    local v39 = p33 - v34
    v37(v38, (math.sign(v39)))
    return p32.currentSubjectDistance
end
function v_u_12.GetVRFocus(p40, p41, p42)
    local v43 = p40.lastCameraFocus or p41
    local v44 = p40.cameraTranslationConstraints.x
    local v45 = p40.cameraTranslationConstraints.y + p42
    local v46 = math.min(1, v45)
    local v47 = p40.cameraTranslationConstraints.z
    p40.cameraTranslationConstraints = Vector3.new(v44, v46, v47)
    local v48 = p40:GetCameraHeight()
    local v49 = Vector3.new(0, v48, 0)
    local v50 = CFrame.new
    local v51 = p41.x
    local v52 = v43.y
    local v53 = p41.z
    return v50(Vector3.new(v51, v52, v53):Lerp(p41 + v49, p40.cameraTranslationConstraints.y))
end
function v_u_12.StartFadeFromBlack(p54)
    if v_u_7.VignetteEnabled ~= false then
        local v55 = v_u_5:FindFirstChild("VRFade")
        if not v55 then
            v55 = Instance.new("ColorCorrectionEffect")
            v55.Name = "VRFade"
            v55.Parent = v_u_5
        end
        v55.Brightness = -1
        p54.VRFadeResetTimer = 0.1
    end
end
function v_u_12.UpdateFadeFromBlack(p56, p57)
    local v58 = v_u_5:FindFirstChild("VRFade")
    if p56.VRFadeResetTimer > 0 then
        local v59 = p56.VRFadeResetTimer - p57
        p56.VRFadeResetTimer = math.max(v59, 0)
        local v60 = v_u_5:FindFirstChild("VRFade")
        if v60 and v60.Brightness < 0 then
            local v61 = v60.Brightness + p57 * 10
            v60.Brightness = math.min(v61, 0)
            return
        end
    elseif v58 then
        v58.Brightness = 0
    end
end
function v_u_12.StartVREdgeBlur(p62, p63)
    if v_u_7.VignetteEnabled ~= false then
        local v64 = workspace.CurrentCamera:FindFirstChild("VRBlurPart")
        if not v64 then
            local v_u_65 = Instance.new("Part")
            v_u_65.Name = "VRBlurPart"
            v_u_65.Parent = workspace.CurrentCamera
            v_u_65.CanTouch = false
            v_u_65.CanCollide = false
            v_u_65.CanQuery = false
            v_u_65.Anchored = true
            v_u_65.Size = Vector3.new(0.44, 0.47, 1)
            v_u_65.Transparency = 1
            v_u_65.CastShadow = false
            v_u_6.RenderStepped:Connect(function(_)
                local v66 = v_u_1:GetUserCFrame(Enum.UserCFrame.Head)
                if v_u_10 then
                    local v67 = workspace.CurrentCamera.CFrame * (CFrame.new(v66.p * workspace.CurrentCamera.HeadScale) * (v66 - v66.p))
                    v_u_65.CFrame = v67 * CFrame.Angles(0, 3.141592653589793, 0) + v67.LookVector * (1.05 * workspace.CurrentCamera.HeadScale)
                    v_u_65.Size = Vector3.new(0.44, 0.47, 1) * workspace.CurrentCamera.HeadScale
                else
                    local v68 = workspace.Camera.CFrame * v66
                    v_u_65.CFrame = v68 * CFrame.Angles(0, 3.141592653589793, 0) + v68.LookVector * 1.05
                end
            end)
            v64 = v_u_65
        end
        local v69 = p63.PlayerGui:FindFirstChild("VRBlurScreen")
        local v70
        if v69 then
            v70 = v69:FindFirstChild("VRBlur")
        else
            v70 = nil
        end
        if not v70 then
            local v71 = v69 or (Instance.new("SurfaceGui") or Instance.new("ScreenGui"))
            v71.Name = "VRBlurScreen"
            v71.Parent = p63.PlayerGui
            v71.Adornee = v64
            v70 = Instance.new("ImageLabel")
            v70.Name = "VRBlur"
            v70.Parent = v71
            v70.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
            v70.AnchorPoint = Vector2.new(0.5, 0.5)
            v70.Position = UDim2.new(0.5, 0, 0.5, 0)
            local v72 = workspace.CurrentCamera.ViewportSize.X * 2.3 / 512
            local v73 = workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512
            v70.Size = UDim2.fromScale(v72, v73)
            v70.BackgroundTransparency = 1
            v70.Active = true
            v70.ScaleType = Enum.ScaleType.Stretch
        end
        v70.Visible = true
        v70.ImageTransparency = 0
        p62.VREdgeBlurTimer = 0.14
    end
end
function v_u_12.UpdateEdgeBlur(p74, p75, p76)
    local v77 = p75.PlayerGui:FindFirstChild("VRBlurScreen")
    local v78
    if v77 then
        v78 = v77:FindFirstChild("VRBlur")
    else
        v78 = nil
    end
    if v78 then
        if p74.VREdgeBlurTimer > 0 then
            p74.VREdgeBlurTimer = p74.VREdgeBlurTimer - p76
            local v79 = p75.PlayerGui:FindFirstChild("VRBlurScreen")
            local v80 = v79 and v79:FindFirstChild("VRBlur")
            if v80 then
                local v81 = p74.VREdgeBlurTimer
                v80.ImageTransparency = 1 - math.clamp(v81, 0.01, 0.14) * 7.142857142857142
                return
            end
        else
            v78.Visible = false
        end
    end
end
function v_u_12.GetCameraHeight(p82)
    return p82.inFirstPerson and 0 or 0.25881904510252074 * p82.currentSubjectDistance
end
function v_u_12.GetSubjectCFrame(p83)
    local v84 = v_u_11.GetSubjectCFrame(p83)
    local v85 = workspace.CurrentCamera
    if v85 then
        v85 = v85.CameraSubject
    end
    if not v85 then
        return v84
    end
    if v85:IsA("Humanoid") and (v85:GetState() == Enum.HumanoidStateType.Dead and v85 == p83.lastSubject) then
        v84 = p83.lastSubjectCFrame
    end
    if v84 then
        p83.lastSubjectCFrame = v84
    end
    return v84
end
function v_u_12.GetSubjectPosition(p86)
    local v87 = v_u_11.GetSubjectPosition(p86)
    local v88 = game.Workspace.CurrentCamera
    if v88 then
        v88 = v88.CameraSubject
    end
    if not v88 then
        return nil
    end
    if v88:IsA("Humanoid") then
        if v88:GetState() == Enum.HumanoidStateType.Dead and v88 == p86.lastSubject then
            v87 = p86.lastSubjectPosition
        end
    elseif v88:IsA("VehicleSeat") then
        v87 = v88.CFrame.p + v88.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0))
    end
    p86.lastSubjectPosition = v87
    return v87
end
return v_u_12