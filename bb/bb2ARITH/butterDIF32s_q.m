% DIF Butterfly	
% z = (x + y)*k
% w = (x – y)*k   
function [z w] = butterDIF32s_q(x,y,k,qpoint)
 [p m]= addsub22s_q(x,y,qpoint);   
 z = mul21s_q(k,p,qpoint);   
 w = mul21s_q(k,m,qpoint);   
