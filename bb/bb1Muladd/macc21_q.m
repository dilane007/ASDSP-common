% macc21_q.m
%=======================================================
function  acc = macc21_q(x,y,qpoint)
       z= mul21_q(x,y,qpoint); 
       u= sum(z); 
       acc= qformat(u,qpoint); 
end
