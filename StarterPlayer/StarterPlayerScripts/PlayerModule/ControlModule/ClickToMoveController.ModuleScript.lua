local v1, v2 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding")
end)
local v_u_3 = v1 and v2
local v4, v5 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2")
end)
local v_u_6 = v4 and v5
local v_u_7 = game:GetService("UserInputService")
local v_u_8 = game:GetService("PathfindingService")
local v_u_9 = game:GetService("Players")
game:GetService("Debris")
local v_u_10 = game:GetService("StarterGui")
local v_u_11 = game:GetService("Workspace")
local v_u_12 = game:GetService("CollectionService")
local v_u_13 = game:GetService("GuiService")
local v_u_14 = true
local v_u_15 = true
local v_u_16 = false
local v_u_17 = 1
local v_u_18 = 8
local v_u_19 = {
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Down] = true
}
local v_u_20 = v_u_9.LocalPlayer
local v_u_21 = require(script.Parent:WaitForChild("ClickToMoveDisplay"))
local v_u_22 = {}
local function v_u_25(p23)
    if p23 then
        local v24 = p23:FindFirstChildOfClass("Humanoid")
        if v24 then
            return p23, v24
        else
            return v_u_25(p23.Parent)
        end
    else
        return
    end
end
v_u_22.FindCharacterAncestor = v_u_25
local function v_u_36(p26, p27, p28)
    local v29 = p28 or {}
    local v30, v31, v32, v33 = v_u_11:FindPartOnRayWithIgnoreList(p26, v29)
    if not v30 then
        return nil, nil
    end
    if p27 and v30.CanCollide == false then
        local v34 = not v30 or v30:FindFirstChildOfClass("Humanoid")
        if not v34 then
            local v35
            v35, v34 = v_u_25(v30.Parent)
        end
        if v34 == nil then
            table.insert(v29, v30)
            return v_u_36(p26, p27, v29)
        end
    end
    return v30, v31, v32, v33
