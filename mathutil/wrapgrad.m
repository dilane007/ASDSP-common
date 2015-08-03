%WRAPGRAD Map angles measured in gradians to the interval [-200,200).
%
%   B = WRAPGRAD(A) maps the angles in A to their equivalent in the interval
%   [-200,200) by adding or subtracting the appropriate multiple of 400.
%
%   See also WRAPRAD, WRAPDEG, UNWRAP.

%   Author:      Peter J. Acklam
%   Time-stamp:  2004-02-19 12:42:51 +0100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function b = wrapgrad(a)

   % check array class
   if ~isnumeric(a)
      error('Input must be a numeric array.');
   end

   b = a - 400 * floor((a + 200) / 400);
end