%LOGIT  The logit transformation.
%
%   The logit tranformation maps the interval (0,1) to the whole real line.
%   The transformation is Y = LOG(X / (1 - X)).
%
%   See also ILOGIT.

%   Author:      Peter J. Acklam
%   Time-stamp:  2003-11-04 10:42:55 +0100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function y = logit(x)

   y = zeros(size(x));
   y(:) = NaN;

   % Case when 0 < X and X < 1:
   i = (0 < x) & (x < 1);
   if any(i(:))
      y(i) = log(x(i) ./ (1 - x(i)));
   end

   % Case when X = 0:
   i = x == 0;
   if any(i(:))
      y(i) = -Inf;
   end

   % Case when X = 1:
   i = x == 1;
   if any(i(:))
      y(i) = Inf;
   end

end