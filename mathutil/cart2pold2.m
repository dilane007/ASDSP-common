%[TH,R] = CART2POLD(X,Y) TH is returned in degrees. 
% transforms corresponding elements of data stored in Cartesian coordinates X,Y to polar coordinates (angle TH and radius R).  
% The arrays X and Y must be the same size (or either can be scalar). TH is returned in degrees. 
function [th,r,z] = cart2pold(x,y,z)
  th = 180/pi*atan2(y,x);
  r = sqrt(x.^2+y.^2);
end