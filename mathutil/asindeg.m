%ASINDEG Inverse sine with degrees as unit.
%
%   ASINDEG(X) is the arcsine of the elements of X, when the unit is degrees.
%
%   See also ASIN, ASINGRAD, SIN, SINDEG.

%   Author:      Peter J. Acklam
%   Time-stamp:  2004-02-19 18:25:23 +0100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function y = asindeg(x)
   % check array class
   if ~isnumeric(x)
      error('Input must be a numeric array.');
   end

   y = (180 / pi) * asin(x);
end