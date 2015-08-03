function z= sub21p_l(x,y)
    x=  int32(x);    %make sure that it the right type
    y=  int32(y);    %
    fx= double(x); %double will allow promotion
    fy= double(y); %
    fz= minus(fx,fy);
    %use int64 to describe > 32 bit result
    %good idea??
    z= int64(fz);
end

