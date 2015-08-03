function lZ = uss2ul(x1,x2)
%x1=hi x2=lo
   xh = uint32(x1);  %[0 hi]
   xl = uint32(x2);  %[0 lo]
   a = bitshift(xh,16);  %[hi 0];
   lZ = bitor(a,xl); 
end