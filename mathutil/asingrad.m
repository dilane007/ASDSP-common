%ASINGRAD Inverse sine with gradians as unit.
%
%   ASINGRAD(X) is the arcsine of the elements of X, when the unit is gradians.
%
%   See also ASIN, ASINDEG, SIN, SINGRAD.

%   Author:      Peter J. Acklam
%   Time-stamp:  2004-02-19 18:25:23 +0100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function y = asingrad(x)
   if ~isnumeric(x)
      error('Input must be a numeric array.');
   end

   y = (200 / pi) * asin(x);
end