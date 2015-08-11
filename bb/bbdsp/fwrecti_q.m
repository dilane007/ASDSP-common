% z= FWRECTI_Q(x,qpoint)   returns a fully rectified wave 
% TYPE=unc  output= q
% SHAPE= scalar,vector;
% RANGE= as qformat
% Modal= 100% qformat
function z=fwrecti_q(x,qpoint);
 if nargin < 2, qpoint=53.53; end;

 y= sub21_q(0,x,qpoint); 
 k= x.*0; 
 cc1= x>k;        
 z1(cc1)=x(cc1);
 z1(~cc1)=k(~cc1);
 cc2= y>k;
 z2(cc2)=y(cc2);        
 z2(~cc2)=k(~cc2);
 z=add21_q(z1,z2,qpoint);
end

