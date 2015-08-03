% DIT Butterfly	
% z = x + y*k
% w = x – y*k   
function [z w] = butterDIT32s_q(x,y,k,qpoint)
 p = mul21s_q(y,k,qpoint);   
 [z w] = addsub22s_q(x,p,qpoint);   
end 