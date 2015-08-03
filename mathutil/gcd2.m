%GCD2 Greatest common divisor of all elements.
%
%   GCD2(X) is the greatest common divisor of all elements in X.
%
%   See also GCD, LCM, LCMALL.
%   Author:      Peter J. Acklam
%   Time-stamp:  2004-02-09 18:31:56 +0100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
% commented out with [FREEM]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function g = gcd2(x)
   % Check array values.
   if ~isreal(x)
      error('Argument must be a numeric and real array.');
   end

%[FREEM]    % Any NaN or +/-Inf in input gives NaN output.
%    if any(~isfinite(x))
%       g = NaN;
%       return;
%    end

   % Check the finite elements.
   if ~isequal(x, round(x))
      error('All finite elements must be real integers.');
   end;

   % Now find greatest common divisor.
   n = prod(size(x));
   g = 0;
   for i = 1 : n
      g = gcd(g, x(i));
      if g == 1
         break;
      end;
   end;

end