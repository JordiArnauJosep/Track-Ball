function [rotvec] = EulerAxisToRotationVector(axis,angle)
%EulerAxisToQuaternion Transform an Euler Axis to Rotation Vector
rotvec=axis*angle;
end
