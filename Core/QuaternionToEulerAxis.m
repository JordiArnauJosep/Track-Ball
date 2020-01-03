function [axis,angle] = QuaternionToEulerAxis(quat)
%QuaternionToEulerAxis Transform a Quaternion to Euler Axis
angle=acos(quat(1))*2;
axis=asin(quat(2:4));
axis=quat(2:4)/axis;
end

