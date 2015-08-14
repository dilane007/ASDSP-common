% can be used a generic q format N x P -> N+P
% the limitations is that 32x32 gives 53 bit precision instead of 64bit
%   due to FP double  
% still okay 24 x 24 --> 48 
%--------------------------------------------------
function  z = mul21_q(x,y,qpoint)
  p= times(x,y); 
  z= qformat(p,qpoint); 
end
