function res = ndimsm(varargin) 
% DESCRIPTION res = ndimsm(a,b,...)
%  The number of dimensions of matrices
%  ndims(1) is 2 according to Math?works! In this routine it evaluates to 0.
%  Any empty matrix evaluates to -1 otherwise the last non singleton.
%  Dimension will determine the result. The result is a one row vector 
%  and any number of inputs will do.
% INPUT 
%  Any argument list
% OUTPUT 
%  res -- Integer indicating number of dimensions for each input argument.
% TRY 
%  ndimsm(1) => 0
%  ndimsm(ones(0,1,2)) => -1
%  ndimsm(ones(3,2,1)) => 2 

% by Magnus Almgren 970528

rsiz = size(varargin{1});

if any(rsiz==0)
 res = -1;   % empty matrix
elseif any(rsiz>1)
 res = max(find(rsiz>1));
else
 res = 0;    % the scalar case
 % This may seem a little bit odd but since
 % ones(1,1,2,1,1,...) has three dimensions,
 % ones(1,2,1,1,...) has two dimensions and
 % ones(2,1,1,...) has one dimension although ndims(ones(2,1,1,...)) => 2 
 % it is reasonable that
 % ones(1,1,...) has the dimension value set to zero.
 % Any empty matrix will then get the dimension value -1.
end

% if more input arguments
if nargin > 1
 res = [res ndimsm(varargin{2:end})];
end