end
v_u_22.Raycast = v_u_36
local v_u_37 = {}
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = nil
local function v_u_52(p42)
    if p42 ~= v_u_39 then
        if v_u_40 then
            v_u_40:Disconnect()
            v_u_40 = nil
        end
        if v_u_41 then
            v_u_41:Disconnect()
            v_u_41 = nil
        end
        v_u_39 = p42
        local v43 = {}
        local v44 = v_u_20
        if v44 then
            v44 = v_u_20.Character
        end
        __set_list(v43, 1, {v44})
        v_u_38 = v43
        if v_u_39 ~= nil then
            local v45 = v_u_12:GetTagged(v_u_39)
            for _, v46 in ipairs(v45) do
                local v47 = v_u_38
                table.insert(v47, v46)
            end
            v_u_40 = v_u_12:GetInstanceAddedSignal(v_u_39):Connect(function(p48)
                local v49 = v_u_38
                table.insert(v49, p48)
            end)
            v_u_41 = v_u_12:GetInstanceRemovedSignal(v_u_39):Connect(function(p50)
                for v51 = 1, #v_u_38 do
                    if v_u_38[v51] == p50 then
                        v_u_38[v51] = v_u_38[#v_u_38]
                        table.remove(v_u_38)
                        return
                    end
                end
            end)
        end
    end
end
local function v_u_117(p53)
    if p53 == nil or p53.PrimaryPart == nil then
        return
    else
        assert(p53, "")
        local v54 = p53.PrimaryPart
        assert(v54, "")
        local v55 = p53.PrimaryPart.CFrame:Inverse()
        local v56 = Vector3.new(inf, inf, inf)
        local v57 = Vector3.new(-inf, -inf, -inf)
        for _, v58 in pairs(p53:GetDescendants()) do
            if v58:IsA("BasePart") and v58.CanCollide then
                local v59 = v55 * v58.CFrame
                local v60 = v58.Size.X / 2
                local v61 = v58.Size.Y / 2
                local v62 = v58.Size.Z / 2
                local v63 = Vector3.new(v60, v61, v62)
                local v64 = {}
                local v65 = v63.X
                local v66 = v63.Y
                local v67 = v63.Z
                local v68 = Vector3.new(v65, v66, v67)
                local v69 = v63.X
                local v70 = v63.Y
                local v71 = -v63.Z
                local v72 = Vector3.new(v69, v70, v71)
                local v73 = v63.X
                local v74 = -v63.Y
                local v75 = v63.Z
                local v76 = Vector3.new(v73, v74, v75)
                local v77 = v63.X
                local v78 = -v63.Y
                local v79 = -v63.Z
                local v80 = Vector3.new(v77, v78, v79)
                local v81 = -v63.X
                local v82 = v63.Y
                local v83 = v63.Z
                local v84 = Vector3.new(v81, v82, v83)
                local v85 = -v63.X
                local v86 = v63.Y
                local v87 = -v63.Z
                local v88 = Vector3.new(v85, v86, v87)
                local v89 = -v63.X
                local v90 = -v63.Y
                local v91 = v63.Z
                local v92 = Vector3.new(v89, v90, v91)
                local v93 = -v63.X
                local v94 = -v63.Y
                local v95 = -v63.Z
                __set_list(v64, 1, {v68, v72, v76, v80, v84, v88, v92, (Vector3.new(v93, v94, v95))})
                for _, v96 in ipairs(v64) do
                    local v97 = v59 * v96
                    local v98 = v56.X
                    local v99 = v97.X
                    local v100 = math.min(v98, v99)
                    local v101 = v56.Y
                    local v102 = v97.Y
                    local v103 = math.min(v101, v102)
                    local v104 = v56.Z
                    local v105 = v97.Z
                    local v106 = math.min(v104, v105)
                    v56 = Vector3.new(v100, v103, v106)
                    local v107 = v57.X
                    local v108 = v97.X
                    local v109 = math.max(v107, v108)
                    local v110 = v57.Y
                    local v111 = v97.Y
                    local v112 = math.max(v110, v111)
                    local v113 = v57.Z
                    local v114 = v97.Z
                    local v115 = math.max(v113, v114)
                    v57 = Vector3.new(v109, v112, v115)
                end
            end
        end
        local v116 = v57 - v56
        if v116.X < 0 or (v116.Y < 0 or v116.Z < 0) then
            return nil
        else
            return v116
        end
    end
end
local function v_u_183(p118, p119, p120)
    local v_u_121 = {}
    local v122
    if p120 == nil then
        v122 = v_u_16
        p120 = true
    else
        v122 = p120
    end
    v_u_121.Cancelled = false
    v_u_121.Started = false
    v_u_121.Finished = Instance.new("BindableEvent")
    v_u_121.PathFailed = Instance.new("BindableEvent")
    v_u_121.PathComputing = false
    v_u_121.PathComputed = false
    v_u_121.OriginalTargetPoint = p118
    v_u_121.TargetPoint = p118
    v_u_121.TargetSurfaceNormal = p119
    v_u_121.DiedConn = nil
    v_u_121.SeatedConn = nil
    v_u_121.BlockedConn = nil
    v_u_121.TeleportedConn = nil
    v_u_121.CurrentPoint = 0
    v_u_121.HumanoidOffsetFromPath = Vector3.new(0, 0, 0)
    v_u_121.CurrentWaypointPosition = nil
    v_u_121.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
    v_u_121.CurrentWaypointPlaneDistance = 0
    v_u_121.CurrentWaypointNeedsJump = false
    v_u_121.CurrentHumanoidPosition = Vector3.new(0, 0, 0)
    v_u_121.CurrentHumanoidVelocity = 0
    v_u_121.NextActionMoveDirection = Vector3.new(0, 0, 0)
    v_u_121.NextActionJump = false
    v_u_121.Timeout = 0
    local v123 = v_u_20
    local v124
    if v123 then
        v124 = v123.Character
    else
        v124 = v123
    end
    local v125
    if v124 then
        v125 = v_u_37[v123]
        if not v125 or v125.Parent ~= v124 then
            v_u_37[v123] = nil
            v125 = v124:FindFirstChildOfClass("Humanoid")
            if v125 then
                v_u_37[v123] = v125
            end
        end
    else
        v125 = nil
    end
    v_u_121.Humanoid = v125
    v_u_121.OriginPoint = nil
    v_u_121.AgentCanFollowPath = false
    v_u_121.DirectPath = false
    v_u_121.DirectPathRiseFirst = false
    v_u_121.stopTraverseFunc = nil
    v_u_121.setPointFunc = nil
    v_u_121.pointList = nil
    local v126 = v_u_121.Humanoid
    if v126 then
        v126 = v_u_121.Humanoid.RootPart
    end
    if v126 then
        v_u_121.OriginPoint = v126.CFrame.Position
        local v127 = 2
        local v128 = 5
        local v129 = true
        local v130 = v_u_121.Humanoid.SeatPart
        if v130 and v130:IsA("VehicleSeat") then
            local v131 = v130:FindFirstAncestorOfClass("Model")
            if v131 then
                local v132 = v131.PrimaryPart
                v131.PrimaryPart = v130
                if p120 then
                    local v133 = v131:GetExtentsSize()
                    local v134 = v_u_17 * 0.5
                    local v135 = v133.X * v133.X + v133.Z * v133.Z
                    v127 = v134 * math.sqrt(v135)
                    v128 = v_u_17 * v133.Y
                    v_u_121.AgentCanFollowPath = true
                    v_u_121.DirectPath = p120
                    v129 = false
                end
                v131.PrimaryPart = v132
            end
        else
            local v136 = nil
            if v_u_3 then
                local v137 = v_u_20
                if v137 then
                    v137 = v_u_20.Character
                end
                if v137 ~= nil then
                    v136 = v_u_117(v137)
                end
            end
            if v136 == nil then
                local v138 = v_u_20
                if v138 then
                    v138 = v_u_20.Character
                end
                v136 = v138:GetExtentsSize()
            end
            assert(v136, "")
            local v139 = v_u_17 * 0.5
            local v140 = v136.X * v136.X + v136.Z * v136.Z
            v127 = v139 * math.sqrt(v140)
            v128 = v_u_17 * v136.Y
            v129 = v_u_121.Humanoid.JumpPower > 0
            v_u_121.AgentCanFollowPath = true
            v_u_121.DirectPath = v122
            v_u_121.DirectPathRiseFirst = v_u_121.Humanoid.Sit
        end
        if v_u_6 then
            v_u_121.pathResult = v_u_8:CreatePath({
                ["AgentRadius"] = v127,
                ["AgentHeight"] = v128,
                ["AgentCanJump"] = v129,
                ["AgentCanClimb"] = true
            })
        else
            v_u_121.pathResult = v_u_8:CreatePath({
                ["AgentRadius"] = v127,
                ["AgentHeight"] = v128,
                ["AgentCanJump"] = v129
            })
        end
    end
    function v_u_121.Cleanup(_)
        if v_u_121.stopTraverseFunc then
            v_u_121.stopTraverseFunc()
            v_u_121.stopTraverseFunc = nil
        end
        if v_u_121.BlockedConn then
            v_u_121.BlockedConn:Disconnect()
            v_u_121.BlockedConn = nil
        end
        if v_u_121.DiedConn then
            v_u_121.DiedConn:Disconnect()
            v_u_121.DiedConn = nil
        end
        if v_u_121.SeatedConn then
            v_u_121.SeatedConn:Disconnect()
            v_u_121.SeatedConn = nil
        end
        if v_u_121.TeleportedConn then
            v_u_121.TeleportedConn:Disconnect()
            v_u_121.TeleportedConn = nil
        end
        v_u_121.Started = false
    end
    function v_u_121.Cancel(_)
        v_u_121.Cancelled = true
        v_u_121:Cleanup()
    end
    function v_u_121.IsActive(_)
        local v141 = v_u_121.AgentCanFollowPath and v_u_121.Started
        if v141 then
            v141 = not v_u_121.Cancelled
        end
        return v141
    end
    function v_u_121.OnPathInterrupted(_)
        v_u_121.Cancelled = true
        v_u_121:OnPointReached(false)
    end
    function v_u_121.ComputePath(_)
        if v_u_121.OriginPoint then
            if v_u_121.PathComputed or v_u_121.PathComputing then
                return
            end
            v_u_121.PathComputing = true
            if v_u_121.AgentCanFollowPath then
                if v_u_121.DirectPath then
                    v_u_121.pointList = { PathWaypoint.new(v_u_121.OriginPoint, Enum.PathWaypointAction.Walk), PathWaypoint.new(v_u_121.TargetPoint, v_u_121.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk) }
                    v_u_121.PathComputed = true
                else
                    v_u_121.pathResult:ComputeAsync(v_u_121.OriginPoint, v_u_121.TargetPoint)
                    v_u_121.pointList = v_u_121.pathResult:GetWaypoints()
                    v_u_121.BlockedConn = v_u_121.pathResult.Blocked:Connect(function(p142)
                        v_u_121:OnPathBlocked(p142)
                    end)
                    v_u_121.PathComputed = v_u_121.pathResult.Status == Enum.PathStatus.Success
                end
            end
            v_u_121.PathComputing = false
        end
    end
    function v_u_121.IsValidPath(_)
        v_u_121:ComputePath()
        local v143 = v_u_121.PathComputed
        if v143 then
            v143 = v_u_121.AgentCanFollowPath
        end
        return v143
    end
    v_u_121.Recomputing = false
    function v_u_121.OnPathBlocked(_, p144)
        if v_u_121.CurrentPoint <= p144 and not v_u_121.Recomputing then
            v_u_121.Recomputing = true
            if v_u_121.stopTraverseFunc then
                v_u_121.stopTraverseFunc()
                v_u_121.stopTraverseFunc = nil
            end
            v_u_121.OriginPoint = v_u_121.Humanoid.RootPart.CFrame.p
            v_u_121.pathResult:ComputeAsync(v_u_121.OriginPoint, v_u_121.TargetPoint)
            v_u_121.pointList = v_u_121.pathResult:GetWaypoints()
            if #v_u_121.pointList > 0 then
                v_u_121.HumanoidOffsetFromPath = v_u_121.pointList[1].Position - v_u_121.OriginPoint
            end
            v_u_121.PathComputed = v_u_121.pathResult.Status == Enum.PathStatus.Success
            if v_u_14 then
                local v145 = v_u_121
                local v146 = v_u_121
                local v147, v148 = v_u_21.CreatePathDisplay(v_u_121.pointList)
                v145.stopTraverseFunc = v147
                v146.setPointFunc = v148
            end
            if v_u_121.PathComputed then
                v_u_121.CurrentPoint = 1
                v_u_121:OnPointReached(true)
            else
                v_u_121.PathFailed:Fire()
                v_u_121:Cleanup()
            end
            v_u_121.Recomputing = false
        end
    end
    function v_u_121.OnRenderStepped(_, p149)
        if v_u_121.Started and not v_u_121.Cancelled then
            v_u_121.Timeout = v_u_121.Timeout + p149
            if v_u_18 < v_u_121.Timeout then
                v_u_121:OnPointReached(false)
                return
            end
            v_u_121.CurrentHumanoidPosition = v_u_121.Humanoid.RootPart.Position + v_u_121.HumanoidOffsetFromPath
            v_u_121.CurrentHumanoidVelocity = v_u_121.Humanoid.RootPart.Velocity
            while v_u_121.Started and v_u_121:IsCurrentWaypointReached() do
                v_u_121:OnPointReached(true)
            end
            if v_u_121.Started then
                v_u_121.NextActionMoveDirection = v_u_121.CurrentWaypointPosition - v_u_121.CurrentHumanoidPosition
                if v_u_121.NextActionMoveDirection.Magnitude > 1e-6 then
                    v_u_121.NextActionMoveDirection = v_u_121.NextActionMoveDirection.Unit
                else
                    v_u_121.NextActionMoveDirection = Vector3.new(0, 0, 0)
                end
                if v_u_121.CurrentWaypointNeedsJump then
                    v_u_121.NextActionJump = true
                    v_u_121.CurrentWaypointNeedsJump = false
                    return
                end
                v_u_121.NextActionJump = false
            end
        end
    end
    function v_u_121.IsCurrentWaypointReached(_)
        local v150
        if v_u_121.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) then
            v150 = true
        else
            local v151 = v_u_121.CurrentWaypointPlaneNormal:Dot(v_u_121.CurrentHumanoidPosition) - v_u_121.CurrentWaypointPlaneDistance
            local v152 = 0.0625 * -v_u_121.CurrentWaypointPlaneNormal:Dot(v_u_121.CurrentHumanoidVelocity)
            v150 = v151 < math.max(1, v152)
        end
        if v150 then
            v_u_121.CurrentWaypointPosition = nil
            v_u_121.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            v_u_121.CurrentWaypointPlaneDistance = 0
        end
        return v150
    end
    function v_u_121.OnPointReached(_, p153)
        if p153 and not v_u_121.Cancelled then
            if v_u_121.setPointFunc then
                v_u_121.setPointFunc(v_u_121.CurrentPoint)
            end
            local v154 = v_u_121.CurrentPoint + 1
            if #v_u_121.pointList < v154 then
                if v_u_121.stopTraverseFunc then
                    v_u_121.stopTraverseFunc()
                end
                v_u_121.Finished:Fire()
                v_u_121:Cleanup()
            else
                local v155 = v_u_121.pointList[v_u_121.CurrentPoint]
                local v156 = v_u_121.pointList[v154]
                local v157 = v_u_121.Humanoid:GetState()
                if (v157 == Enum.HumanoidStateType.FallingDown or v157 == Enum.HumanoidStateType.Freefall) and true or v157 == Enum.HumanoidStateType.Jumping then
                    local v158 = v156.Action == Enum.PathWaypointAction.Jump
                    if not v158 and v_u_121.CurrentPoint > 1 then
                        local v159 = v_u_121.pointList[v_u_121.CurrentPoint - 1]
                        local v160 = v155.Position - v159.Position
                        local v161 = v156.Position - v155.Position
                        v158 = Vector2.new(v160.x, v160.z).Unit:Dot(Vector2.new(v161.x, v161.z).Unit) < 0.996
                    end
                    if v158 then
                        v_u_121.Humanoid.FreeFalling:Wait()
                        wait(0.1)
                    end
                end
                v_u_121:MoveToNextWayPoint(v155, v156, v154)
            end
        else
            v_u_121.PathFailed:Fire()
            v_u_121:Cleanup()
            return
        end
    end
    function v_u_121.MoveToNextWayPoint(_, p162, p163, p164)
        v_u_121.CurrentWaypointPlaneNormal = p162.Position - p163.Position
        if not v_u_6 or p163.Label ~= "Climb" then
            local v165 = v_u_121
            local v166 = v_u_121.CurrentWaypointPlaneNormal.X
            local v167 = v_u_121.CurrentWaypointPlaneNormal.Z
            v165.CurrentWaypointPlaneNormal = Vector3.new(v166, 0, v167)
        end
        if v_u_121.CurrentWaypointPlaneNormal.Magnitude > 1e-6 then
            v_u_121.CurrentWaypointPlaneNormal = v_u_121.CurrentWaypointPlaneNormal.Unit
            v_u_121.CurrentWaypointPlaneDistance = v_u_121.CurrentWaypointPlaneNormal:Dot(p163.Position)
        else
            v_u_121.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            v_u_121.CurrentWaypointPlaneDistance = 0
        end
        v_u_121.CurrentWaypointNeedsJump = p163.Action == Enum.PathWaypointAction.Jump
        v_u_121.CurrentWaypointPosition = p163.Position
        v_u_121.CurrentPoint = p164
        v_u_121.Timeout = 0
    end
    function v_u_121.Start(_, p168)
        if v_u_121.AgentCanFollowPath then
            if v_u_121.Started then
                return
            else
                v_u_121.Started = true
                v_u_21.CancelFailureAnimation()
                if v_u_14 and (p168 == nil or p168) then
                    local v169 = v_u_121
                    local v170 = v_u_121
                    local v171, v172 = v_u_21.CreatePathDisplay(v_u_121.pointList, v_u_121.OriginalTargetPoint)
                    v169.stopTraverseFunc = v171
                    v170.setPointFunc = v172
                end
                if #v_u_121.pointList > 0 then
                    local v173 = v_u_121
                    local v174 = v_u_121.pointList[1].Position.Y - v_u_121.OriginPoint.Y
                    v173.HumanoidOffsetFromPath = Vector3.new(0, v174, 0)
                    v_u_121.CurrentHumanoidPosition = v_u_121.Humanoid.RootPart.Position + v_u_121.HumanoidOffsetFromPath
                    v_u_121.CurrentHumanoidVelocity = v_u_121.Humanoid.RootPart.Velocity
                    v_u_121.SeatedConn = v_u_121.Humanoid.Seated:Connect(function(_, _)
                        v_u_121:OnPathInterrupted()
                    end)
                    v_u_121.DiedConn = v_u_121.Humanoid.Died:Connect(function()
                        v_u_121:OnPathInterrupted()
                    end)
                    v_u_121.TeleportedConn = v_u_121.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function()
                        v_u_121:OnPathInterrupted()
                    end)
                    v_u_121.CurrentPoint = 1
                    v_u_121:OnPointReached(true)
                else
                    v_u_121.PathFailed:Fire()
                    if v_u_121.stopTraverseFunc then
                        v_u_121.stopTraverseFunc()
                    end
                end
            end
        else
            v_u_121.PathFailed:Fire()
            return
        end
    end
    local v175 = v_u_121.TargetPoint + v_u_121.TargetSurfaceNormal * 1.5
    local v176 = Ray.new(v175, Vector3.new(0, -50, 0))
    local v177 = v_u_11
    local v178
    if v_u_38 then
        v178 = v_u_38
    else
        v_u_38 = {}
        local v179 = v_u_38
        local v180 = v_u_20
        if v180 then
            v180 = v_u_20.Character
        end
        table.insert(v179, v180)
        v178 = v_u_38
    end
    local v181, v182 = v177:FindPartOnRayWithIgnoreList(v176, v178)
    if v181 then
        v_u_121.TargetPoint = v182
    end
    v_u_121:ComputePath()
    return v_u_121
