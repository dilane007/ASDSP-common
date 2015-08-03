function z= mul21ps_q15(x,y)
% 1q15 x 1q15 -> 1q31

%% Input pins: format change and range checking if needed
 lX=q15fp2l(x);
 lY=q15fp2l(y);
%% Kernel
 lZ= times(lX,lY);% 1q15 x 1q15 -> 2q30
 lZ= times(lZ,2); % 2q30 --> 1q31 and saturate
 
%% Output pins: format change if needed
 z=q31l2fp(lZ);
