function s = mdiv(varargin) % multiplies a number of argument
% DESCRIPTION s = mdiv(a,b,c,...)
%  Divides (.*) varables of different sizes.
%  No warning if divide by zero.
%  Arguments are expanded to fit each other and then added together.
%  Expansion is made on singleton dimensions to fit the size of other.
% INPUT
%  any two arguments of numeric matrices
% OUTPUT
%  s -- The ratio (./) of the inputs
% TRY
%  mdiv(ones(2,1),ones(1,2)), size(mdiv(ones(2,1),ones(2,3,4)))
% SEE ALSO
%  mprod,mplus,adjsiz,adjsiza

% by Magnus Almgren 000517

v = adjsiz(varargin{:});
warning off
s = v{1}./v{2};
warning on