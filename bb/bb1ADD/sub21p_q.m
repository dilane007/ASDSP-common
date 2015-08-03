function  z = sub21p_q(x,y,qpoint)
       if qpoint==8, qpoint=24; end; %8q8 -> 9q23 
       if qpoint==16, qpoint=26; end; %16q16 ->17q36 
       if qpoint==32, error('qpoint=32; cannot be promoted');end; 
       %
       x= double(x); 
       y= double(y); 
       t= minus(x,y); 
       z= qformat(t,qpoint-1);
end
