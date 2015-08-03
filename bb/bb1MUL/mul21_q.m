function  z = mul21_q(x,y,qpoint)
% can be used a generic q format N x P -> N+P
% the limitations is that 32x32 gives 53 bit precision instead of 64bit
%   due to FP double format limitation 
% still okay 24 x 24 --> 48 
%            32 x 16 --> 48 
%--------------------------------------------------
  p= times(x,y); 
  z= qformat(p,qpoint); 
end
