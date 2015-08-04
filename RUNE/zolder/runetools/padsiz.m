function varargout = padsiz(pad, varargin)
% DESCRIPTION [a,b,...] = padsiz(pad,a,b,...)
%  Will extend dimensions of
%  each input argument to maximum 
%  size of the other arguments.
% INPUT
%  pad --       Nonfilled areas are padded with this value.
%  varargin --  Matrices of any size
% OUTPUT
%  The result is matrices of the same size.
%  The nonfilled areas are padded with pad.
% TRY
%  [a, b] = padsiz(NaN, ones(1,2), ones(2,1))
% SEE ALSO 
%  adjsiza,adjsiz,repelem

% by Magnus Almgren 990317

dim = maxsize(varargin{:});
for i = 1:length(varargin)  % Go through all arguments.
 varargout{i} = zeros([dim 1])+pad;
 siz = size(varargin{i});
 if ~any(siz==0)
  ind = indpart(dim, siz);
  varargout{i}(ind) = varargin{i}(:);
 end
end
