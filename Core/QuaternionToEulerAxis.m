function [axis,angle] = QuaternionToEulerAxis(quat)
%QuaternionToEulerAxis Transform a Quaternion to Euler Axis
angle=acos(quat(1))*2;
if(angle==0)
    axis=[1;0;0];
else
    axis=quat(2:4)/sin(angle/2);
end
end

