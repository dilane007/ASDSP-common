function res = gcd1(a)
% DESCRIPTION res = gcd1(a)
%  Greatest common divisor for each column of any non empty matrix
%  with integer values. 
% INPUT
%  a --    Any non integer matrix.
% OUTPUT
%  res --  A vector with one element for each column,
%          containing the greatest common divisor for that column.
% TRY
%  gcd1([5; 30]) or gcd1([2*3*4 3*5 2*3]')
% SEE ALSO
%  gcd
 
% by Magnus Almgren 991101

if isempty(a)
 res = a;
 return;  %DFM modified
end
r = a(1,:); 
for i = 1:size(a,1);
 r = gcd(r,a(i,:));
end
res = reshape(r,size(a(1,:)));  