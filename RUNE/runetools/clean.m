function res = clean(a)
% DESCRIPTION res = clean(a)
%  Keeps only finite values of matrix a.
% INPUT
%  a --   any matrix
% OUTPUT
%  res --  A vector spanning the first dimension
%          with all non finite elements removed.
%          Non finite elements are NaN and Inf
% TRY
%  clean([nan 3 nan 2 inf])

% by Magnus Almgren 951104 revised 040202

res = flatten(a(isfinite(a)));


% $Id: clean.m,v 1.1 2004/02/19 17:27:42 bogdant Exp $
