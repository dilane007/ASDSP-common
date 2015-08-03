function z= add21m_b(x,y)
  x=  int8(x)%enforce type before promotion
  y=  int8(y)
  lx= int32(x)%promote to allow repairing overflowed results
  ly= int32(y)
  lw= plus(lx,ly)
  cc1= gt(lw,intmax('int8')) % if pos. ovf
  lw(cc1)= lw(cc1) - power(2,8) % put result back in range
  cc2= lt(lw,intmin('int8')) % if neg. ovf
  lw(cc2)= lw(cc2) + power(2,8) % put result back in range
  z=  int8(lw);
end
