% mul42_q.m
%=======================================================
function  [z w] = mul42_q(a,b,c,d,qtyp)
       p1= times(a,b); 
       p2= times(c,d); 
       z= qformat(p1,qtyp); 
       w= qformat(p2,qtyp); 
end
