local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = {
    "CameraMinZoomDistance",
    "CameraMaxZoomDistance",
    "CameraMode",
    "DevCameraOcclusionMode",
    "DevComputerCameraMode",
    "DevTouchCameraMode",
    "DevComputerMovementMode",
    "DevTouchMovementMode",
    "DevEnableMouseLock"
}
local v_u_3 = {
    "ComputerCameraMovementMode",
    "ComputerMovementMode",
    "ControlMode",
    "GamepadCameraSensitivity",
    "MouseSensitivity",
    "RotationType",
    "TouchCameraMovementMode",
    "TouchMovementMode"
}
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("UserInputService")
local v_u_7 = game:GetService("VRService")
local v_u_8 = UserSettings():GetService("UserGameSettings")
local v_u_9 = require(script:WaitForChild("CameraUtils"))
local v_u_10 = require(script:WaitForChild("CameraInput"))
local v_u_11 = require(script:WaitForChild("ClassicCamera"))
local v_u_12 = require(script:WaitForChild("OrbitalCamera"))
local v_u_13 = require(script:WaitForChild("LegacyCamera"))
local v_u_14 = require(script:WaitForChild("VehicleCamera"))
local v_u_15 = require(script:WaitForChild("VRCamera"))
local v_u_16 = require(script:WaitForChild("VRVehicleCamera"))
local v_u_17 = require(script:WaitForChild("Invisicam"))
local v_u_18 = require(script:WaitForChild("Poppercam"))
local v_u_19 = require(script:WaitForChild("TransparencyController"))
local v_u_20 = require(script:WaitForChild("MouseLockController"))
local v_u_21 = {}
local v_u_22 = {}
local v23 = v_u_4.LocalPlayer:WaitForChild("PlayerScripts")
v23:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
v23:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
v23:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)
v23:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
v23:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
v23:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
v23:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)
function v_u_1.new()
    local v24 = v_u_1
    local v_u_25 = setmetatable({}, v24)
    v_u_25.activeCameraController = nil
    v_u_25.activeOcclusionModule = nil
    v_u_25.activeTransparencyController = nil
    v_u_25.activeMouseLockController = nil
    v_u_25.currentComputerCameraMovementMode = nil
    v_u_25.cameraSubjectChangedConn = nil
    v_u_25.cameraTypeChangedConn = nil
    for _, v26 in pairs(v_u_4:GetPlayers()) do
        v_u_25:OnPlayerAdded(v26)
    end
    v_u_4.PlayerAdded:Connect(function(p27)
        v_u_25:OnPlayerAdded(p27)
    end)
    v_u_25.activeTransparencyController = v_u_19.new()
    v_u_25.activeTransparencyController:Enable(true)
    v_u_25.activeMouseLockController = v_u_20.new()
    local v28 = v_u_25.activeMouseLockController:GetBindableToggleEvent()
    if v28 then
        v28:Connect(function()
            v_u_25:OnMouseLockToggled()
        end)
    end
    v_u_25:ActivateCameraController(v_u_25:GetCameraControlChoice())
    v_u_25:ActivateOcclusionModule(v_u_4.LocalPlayer.DevCameraOcclusionMode)
    v_u_25:OnCurrentCameraChanged()
    v_u_5:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p29)
        v_u_25:Update(p29)
    end)
    for _, v_u_30 in pairs(v_u_2) do
        v_u_4.LocalPlayer:GetPropertyChangedSignal(v_u_30):Connect(function()
            v_u_25:OnLocalPlayerCameraPropertyChanged(v_u_30)
        end)
    end
    for _, v_u_31 in pairs(v_u_3) do
        v_u_8:GetPropertyChangedSignal(v_u_31):Connect(function()
            v_u_25:OnUserGameSettingsPropertyChanged(v_u_31)
        end)
    end
    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        v_u_25:OnCurrentCameraChanged()
    end)
    return v_u_25
