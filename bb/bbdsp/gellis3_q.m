function  z= gellis3_q(x0,bufk,qpoint)
%-------------------------------
%original equation
%  z(t)= G*(x(t)-z(t-1)) + z(t-1)		
% with G= (1- exp(-Fc*Ts*2*PI))		
%implementation
% uses x,z as variables and k as coefs
% z = k*(x0-z1)+z1		
%-------------------------------
%Inputs  
% x0    Shape=scalar type=1q15
% bufk  Shape=scalar(k) type=1q15
%Outputs 
% z     Shape=vector type=1q15
%States 
% z1    Shape=scalar type=1q15
%-------------------------------
global verbose;
MLABIDX=1;

if nargin < 3, qpoint=53.53; end;

persistent z1;
 %on reset,clear state 
 if (isempty(z1)),z1=0;end;
 %local storage 
 bufx(0+MLABIDX)=x0;
 bufx(1+MLABIDX)=z1;
 %kernel 
 xq= qformat(bufx,qpoint);
 kq= qformat(bufk);
 s = sub21_q(xq(1),xq(2),qpoint);
 t = mul21_q(s,kq(1),qpoint);
 z = add21_q(xq(2),t,qpoint);
 z1= z;
 %debug 
 if (verbose >=10), display(z);end;

end%function

