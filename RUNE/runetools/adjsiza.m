function varargout = adjsiza(varargin)
% DESCRIPTION [a,b,...] = adjsiza(a,b,...) 
%  Will extend singleton dimensions on each input argument to match
%  the size of the other arguments. If dimensions are not singletons
%  nor of the same size as the rest of the inputs, an error will occur.
%  It is also an error if any argument is empty. The result is matrices
%  of the same size.
% INPUT
%  any number of matrices
% OUTPUT
%  one matrix for each input all of the same size
% TRY 
%  [a, b] = adjsiza(ones(1,1,2,2), ones(1,2,2,1)) => size(a)==size(b)
% SEE ALSO
%  adjsiz, adjsizabdim

% by Magnus Almgren 990714  heavily revised 040202 by MA

s = sizes(varargin{1:end}); % the sizes of all inputs in one matrix
maxs = max(s,[],1); % the size of output elements
check = s==1 | repmat(maxs,[size(s,1),1])-s==0; % singleton or maxsize?
if any(check(:)==0) | any(s(:)==0)
 error('Input arguments mismatch or empty')
end

for j = 1:max(1,nargout)  % go through all arguments
 % an error if number of input matrices to reshape 
 % are less than number of outputs 
 varargout{j} = repmat(varargin{j}, maxs./s(j,:)); % expand size to maxs
end

% $Id: adjsiza.m,v 1.1 2004/02/19 17:27:42 bogdant Exp $
