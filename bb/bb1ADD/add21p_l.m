function z= add21p_l(x,y)
    x=  int32(x);    %make sure that it the right type
    y=  int32(y);    %
    fx= double(x); %double will allow promotion
    fy= double(y); %
    %adding in promoted format
    %use int64 to describe > 32 bit result
    z= int64(fx+fy);
end

