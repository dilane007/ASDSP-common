% dec2bhex.m
%=======================================================
function z = dec2bhex(x)

flag = x < 0;
z = flag.*256 + x ;
z = dec2hex(z,2);



                                                                                                      




