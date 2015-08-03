function [x,y,th2] = pold2cart(th,r)
%POL2CART Transform polar to Cartesian coordinates.
%   [X,Y] = POL2CART(TH,R) transforms corresponding elements of data
%   stored in polar coordinates (angle TH, radius R) to Cartesian
%   coordinates X,Y.  The arrays TH and R must the same size (or
%   either can be scalar).  TH must be in degrees.
%
%-----------------------------------------------------------------------
th2=th*pi/180;
x = r.*cos(th2);
y = r.*sin(th2);
