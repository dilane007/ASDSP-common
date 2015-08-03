function  z = add21p_q(x,y,qpoint)
       x= double(x); 
       y= double(y); 
       t= plus(x,y); 
       if qpoint==8, qpoint=24; end; %8q8 -> 9q23 
       if qpoint==16, qpoint=26; end; %16q16 ->17q36 
       if qpoint==32, error('qpoint=32; cannot be promoted');end; 
       z= qformat(t,qpoint-1);
end
