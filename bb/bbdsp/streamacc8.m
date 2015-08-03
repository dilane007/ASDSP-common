function z = streamacc8(xin,ctrdin,NDATA)
fxp_init('hw','m','f',0,0,0,0,'prop_on');
 %constants and asserts
 mbfxpscalar(8,0,'u',xin);
 k = fxp([3 2 2 -1 -1 2 2 3],4,0,'s'); 
 NSTATE=length(k);
 scale=-3;
%init
 persistent bufx;
 init_persistent(bufx,zeros(1,NSTATE));
 %body
 bufx = stream_register(xin,bufx,ctrdin,NDATA,NSTATE);
 z =  bitshifta(bufx*k',scale); 

function regs = stream_register(din,regs,ctrdin,NDIN,NSTATE)
CTAPS = ceil(NSTATE/2);
for tap=NSTATE:-1:1
 if (((ctrdin==1) && ( tap <= CTAPS )) || ((tap==1) && (ctrdin<=NDIN)))
     regs(tap) =din;
  elseif (tap > 1)
     regs(tap) = regs(tap-1);
  end    
end
