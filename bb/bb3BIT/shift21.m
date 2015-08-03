% z= shift21(x,y)
%   z= x << y positive 
%   z= x >> y negative; not exact as shift is replaced by division
% SHAPE: unc
% TYPE: unc
% RANGE: as type
%-------------------------------
function z= shift21(x,y)
 IMPLM=11;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if verbose >= 10, fprintf(OFP,'[SHIFT21]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if IMPLM==11
        z=x.*power(2,y);
    end;
end

