% madd31_q.m
%=======================================================
function  z = madd31_q(x,y,v,qpoint)
       p= qformat(x.*y,qpoint); 
       z= qformat(p+v,qpoint); 
end
