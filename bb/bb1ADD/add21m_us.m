function z= add21m_us(x,y)
        x= uint16(x);%enforce type before promoting
        y= uint16(y);
        lx= uint32(x);
        ly= uint32(y);
        lw= plus(lx,ly);%promoted format prevents saturation of overflowed results
        lu= bitshift(lw,16);%get rid of upper bits 
        lt= bitshift(lu,-16);%back to right aligned 
        z=  uint16(lt);%back to 16-bit width (and uint16 type)
end

