function z= sub21p_ub(x,y)
    bx= uint8(x);%make sure it is the right type in input 
    by= uint8(y);
    lx= uint32(bx);%promote
    ly= uint32(by);
    z = minus(lx,ly);% %adding in promoted format;make sure that output is >8-bit
end