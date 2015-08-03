% mul31.m
%=======================================================
function  z = mul31_q(x,y,v,qpoint)
       p= times(x,y); 
       r= qformat(p,qpoint); 
       s= times(r,v); 
       z= qformat(s,qpoint); 
end
