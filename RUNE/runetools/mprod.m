function s = mprod(varargin) % multiplies a number of argument
% DESCRIPTION s = mprod(a,b,c,...)
%  Multiplies (.*) variables of different sizes.
%  Arguments are expanded to fit each other and then multiplied together
%  element by element. Expansion is made on singleton dimensions to fit
%  the size of other arguments.
% INPUT
%  Any input argument list of numeric matrices.
% OUTPUT
%  s -- The product (.*) of the inputs
% TRY
%  mprod(ones(2,1),ones(1,2)), size(mprod(ones(2,1),ones(2,3,4)))
% SEE ALSO 
%  mplus,mdiv,mexp,adjsiz,adjsiza

% by Magnus Almgren 990317

v = adjsiz(varargin{:});
s = v{1};
for i=2:length(v)
 s = s.*v{i};
end
  
% $Id: mprod.m,v 1.1 2004/02/19 17:27:44 bogdant Exp $
