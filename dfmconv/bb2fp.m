function z = bb2fp(x,y)
   cc= ge(x,128);
   z = 256*x+y;
   if (cc) 
       z = 65536-z;
   end;    
end