function z= sub21p_s(x,y)
    sx= int16(x);%make sure it is the right type in input 
    sy= int16(y);
    lx= int32(sx);%promote 
    ly= int32(sy);
    z= minus(lx,ly); %make sure that output is >16bit 
end
