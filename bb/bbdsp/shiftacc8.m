function z = shiftacc8(xin)
fxp_init('hw','m','f',0,0,0,0,'prop_on');
 %constants and asserts
 mbfxpscalar(8,0,'u',xin);
 k = fxp([3 2 2 -1 -1 2 2 3],4,0,'s'); 
 NSTATE=length(k);
 scale=-3;
%init
 persistent bufx;
 CATALYTIC_init_persistent(bufx,zeros(1,NSTATE));
 %body
 bufx = shift_register(xin,bufx,NSTATE);
 z =  bitshifta(bufx*k',scale); 

function regs = shift_register(din,regs,NSTATE)
for tap=NSTATE-1:-1:0
  if tap ~=0      regs(tap+1) = regs(tap);
  else            regs(tap+1) = din;  end    
end
