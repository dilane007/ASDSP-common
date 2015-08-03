function z= add21m_s(x,y)
    x=  int16(x);%enforce type before promotion
    y=  int16(y);
    lx= int32(x);%promote to allow repairing overflowed results
    ly= int32(y);
    lw= plus(lx,ly);
    cc1= gt(lw,intmax('int16')); % if pos. ovf
    lw(cc1)= lw(cc1) - power(2,16); % put result back in range
    cc2= lt(lw,intmin('int16')); % if neg. ovf
    lw(cc2)= lw(cc2) + power(2,16); % put result back in range
    z=int16(lw);
end
