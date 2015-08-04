function s = mdiv(varargin) % generalized division
% DESCRIPTION s = mdiv(a,b)
%  Divides (./) variables of different sizes.
%  No warning if divide by zero.
%  Arguments are expanded to fit each other and then divided element by 
%  element. Expansion is made on singleton dimensions to fit the size 
%  of other arguments.
% INPUT
%  any two arguments of numeric matrices
% OUTPUT
%  s -- The ratio (./) of the inputs
% TRY
%  mdiv(ones(1,2),ones(2,1)), size(mdiv(ones(2,1),ones(2,3,4)))
%  Compare 0/0 with mdiv(0,0)
% SEE ALSO
%  mplus,mprod,mexp,adjsiz,adjsiza

% by Magnus Almgren 000517

v = adjsiz(varargin{:});
warning off
s = v{1}./v{2};
warning on
% $Id: mdiv.m,v 1.1 2004/02/19 17:27:44 bogdant Exp $
