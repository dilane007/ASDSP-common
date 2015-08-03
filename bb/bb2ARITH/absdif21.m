% ariti\ABSDIF\absdif21.m
% z=absdif21(x,y);
% SHAPE: unc
% TYPE: unc
% RANGE: as type
%-------------------------------
function z=absdif21(x,y,qpoint);
 IMPLM=13;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if verbose >= 10, fprintf(OFP,'[ABSDIF21]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=============================================
   if IMPLM==12 
        z= sub21(x,y);
        cc= lt(z,0);
        z(cc)= sub21(0,z(cc));
   end;%
   if IMPLM==13 
        cc= gt(x,y);
        z(cc) = sub21(x(cc),y(cc));
        z(~cc)= sub21(y(~cc),x(~cc));
   end;%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

