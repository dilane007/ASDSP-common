%PRCOFTOT Percent of total.
%
%   PRCOFTOT(A, B) computes the percentage that B is relative to A.
%
%   Author:      Peter J. Acklam
%   Time-stamp:  2003-10-13 14:28:32 +0200
%   E-mail:      pjacklam@online.no
%   URL:         http://home.online.no/~pjacklam
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function prc = prcoftot(a, b)
   i = ~a;          % true when a is zero
   % use an adjusted denominator to avoid "division by zero" error
   a(i) = 1;
   prc = 100 * b ./ a;
   prc(i) = sign(b(i)) * Inf;           % when a = 0
end