function z= add21m_l(x,y)
    x=  int32(x);%enforce type before promotion
    y=  int32(y);
    fx= double(x); %promote to allow repairing overflowed results
    fy= double(y); %
    fw= plus(fx,fy);
    cc1= gt(fw,intmax('int32')); % if pos. ovf
    fw(cc1) = fw(cc1) - power(2,32); % put result back in range
    cc2= lt(fw,intmin('int32')); % if neg. ovf
    fw(cc2) = fw(cc2) + power(2,32); % put result back in range
    z=  int32(fw);
end