end
function v_u_1.GetCameraMovementModeFromSettings(_)
    if v_u_4.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return v_u_9.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic)
    else
        local v32, v33
        if v_u_6.TouchEnabled then
            v32 = v_u_9.ConvertCameraModeEnumToStandard(v_u_4.LocalPlayer.DevTouchCameraMode)
            v33 = v_u_9.ConvertCameraModeEnumToStandard(v_u_8.TouchCameraMovementMode)
        else
            v32 = v_u_9.ConvertCameraModeEnumToStandard(v_u_4.LocalPlayer.DevComputerCameraMode)
            v33 = v_u_9.ConvertCameraModeEnumToStandard(v_u_8.ComputerCameraMovementMode)
        end
        if v32 == Enum.DevComputerCameraMovementMode.UserChoice then
            return v33
        else
            return v32
        end
    end
end
function v_u_1.ActivateOcclusionModule(p34, p35)
    local v36
    if p35 == Enum.DevCameraOcclusionMode.Zoom then
        v36 = v_u_18
    else
        if p35 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode")
            return
        end
        v36 = v_u_17
    end
    p34.occlusionMode = p35
    if p34.activeOcclusionModule and p34.activeOcclusionModule:GetOcclusionMode() == p35 then
        if not p34.activeOcclusionModule:GetEnabled() then
            p34.activeOcclusionModule:Enable(true)
        end
    else
        local v37 = p34.activeOcclusionModule
        p34.activeOcclusionModule = v_u_22[v36]
        if not p34.activeOcclusionModule then
            p34.activeOcclusionModule = v36.new()
            if p34.activeOcclusionModule then
                v_u_22[v36] = p34.activeOcclusionModule
            end
        end
        if p34.activeOcclusionModule then
            if p34.activeOcclusionModule:GetOcclusionMode() ~= p35 then
                warn("CameraScript ActivateOcclusionModule mismatch: ", p34.activeOcclusionModule:GetOcclusionMode(), "~=", p35)
            end
            if v37 then
                if v37 == p34.activeOcclusionModule then
                    warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
                else
                    v37:Enable(false)
                end
            end
            if p35 == Enum.DevCameraOcclusionMode.Invisicam then
                if v_u_4.LocalPlayer.Character then
                    p34.activeOcclusionModule:CharacterAdded(v_u_4.LocalPlayer.Character, v_u_4.LocalPlayer)
                end
            else
                for _, v38 in pairs(v_u_4:GetPlayers()) do
                    if v38 and v38.Character then
                        p34.activeOcclusionModule:CharacterAdded(v38.Character, v38)
                    end
                end
                p34.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject)
            end
            p34.activeOcclusionModule:Enable(true)
        end
    end
end
function v_u_1.ShouldUseVehicleCamera(p39)
    local v40 = workspace.CurrentCamera
    if not v40 then
        return false
    end
    local v41 = v40.CameraType
    local v42 = v40.CameraSubject
    local v43 = v41 == Enum.CameraType.Custom and true or v41 == Enum.CameraType.Follow
    local v44 = v42 and v42:IsA("VehicleSeat") or false
    local v45 = p39.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam
    if v44 then
        if not v43 then
            v45 = v43
        end
    else
        v45 = v44
    end
    return v45
