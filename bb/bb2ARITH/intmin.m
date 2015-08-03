function  z = intmin(str1)
       switch(str1)
           case ('int8')   z= -power(2,7);
           case ('int16')  z= -power(2,15);
           case ('int32')  z= -power(2,31);
           case ('uint8')  z= 0;
           case ('uint16') z= 0
           case ('uint32') z= 0;
       end;       
end
