function y = linmean(varargin)
% DESCRIPTION y = linmean(m, dim) 
%  The same as mean but the input argument
%  and the outpout are in dB.
%  y = lin2db(mean(db2lin(arg),dim)).
%  dim is optional.
% INPUT 
%  m --  A matrix with real values representing entities in dB.
%  dim -- The dimension in which the mean value is computed
% OUTPUT
%  y --  The corresponding matrix cumsummed in the linear domain.
% TRY
%  linmean([0; 0]),linmean([0, -inf])
% SEE ALSO 
%  cumsum, linsum, lincumsum

% by Magnus Almgren 011022

% mean value in the linear domain and back to dB
y = lin2db(mean(db2lin(varargin{1}),varargin{2:end}));

% $Id: linmean.m,v 1.1 2004/02/19 17:27:43 bogdant Exp $
