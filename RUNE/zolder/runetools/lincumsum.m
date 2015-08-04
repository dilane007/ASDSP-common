function y = lincumsum(varargin) 
% DESCRIPTION y = lincumsum(m, dim) 
%  The same as cumsum but argument the main argument
%  in and out are in dB.
%  y = lin2db(cumsum(db2lin(arg),dim)).
%  dim is optional.
% INPUT 
%  m --  A matrix with real values representing entities in dB.
% OUTPUT
%  y --  The corresponding matrix cumsummed in the linear domain.
% TRY
%  lincumsum([0; 0]), lincumsum([0 0],2), linsumcum([-inf 0])
% 					SEE ALSO cumsum 

% by Magnus Almgren 011008

% cumsum in linear and back to dB again
y = lin2db(cumsum(db2lin(varargin{1}),varargin{2:end}));

