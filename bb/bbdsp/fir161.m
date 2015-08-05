function z= fir161(x,y)
IMPLM=12;
if IMPLM == 99,  z=x; end;
if IMPLM == 98,  z=y; end;

if IMPLM == 12
    p = mul21(x,y);
    z = add161(p);
end;

end