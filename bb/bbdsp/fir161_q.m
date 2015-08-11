% z= FIR161_q(x,y,qpoint) Fir Filter of length=16
function z= fir161_q(x,y,qpoint)
%%%
    if nargin < 3, qpoint=53.53; end;      
%%%
 IMPLM=12;
%    
if IMPLM == 99,  z=x; end;
if IMPLM == 98,  z=y; end;

if IMPLM == 1
    zout = zeros(1,1);
    for n= 1:16
      p = times(x(n),y(n) );
      z = add21(z,p);
    end;
end;

if IMPLM == 11
%MODAL= no qformat in internal nodes    
    xq= qformat(x,qpoint);%
    yq= qformat(y,qpoint);%
    zz = sum(xq.*kq);
    z = qformat(zz,qpoint);  
end;

if IMPLM == 12
%MODAL= full qformat of all blocks    
    xq= qformat(x,qpoint);%
    yq= qformat(y,qpoint);%
    p = mul21_q(xq,yq,qpoint);
    z = add161_q(p,qpoint);
end;

end