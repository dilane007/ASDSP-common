function varargout = adjsizabdim(varargin)
% DESCRIPTION [a,b,c,...] = adjsizabdim(dim,a,b,c,...) 
%  will extend singleton dimensions of
%  each input argument to match the other arguments except for the dimension
%  dim where the sizes will remain the same as in the input arguments.
%  If dimensions are not singletons nor of the same size an error will occur.
%  It is also an error if any arguument is empty
% INPUT
%  dim -- the dimension along which no size expansion takes palce
%  a,b,c... -- input matrices that will be expadned to match each other
% OUTPUT
%  a,b,c -- matrices. Now all of the same size.
% TRY 
%  [a, b] = adjsizabdim(1,ones(2,1,3), ones(3,1,3))
% SEE ALSO
%  adjsiza, adjsiz

% by Magnus Almgren 030724 revised 040202
dim = varargin{1};
s = sizes(varargin{2:end}); % the sizes of all inputs in one matrix
s(:,dim) = 1; % adjust size for dimension dim only
maxs = max(s,[],1); % the size of output elements
check = s==1 | repmat(maxs,[size(s,1),1])-s==0; % singleton or maxsize?
if any(check(:)==0) | any(s(:)==0)
 error('Input arguments mismatch or empty')
end

for j = 1:max(1,nargout)  % go through all arguments
 % an error if number of input matrices to reshape 
 % are less than number of outputs 
 varargout{j} = repmat(varargin{j+1}, maxs./s(j,:)); % expand size to maxs
end

% $Id: adjsizabdim.m,v 1.1 2004/02/19 17:27:42 bogdant Exp $
