function  bufz= pmavf_q(x0,qpoint)
%Inputs  
% x0    Shape=scalar type=fp
%Outputs 
% z     Shape=vector type=fp
%States 
% w    Shape=vector type=fp
%Temp 
% k    Shape=vector type=fp
global verbose;
global NCELL;
persistent bufw;

 if nargin < 2, qpoint=53.53; end;

 %on reset,clear state 
 if (isempty(bufw)), bufw=zeros(1,NCELL);end;
 %compute coefs statically
 bufk  = qformat(linspace(0,0.99,NCELL),qpoint);%NCELL(typ:100) coefs between 0 and 1
 %kernel 
 bufz= zeros(1,NCELL);%avoid loop warning
 for nn=1:NCELL;
    bufz(nn)= pmavfsec_q(x0,bufw(nn),bufk(nn),qpoint);
    bufw(nn)= bufz(nn);
 end
 %debug 
 if (verbose >=10), display(bufz);end;

end%function

