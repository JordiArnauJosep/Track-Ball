function [rotmat] = EulerAxisToRotationMatrix(axis,angle)
%EulerAxisToQuaternion Transform an Euler Axis to Rotation Matrix
ux=[0,-axis(3),axis(2);axis(3),0,-axis(1);-axis(2),axis(1),0];
rotmat1=eye(3)*cos(angle);
rotmat2=(1-cos(angle))*(axis*axis');
rotmat3=ux*sin(angle);
rotmat=rotmat1+rotmat2+rotmat3;
end