end
function v_u_1.ActivateCameraController(p46, p47, p48)
    local v49 = nil
    if p48 ~= nil then
        if p48 == Enum.CameraType.Scriptable then
            if p46.activeCameraController then
                p46.activeCameraController:Enable(false)
                p46.activeCameraController = nil
            end
            return
        end
        if p48 == Enum.CameraType.Custom then
            p47 = p46:GetCameraMovementModeFromSettings()
        elseif p48 == Enum.CameraType.Track then
            p47 = Enum.ComputerCameraMovementMode.Classic
        elseif p48 == Enum.CameraType.Follow then
            p47 = Enum.ComputerCameraMovementMode.Follow
        elseif p48 == Enum.CameraType.Orbital then
            p47 = Enum.ComputerCameraMovementMode.Orbital
        elseif p48 == Enum.CameraType.Attach or (p48 == Enum.CameraType.Watch or p48 == Enum.CameraType.Fixed) then
            v49 = v_u_13
        else
            warn("CameraScript encountered an unhandled Camera.CameraType value: ", p48)
        end
    end
    if not v49 then
        if v_u_7.VREnabled then
            v49 = v_u_15
        elseif p47 == Enum.ComputerCameraMovementMode.Classic or (p47 == Enum.ComputerCameraMovementMode.Follow or (p47 == Enum.ComputerCameraMovementMode.Default or p47 == Enum.ComputerCameraMovementMode.CameraToggle)) then
            v49 = v_u_11
        else
            if p47 ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.")
                return
            end
            v49 = v_u_12
        end
    end
    if p46:ShouldUseVehicleCamera() then
        if v_u_7.VREnabled then
            v49 = v_u_16
        else
            v49 = v_u_14
        end
    end
    local v50
    if v_u_21[v49] then
        v50 = v_u_21[v49]
        if v50.Reset then
            v50:Reset()
        end
    else
        v50 = v49.new()
        v_u_21[v49] = v50
    end
    if p46.activeCameraController then
        if p46.activeCameraController == v50 then
            if not p46.activeCameraController:GetEnabled() then
                p46.activeCameraController:Enable(true)
            end
        else
            p46.activeCameraController:Enable(false)
            p46.activeCameraController = v50
            p46.activeCameraController:Enable(true)
        end
    elseif v50 ~= nil then
        p46.activeCameraController = v50
        p46.activeCameraController:Enable(true)
    end
    if p46.activeCameraController then
        if p47 ~= nil then
            p46.activeCameraController:SetCameraMovementMode(p47)
            return
        end
        if p48 ~= nil then
            p46.activeCameraController:SetCameraType(p48)
        end
    end
end
function v_u_1.OnCameraSubjectChanged(p51)
    local v52 = workspace.CurrentCamera
    local v53
    if v52 then
        v53 = v52.CameraSubject
    else
        v53 = v52
    end
    if p51.activeTransparencyController then
        p51.activeTransparencyController:SetSubject(v53)
    end
    if p51.activeOcclusionModule then
        p51.activeOcclusionModule:OnCameraSubjectChanged(v53)
    end
    p51:ActivateCameraController(nil, v52.CameraType)
end
function v_u_1.OnCameraTypeChanged(p54, p55)
    if p55 == Enum.CameraType.Scriptable and v_u_6.MouseBehavior == Enum.MouseBehavior.LockCenter then
        v_u_9.restoreMouseBehavior()
    end
    p54:ActivateCameraController(nil, p55)
end
function v_u_1.OnCurrentCameraChanged(p_u_56)
    local v_u_57 = game.Workspace.CurrentCamera
    if v_u_57 then
        if p_u_56.cameraSubjectChangedConn then
            p_u_56.cameraSubjectChangedConn:Disconnect()
        end
        if p_u_56.cameraTypeChangedConn then
            p_u_56.cameraTypeChangedConn:Disconnect()
        end
        p_u_56.cameraSubjectChangedConn = v_u_57:GetPropertyChangedSignal("CameraSubject"):Connect(function()
            p_u_56:OnCameraSubjectChanged(v_u_57.CameraSubject)
        end)
        p_u_56.cameraTypeChangedConn = v_u_57:GetPropertyChangedSignal("CameraType"):Connect(function()
            p_u_56:OnCameraTypeChanged(v_u_57.CameraType)
        end)
        p_u_56:OnCameraSubjectChanged(v_u_57.CameraSubject)
        p_u_56:OnCameraTypeChanged(v_u_57.CameraType)
    end
