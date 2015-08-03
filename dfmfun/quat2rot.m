function rot = quat2rot(quat)
% function rot = quat2rot(quat)

a = quat(1);
b = quat(2);
c = quat(3);
d = quat(4);
% quat = a + bi + cj + dk
% rot = [a^2+b^2-c^2-d^2  2*b*c-2*a*d      2*a*c+2*b*d;
%        2*a*d+2*b*c      a^2-b^2+c^2-d^2  2*c*d-2*a*b;
%        2*b*d-2*a*c      2*a*b+2*c*d      a^2-b^2-c^2+d^2];
rot = [1-2*c^2-2*d^2    2*b*c-2*a*d      2*a*c+2*b*d;
       2*a*d+2*b*c      1-2*b^2-2*d^2    2*c*d-2*a*b;
       2*b*d-2*a*c      2*a*b+2*c*d      1-2*b^2-2*c^2];
   
