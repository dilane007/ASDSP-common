function z = rounddig(x, n)
%ROUNDDIG Round to a specified number of digits.
%
%   Y = ROUNDDIG(X, N) rounds the elements of X to N digits.
%   For instance, rounddig(10*sqrt(2) + i*pi/10, 4) returns 14.14 + 0.3142i
%   See also: ROUND, FIX, FLOOR, CEIL, ROUNDDEC, TRUNCDIG, TRUNCDEC.
%   Author:      Peter J. Acklam
%   Time-stamp:  2003-10-14 00:56:10 +0200
%--------------------------------------------------------------------
%dfm was here
%<13jun2015> [FREEM] fails on direct indexing ones expansion   x = x(*ones(size_x)); 
%                    as it always return a col instead of size_x
%--------------------------------------------------------------------
TOOL= 'FMAT';
   if strcmp(TOOL,'MLAB')
       error(nargchk(2, 2, nargin));
       if isempty(x) || isempty(n)
           z = [];
           return
       end
   end

   % Get size of input arguments.
   size_x   = size(x);
   size_n   = size(n);
   scalar_x = all(size_x == 1);         % True if x is a scalar.
   scalar_n = all(size_n == 1);         % True if n is a scalar.

   % Check size of input arguments and expand if necessary.
   if scalar_x
      if ~scalar_n                      % X is scalar, N is not.
         if strcmp(TOOL,'MLAB')
             x = x(ones(size_n));           % Expand x.
         else
             x = x.*ones(size_n);           % Expand x.
         end;
         size_x = size_n;
         scalar_x = 0;
      end
   else
      if scalar_n                       % N is scalar, X is not.
         if strcmp(TOOL,'MLAB')
             n = n(ones(size_x));           % Expand x.
         else
             n = n.*ones(size_x);           % Expand x.
         end;
         size_n = size_x;
         scalar_n = 0;
      else                              % Neither X nor N is scalar.
         if ~isequal(size_x, size_n)
            error(['When both arguments are matrices they must have the same size']);
         end
      end
   end

   % Initialize output array.
   z = zeros(size(x));

   % Real part of X.
   t = real(x);                 % Get the real part.
   k = find(t);                 % Find indices of non-zero elements.
   if ~isempty(k);
      t = t(k);
      m = nextpowof10(abs(t));
      e = n(k) - m;

      j = e >= 0;
      f = 10.^e(j);
      z(k(j)) = round( t(j) .* f ) ./ f;

      j = ~j;
      f = 10.^(-e(j));
      z(k(j)) = round( t(j) ./ f ) .* f;
   end

   % Imaginary part of X.
   t = imag(x);
   k = find(t);
   if ~isempty(k)
      t = t(k);
      m = nextpowof10(abs(t));
      e = n(k)-m;

      j = e >= 0;
      f = 10.^e(j);
      z(k(j)) = y(k(j)) + i*round( t(j) .* f ) ./ f;

      j = ~j;
      f = 10.^(-e(j));
      z(k(j)) = y(k(j)) + i*round( t(j) ./ f ) .* f;
   end