end
local function v_u_186(p184)
    if p184 ~= nil then
        for _, v185 in pairs(p184:GetChildren()) do
            if v185:IsA("Tool") then
                return v185
            end
        end
    end
end
local v_u_187 = nil
local v_u_188 = nil
local v_u_189 = nil
local function v_u_198(p190, p_u_191, p_u_192, p_u_193, p_u_194)
    if v_u_187 then
        if v_u_187 then
            v_u_187:Cancel()
            v_u_187 = nil
        end
        if v_u_188 then
            v_u_188:Disconnect()
            v_u_188 = nil
        end
        if v_u_189 then
            v_u_189:Disconnect()
            v_u_189 = nil
        end
    end
    v_u_187 = p190
    p190:Start(p_u_194)
    v_u_188 = p190.Finished.Event:Connect(function()
        if v_u_187 then
            v_u_187:Cancel()
            v_u_187 = nil
        end
        if v_u_188 then
            v_u_188:Disconnect()
            v_u_188 = nil
        end
        if v_u_189 then
            v_u_189:Disconnect()
            v_u_189 = nil
        end
        local v195 = p_u_192 and v_u_186(p_u_193)
        if v195 then
            v195:Activate()
        end
    end)
    v_u_189 = p190.PathFailed.Event:Connect(function()
        if v_u_187 then
            v_u_187:Cancel()
            v_u_187 = nil
        end
        if v_u_188 then
            v_u_188:Disconnect()
            v_u_188 = nil
        end
        if v_u_189 then
            v_u_189:Disconnect()
            v_u_189 = nil
        end
        if p_u_194 == nil or p_u_194 then
            local v196 = v_u_15
            if v196 then
                local v197 = v_u_187
                if v197 then
                    v197 = v_u_187:IsActive()
                end
                v196 = not v197
            end
            if v196 then
                v_u_21.PlayFailureAnimation()
            end
            v_u_21.DisplayFailureWaypoint(p_u_191)
        end
    end)
