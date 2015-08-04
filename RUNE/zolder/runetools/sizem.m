function s = sizem(m, dims)
% DESCRIPTION res = sizem(m, dims) 
%  For a matrix m the size is given for each element of dims.
%  Dims is the dimensions for which the size is determined.
%  If dims is omitted then the size of all dimensions of m are delivered.
% INPUT 
%  m --    A matrix of any size.
%  dims -- A vector with index number to dimensions. 
% OUTPUT 
%  res --  The coresponding sizes. 
% TRY 
%  sizem(ones(2,3,4)) => [2 3 4]
%  sizem(ones(2,3,4), [2 3]) => [3 4]
% SEE ALSO 
%  size, ndimsm

% by Magnus Almgren 970529

s = size(m);
if prod(s) == 0
  s = 0;
elseif length(s) == 2 & s(2) == 1
  s = s(1);
end
if nargin > 1
  if any(dims<1)
    error('Dimensions must be non-negative integers.')
  else
    stemp = [s 1];
    s = stemp(min(length(stemp), dims));
  end
end
