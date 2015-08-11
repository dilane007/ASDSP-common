%z= PMAVFSEC_Q(x0,z1,b,qpoint)
%Pseudo Moving AVerage filter section
%original equation
% y(t) = G*x(t) + B*y(t-1)		
% with B= exp(-Fc*Ts*2*PI)		
% with G=1-B		
%implementation
% uses x,z as variables and b as coefs such than:
% z = (1-b)*x0 + b*z1		
%-------------------------------
% TYPE= unc (inputs)  q (output)
% SHAPE= scalar
% RANGE= as qformat
% modal= sat
%-------------------------------
function  z= pmavfsec_q(x0,z1,b,qpoint)
   
global verbose;

if nargin < 4, qpoint=53.53; end;

IMPLM=11;

x0q= qformat(x0,qpoint);
z1q= qformat(z1,qpoint);
bq=  qformat(b,qpoint);

switch(IMPLM)
    case(11)    
        kq = sub21_q(1,bq,qpoint);
        z = madd41_q(x0q,kq,z1q,bq,qpoint);
%further work 
    case(12)    
        z = madd61_q(x0q,1,x0q,-bq,z1q,bq,qpoint);
    case(13)    
        pq = madd41_q(x0q,-bq,z1q,bq,qpoint);
        z = add21_q(x0q,pq,qpoint);
    case(14)    
        sq = sub21_q(z1q,x0,qpoint);
        pq = mul21_q(sq,bq,qpoint);
        z = add21_q(x0q,pq,qpoint);
end;

%debug 
if (verbose >=10), disp(z);end;
%
end%function