end
function OnTap(p199, p200, p201)
    local v202 = v_u_11.CurrentCamera
    local v203 = v_u_20.Character
    local v204 = v_u_20
    local v205
    if v204 then
        v205 = v204.Character
    else
        v205 = v204
    end
    local v206
    if v205 then
        v206 = v_u_37[v204]
        if not v206 or v206.Parent ~= v205 then
            v_u_37[v204] = nil
            v206 = v205:FindFirstChildOfClass("Humanoid")
            if v206 then
                v_u_37[v204] = v206
            end
        end
    else
        v206 = nil
    end
    local v207
    if v206 == nil then
        v207 = false
    else
        v207 = v206.Health > 0
    end
    if v207 then
        if #p199 == 1 or p200 then
            if v202 then
                local v208 = v202:ScreenPointToRay(p199[1].X, p199[1].Y)
                local v209 = Ray.new(v208.Origin, v208.Direction * 1000)
                local v210 = v_u_20
                local v211
                if v210 then
                    v211 = v210.Character
                else
                    v211 = v210
                end
                if v211 then
                    local v212 = v_u_37[v210]
                    if not v212 or v212.Parent ~= v211 then
                        v_u_37[v210] = nil
                        local v213 = v211:FindFirstChildOfClass("Humanoid")
                        if v213 then
                            v_u_37[v210] = v213
                        end
                    end
                end
                local v214 = v_u_22.Raycast
                local v215 = true
                local v216
                if v_u_38 then
                    v216 = v_u_38
                else
                    v_u_38 = {}
                    local v217 = v_u_38
                    local v218 = v_u_20
                    if v218 then
                        v218 = v_u_20.Character
                    end
                    table.insert(v217, v218)
                    v216 = v_u_38
                end
                local v219, v220, v221 = v214(v209, v215, v216)
                local v222, v223 = v_u_22.FindCharacterAncestor(v219)
                if p201 and (v223 and (v_u_10:GetCore("AvatarContextMenuEnabled") and v_u_9:GetPlayerFromCharacter(v223.Parent))) then
                    if v_u_187 then
                        v_u_187:Cancel()
                        v_u_187 = nil
                    end
                    if v_u_188 then
                        v_u_188:Disconnect()
                        v_u_188 = nil
                    end
                    if v_u_189 then
                        v_u_189:Disconnect()
                        v_u_189 = nil
                    end
                    return
                end
                if p200 then
                    v222 = nil
                else
                    p200 = v220
                end
                if p200 and v203 then
                    if v_u_187 then
                        v_u_187:Cancel()
                        v_u_187 = nil
                    end
                    if v_u_188 then
                        v_u_188:Disconnect()
                        v_u_188 = nil
                    end
                    if v_u_189 then
                        v_u_189:Disconnect()
                        v_u_189 = nil
                    end
                    local v224 = v_u_183(p200, v221)
                    if v224:IsValidPath() then
                        v_u_198(v224, p200, v222, v203)
                    else
                        v224:Cleanup()
                        if v_u_187 and v_u_187:IsActive() then
                            v_u_187:Cancel()
                        end
                        if v_u_15 then
                            v_u_21.PlayFailureAnimation()
                        end
                        v_u_21.DisplayFailureWaypoint(p200)
                    end
                end
            end
        else
            local v225 = #p199 >= 2 and (v202 and v_u_186(v203))
            if v225 then
                v225:Activate()
            end
        end
    end
