function sZ = bb2us(x)
   xh = uint16(x(1));
   xl = uint16(x(2));
   xxh = bitshift(xh,8);
   sZ = bitor(xxh,xl); 
end