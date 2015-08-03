% dec2shex
%=======================================================
function z  = dec2shex(x)
    flag = x < 0;
    z = flag.*65536 + x ;
    z = dec2hex(z,4);
end
                                                                                                      




