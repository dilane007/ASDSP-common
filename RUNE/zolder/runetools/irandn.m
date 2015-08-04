function res = irandn(varargin)
% DESCRIPTION res = irandn(r,c,...)  
%  Complex random normal distributed numbers.
%  In the real as well as in the imaginary part.
%  abs(irandn(r,c,...)) is then rayleigh distributed.
% INPUT
%  size parameters as for i.e. zeros
% OUTPUT
%  res --  A matrix of size according to input with complex
%          elements. Both the real and the imaginary part 
%          distributed N(0,1).

% TRY plot(irandn(100),'.')
% SEE ALSO irand

% by Magnus Almgren 970611

res = randn(varargin{:}) + i*randn(varargin{:});
