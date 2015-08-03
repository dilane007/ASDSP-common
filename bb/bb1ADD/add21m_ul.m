function z= add21m_ul(x,y)
  x= uint32(x);%enforce type before promotion
  y= uint32(y);
  fx= double(x);
  fy= double(y);
  fw= plus(fx,fy);%promoted format prevents saturation of overflowed results
  cc= gt(fw,intmax('uint32')); %if result overflowed
  fw(cc)= fix(fw(cc) - power(2,32)); %put it back in 32-bit range
  z = uint32(fw);%back to 32-bit width (and type)
end
