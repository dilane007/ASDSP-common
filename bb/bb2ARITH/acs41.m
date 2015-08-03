% z=acs41(x,y,a,b);
% SHAPE: unc
% TYPE: unc
% RANGE: as type
%-------------------------------
function z= acs41(x,y,a,b)
 IMPLM=12;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if verbose >= 10, fprintf(OFP,'[ACS41]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    u= add21(x,a);
    v= add21(y,b);
    %keep smallest metric
    cc=lt21(u,v); %is u<v?
    z=triop31(cc,u,v);%if yes keep u, else keep v
end