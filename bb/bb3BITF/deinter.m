% [z w]=deinter(x) deinterleave 1 vector(x) into 2 vectors: odd-numbered and even-numbered (z,w)
% SHAPE= will fail on scalar
% tested: not exhaustive in (original) ariti\max8u1
% %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z w]=deinter12(x)
    z= x(1:2:end-1);     
    w= x(2:2:end);
end 

