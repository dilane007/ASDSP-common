function dim = firstsing(varargin) 
% DESCRIPTION dim = firstsing(varargin)
%  Finds first singleton dimension common to all input arguments.
% INPUT
%  A number of matrices, probably with different sizes.
% OUTPUT
%  dim --  A positive integer indicating the first
%          common singleton dimension.
% TRY
%  firstsing(rand(2,1,2), rand(2,1)) => 2

% by Magnus Almgren 990317

dims = find([maxsize(varargin{:}) 1]==1);
dim = dims(1);
