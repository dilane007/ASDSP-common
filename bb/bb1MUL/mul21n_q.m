% MUL21n_q
% function z= mul21n_q(x,y,qpoint)
% SHAPE: tested row
% TYPE: qformat
% RANGE: as type
%-------------------------------
function z=mul21n_q(x,y);
 IMPLM=13;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if verbose >= 10, fprintf(OFP,'[MUL21N_Q]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% Input pins: format change and range checking if needed
 fX=qformat(x,qpoint);
 fY=qformat(y,qpoint);

%% Kernel
 fZ= times(fX,fY);% NqM x NqM -> NNqMM
 lZ= int16(fZ * power(2,15));% NNqMM --> NNqM
 fZ= double(lZ)/power(2,15);% NNqMM --> NNqM
 
%% Output pins: format change if needed
 z=qformat(fZ,qpoint);

end
