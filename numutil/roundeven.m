%ROUNDEVEN Round towards nearest integer (pick even in .5 cases)
%   ROUNDEVEN(X) rounds the elements of X to the nearest integer.  In cases
%   where the fractional part is .5, the results is rounded to the nearest even integer.
%--------------------------------------------------------------------
%   Author:      Peter J. Acklam
%   Time-stamp:  2002-03-03 13:18:38 +0100
%--------------------------------------------------------------------
%dfm was here
%--------------------------------------------------------------------
function z = roundeven(x)
   % do the real part of x
   xr = real(x);
   yr = round(xr);
   kindex = (xr - floor(xr)) == 0.5 & rem(yr, 2);
   yr(kindex) = fix(xr(kindex));
   if isreal(x)
      z = yr;
   else
      % do the imaginary part of x
      xi  = imag(x);
      yi  = round(xi);
      kindex   = (xi - floor(xi)) == 0.5 & rem(yi, 2);
      yi(kindex) = fix(xi(kindex));
      % build complex output
      z = complex(yr, yi);
   end
end