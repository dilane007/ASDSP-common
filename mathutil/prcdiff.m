%PRCDIFF Percent difference.
%
%   PRCDIFF(A, B) computes the percent difference between A and B.  That is,
%   the difference in percent between A and B relative to A.
%
%   Author:      Peter J. Acklam
%   Time-stamp:  2003-10-13 14:28:03 +0200
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function prc = prcdiff(a, b)
   i = ~a;          % true when a is zero
   j = ~b;          % true when b is zero

   % use an adjusted denominator to avoid "division by zero" error
   c = a;
   c(i) = 1;

   prc = 100 * (b - a) ./ c;

   prc(i &  j) = NaN;                           % when a = 0 and b = 0
   prc(i & ~j) = sign(b(i & ~j)) * Inf;         % when a = 0 and b ~= 0
end