function z= add21p_b(x,y)
    bx= int8(x);%make sure it is the right type in input 
    by= int8(y);
    lx= int32(bx);%promote 
    ly= int32(by);
    z=  plus(lx,ly);%make sure output is >8-bit 
end