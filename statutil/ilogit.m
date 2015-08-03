%ILOGIT The inverse logit transformation.
%
%   The inverse tranformation maps the whole real line to the interval (0,1).
%   The tranformation is X = EXP(Y) / (1 + EXP(Y)).
%
%   See also LOGIT.

%   Author:      Peter J. Acklam
%   Time-stamp:  2003-11-04 10:30:15 +0100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function z = ilogit(x)
   t = exp(x);
   z = t ./ (1+t);
   k = isinf(x);
   if any(k(:)),  z(k) = x(k) > 0;   end;
end