% [z w]=deinter(x) deinterleave vector(x) into odd-numbered and even-numbered vectors (z,w)
% tested: not exhaustive in (original) ariti\max8u1
% %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z w]=deinter(xin)
    z= xin(1:2:end-1);     
    w= xin(2:2:end);
end 

