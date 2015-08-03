function  z = intmax(str1)
       switch(str1)
           case ('int8')  z= power(2,7)-1;
           case ('int16') z= power(2,15)-1;
           case ('int32') z= power(2,31)-1;
           case ('uint8')  z= power(2,8)-1;
           case ('uint16') z= power(2,16)-1;
           case ('uint32') z= power(2,32)-1;
       end;       
end
