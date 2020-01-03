function [axis,angle] = RotationVectorToEulerAxis(rotvec)
%EulerAxisToQuaternion Transform a Rotation Vector to Euler Axis
angle=norm(rotvec);
axis=rotvec/angle;
end
