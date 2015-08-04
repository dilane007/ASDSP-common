function bind = ismax(x,dim)
% DESCRIPTION bind = ismax(x,dim)
%  Calculates a binary matrix pointing to the maximum element 
%  in that dimension ,
%  otherwise along the first non-singleton dimension.
% INPUT 
%  x --    any matrix
%  dim --  the dimension along which the operation will be performed.
% OUTPUT 
%  bind --  Binary matrix pointing to the max value in dimension dim.
% TRY
%  ismax([2.3; 3.2]),ismax(rand(5,6),2)
% SEE ALSO 
%  max, maxind, minind

% by Magnus Almgren 011023
if ~exist('dim','var') % defauld dimension dim
 dims = find(sizem(x)>1);
 if isempty(dims)
  dim = 1;
 else
  dim = dims(1);
 end
end
[dummy, ind] = max(x,[],dim); 
bind = zeros(size(x));
bind(index1(ind,dim,size(x))) = 1;
bind = logical(bind);