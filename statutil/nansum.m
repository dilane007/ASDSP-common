%NANSUM Sum of elements ignoring NaNs.
%
%   For vectors, NANSUM(X) is the sum of the elements in X, ignoring NaNs,
%   i.e., SUM(X(~ISNAN(X))).
%
%   For matrices, NANSUM(X) is a row vector containing the NANSUM value of
%   each column.
%
%   In general, NANSUM(X) is the NANSUM value of the elements along the
%   first non-singleton dimension of X.
%
%   NANSUM(X,DIM) is the NANSUM value along the dimension DIM of X.
%
%   See also MEAN, STD, MIN, MAX, COV.

%   Author:      Peter J. Acklam
%   Time-stamp:  2001-07-07 22:58:23 +0200
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
% bug corrected; m instead of z was returned
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function z = nansum(x, dim)
   sx = size(x);
   dx = ndims(x);

   % get first non-singleton dimension, or 1 if none found
   if nargin < 2
      k = find(sx ~= 1);
         if isempty(k)
         dim = 1;
      else
         dim = k(1);
      end
   else
      if any(size(dim) ~= 1) | dim < 1 | dim ~= round(dim)
         error('Dimension must be a scalar positive integer.');
      end
   end

   n = size(x, dim);

   % replace NaNs with zeros
   x(isnan(x)) = 0;

   % degenerate case
   if isempty(x)
      sy = sx;
      if dim <= dx
         sy(dim) = 1;
      end
      y = zeros(sy);
      return;
   end
   % compute sum along dimension `dim'
   z= sum(x, dim);
end