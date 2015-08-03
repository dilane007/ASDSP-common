% macc41.m
%=======================================================
function  acc = macc41(a,b,c,d)
       p1= mul21(a,b); 
       p2= mul21(c,d); 
       z = add21(p1,p2); 
       acc= sum(z); 
 end
