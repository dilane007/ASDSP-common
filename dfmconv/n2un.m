function uz= n2un(x)
% signed nibble to unsigned nibble
 sign = lt(x,0); 
 uns  = ge(x,0); 
 uz(uns) = uint8(x(uns));
 uz(sign)= uint8(16 + x(sign));%2s complement in 4 bit circle
end
