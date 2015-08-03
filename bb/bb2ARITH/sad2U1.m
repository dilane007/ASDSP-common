% vectorr\SAD\sad2U1.m
% z= sad21(x,y,len);
% SHAPE: unc  
% TYPE: unc
% RANGE: unc
% return: a scalar
%-------------------------------
function z=sad2U1(x,y);
 IMPLM=11;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if verbose >= 10, fprintf(OFP,'[SAD2U1]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=============================================
if IMPLM==11
    z=sum(abs(x-y));
    z=z(:);%ensure a scalar result even in case of 2D shape
end;%


