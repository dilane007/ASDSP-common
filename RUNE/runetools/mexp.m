function s = mexp(varargin) % generaliized .^
% DESCRIPTION s = mexp(a,b)
%  raises a (.^) to b although different sizes.
%  Arguments are expanded to fit each other and then rasied
%  Expansion is made on singleton dimensions to fit the size of other argument.
% INPUT
%  any two arguments of numeric matrices
% OUTPUT
%  s -- a.^b
% TRY
%  mexp(2,1:8), mexp((0:4)',0:5), size(mexp(ones(2,1),ones(2,3,4)))
% SEE ALSO
%  mprod,mplus,mdiv,adjsiz,adjsiza

% by Magnus Almgren 010930 revised 031012

% If one of the arguments is an empty matrix that argument is returned
% If they both are empty they must be of the same size though
% This is inline with the odd syntax of matlab
if isempty(varargin{1}) | isempty(varargin{1})
 v = varargin{1} + varargin{1};
 return
end
 
v = adjsiz(varargin{:});
s = v{1}.^v{2};
 
% $Id: mexp.m,v 1.1 2004/02/19 17:27:44 bogdant Exp $