end
local v_u_226 = require(script.Parent:WaitForChild("Keyboard"))
local v_u_227 = setmetatable({}, v_u_226)
v_u_227.__index = v_u_227
function v_u_227.new(p228)
    local v229 = v_u_226.new(p228)
    local v230 = v_u_227
    local v231 = setmetatable(v229, v230)
    v231.fingerTouches = {}
    v231.numUnsunkTouches = 0
    v231.mouse1Down = tick()
    v231.mouse1DownPos = Vector2.new()
    v231.mouse2DownTime = tick()
    v231.mouse2DownPos = Vector2.new()
    v231.mouse2UpTime = tick()
    v231.keyboardMoveVector = Vector3.new(0, 0, 0)
    v231.tapConn = nil
    v231.inputBeganConn = nil
    v231.inputChangedConn = nil
    v231.inputEndedConn = nil
    v231.humanoidDiedConn = nil
    v231.characterChildAddedConn = nil
    v231.onCharacterAddedConn = nil
    v231.characterChildRemovedConn = nil
    v231.renderSteppedConn = nil
    v231.menuOpenedConnection = nil
    v231.running = false
    v231.wasdEnabled = false
    return v231
end
function v_u_227.DisconnectEvents(p232)
    local v233 = p232.tapConn
    if v233 then
        v233:Disconnect()
    end
    local v234 = p232.inputBeganConn
    if v234 then
        v234:Disconnect()
    end
    local v235 = p232.inputChangedConn
    if v235 then
        v235:Disconnect()
    end
    local v236 = p232.inputEndedConn
    if v236 then
        v236:Disconnect()
    end
    local v237 = p232.humanoidDiedConn
    if v237 then
        v237:Disconnect()
    end
    local v238 = p232.characterChildAddedConn
    if v238 then
        v238:Disconnect()
    end
    local v239 = p232.onCharacterAddedConn
    if v239 then
        v239:Disconnect()
    end
    local v240 = p232.renderSteppedConn
    if v240 then
        v240:Disconnect()
    end
    local v241 = p232.characterChildRemovedConn
    if v241 then
        v241:Disconnect()
    end
    local v242 = p232.menuOpenedConnection
    if v242 then
        v242:Disconnect()
    end
