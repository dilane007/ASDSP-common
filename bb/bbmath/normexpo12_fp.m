% [z w]=NORMEXPO12(x)
%simulate the fixed point sequence
%N= clz(x) followed by (left)shift by N
%NOTE: if x is 16q16  clz=15-exp

function [z w]=normexpo12_fp(x)
%clz
    exp= floor(log2(x));
    %x= [16385 16384 18383 8193 4097 2050 1200 600 300]
    %exp=  14    14    14   13   12   11   10   9   8    
    %x= [2.63  1.63  1  0.999  0.99  0.4097  0.2050  0.12 0.06 0.03]
    %exp= 1     0   0   -1     -1     -2      -3     -4   -5   -6
%shift by N   
    z= times(x,power(2,-exp));%left shift
%return also exp 
    w= exp; 
end