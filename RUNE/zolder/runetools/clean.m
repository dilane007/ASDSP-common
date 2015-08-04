function res = clean(a)
% DESCRIPTION res = clean(a)
%  Keeps only finite values of vector a.
% INPUT
%  a --   any vector
% OUTPUT
%  res --  A vector spanning the same dimension as the input,
%         but with all non finite elements removed.
% TRY
%  clean([nan 3 nan 2 inf])

% by Magnus Almgren 951104

res = a(finite(a));