end
function v_u_227.OnTouchBegan(p243, p244, p245)
    if p243.fingerTouches[p244] == nil and not p245 then
        p243.numUnsunkTouches = p243.numUnsunkTouches + 1
    end
    p243.fingerTouches[p244] = p245
end
function v_u_227.OnTouchChanged(p246, p247, p248)
    if p246.fingerTouches[p247] == nil then
        p246.fingerTouches[p247] = p248
        if not p248 then
            p246.numUnsunkTouches = p246.numUnsunkTouches + 1
        end
    end
end
function v_u_227.OnTouchEnded(p249, p250, _)
    if p249.fingerTouches[p250] ~= nil and p249.fingerTouches[p250] == false then
        p249.numUnsunkTouches = p249.numUnsunkTouches - 1
    end
    p249.fingerTouches[p250] = nil
end
function v_u_227.OnCharacterAdded(p_u_251, p252)
    p_u_251:DisconnectEvents()
    p_u_251.inputBeganConn = v_u_7.InputBegan:Connect(function(p253, p254)
        if p253.UserInputType == Enum.UserInputType.Touch then
            p_u_251:OnTouchBegan(p253, p254)
        end
        if p_u_251.wasdEnabled and (p254 == false and (p253.UserInputType == Enum.UserInputType.Keyboard and v_u_19[p253.KeyCode])) then
            if v_u_187 then
                v_u_187:Cancel()
                v_u_187 = nil
            end
            if v_u_188 then
                v_u_188:Disconnect()
                v_u_188 = nil
            end
            if v_u_189 then
                v_u_189:Disconnect()
                v_u_189 = nil
            end
            v_u_21.CancelFailureAnimation()
        end
        if p253.UserInputType == Enum.UserInputType.MouseButton1 then
            p_u_251.mouse1DownTime = tick()
            p_u_251.mouse1DownPos = p253.Position
        end
        if p253.UserInputType == Enum.UserInputType.MouseButton2 then
            p_u_251.mouse2DownTime = tick()
            p_u_251.mouse2DownPos = p253.Position
        end
    end)
    p_u_251.inputChangedConn = v_u_7.InputChanged:Connect(function(p255, p256)
        if p255.UserInputType == Enum.UserInputType.Touch then
            p_u_251:OnTouchChanged(p255, p256)
        end
    end)
    p_u_251.inputEndedConn = v_u_7.InputEnded:Connect(function(p257, p258)
        if p257.UserInputType == Enum.UserInputType.Touch then
            p_u_251:OnTouchEnded(p257, p258)
        end
        if p257.UserInputType == Enum.UserInputType.MouseButton2 then
            p_u_251.mouse2UpTime = tick()
            local v259 = p257.Position
            local v260 = v_u_187 or p_u_251.keyboardMoveVector.Magnitude <= 0
            if p_u_251.mouse2UpTime - p_u_251.mouse2DownTime < 0.25 and ((v259 - p_u_251.mouse2DownPos).magnitude < 5 and v260) then
                OnTap({ v259 })
            end
        end
    end)
    p_u_251.tapConn = v_u_7.TouchTap:Connect(function(p261, p262)
        if not p262 then
            OnTap(p261, nil, true)
        end
    end)
    p_u_251.menuOpenedConnection = v_u_13.MenuOpened:Connect(function()
        if v_u_187 then
            v_u_187:Cancel()
            v_u_187 = nil
        end
        if v_u_188 then
            v_u_188:Disconnect()
            v_u_188 = nil
        end
        if v_u_189 then
            v_u_189:Disconnect()
            v_u_189 = nil
        end
    end)
    local function v_u_265(p263)
        if v_u_7.TouchEnabled and p263:IsA("Tool") then
            p263.ManualActivationOnly = true
        end
        if p263:IsA("Humanoid") then
            local v264 = p_u_251.humanoidDiedConn
            if v264 then
                v264:Disconnect()
            end
            p_u_251.humanoidDiedConn = p263.Died:Connect(function() end)
        end
    end
    p_u_251.characterChildAddedConn = p252.ChildAdded:Connect(function(p266)
        v_u_265(p266)
    end)
    p_u_251.characterChildRemovedConn = p252.ChildRemoved:Connect(function(p267)
        if v_u_7.TouchEnabled and p267:IsA("Tool") then
            p267.ManualActivationOnly = false
        end
    end)
    for _, v268 in pairs(p252:GetChildren()) do
        v_u_265(v268)
    end
