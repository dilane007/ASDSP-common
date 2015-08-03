function ussZ =swap11_us(ussX)
% packed  swap
% x= xhi || xlo
% z= xlo || xhi
% there are known limitations 
usXhi= uint16(bitand(bitshift(ussX,-16),hex2dec('0000FFFF')));
usXlo= uint16(bitand(bitshift(ussX,  0),hex2dec('0000FFFF')));
ussZ = bitor(bitand(bitshift(zext(usXlo,32),16),hex2dec('FFFF0000')), ...
             bitand(         zext(usXhi,32),    hex2dec('0000FFFF')));
end
