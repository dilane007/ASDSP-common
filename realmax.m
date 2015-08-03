%[DFM] z= REALMAX
% shape, type, range checking: none
% WARNING!! value checking: NOT quite identical to matlab
function z= realmax
    f= 2;  %should be 1-eps/2
    e= 1022; %should be 1024
    z= f.*2.^e;% return inf if I use the Matlab value
end
    

