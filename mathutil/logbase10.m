%LOGBASE10  Base 10 log (more accurate than LOG10).
%   LOGBASE10(X) is the base 10 logarithm of the elements of X.
%   LOGBASE10 is the same as LOG10 except that the former returns a more
%    accurate result.  For instance, LOG10(1000) does not return exactly 3,
%    whereas LOGBASE10 does.
%   See also LOG10, LOG, LOG2, EXP.

%   Author:      Peter J. Acklam
%   Time-stamp:  2003-10-13 14:58:24 +0200
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function y = logbase10(x)
   log_of_ten = log(10);
   y = log(x) ./ log_of_ten;                    % predictor
   y = y - log(10.^y ./ x) ./ log_of_ten;       % corrector
end