% Common\SeqHex.m

function lX = SeqHex(start,step,stop)
x = hex2dec(start):hex2dec(step):hex2dec(stop);
lX=fxp(x,32,0);


                                                                                                      




