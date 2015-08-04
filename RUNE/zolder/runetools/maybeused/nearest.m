function vn = nearest(v,vsel) % select nearest element of v
% function vn = nearest(v,vsel) For each element of v select the closest 
% element in vsel. Input is of any size and size of v is preserved to output
% vsel must have finite values but but not in any specific order
% Try nearest(rand(2,2,2),[0 1]), nearest(0:0.5:1,0:1)

% by Magnus Almgren 990317
if isempty(v) | isempty(vsel)
 vn = [];
else
 % a problem here when vsel happens to be -inf or inf
 v = max(v,min(vsel(:))); % nearest(-inf,[0 1]) would cause a problem
 
 % turn vsel upside down to get rounding correct in the case when
 % vsel is ascending
 vself = vsel(end:-1:1); % make vsel point in that dimension
 v1 = vself(minind(abs(mplus(v(:).', -vself(:))),[],1)); % select closest
 vn = reshape(v1,size(v)); % back to original size
end
