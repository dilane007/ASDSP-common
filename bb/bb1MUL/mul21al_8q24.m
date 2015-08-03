% MUL21AL_8q24
% 8q24 x 8q24 -> 8q24    
% z= mul21al_8q24(x,y);
% SHAPE: tested row
% TYPE: qformat
% RANGE: as type
% modal= aligned to qpoint in a 32-bit long
% sat: implied by aligned qpoint    
% rounding: no
%----------------------------------------------------------------------
function z= mul21al_8q24(x,y)
 IMPLM=13;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if verbose >= 10, fprintf(OFP,'[MUL21AL_8Q24]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Input pins: format change and range checking if needed
  lX=q24fp2l(x); %ensure precision is 32-bit or less
  fX=q24l2fp(lX);
  lY=q24fp2l(y);
  fY=q24l2fp(lY);
  
  %% Kernel
   fZ= times(fX,fY);% % 8q24 x 8q24 -> 16q37
   lZ= q24fp2l(fZ);%  16q37 --> sat 8q24
   
  %% Output pins: format change if needed
    z= q24l2fp(lZ);
  
end