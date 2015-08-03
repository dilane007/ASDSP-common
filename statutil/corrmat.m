%CORRMAT Correlation matrix.
%
%   R = CORRMAT(X) returns the correlation matrix of the data in X.  If X is
%   N-by-P, then R is P-by-P.  R has ones on the main diagonal and values in
%   the range [-1,1] everywhere else.

%   Author:      Peter J. Acklam
%   Time-stamp:  2002-09-26 08:20:48 +0200
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function R = corrmat(X)
   S = varmat(X);       % get variance matrix
   R = var2corr(S);     % convert variance matrix to correlation matrix
end