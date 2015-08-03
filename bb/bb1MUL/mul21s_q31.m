function z= mul21s_q31(x,y)
% 1q31 x 1q31 -> 1q31

%% Input pins: format change and range checking if needed
lX=q31fp2l(x); %ensure precision is 32-bit or less
fX=q31l2fp(lX);
lY=q31fp2l(y);
fY=q31l2fp(lY);

%% Kernel
 fZ= times(fX,fY);% 1q31 x 1q31 -> 2q51
 lZ= q31fp2l(fZ);% 2q51 --> sat 1q31
 
%% Output pins: format change if needed
  z= q31l2fp(lZ);
