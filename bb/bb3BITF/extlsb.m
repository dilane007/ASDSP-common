% ATUTOR\EXTEND\extlsb.m
% Extend lsb side -- more precision
%=======================================================
function  z = extlsb(x,nlsb)
[left right sign]= precision(x);
zleft  = left;
zright = right+nlsb;
z = fxp(x,zleft,zright,sign);
