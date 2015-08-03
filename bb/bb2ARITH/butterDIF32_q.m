function [z w] = butterDIF32(x,y,k)
% DIF Butterfly	
% z = (x + y)*k
% w = (x – y)*k   
 [p m]= addsub22(x,y);   
 z = mul21(k,p);   
 w = mul21(k,m);   
end