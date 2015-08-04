function ind = indpart(dimb, dims)
% DESCRIPTION ind = indpart(dims, dimb)
%  Calculates index from a smaller matrix into a bigger.
% INPUT
%  dims --  The size of the smaller matrix.
%  dimb --  The size of the bigger matrix.
% OUTPUT
%  ind --   An index in the first dimension.
% TRY
%  indpart(size(ones(3,2)),size(ones(1,2)))

% by Magnus Almgren 981001

for j = 1:length(dims)
 v{j}=flatten(1:dims(j),j);
end
v{length(dims)+1} = dimb;
ind = flatten(index(v{:}));