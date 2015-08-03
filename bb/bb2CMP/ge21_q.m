function  z = ge21_q(x,y,qpoint)
    x= qformat(x,qpoint);
    y= qformat(y,qpoint);
    z= ge(x,y); 
end
