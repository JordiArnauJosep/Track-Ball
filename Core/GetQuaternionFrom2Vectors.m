function [q] = GetQuaternionFrom2Vectors(vec1,vec2)
%GetQuaternionFrom2Vectors Get a Quaternion from two vectors
modulevec1=power(vec1,2);
modulevec1=sqrt(modulevec1(1)+modulevec1(2)+modulevec1(3));
modulevec2=power(vec2,2);
modulevec2=sqrt(modulevec2(1)+modulevec2(2)+modulevec2(3));
vec1=vec1/modulevec1;
vec2=vec2/modulevec2;
w = cross(vec1, vec2);
u=vec1'*vec2;
q = [(u); w(1); w(2); w(3)];
moduleq=power(q,2);
moduleq=sqrt(moduleq(1)+moduleq(2)+moduleq(3)+moduleq(4));
q=q/moduleq;
%normalize(q);
end