%Z= SHRT2HEX(X) Convert signed 16-bit to a string of 4 hex.
%Note: here short is no a type; it is a range; i.e -2^15:2^15-1
%   and a number of bits = 16bits
% input:  
%  TYPE: numeric; does not have to be int16, as it will be casted
%  SHAPE: 1D, 2D
% output: 
%  TYPE: string of chars
%  SHAPE: cln
% qint: NN (as in NNqFF) e.g 6q10 --> 6
%--------------------------------------------------------------------------------
% original jacklam
%   INT16_TO_HEX(X), where X is an array with N int16 values, returns an N-by-4
%   character array (string) of hexadecimal numbers where each row in the
%   output represents an element in X.
%   See also FORMAT HEX.
%   Author:      Peter J. Acklam
%   Time-stamp:  2003-11-17 11:21:25 +0100
%---------------------------------------------------------
% dfm was here
%  <21jun2015> superfluous testing positive/negative suppressed; 
%---------------------------------------------------------
function z= shrt2hex(x,qint)
    y=long2hex(x,qint);
    z=y(:,1:4);
end
