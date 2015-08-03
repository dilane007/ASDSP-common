% ATUTOR\EXTEND\extmsb.m
% Extend towards msb
%=======================================================
function  z = extmsb(x,nmsb)
[left right sign]= precision(x);
zleft = left+nmsb;
zright = right;
z = fxp(x,zleft,zright,sign);
