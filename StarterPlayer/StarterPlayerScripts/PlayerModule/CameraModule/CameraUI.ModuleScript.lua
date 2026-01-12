local v1 = game:GetService("Players")
local v_u_2 = game:GetService("TweenService")
local v3 = v1.LocalPlayer
if not v3 then
    v1:GetPropertyChangedSignal("LocalPlayer"):Wait()
    v3 = v1.LocalPlayer
end
local v_u_7 = (function(p4, p5)
    local v6 = p4:FindFirstChildOfClass(p5)
    while not v6 or v6.ClassName ~= p5 do
        v6 = p4.ChildAdded:Wait()
    end
    return v6
end)(v3, "PlayerGui")
local v_u_8 = UDim2.new(0, 326, 0, 58)
local v_u_9 = UDim2.new(0, 80, 0, 58)
local v_u_10 = Color3.fromRGB(32, 32, 32)
local v_u_11 = Color3.fromRGB(200, 200, 200)
local v_u_12 = false
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local function v_u_70()
    local v18 = not v_u_12
    assert(v18, "initializeUI called when already initialized")
    local v_u_19 = "ScreenGui"
    local function v25(p20)
        local v21 = Instance.new(v_u_19)
        local v22 = p20.Parent
        p20.Parent = nil
        for v23, v24 in pairs(p20) do
            if type(v23) == "string" then
                v21[v23] = v24
            else
                v24.Parent = v21
            end
        end
        v21.Parent = v22
        return v21
    end
    local v26 = {
        ["Name"] = "RbxCameraUI",
        ["AutoLocalize"] = false,
        ["Enabled"] = true,
        ["DisplayOrder"] = -1,
        ["IgnoreGuiInset"] = false,
        ["ResetOnSpawn"] = false,
        ["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
    }
    local v_u_27 = "ImageLabel"
    local function v33(p28)
        local v29 = Instance.new(v_u_27)
        local v30 = p28.Parent
        p28.Parent = nil
        for v31, v32 in pairs(p28) do
            if type(v31) == "string" then
                v29[v31] = v32
            else
                v32.Parent = v29
            end
        end
        v29.Parent = v30
        return v29
    end
    local v34 = {
        ["Name"] = "Toast",
        ["Visible"] = false,
        ["AnchorPoint"] = Vector2.new(0.5, 0),
        ["BackgroundTransparency"] = 1,
        ["BorderSizePixel"] = 0,
        ["Position"] = UDim2.new(0.5, 0, 0, 8),
        ["Size"] = v_u_9,
        ["Image"] = "rbxasset://textures/ui/Camera/CameraToast9Slice.png",
        ["ImageColor3"] = v_u_10,
        ["ImageRectSize"] = Vector2.new(6, 6),
        ["ImageTransparency"] = 1,
        ["ScaleType"] = Enum.ScaleType.Slice,
        ["SliceCenter"] = Rect.new(3, 3, 3, 3),
        ["ClipsDescendants"] = true
    }
    local v_u_35 = "Frame"
    local function v41(p36)
        local v37 = Instance.new(v_u_35)
        local v38 = p36.Parent
        p36.Parent = nil
        for v39, v40 in pairs(p36) do
            if type(v39) == "string" then
                v37[v39] = v40
            else
                v40.Parent = v37
            end
        end
        v37.Parent = v38
        return v37
    end
    local v42 = {
        ["Name"] = "IconBuffer",
        ["BackgroundTransparency"] = 1,
        ["BorderSizePixel"] = 0,
        ["Position"] = UDim2.new(0, 0, 0, 0),
        ["Size"] = UDim2.new(0, 80, 1, 0)
    }
    local v_u_43 = "ImageLabel"
    __set_list(v42, 1, {(function(p44)
    local v45 = Instance.new(v_u_43)
    local v46 = p44.Parent
    p44.Parent = nil
    for v47, v48 in pairs(p44) do
        if type(v47) == "string" then
            v45[v47] = v48
        else
            v48.Parent = v45
        end
    end
    v45.Parent = v46
    return v45
end)({
    ["Name"] = "Icon",
    ["AnchorPoint"] = Vector2.new(0.5, 0.5),
    ["BackgroundTransparency"] = 1,
    ["Position"] = UDim2.new(0.5, 0, 0.5, 0),
    ["Size"] = UDim2.new(0, 48, 0, 48),
    ["ZIndex"] = 2,
    ["Image"] = "rbxasset://textures/ui/Camera/CameraToastIcon.png",
    ["ImageColor3"] = v_u_11,
    ["ImageTransparency"] = 1
})})
    local v49 = v41(v42)
    local v_u_50 = "Frame"
    local function v56(p51)
        local v52 = Instance.new(v_u_50)
        local v53 = p51.Parent
        p51.Parent = nil
        for v54, v55 in pairs(p51) do
            if type(v54) == "string" then
                v52[v54] = v55
            else
                v55.Parent = v52
            end
        end
        v52.Parent = v53
        return v52
    end
    local v57 = {
        ["Name"] = "TextBuffer",
        ["BackgroundTransparency"] = 1,
        ["BorderSizePixel"] = 0,
        ["Position"] = UDim2.new(0, 80, 0, 0),
        ["Size"] = UDim2.new(1, -80, 1, 0),
        ["ClipsDescendants"] = true
    }
    local v_u_58 = "TextLabel"
    local v_u_59 = "TextLabel"
    __set_list(v57, 1, {(function(p60)
    local v61 = Instance.new(v_u_58)
    local v62 = p60.Parent
    p60.Parent = nil
    for v63, v64 in pairs(p60) do
        if type(v63) == "string" then
            v61[v63] = v64
        else
            v64.Parent = v61
        end
    end
    v61.Parent = v62
    return v61
end)({
    ["Name"] = "Upper",
    ["AnchorPoint"] = Vector2.new(0, 1),
    ["BackgroundTransparency"] = 1,
    ["Position"] = UDim2.new(0, 0, 0.5, 0),
    ["Size"] = UDim2.new(1, 0, 0, 19),
    ["Font"] = Enum.Font.GothamMedium,
    ["Text"] = "Camera control enabled",
    ["TextColor3"] = v_u_11,
    ["TextTransparency"] = 1,
    ["TextSize"] = 19,
    ["TextXAlignment"] = Enum.TextXAlignment.Left,
    ["TextYAlignment"] = Enum.TextYAlignment.Center
}), (function(p65)
    local v66 = Instance.new(v_u_59)
    local v67 = p65.Parent
    p65.Parent = nil
    for v68, v69 in pairs(p65) do
        if type(v68) == "string" then
            v66[v68] = v69
        else
            v69.Parent = v66
        end
    end
    v66.Parent = v67
    return v66
end)({
    ["Name"] = "Lower",
    ["AnchorPoint"] = Vector2.new(0, 0),
    ["BackgroundTransparency"] = 1,
    ["Position"] = UDim2.new(0, 0, 0.5, 3),
    ["Size"] = UDim2.new(1, 0, 0, 15),
    ["Font"] = Enum.Font.Gotham,
    ["Text"] = "Right mouse button to toggle",
    ["TextColor3"] = v_u_11,
    ["TextTransparency"] = 1,
    ["TextSize"] = 15,
    ["TextXAlignment"] = Enum.TextXAlignment.Left,
    ["TextYAlignment"] = Enum.TextYAlignment.Center
})})
    __set_list(v34, 1, {v49, v56(v57)})
    __set_list(v26, 1, {(v33(v34))})
    v26.Parent = v_u_7
    v_u_13 = v25(v26)
    v_u_14 = v_u_13.Toast
    v_u_15 = v_u_14.IconBuffer.Icon
    v_u_16 = v_u_14.TextBuffer.Upper
    v_u_17 = v_u_14.TextBuffer.Lower
    v_u_12 = true
end
local v_u_72 = {
    ["setCameraModeToastEnabled"] = function(p71)
        if p71 or v_u_12 then
            if not v_u_12 then
                v_u_70()
            end
            v_u_14.Visible = p71
            if not p71 then
                v_u_72.setCameraModeToastOpen(false)
            end
        end
    end
}
local v_u_73 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
function v_u_72.setCameraModeToastOpen(p74)
    local v75 = v_u_12
    assert(v75)
    v_u_2:Create(v_u_14, v_u_73, {
        ["Size"] = p74 and v_u_8 or v_u_9,
        ["ImageTransparency"] = p74 and 0.4 or 1
    }):Play()
    v_u_2:Create(v_u_15, v_u_73, {
        ["ImageTransparency"] = p74 and 0 or 1
    }):Play()
    v_u_2:Create(v_u_16, v_u_73, {
        ["TextTransparency"] = p74 and 0 or 1
    }):Play()
    v_u_2:Create(v_u_17, v_u_73, {
        ["TextTransparency"] = p74 and 0 or 1
    }):Play()
end
return v_u_72