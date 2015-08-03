% [z w]=deinter88(x) deinterleave 8way vector(x) into odd-numbered and even-numbered vectors (z,w)
% tested: no testbench
% %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z w]=deinter88(xin)
    z= xin(1:2:7);     
    w= xin(2:2:8);
end 

