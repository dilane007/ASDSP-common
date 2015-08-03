% z= range(x, dim)
% Return the range of the elements of an array.
%   For vectors, RANGE(X) is the range of the elements of X, i.e., MAX(X) - MIN(X).
%   For matrices, RANGE(X) is a row vector containing the range of each column.
%   In general, RANGE(X) is the range along the first non-singleton dimension of X.
%
%   The range is the difference between the maximum and minimum values.
%   See also MAX, MIN.
%   Author:      Peter J. Acklam
%   Time-stamp:  2003-11-04 10:55:05 +0100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
% nargchk suppressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dfm was here
function z= range(x, dim)
   % get first non-singleton dimension, or 1 if none found
   if nargin < 2
      k = find(size(x) ~= 1);
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

   % compute the range
   z= max(x, [], dim) - min(x, [], dim);
end