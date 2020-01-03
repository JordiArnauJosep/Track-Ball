function [roll, pitch, yaw] = RotationMatrixToEulerAngles(rotmat)
%EulerAxisToQuaternion Transform a Rotation Matrix to Euler Angles
pitch=asin(-rotmat(3,1));
if sin(pitch) == -1
    roll=0;
    yaw=atan2(rotmat(1,2)+sin(roll),rotmat(2,2)-cos(roll));
elseif sin(pitch) == 1
    roll=0;
    yaw=atan2(-(rotmat(1,2)-sin(roll)),-(rotmat(2,2)-cos(roll)));
else
    roll=atan2(rotmat(3,2)/cos(pitch),rotmat(3,3)/cos(pitch));
    yaw=atan2(rotmat(2,1)/cos(pitch),rotmat(1,1)/cos(pitch));
end
end
