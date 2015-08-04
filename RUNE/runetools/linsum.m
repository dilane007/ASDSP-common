function y = linsum(varargin) 
% DESCRIPTION y = linsum(m, dim) 
%  Takes the same argument list as sum.m,
%  but calculates lin2db(sum(db2lin(m),dim)).
%  dim is optional.
% INPUT 
%  m --   A matrix with real values representing entities in dB.
%  dim -- The dimension in which the opration is performed default is 1.
% OUTPUT
%  y --   The corresponding matrix summed in the linear domain.
% TRY
%  linsum([0; 0]), linsum([0 0],2), linsum([-inf 0])
% SEE ALSO 
%  sum, linmean, lincumsum 

% by Magnus Almgren 990226

% sum in the linear linear domain and back to dB
y = lin2db(sum(db2lin(varargin{1}),varargin{2:end}));

% $Id: linsum.m,v 1.1 2004/02/19 17:27:44 bogdant Exp $
