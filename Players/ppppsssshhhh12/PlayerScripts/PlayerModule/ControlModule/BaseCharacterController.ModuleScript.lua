local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.new()
    local v2 = v_u_1
    local v3 = setmetatable({}, v2)
    v3.enabled = false
    v3.moveVector = Vector3.new(0, 0, 0)
    v3.moveVectorIsCameraRelative = true
    v3.isJumping = false
    return v3
end
function v_u_1.OnRenderStepped(_, _) end
function v_u_1.GetMoveVector(p4)
    return p4.moveVector
end
function v_u_1.IsMoveVectorCameraRelative(p5)
    return p5.moveVectorIsCameraRelative
end
function v_u_1.GetIsJumping(p6)
    return p6.isJumping
end
function v_u_1.Enable(_, _)
    error("BaseCharacterController:Enable must be overridden in derived classes and should not be called.")
    return false
end
return v_u_1