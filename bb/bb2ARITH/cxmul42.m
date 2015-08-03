function [zr zi]= cxmul42(xr,xi,yr,yi)
 a= times(xr,yr);
 b= times(xi,yi);
 c= times(xr,yi);
 d= times(xi,yr);
 zr= minus(a,b);
 zi= plus(c,d);
end