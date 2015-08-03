% ariti\ABSDIF\absdif21s_6q18.m
% z= absdif21s_6q18(x,y);
% SHAPE: tested row, 2D
% TYPE: qformat
% RANGE: as type
%-------------------------------
function z=absdif21s_6q18(x,y);
 IMPLM=13;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if verbose >= 10, fprintf(OFP,'[ABSDIF21S_6Q18]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=============================================
   if IMPLM==12 
        z= sub21_q(x,y,6.18);
        cc= lt(z,0);
        z(cc)= sub21_q(0,z(cc),6.18);
   end;%
   if IMPLM==13 
        cc= gt(x,y);
        z(cc) = sub21_q(x(cc),y(cc),6.18);
        z(~cc)= sub21_q(y(~cc),x(~cc),6.18);
   end;%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

