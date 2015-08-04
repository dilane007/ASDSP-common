function rber = ci2rber(ci)
% DESCRIPTION
% rber = ci2rber(ci)
%  A simple model for Raw Bit Error Rate
% INPUT 
%  ci   -- Carrier to Interference Ratio in dB
% OUTPUT 
%  rber -- Raw Bit Error Rate
% TRY 
%  plot(-30:10, ci2rber(-30:10))

% by Magnus Almgren 040202
rber = qfunc(db2lin(ci/2));

% $Id: ci2rber.m,v 1.2 2004/03/11 15:01:30 olav Exp $
