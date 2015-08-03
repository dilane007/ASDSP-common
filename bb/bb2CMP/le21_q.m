function  z = le21_q(x,y,qpoint)
    x= qformat(x,qpoint);
    y= qformat(y,qpoint);
    z= le(x,y); 
end
