function  [zr zi] = cxmul42_q(xr,xi,yr,yi,qpoint)
% can be used a generic q format N x P -> N+P
% the limitations is that 32x32 gives 53 bit precision instead of 64bit
%   due to FP double format limitation 
% still okay 24 x 24 --> 48 
%            32 x 16 --> 48 
%--------------------------------------------------
 a= times(xr,yr);
 b= times(xi,yi);
 c= times(xr,yi);
 d= times(xi,yr);
 zr= minus(a,b);
 zi= plus(c,d);
 zr= qformat(zr,qpoint); 
 zi= qformat(zi,qpoint); 
end
