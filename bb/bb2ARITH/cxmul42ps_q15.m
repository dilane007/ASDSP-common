function  [zr zi] = cxmul42ps_q15(xr,xi,yr,yi)
% 1q15 x 1q15 -> 1q31

%% Input pins: format change and range checking if needed
xr= qformat(xr,1.15); 
xi= qformat(xi,1.15); 
yr= qformat(yr,1.15); 
yi= qformat(yi,1.15); 

%% Kernel
 a= times(xr,yr);
 b= times(xi,yi);
 c= times(xr,yi);
 d= times(xi,yr);
 zr= minus(a,b);
 zi= plus(c,d);
 
%% Output pins: format change if needed
 zr= qformat(zr,1.31); 
 zi= qformat(zi,1.31); 
end
