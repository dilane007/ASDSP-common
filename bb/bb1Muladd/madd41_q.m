% madd41_q.m
%=======================================================
function  z  = madd41_q(a,b,c,d,qpoint)
       p1= mul21_q(a,b,qpoint); 
       p2= mul21_q(c,d,qpoint); 
       z = add21_q(p1,p2,qpoint); 
 end
