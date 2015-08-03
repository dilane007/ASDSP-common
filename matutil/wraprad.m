%WRAPRAD Map angles measured in radians to the interval [-pi,pi).
%
%   B = WRAPRAD(A) maps the angles in A to their equivalent in the interval
%   [-pi,pi) by adding or subtracting the appropriate multiple of 2*pi.
%
%   See also WRAPDEG, WRAPGRAD, UNWRAPDEG, UNWRAP.

%   Author:      Peter J. Acklam
%   Time-stamp:  2003-10-13 14:27:25 +0200
%   E-mail:      pjacklam@online.no
%   URL:         http://home.online.no/~pjacklam
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function b = wraprad(a)
   PI = pi;
   TWOPI = 2*PI;

   b = a - TWOPI * floor((a + PI) / TWOPI);
end