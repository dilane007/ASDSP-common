function z=dec2bf(x,bflen)
% there is a special case: if x=0 the bin. array length is only 1 digit
   
     if (x==0),    z(1:bflen)='0'; 
     else,         z=dec2bin(x,bflen);
     end;
 
end



    