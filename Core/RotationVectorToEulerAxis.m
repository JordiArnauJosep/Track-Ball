function [axis,angle] = RotationVectorToEulerAxis(rotvec)
%EulerAxisToQuaternion Transform a Rotation Vector to Euler Axis
angle=norm(rotvec);
if(angle==0)
    axis=[1;0;0];
else
    axis=rotvec/angle;
end
end
