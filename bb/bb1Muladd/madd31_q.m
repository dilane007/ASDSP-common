% madd31_q.m
%=======================================================
function  z = madd31_q(x,y,v,qpoint)
       p= mul21_q(x,y,qpoint); 
       v= qformat(v,qpoint);
       z= add21_q(p,v,qpoint); 
end
