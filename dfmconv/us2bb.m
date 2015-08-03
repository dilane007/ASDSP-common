function [zhi zlo] = us2bb(x)
   x = uint16(x);
   zhi = uint8(bitand(bitshift(x,-8),255));
   zlo = uint8(bitand(bitshift(x, 0),255));
   
end
