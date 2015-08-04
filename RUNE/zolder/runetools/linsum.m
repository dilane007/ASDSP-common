function y = linsum(varargin) 
% DESCRIPTION y = linsum(varargin) 
%  Takes the same argument list as sum.m,
%  but calculates lin2db(sum(db2lin(arg1),dim)).
%  dim is optional.
% INPUT 
%  varargin --  A matrix with real values representing entities in dB.
% OUTPUT
%  y --         The corresponding matrix summed in the linear domain.
% TRY
%  linsum([0; 0]), linsum([0 0],2), linsum([-inf 0])
% 					SEE ALSO sum 

% by Magnus Almgren 990226

varargin{1} = db2lin(varargin{1}); % convert into linear
y = lin2db(sum(varargin{:})); % sum in linear and back to dB
