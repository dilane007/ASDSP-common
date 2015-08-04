% [X,Y,TH2] = POLD2CART(TH,R) 
% transforms polar coordinates (angle TH, radius R) to Cartesian coordinates X,Y.  
% TYPE: FP
% SHAPE: TH , R same shape 
% RANGE: TH must be in degrees.
%-----------------------------------------------------------------------
function [x,y,th2] = pold2cart(th,r)
 IMPLM=1;
 
 if IMPLM == 1
     th2=th*pi/180;
     x = r.*cos(th2);
     y = r.*sin(th2);
 end;
 
end