% dec2lhex
%=======================================================
function z = dec2lhex(x)

MAXBASE=65536*65536;
flag = x < 0;
z = flag.*MAXBASE + x ;
z = dec2hex(z,8);


                                                                                                      