end
function v_u_227.Start(p269)
    p269:Enable(true)
end
function v_u_227.Stop(p270)
    p270:Enable(false)
end
function v_u_227.CleanupPath(_)
    if v_u_187 then
        v_u_187:Cancel()
        v_u_187 = nil
    end
    if v_u_188 then
        v_u_188:Disconnect()
        v_u_188 = nil
    end
    if v_u_189 then
        v_u_189:Disconnect()
        v_u_189 = nil
    end
end
function v_u_227.Enable(p_u_271, p272, p273, p274)
    if p272 then
        if not p_u_271.running then
            if v_u_20.Character then
                p_u_271:OnCharacterAdded(v_u_20.Character)
            end
            p_u_271.onCharacterAddedConn = v_u_20.CharacterAdded:Connect(function(p275)
                p_u_271:OnCharacterAdded(p275)
            end)
            p_u_271.running = true
        end
        p_u_271.touchJumpController = p274
        if p_u_271.touchJumpController then
            p_u_271.touchJumpController:Enable(p_u_271.jumpEnabled)
        end
    else
        if p_u_271.running then
            p_u_271:DisconnectEvents()
            if v_u_187 then
                v_u_187:Cancel()
                v_u_187 = nil
            end
            if v_u_188 then
                v_u_188:Disconnect()
                v_u_188 = nil
            end
            if v_u_189 then
                v_u_189:Disconnect()
                v_u_189 = nil
            end
            if v_u_7.TouchEnabled then
                local v276 = v_u_20.Character
                if v276 then
                    for _, v277 in pairs(v276:GetChildren()) do
                        if v277:IsA("Tool") then
                            v277.ManualActivationOnly = false
                        end
                    end
                end
            end
            p_u_271.running = false
        end
        if p_u_271.touchJumpController and not p_u_271.jumpEnabled then
            p_u_271.touchJumpController:Enable(true)
        end
        p_u_271.touchJumpController = nil
    end
    if v_u_7.KeyboardEnabled and p272 ~= p_u_271.enabled then
        p_u_271.forwardValue = 0
        p_u_271.backwardValue = 0
        p_u_271.leftValue = 0
        p_u_271.rightValue = 0
        p_u_271.moveVector = Vector3.new(0, 0, 0)
        if p272 then
            p_u_271:BindContextActions()
            p_u_271:ConnectFocusEventListeners()
        else
            p_u_271:UnbindContextActions()
            p_u_271:DisconnectFocusEventListeners()
        end
    end
    p_u_271.wasdEnabled = p272 and p273 and p273 or false
    p_u_271.enabled = p272
