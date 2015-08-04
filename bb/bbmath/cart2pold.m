% [TH,R] = CART2POLD(X,Y) TH is returned in degrees. 
% Cartesian coordinates X,Y to polar coordinates (angle TH and radius R).  
% TYPE: FP
% SHAPE: x,y same shape 
% RANGE: function limited 
function [th,r] = cart2pold(x,y)
 IMPLM=1;
 
 if IMPLM == 1
     th = 180/pi*atan2(y,x);
     r = sqrt(x.^2+y.^2);
 end; 

end 