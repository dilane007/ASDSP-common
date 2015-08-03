% ATUTOR\EXTEND\extend.m
% Extend on both end 
%=======================================================
function  z = extend(x,msb,lsb)
[left right sign]= precision(x);
zleft  = left+msb;
zright = right+lsb;
z = fxp(x,zleft,zright,sign);