end
function v_u_227.OnRenderStepped(p278, p279)
    p278.isJumping = false
    if v_u_187 then
        v_u_187:OnRenderStepped(p279)
        if v_u_187 then
            p278.moveVector = v_u_187.NextActionMoveDirection
            p278.moveVectorIsCameraRelative = false
            if v_u_187.NextActionJump then
                p278.isJumping = true
            end
        else
            p278.moveVector = p278.keyboardMoveVector
            p278.moveVectorIsCameraRelative = true
        end
    else
        p278.moveVector = p278.keyboardMoveVector
        p278.moveVectorIsCameraRelative = true
    end
    if p278.jumpRequested then
        p278.isJumping = true
    end
end
function v_u_227.UpdateMovement(p280, p281)
    if p281 == Enum.UserInputState.Cancel then
        p280.keyboardMoveVector = Vector3.new(0, 0, 0)
    elseif p280.wasdEnabled then
        local v282 = p280.leftValue + p280.rightValue
        local v283 = p280.forwardValue + p280.backwardValue
        p280.keyboardMoveVector = Vector3.new(v282, 0, v283)
    end
end
function v_u_227.UpdateJump(_) end
function v_u_227.SetShowPath(_, p284)
    v_u_14 = p284
end
function v_u_227.GetShowPath(_)
    return v_u_14
end
function v_u_227.SetWaypointTexture(_, p285)
    v_u_21.SetWaypointTexture(p285)
end
function v_u_227.GetWaypointTexture(_)
    return v_u_21.GetWaypointTexture()
end
function v_u_227.SetWaypointRadius(_, p286)
    v_u_21.SetWaypointRadius(p286)
end
function v_u_227.GetWaypointRadius(_)
    return v_u_21.GetWaypointRadius()
end
function v_u_227.SetEndWaypointTexture(_, p287)
    v_u_21.SetEndWaypointTexture(p287)
end
function v_u_227.GetEndWaypointTexture(_)
    return v_u_21.GetEndWaypointTexture()
end
function v_u_227.SetWaypointsAlwaysOnTop(_, p288)
    v_u_21.SetWaypointsAlwaysOnTop(p288)
end
function v_u_227.GetWaypointsAlwaysOnTop(_)
    return v_u_21.GetWaypointsAlwaysOnTop()
end
function v_u_227.SetFailureAnimationEnabled(_, p289)
    v_u_15 = p289
end
function v_u_227.GetFailureAnimationEnabled(_)
    return v_u_15
end
function v_u_227.SetIgnoredPartsTag(_, p290)
    v_u_52(p290)
end
function v_u_227.GetIgnoredPartsTag(_)
    return v_u_39
end
function v_u_227.SetUseDirectPath(_, p291)
    v_u_16 = p291
end
function v_u_227.GetUseDirectPath(_)
    return v_u_16
end
function v_u_227.SetAgentSizeIncreaseFactor(_, p292)
    v_u_17 = p292 / 100 + 1
end
function v_u_227.GetAgentSizeIncreaseFactor(_)
    return (v_u_17 - 1) * 100
end
function v_u_227.SetUnreachableWaypointTimeout(_, p293)
    v_u_18 = p293
end
function v_u_227.GetUnreachableWaypointTimeout(_)
    return v_u_18
end
function v_u_227.SetUserJumpEnabled(p294, p295)
    p294.jumpEnabled = p295
    if p294.touchJumpController then
        p294.touchJumpController:Enable(p295)
    end
end
function v_u_227.GetUserJumpEnabled(p296)
    return p296.jumpEnabled
end
function v_u_227.MoveTo(_, p297, p298, p299)
    local v300 = v_u_20.Character
    if v300 == nil then
        return false
    end
    local v301 = v_u_183(p297, Vector3.new(0, 1, 0), p299)
    if not (v301 and v301:IsValidPath()) then
        return false
    end
    v_u_198(v301, p297, nil, v300, p298)
    return true
end
return v_u_227