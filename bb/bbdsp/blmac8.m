function z = blmac8(bufin)
fxp_init('hw','m','f',0,0,0,0,'prop_on');
 %constants and asserts
 k = fxp([3 2 2 -1 -1 2 2 3],4,0,'s'); 
 NSTATE=length(k);
 mbfxprow(8,0,'u',bufin);
 mbsize([1 NSTATE],bufin);
 scale=-3;
 %body
 z= bitshifta(bufin*k',scale); 


