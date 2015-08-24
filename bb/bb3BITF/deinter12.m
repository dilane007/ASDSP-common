% [z w]=deinter(x) deinterleave 1 vector(x) into 2 vectors: odd-numbered and even-numbered (z,w)
% SHAPE= vector min size is 2
% tested: not tested
% %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z w]=deinter12(x)
    z= x(1:2:end-1);     
    w= x(2:2:end);
end 

