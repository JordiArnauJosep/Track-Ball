function [rotmat] = EulerAnglesToRotationMatrix(roll, pitch, yaw)
%EulerAxisToQuaternion Transform an Euler Angles to Rotation Matrix
Ryaw=[cos(yaw),sin(yaw),0;-sin(yaw),cos(yaw),0;0,0,1];
Rpitch=[cos(pitch),0,-sin(pitch);0,1,0;sin(pitch),0,cos(pitch)];
Rroll=[1,0,0;0,cos(roll),sin(roll);0,-sin(roll),cos(roll)];
rotmat=Ryaw'*Rpitch'*Rroll';
end
