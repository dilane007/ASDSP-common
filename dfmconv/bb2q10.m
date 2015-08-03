function z = bb2q10(x)
   cc= ge(x(1),128);
   z = 256*double(x(1))+double(x(2));
   if (cc) 
       z = z-65536;
   end;    
   z=z/1024; 
end