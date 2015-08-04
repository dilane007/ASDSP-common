function b = swdims(a, ft) % switch two dimensions of a matrix
% function b = swdims(a, ft) first arg is any matrix 
% second argunent specifies two dimensions that will sitch places
% in the first argument
% TRY size(swdims(ones(1,2,3),[2 3]))

% by Magnus Almgren 981114

if diff(ft)==0
 b=a;
else
 d = 1:max(ndimsm(a), max(ft));
 temp = d(ft(1));
 d(ft(1)) = d(ft(2));
 d(ft(2)) = temp;
 b = permute(a,d);
end