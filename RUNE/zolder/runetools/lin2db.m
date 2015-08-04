function varargout = lin2db(varargin)
% DESCRIPTION y = lin2db(x)
%  Converts linear to dB, no warning if zero.
%  The function accepts any number of arguments.
%  An error is issued for values less than zero.
% INPUT
%  Any number arguments of any matrix with non negative
%  numbers.
% OUTPUT
%  y -- As inputs, but coverted into dB.
% TRY
%  lin2db(0), lin2db([1 1]), lin2db([0 1],ones(2,2,2))
% SEE ALSO
%  db2lin

% by Magnus Almgren 990301

for i=1:nargin
if any(varargin{i}(:)<0)
  error('Input argument is less than zero')
end

% supress warning for log of 0 
warning off
varargout{i} = 10*log10(varargin{i});
warning on
end