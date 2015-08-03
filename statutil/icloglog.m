%ICLOGLOG The inverse complementary log log transformation.
%
%   The inverse tranformation maps the whole real line to the interval (0,1).
%   The tranformation is X = 1 - EXP(-EXP(Y)).
%
%   See also CLOGLOG.
%   Author:      Peter J. Acklam
%   Time-stamp:  2003-11-04 10:45:38 +0100
function x = icloglog(y)
   x = 1 - exp(-exp(y));
end
