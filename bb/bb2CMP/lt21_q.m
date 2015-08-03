function  z = lt21_q(x,y,qpoint)
    x= qformat(x,qpoint);
    y= qformat(y,qpoint);
    z= lt(x,y); 
end
