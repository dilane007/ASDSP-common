%Z= BYTE2HEX(X) Convert signed 8-bit to a string of 2 hex.
%Note: here byte is no a type; it is a range; i.e -256:255
%   and a number of bits = 8 bits
% input:  
%  TYPE: numeric; does not have to be int8, as it will be casted
%  SHAPE: 1D, 2D
% output: 
%  TYPE: string of chars
%  SHAPE: cln
% qint: NN (as in NNqFF) e.g 2q6  --> 2
%--------------------------------------------------------------------------------
function z= byte2hex(x,qint)
    za=long2hex(x,qint);
    z=za(:,1:2);
end
