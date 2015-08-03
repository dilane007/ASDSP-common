function lZ = bbbb2ul(x)
   xhh = uint32(x(1));
   xhl = uint32(x(2));
   xlh = uint32(x(3));
   xll = uint32(x(4));
   a = bitshift(xhh,24);  
   b = bitshift(xhl,16); 
   c = bitshift(xlh,8);
   lV = bitor(a,xll); 
   lW = bitor(b,c); 
   lZ = bitor(lV,lW); 
end