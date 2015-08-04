function res = index(varargin)
% DESCRIPTION res = index(r,c,...,dims)
%  A flat index into a matrix.
%  The argument list contains index into each dimension of the matrix
%  (r,c,...) followed by the size of the matrix (dims).
%  Each dimension of the arguments must either have the same size 
%  or be a singleton. 
%  The last argument (dims) must at least have the length of the 
%  agument list minus two.
%  If any of the arguments are empty the result is an empty matrix.
% TRY 
%  index(1,2,[2 2]) => 3 
%  index(1,2,3,[2 2 4]) => 11
%  index(1,2,2) will give the result 3.
%  index((1:2)',1:2,[2 2])

% by Magnus Almgren 970401

% Make all but the last input variable into the same size.
if min(ndimsm(varargin{1:end-1}))>-1; % no empty indices 
 v = adjsiz(varargin{1:end-1});
 
 % cumprod(dims) 
 cisiz = cumprod(varargin{end}(1:nargin-2));
 
 res = v{1};
 for i = 2:nargin-1
  res = res + cisiz(i-1).*(v{i}-1); 
 end
else
 res = [];
end
