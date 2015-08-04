function y = qfunc(x);
% y = qfunc(x)
% Q funtion Q(x) is 1/2 erfc ( x/sqrt(2) )
% INPUT
%  x -- A matrix of any size.
% SEE ALSO erfc
y=0.5*erfc(x/sqrt(2));
