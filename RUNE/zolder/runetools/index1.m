function flind = index1(ind,dim,siz)
% function flind = index1(ind,dim,siz)
% calculates flat index into a matrix 
% can reorder in one specific dimension

% by Magnus Almgren 990603
for i = 1:length(siz)
 v{i} = flatten((1:siz(i)),i);
end
v{dim} = ind;
v{length(siz)+1} = siz;
flind = index(v{:});