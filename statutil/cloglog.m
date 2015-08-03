%Y = LOG(-LOG(1 - X))
%CLOGLOG The complementary log log transformation.
%
%   The complementary log log transformation tranformation maps the interval
%   (0,1) to the whole real line.  .
%
%   See also ICLOGLOG.

%   Author:      Peter J. Acklam
%   Time-stamp:  2003-11-04 10:51:45 +0100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% cosmetics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function y = cloglog( x )
   y = zeros(size(x));
   y(:) = NaN;

   % Case when 0 < X and X < 1:
   i = (0 < x) & (x < 1);
   if any(i(:)),   y(i) = log(-log(1 - x(i)));   end

   % Case when X = 0:
   i = x == 0;
   if any(i(:)),      y(i) = -Inf;   end

   % Case when X = 1:
   i = x == 1;
   if any(i(:)),      y(i) = Inf;   end;

end