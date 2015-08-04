function indo = wrapind(indi, siz)
% DESCRIPTION indo = wrapind(indi, siz)
%  Wraps or folds indo back to the range
%  1:size in a cyclic fashion.
%  wrapind([-1 0 1 2 3 4], 3) => [2 3 1 2 3 1]
%  Both input arguments are rounded before usage.
% INPUT 
%  indi -- Any real matrix of any size.
%  siz --  A scalar value not exceeded of the output. It must be >=0.5.
% OUTPUT
%  indo -- the folded version of indo. Has the same size as indi
% SEE ALSO
%  mod, floor, round, ceil
% TRY
%  wrapind([-1 0 1 2 3 4], 3)

% by Magnus Almgren 951104

indo = round( mod(indi-0.5, round(siz) ) + 0.5);

% $Id: wrapind.m,v 1.2 2004/03/15 14:25:37 bogdant Exp $
