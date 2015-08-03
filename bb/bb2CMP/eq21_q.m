function  z = eq21_q(x,y,qpoint)
    x= qformat(x,qpoint)
    y= qformat(y,qpoint)
    z= eq(x,y); 
end
