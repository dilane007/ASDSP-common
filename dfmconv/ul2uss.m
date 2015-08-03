function [usZhi usZlo] = ul2uss(ulX) 
usZhi= uint16(bitand(bitshift(ulX,-16),hex2dec('0000FFFF')));
usZlo= uint16(bitand(          ulX,    hex2dec('0000FFFF')));


