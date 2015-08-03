% z=addd21(x,y);
% SHAPE: unc
% TYPE: unc
% RANGE: as type
%-------------------------------
function z= addd21(x,y)
 IMPLM=12;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if verbose >= 10, fprintf(OFP,'[ADDD21]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    v= shift21(y,1);
    z= add21(x,v);
end