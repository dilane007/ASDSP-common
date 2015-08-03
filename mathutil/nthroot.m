%NTHROOT Compute the n-th root of a real number.
%  Z= NTHROOT(X, N) returns the Nth root of the elements of X.  
% X and N must be real, and when X is negative, N must be an odd integer.
  % Step 1
   % Depending on which way N converges to zero, the expression X^(1/N) converges
   % to different values, so output must be NaN whenever N is zero.  
   % The output is also NaN whenever N or X is NaN.
  % Step 2
   % Correct numerical errors (since, e.g., 64^(1/3) is not exactly 4) by one iteration of Newton's method.
   % Skip NaNs and +/-Infs in Z and X.  
   % Also skip the case when Z = 0; it would cause a divide by zero warning.
%   See also POWER.
%   Author:      Peter J. Acklam
%   Time-stamp:  2004-02-08 13:07:10 +0100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
% isfinite replaced by isreal
% corrected bug on extending n when scalar; it was using the wrong flag (x flag)
% dfm cosmetics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function z = nthroot(x, n)
   % Check array size consistency.
   % Get the size of the input arrays.  Delay replication (scalar expansion) of
   % input arguments until after we have checked the array values, but remember
   % which variables that must be replicated.  Also get size of output array.
   %

   sx = size(x)
   sn = size(n)

   do_rep_x = false;            % should X be replicated?
   do_rep_n = false;            % should N be replicated?

   if any(sx ~= 1)
      if any(sn ~= 1)
         % X and N are both non-scalar
         if ~isequal(sx, sn)
            error(['When X and N both are non-scalars, ' ...
                   'they must have the same size.']);
         end;
      else
         % X is non-scalar, N is scalar, so replicate N
         do_rep_n = true
      end;
      sz = sx;
   else
      if any(sn ~= 1)
         % X is scalar, N is non-scalar, so remember to replicate X
         do_rep_x = true;
      else         % X and N are both scalar
      end;
      sz = sn;
   end;

   %
   % Check array values.
   %
   if ~isreal(x) | ~isreal(n)
      error('Both X and N must be real.');
   end

   if any((x(:) < 0) & mod(n(:), 2) ~= 1) & (x(:) ~= 0)
      error('When X is negative, N must be an odd integer or zero.');
   end

   %
   % Replicate variable if required.
   %
   if  do_rep_x ,  x = repmat(x, sz);end;
   if  do_rep_n,   n = repmat(n, sz);end;
   
   % Initialize output.
   y = repmat(NaN, sz);
   % Step 1
   k = (n ~= 0) & ~isnan(n) & ~isnan(x);
   z(k) = sign(x(k)) .* abs(x(k)).^(1 ./ n(k));
   % Step 2
   k = isreal(z) & isreal(n) & (z ~= 0);
   z(k) = z(k) - (z(k).^n(k) - x(k)) ./ (n(k) .* z(k).^(n(k) - 1));
end