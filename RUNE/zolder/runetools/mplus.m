function s = mplus(varargin) 
% DESCRIPTION s = mplus(a,b,c,...)
%  Adds variables of different sizes.
%  Arguments are expanded to fit each other and then added together.
%  Expansion is made on singleton dimensions to fit the size of other.
% INPUT 
%  Any list of numeric matrices, that have equal or different size.
%  If the latter, the dimension which should be expanded to receive
%  equal sizes must be singleton. For example: A 3-by-2 and a 2-by-3
%  matrix does not work, but a 3-by-2 and a 3-by-1 works fine.
% OUTPUT
%  s --  Sum of the expanded inputs.
% TRY 
%  mplus(ones(2,1),ones(1,2)), size(mplus(ones(2,1),ones(2,3,4)))
% SEE ALSO 
%  mprod,adjsiz,adjsiza

% by Magnus Almgren 990317

v = adjsiz(varargin{:});
s = v{1};
for i=2:length(v)
   s = s+v{i};
end

