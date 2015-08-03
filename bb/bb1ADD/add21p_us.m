function z= add21p_us(x,y)
    sx= uint16(x);%make sure it is the right type in input 
    sy= uint16(y);
    lx= uint32(sx);%promote
    ly= uint32(sy);
    z= lx+ly; %adding in promoted format;make sure that output is >16bit 
end

