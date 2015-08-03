% [z w]=NORMA12(x)
% equivalent DSP : N=clz(x) followed by z= shr(x,N)
% N=15...-15 
% q-format dependent: works for 16q16 format 
% <27Jan2010> used to compute log;
%IMPLEMENTATION 1: use truncated log2 to do clz  
function [z w]=norma12(x)
%clz
    yclz= 15-floor(log2(x));% floor is towards -INF
%shift by N ;   
    yn= yclz-15; % multiply is shift left
    z= times(x,power(2,yn));%shift
    w= yclz; 

end