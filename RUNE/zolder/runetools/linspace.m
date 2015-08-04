function y = linspace(d1, d2, n)
% DESCRIPTION y = linspace(d1, d2, n)
%  Fixes of mathworks mistakes of not handling complex
%  or equal end points.
% INPUT
%  d1 -- start point
%  d2 -- end point
%  n  -- number of elements
% OUTPUT
%  y  -- A vector in second dimension with n elements,
%        where the first element is d1 and the last d2.
%        The rest of the elemnts are equally spaced in between.
% SEE ALSO
%  the original linspace, logspace

%   by Magnus Almgren 980508

if nargin == 2
    n = 100;
end
n = round(n);   
if n>=2
 y = [d1 d1+cumsum((d2-d1)./(n-1)+zeros(1,n-1))];
elseif n ==1
 y = d2;
else
 y = [];
end
