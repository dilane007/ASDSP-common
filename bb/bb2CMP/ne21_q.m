function  z = ne21_q(x,y,qpoint)
    x= qformat(x,qpoint);
    y= qformat(y,qpoint);
    z= ne(x,y); 
end
