%LOGSPACE2 Logarithmically spaced vector.
%
%   LOGSPACE2(d1, d2) generates a row vector of 100 logarithmically equally
%   spaced points between 2^d1 and 2^d2.
%
%   LOGSPACE2(d1, d2, N) generates N points.

%   Author:      Peter J. Acklam
%   Time-stamp:  2003-10-13 15:17:02 +0200
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function y = logspace2(d1, d2, n)
   if nargin < 3
      n = 100;
   end
   y = pow2([d1 + (0:n-2)*(d2-d1)/(n-1), d2]);
end