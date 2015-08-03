% ariti\ABSDIF\absdif21s_q.m
% z=absdif21s_q(x,y,qpoint);
% SHAPE: tested row, 2D
% TYPE: qformat
% RANGE: as type
%-------------------------------
function z=absdif21s_q(x,y,qpoint);
 IMPLM=13;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if verbose >= 10, fprintf(OFP,'[ABSDIF21S_Q]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=============================================
   if IMPLM==12 
        z= sub21_q(x,y,qpoint);
        cc= lt(z,0);
        z(cc)= sub21_q(0,z(cc),qpoint);
   end;%
   if IMPLM==13 
        cc= gt(x,y);
        z(cc) = sub21_q(x(cc),y(cc),qpoint);
        z(~cc)= sub21_q(y(~cc),x(~cc),qpoint);
   end;%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

