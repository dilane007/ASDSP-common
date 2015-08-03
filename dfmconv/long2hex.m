%Z= LONG2HEX(X) Convert signed 32-bit to a string of 8 hex.
%Note: here long is no a type; it is a range; i.e -2^31:2^31-1
%   and a number of bits = 32bits
% input:  
%  TYPE: numeric; does not have to be int8, as it will be casted
%  SHAPE: 1D, 2D
% output: 
%  TYPE: string of chars
%  SHAPE: cln
% qint: as in NNqFF e.g 6q26  --> 6
%--------------------------------------------------------------------------------
% original jacklam
%   INT32_TO_HEX(X), where X is an array with N int32 values, returns an N-by-8
%   character array (string) of hexadecimal numbers where each row in the output represents an element in X.
%
%   See also FORMAT HEX.
%   Author:      Peter J. Acklam
%   Time-stamp:  2003-11-17 11:21:25 +0100
%---------------------------------------------------------
% dfm was here
%  <21jun2015> superfluous testing positive/negative suppressed; 
%              problems with sprintf to suppress the additional FFFFF digits (negative gives 16 digits i.o 8)
%              it finally worked.. how??.. but it did not work when i try different values such as %.4x 
%---------------------------------------------------------
function z= long2hex(x,qint)
   if nargin<2, 
       xa=x;
   else   
       xa= x.*power(2,32-qint);%same as 31-qint+1 since (eg 6q26) qint=6  ==2^5  
   end
   %limit to 32-bit and shape to cln 
   y = int32(xa(:));
   % convert to hex (string)
   za = sprintf('%.8x', y);
   %reshape back 
   z = reshape(za, [8, length(y)]).';
end