function [quat] = EulerAxisToQuaternion(axis,angle)
%EulerAxisToQuaternion Transform an Euler Axis to Quaternion
quat=[0;0;0;0];
quat(1)=cos(angle/2);
quat(2:4)=sin(angle/2)*axis;
end