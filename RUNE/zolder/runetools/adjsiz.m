function v = adjsiz(varargin)
% DESCRIPTION cellarr = adjsiz(a,b,...) 
%  Will extend singleton dimensions on each input argument to match
%  the size of the other arguments. If dimensions are not singletons
%  nor of the same size an error will occur. It is also an error
%  if any argument is empty. The result is matrices of the same size.
% INPUT 
%  any number of matrices
% OUTPUT 
%  v --  A cellarray with one matrix for each input, 
%        all of the same size
% TRY 
%  a = adjsiz(ones(1,1,2,2), ones(1,2,2,1)) => size(a{1})==size(a{2})
% SEE ALSO
%  adjsiza, mplus, mprod

% by Magnus Almgren 990714

% Take chance on size otherwise a reallocation will take place.
dim = zeros(nargin,4); % The dimensions are hopefully not more than 4. 
for j = 1:nargin 
 siz = size(varargin{j})-1;
 dim(j,1:length(siz)) = siz; % Store row by row.
end
dim = dim+1;
% Make a matrix out of max size vector.
mdim = repmat(max(dim,[],1), [size(dim,1) 1]); 
% error if zero or (not 1 and not max)
errv = (dim==0) | ((dim~=1) & (dim~=mdim));
if any(errv(:))
 error('Input arguments mismatch or empty')
end
repdim = mdim./dim; % values to expand inputs with  
for j = 1:nargin  % Go through all arguments.
  v{j} = repmat(varargin{j}, repdim(j,:));
end
