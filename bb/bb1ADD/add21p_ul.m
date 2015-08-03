function z= add21p_ul(x,y)
    x=uint32(x);    %make sure that it is the right type
    y=uint32(y);    %
    fx= double(x);
    fy= double(y);
    %adding in promoted format
    %use int64 to describe > 32 bit result
    z= uint64(fx+fy);
end
