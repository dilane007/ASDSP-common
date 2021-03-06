function z = ndmtimes_loop_naive(x, y)
%NDMTIMES_LOOP_NAIVE N-dimensional matrix multiply.
%
%   NDMTIMES_LOOP_NAIVE(X, Y) is equivalent to X*Y except that the former is
%   vectorized along higher dimensions (dimensions three and above).
%
%   NDMTIMES_LOOP_NAIVE(X) is equlvalent to NDMTIMES_LOOP_NAIVE(X, X).
%
%   Example:
%
%      X = randn(4, 3, 6, 7, 1);
%      Y = randn(3, 5, 6, 1, 5);
%
%      Z1 = zeros(4, 5, 6, 7, 5);
%      for k = 1:5
%         for j = 1:7
%            for i = 1:6
%               Z1(:,:,i,j,k) = X(:,:,i,j,1) * Y(:,:,i,1,k);
%            end
%         end
%      end
%
%      Z2 = ndmtimes_loop_naive(X, Y);   % Z2 will be identical to Z1.
%
%   The matrix product is computed with a loop iterating over all the higher
%   dimensions of X and Y.
%
%   See also MTIMES.

%   Author:      Peter J. Acklam
%   Time-stamp:  2003-11-19 23:19:52 +0100
%   E-mail:      pjacklam@online.no
%   URL:         http://home.online.no/~pjacklam

   nargsin = nargin;
   error(nargchk(1, 2, nargsin));

   % Get the size of X
   sx = size(x);
   dx = ndims(x);

   if (nargsin == 1) | isequal(x, y)

      % See if the sizes match.
      if sx(2) ~= sx(1)
         error('Inner matrix dimensions must agree.');
      end

      % Create the size vector for Z and get the number of dimensions.
      sz = sx;
      dz = length(sz);

      % Initialize output array.
      z = zeros(sz);

      % Extract the vector with the size along the higher dimensions (dimensions
      % three and above)
      sz_hi = sz(3:dz);

      % Compute the number of matrix multiplications to do.
      nmult = prod(sz_hi);

      for k = 1 : nmult
         z(:,:,k) = x(:,:,k) * x(:,:,k);
      end

   else

      % Get the size of Y.
      sy = size(y);
      dy = ndims(y);

      % See if the sizes match.
      if sx(2) ~= sy(1)
         error('Inner matrix dimensions must agree.');
      end

      if (dx == 2) & (dy == 2)

         z = x * y;

      else

         % Pad size vectors for X and Y with trailing singleton dimensions (if
         % necessary) so they have the same length.
         sx = [sx, ones(1, dy-dx)];
         sy = [sy, ones(1, dx-dy)];

         % Create the size vector for Z and get the number of dimensions.
         sz = [sx(1), sy(2), max(sx(3:end), sy(3:end))];
         dz = length(sz);

         % Initialize output array.
         z = zeros(sz);

         % Extract vectors with the size along the higher dimensions (dimensions
         % three and above) of X, Y, and Z.
         sx_hi = sx(3:dz);
         sy_hi = sy(3:dz);
         sz_hi = sz(3:dz);

         % Compute the number of matrix multiplications to do.
         nmult = prod(sz_hi);

         for k = 1 : nmult

            % Convert the linear index K into a subscript vector into Z.
            z_sub = rem(fix((k-1) ./ cumprod([1, sz_hi(1:end-1)])), sz_hi) + 1;

            % Compute the subscript vectors into X and Y by "recycling".
            x_sub = 1 + rem(z_sub - 1, sx_hi);
            y_sub = 1 + rem(z_sub - 1, sy_hi);

            % Convert the subscript vectors for X and Y into linear indexes.
            x_idx = 1 + (x_sub-1) * cumprod([1, sx_hi(1:end-1)]).';
            y_idx = 1 + (y_sub-1) * cumprod([1, sy_hi(1:end-1)]).';

            % Now do the matrix multiplication.
            z(:,:,k) = x(:,:,x_idx) * y(:,:,y_idx);

         end

      end

   end
