% DIT Butterfly	
% z = x + y*k
% w = x – y*k   
function [z w] = butterDIT32(x,y,k)
 p = mul21(y,k);   
 [z w] = addsub22(x,p);   
end 