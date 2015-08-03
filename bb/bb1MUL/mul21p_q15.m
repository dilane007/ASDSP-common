function z= mul21p_q15(x,y)
% 1q15 x 1q15 -> 2q30

%% Input pins: format change and range checking if needed
lX=q15fp2l(x);
lY=q15fp2l(y);

%% Kernel
 lZ= times(lX,lY);% 1q15 x 1q15 -> 2q30
 
%% Output pins: format change if needed
z=q30l2fp(lZ);


