function [axis,angle] = RotationMatrixToEulerAxis(rotmat)
%EulerAxisToQuaternion Transform a Rotation Matrix to Euler Axis
angle=acos((trace(rotmat)-1)/2);
if sin(angle) == 0
    if cos(angle) == 1
        axis=[1;0;0];
    else
        R=(rotmat+eye(3))/2;
        axis=[0;0;0];
        if axis(1)~=0
            axis(1)=sqrt(R(1,1));
            axis(2)=R(1,2)/axis(1);
            axis(3)=R(1,3)/axis(1);
        elseif axis(2)~=0
            axis(2)=sqrt(R(2,2));
            axis(1)=R(2,1)/axis(2);
            axis(3)=R(2,3)/axis(2);
        else
            axis(3)=sqrt(R(3,3));
            axis(1)=R(3,1)/axis(3);
            axis(2)=R(3,2)/axis(3);
        end
    end
else
    ux=(rotmat-rotmat')/(2*sin(angle));
    axis=[ux(3,2);ux(1,3);ux(2,1)];
end
end
