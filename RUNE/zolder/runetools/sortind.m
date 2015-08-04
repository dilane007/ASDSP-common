function ind = sortind(varargin) 
% DESCRIPTION ind = sortind(x,[],dim)
%  As sort but keeps only index.
%  Calculates the index along dimension of the third argument,
%  otherwise along the first non-singleton dimension.
% INPUT
%  x --     any matrix
%  dim --   An integer > 0  indicating the dimension along which the operation will 
%           be performed. Inputs are the same as to sort.
% OUTPUT
%  ind --   Index along the dimension of the operation to the sort value.
% TRY 
%  sortind([2.3; 3.2]), sortind(rand(1,2,3),[],2)
% SEE ALSO 
%  sort, max, min, minind

% by Magnus Almgren 970525

[dum, ind] = sort(varargin{:});

