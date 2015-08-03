% ATUTOR\EXTEND\lsb2msb.m
% transfer bits   +++  magnitude <--> precision ---  
%=======================================================
function  z = lsb2msb(x,nbit)
[left right sign]= precision(x);
zleft  = left+nbit;
zright = right-nbit;
z = fxp(x,zleft,zright,sign);
