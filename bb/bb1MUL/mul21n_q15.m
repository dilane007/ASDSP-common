% 1q15 x 1q15 -> 2q14
function z= mul21n_q15(x,y)
  
  %% Input pins: format change and range checking if needed
  lX=q15fp2l(x);
  lY=q15fp2l(y);
  
  %% Kernel
   lZ= times(lX,lY);% 1q15 x 1q15 -> 2q30
   sZ= double(lZ/65536);% 2q30 --> 2q14
  % %% Kernel2
  %  lZ= times(lX,lY);% 1q15 x 1q15 -> 2q30
  %  sZ= int16(ul2l(bitshifta(l2ul(lZ),-16)));% 2q30 --> 2q14
   
  %% Output pins: format change if needed
  z=q14s2fp(sZ);
end