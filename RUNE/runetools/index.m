function res = index(varargin)
% DESCRIPTION res = index(r,c,...,dims)
%  A flat index into a matrix.
%  The argument list contains index into each dimension of the matrix
%  (r,c,...) followed by the size of the matrix (dims).
%  Each dimension of the arguments must either have the same size 
%  or be a singleton. 
%  The last argument (dims) must at least have the length of the 
%  agument list minus two.
%  If any of the arguments is empty the result is an empty matrix.
% INPUT
%  r   -- index in first dimesion
%  c   -- index in second dimesion
%  .   -- index into thi...
% OUTPUT
%  res -- the liear index into a matrix of size dims
% SEE ALSO
%  index,sub2ind,ind2sub
% TRY 
%  index(1,2,[2 2]) => 3 
%  index(1,2,3,[2 2 4]) => 11
%  index(1,2,2) will give the result 3.
%  index((1:2)',1:2,[2 2])

% by Magnus Almgren 970401

% Make all but the last input variable into the same size.

% return [] if any input is empty
for i = 1:nargin-1
 if isempty(varargin{i})
  res = [];
  return
 end
end
v = adjsiz(varargin{1:end-1}); % expand matrices to the same size

% cumprod(dims) 
cisiz = cumprod(varargin{end}(1:nargin-2));

% compute the flat index
res = v{1};
for i = 2:nargin-1
 res = res + cisiz(i-1).*(v{i}-1); 
end

% $Id: index.m,v 1.1 2004/02/19 17:27:43 bogdant Exp $
