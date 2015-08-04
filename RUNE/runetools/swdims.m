function b = swdims(a, dims) 
% DESCRIPTION b = swdims(a, dims)
%  switch two dimensions of a matrix
% INPUT 
%  a  -- A matrix of any kind to operate on
%  dims -- The two dimensions
% OUTPUT
%  b -- The input matrix a where the two dimension have changed places.
% SEE ALSO 
%  permute
% TRY size(swdims(ones(1,2,3),[2 3]))

% by Magnus Almgren 981114 revised 040202

if diff(dims)==0
 b=a;
else
 d = 1:max(ndims(a), max(dims));
 temp = d(dims(1));
 d(dims(1)) = d(dims(2));
 d(dims(2)) = temp;
 b = permute(a,d);
end

% $Id: swdims.m,v 1.1 2004/02/19 17:27:45 bogdant Exp $
