function z= add21m_ub(x,y)
  x=  uint8(x);%enforce type before promotion
  y=  uint8(y);
  sx= uint16(x);
  sy= uint16(y);
  sw= plus(sx,sy); %promoted format prevents satuaration of overflowed results
  su= bitshift(sw,8);%get rid of upper bits 
  st= bitshift(su,-8);%back to right aligned 
  z=  uint8(st);%back to 8-bit wuidth (and type)
end