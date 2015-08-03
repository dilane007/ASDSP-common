function  z = gt21_q(x,y,qpoint)
    x= qformat(x,qpoint);
    y= qformat(y,qpoint);
    z= gt(x,y); 
end
