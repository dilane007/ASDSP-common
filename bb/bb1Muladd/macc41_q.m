% macc41_q.m
%=======================================================
function  acc = macc41_q(a,b,c,d,qpoint)
       p1= mul21_q(a,b,qpoint); 
       p2= mul21_q(c,d,qpoint); 
       z = add21_q(p1,p2,qpoint); 
       u= sum(z); 
       acc= qformat(u,qpoint); 
 end