end
function v_u_1.OnLocalPlayerCameraPropertyChanged(p58, p59)
    if p59 == "CameraMode" then
        if v_u_4.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if v_u_4.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                local v60 = p58:GetCameraMovementModeFromSettings()
                p58:ActivateCameraController(v_u_9.ConvertCameraModeEnumToStandard(v60))
            else
                warn("Unhandled value for property player.CameraMode: ", v_u_4.LocalPlayer.CameraMode)
            end
        end
        if not p58.activeCameraController or p58.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p58:ActivateCameraController(v_u_9.ConvertCameraModeEnumToStandard(Enum.DevComputerCameraMovementMode.Classic))
        end
        if p58.activeCameraController then
            p58.activeCameraController:UpdateForDistancePropertyChange()
            return
        end
    else
        if p59 == "DevComputerCameraMode" or p59 == "DevTouchCameraMode" then
            local v61 = p58:GetCameraMovementModeFromSettings()
            p58:ActivateCameraController(v_u_9.ConvertCameraModeEnumToStandard(v61))
            return
        end
        if p59 == "DevCameraOcclusionMode" then
            p58:ActivateOcclusionModule(v_u_4.LocalPlayer.DevCameraOcclusionMode)
            return
        end
        if p59 == "CameraMinZoomDistance" or p59 == "CameraMaxZoomDistance" then
            if p58.activeCameraController then
                p58.activeCameraController:UpdateForDistancePropertyChange()
                return
            end
        else
            if p59 == "DevTouchMovementMode" then
                return
            end
            if p59 == "DevComputerMovementMode" then
                return
            end
            local _ = p59 == "DevEnableMouseLock"
        end
    end
end
function v_u_1.OnUserGameSettingsPropertyChanged(p62, p63)
    if p63 == "ComputerCameraMovementMode" then
        local v64 = p62:GetCameraMovementModeFromSettings()
        p62:ActivateCameraController(v_u_9.ConvertCameraModeEnumToStandard(v64))
    end
end
function v_u_1.Update(p65, p66)
    if p65.activeCameraController then
        p65.activeCameraController:UpdateMouseBehavior()
        local v67, v68 = p65.activeCameraController:Update(p66)
        if p65.activeOcclusionModule then
            v67, v68 = p65.activeOcclusionModule:Update(p66, v67, v68)
        end
        local v69 = game.Workspace.CurrentCamera
        v69.CFrame = v67
        v69.Focus = v68
        if p65.activeTransparencyController then
            p65.activeTransparencyController:Update(p66)
        end
        if v_u_10.getInputEnabled() then
            v_u_10.resetInputForFrameEnd()
        end
    end
end
function v_u_1.GetCameraControlChoice(_)
    local v70 = v_u_4.LocalPlayer
    if v70 then
        if v_u_6:GetLastInputType() == Enum.UserInputType.Touch or v_u_6.TouchEnabled then
            if v70.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice then
                return v_u_9.ConvertCameraModeEnumToStandard(v_u_8.TouchCameraMovementMode)
            else
                return v_u_9.ConvertCameraModeEnumToStandard(v70.DevTouchCameraMode)
            end
        else
            if v70.DevComputerCameraMode ~= Enum.DevComputerCameraMovementMode.UserChoice then
                return v_u_9.ConvertCameraModeEnumToStandard(v70.DevComputerCameraMode)
            end
            local v71 = v_u_9.ConvertCameraModeEnumToStandard(v_u_8.ComputerCameraMovementMode)
            return v_u_9.ConvertCameraModeEnumToStandard(v71)
        end
    else
        return
    end
end
function v_u_1.OnCharacterAdded(p72, p73, p74)
    if p72.activeOcclusionModule then
        p72.activeOcclusionModule:CharacterAdded(p73, p74)
    end
end
function v_u_1.OnCharacterRemoving(p75, p76, p77)
    if p75.activeOcclusionModule then
        p75.activeOcclusionModule:CharacterRemoving(p76, p77)
    end
end
function v_u_1.OnPlayerAdded(p_u_78, p_u_79)
    p_u_79.CharacterAdded:Connect(function(p80)
        p_u_78:OnCharacterAdded(p80, p_u_79)
    end)
    p_u_79.CharacterRemoving:Connect(function(p81)
        p_u_78:OnCharacterRemoving(p81, p_u_79)
    end)
end
function v_u_1.OnMouseLockToggled(p82)
    if p82.activeMouseLockController then
        local v83 = p82.activeMouseLockController:GetIsMouseLocked()
        local v84 = p82.activeMouseLockController:GetMouseLockOffset()
        if p82.activeCameraController then
            p82.activeCameraController:SetIsMouseLocked(v83)
            p82.activeCameraController:SetMouseLockOffset(v84)
        end
    end
end
v_u_1.new()
return {}