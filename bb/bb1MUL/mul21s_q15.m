function z= mul21s_q15(x,y)
% 1q15 x 1q15 -> 1q15

%% Input pins: format change and range checking if needed
lX=q15fp2l(x);
lY=q15fp2l(y);

%% Kernel
 lZ= times(lX,lY);% 1q15 x 1q15 -> 2q30
 sZ=  int16(double(lZ/32768));% 1q15 sat 
%% Kernel2
%  lZ= times(lX,lY);
%  ulZ= bitshifta(l2ul(lZ),-15);% 2q30 --> 1q15
%  sZ=  int16(ul2l(ulZ));% 1q15 sat 
 
%% Output pins: format change if needed
z=q15s2fp(sZ);
