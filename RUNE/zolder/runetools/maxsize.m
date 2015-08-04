function res = maxsize(varargin)
% DESCRIPTION res = maxsize(a,b,c,...)
%  Takes any number of inputs and 
%  leaves the maximum size for all of them.
% INPUT
%  an argument list with variables of different sizes
% OUTPUT
%  res --  A vector indicating the maximum size needed
%          in order to contain any of the inputs.
% TRY
%  maxsize(ones(1,2,3), ones(2,1,3,4))

% by Magnus Almgren 970527

% create a vector with the right length to keep the result
res = zeros(1, max(max(ndimsm(varargin{:})),1)); 

% go through all arguments
for i = 1:nargin
  siz = sizem(varargin{i}); % the size of argument i
  % keep the max size sofar
  res(1:length(siz)) = max(res(1:length(siz)),siz);
end

  