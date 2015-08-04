function flind = index1(ind,dim,siz)
% DESCRIPTION flind = index1(ind,dim,siz)
% Calculates flat index into a matrix 
% with reordering in one specific dimension
% INPUT 
%  ind --  any matrix with indices in dimension dim.
%  dim --  the dimension along which the operation will be performed.
%  siz --  size of the matrix to which the index willbe applied.
% OUTPUT 
%  flind -- index into a matrix of size siz.
% TRY
%  index1([1 2],1,[2 2])
%  index1([1 2 3]',1,[2 2])
% SEE ALSO 
%  index,sub2ind,ind2sub

% by Magnus Almgren 011023
for i = 1:length(siz)
 v{i} = flatten((1:siz(i)),i);
end
v{dim} = ind;
v{length(siz)+1} = siz;
flind = index(v{:});

% $Id: index1.m,v 1.1 2004/02/19 17:27:43 bogdant Exp $
