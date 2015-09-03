%FIXDIG Round towards zero with a specified number of digits.
%
%   Y = FIXDIG(X, N) rounds the elements of X to N digits.
%   For instance, fixdig(10*sqrt(2) + i*pi/10, 4) returns 14.14 + 0.3141i
%
%   See also: FIX, FLOOR, CEIL, ROUND, FIXDEC, ROUNDDIG, ROUNDDEC.

%   Author:      Peter J. Acklam
%   Time-stamp:  2003-10-14 00:56:09 +0200
%--------------------------------------------------------------------
%dfm was here
%--------------------------------------------------------------------
function z = fixdig(x, n)
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

   % Check size of input arguments and assign output argument.
   if ~scalar_x && ~scalar_n && ~isequal(size_x, size_n)
      error([ 'When both arguments are matrices they must have' ...
               ' the same size' ]);
   end

   % Real part of X.
   k = find(real(x));
   if ~isempty(k)
      xreal = real(x(k));
      m     = nextpowof10(xreal);
      if scalar_x                       % X is scalar.
         f = 10.^(n - m);
         z = fix(xreal .* f) ./ f;
      else
         z = zeros(size_x);
         if scalar_n                    % N is scalar, X is not.
            f = 10.^(n - m);
         else                           % Neither X nor N is scalar.
            f = 10.^(n(k) - m);
         end
         z(k) = fix(xreal .* f) ./ f;
      end
   end

   % Imaginary part of X.
   k = find(imag(x));
   if ~isempty(k)
      ximag = imag(x(k));
      m = nextpowof10(ximag);
      if scalar_x                       % X is scalar.
         f = 10.^(n - m);
         z = z + i*fix(ximag .* f) ./ f;
      else
         if scalar_n                    % N is scalar, X is not.
            f = 10.^(n - m);
         else                           % Neither X nor N is scalar.
            f = 10.^(n(k) - m);
         end
         z(k) = z(k) + i*fix(ximag .* f) ./ f;
      end
   end
end
