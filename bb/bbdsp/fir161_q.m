function z= fir161_q(x,y,qpoint)
IMPLM=12;
if IMPLM == 99,  z=x; end;
if IMPLM == 98,  z=y; end;

if IMPLM == 1
    zout = zeros(1,1);
    for n= 1:16
      p = times(x(n),y(n) );
      qP = qformat(p,qpoint);
      zout = add21_q(zout,qP,qpoint);
    end;
end;

if IMPLM == 11
    xq= qformat(x,qpoint);%
    yq= qformat(y,qpoint);%
    zz = sum(xq*.kq);
    z = qformat(zz,qpoint);  
end;

if IMPLM == 12
    xq= qformat(x,qpoint);%
    yq= qformat(y,qpoint);%
    p = mul21_q(xq,yq,qpoint);
    z = add161_q(p,qpoint);
end;

end