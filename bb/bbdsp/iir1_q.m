function  z= iir1_q(x0,bufk,qpoint)
%-------------------------------
%original equation
% y(t) = G*x(t) + B*y(t-1)		
% with B= exp(-Fc*Ts*2*PI)		
% with G=1-B		
%implementation
% uses x,z as variables and k,b as coefs
% z = k*x0 + b*z1		
%-------------------------------
%Inputs  
% x0    Shape=scalar type=fp
% bufk  Shape=scalars (k,b) type=fxp
%Outputs 
% z     Shape=vector type=fxp
%States 
% z1    Shape=scalar type=fxp
%-------------------------------
global verbose;
global MLABIDX;
persistent z1;
 if nargin < 3, qpoint=53.53; end;

 %on reset,clear state 
 if (isempty(z1)),z1=0;end;
 %kernel 
 bufx(0+MLABIDX)=x0;
 bufx(1+MLABIDX)=z1;
 xq= qformat(bufx);
 kq= qformat(bufk);
 z = madd41_q(xq(1),kq(1),xq(2),kq(2),qpoint);
 z1= z;
 %debug
 if (verbose >=10), display(z);end;

end%function

