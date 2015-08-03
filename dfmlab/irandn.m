function res = irandn(varargin)
% DESCRIPTION res = irandn(r,c,...)  
%  Complex random normal distributed numbers.
%  In the real as well as in the imaginary part.
%  abs(irandn(r,c,...)) is then rayleigh distributed.
%  Note that E[irandn^2] = sqrt(2); 
% INPUT
%  size parameters as for i.e. zeros
% OUTPUT
%  res --  A matrix of size according to input with complex
%          elements. Both the real and the imaginary part 
%          distributed N(0,1).

% TRY 
%  plot(irandn(1000),'.')
% SEE ALSO 
%  irand, setseed

% by Magnus Almgren 970611

res = randn(varargin{:}) + i*randn(varargin{:});

% $Id: irandn.m,v 1.1 2004/02/19 17:27:43 bogdant Exp $
