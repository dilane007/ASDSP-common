% z=abs11s_q(x,qpoint);
% SHAPE: tested row, 2D
% TYPE: qformat
% RANGE: as type
%-------------------------------
function z=abs11s_q(x,qpoint);
 IMPLM=13;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if verbose >= 10, fprintf(OFP,'[ABS11S_Q]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=============================================
   if IMPLM==12 
        z=qformat(x,qpoint);
        cc= lt(z,0);
        z(cc)= sub21_q(0,z(cc),qpoint);
   end;%
   if IMPLM==13 
        cc= lt(x,0);
        z(~cc)= sub21_q(x(~cc),0,qpoint);%do nope except it ensures qformat including sat
        z(cc) = sub21_q(0,x(cc),qpoint);
   end;%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

