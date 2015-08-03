% MUL21n_8q24
% z= mul21n_8q14(x,y);
% SHAPE: tested row
% TYPE: qformat
% RANGE: as type
%-------------------------------
function z=mul21n_8q24(x,y);
 IMPLM=13;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if verbose >= 10, fprintf(OFP,'[MUL21N_8Q24]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Input pins: format change and range checking if needed
  lX=q24fp2l(x); %ensure precision is 32-bit or less
  lY=q24fp2l(y);
  fX=q24l2fp(lX);
  fY=q24l2fp(lY);
  
  %% Kernel
   fZ= times(fX,fY);% % 8q24 x 8q24 -> 16q37
  %  lZ= q16fp2l(fZ);%  %  -> back to 16q16
   lZ= int32(round(fZ*power(2,16)));
   
  %% Output pins: format change if needed
  % z =q16l2fp(lZ); %back to FP
    z= double(lZ)/(power(2,16)); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end