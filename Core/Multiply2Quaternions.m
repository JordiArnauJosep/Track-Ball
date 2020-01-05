function [q] = Multiply2Quaternions(q1,q2)
%Multiply2Quaternions Does the multiplication of two Quaternions
q=[0;0;0;0];
q(1)=(q1(1)*q2(1))-(q1(2:4)'*q2(2:4));
q(2:4)=(q1(1)*q2(2:4))+(q2(1)*q1(2:4))+(cross(q1(2:4),q2(2:4)));
end

