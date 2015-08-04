function dim = firstnonsing(varargin) % find first non singleton dimension
% DESCRIPTION dim = firstnonsing(a,b,c...)
%  Finds first non singleton dimension in any of the input arguments
%  if all arguments are scalars or empty then dim = 1;
% INPUT
%  a,b,c --  any number of matrices of any kind
% OUTPUT
%  dim -- The first non singleton dimension in any of the matrices 
% SEE ALSO 
%  firstsing
% TRY 
%  firstnonsing(rand(1,1,2), rand(1,2,2)) => 2

% by Magnus Almgren 031015

dims = find(maxsize(varargin{:})>1);
if isempty(dims)
 dim = 1;
else
 dim = dims(1);
end
% $Id: firstnonsing.m,v 1.1 2004/02/19 17:27:42 bogdant Exp $
