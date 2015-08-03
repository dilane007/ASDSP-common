% z=abs11s_6q18(x);
% SHAPE: tested row, 2D
% TYPE: qformat
% RANGE: as type
%-------------------------------
function z=abs11s_6q18(x);
 IMPLM=13;
 global verbose
 global OFP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if verbose >= 10, fprintf(OFP,'[ABS11S_6Q18]IMPLM=%d \n',IMPLM);end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=============================================
   if IMPLM==12 
        z=qformat(x,6.18);
        cc= lt(z,0);
        z(cc)= sub21_q(0,z(cc),6.18);
   end;%
   if IMPLM==13 
        cc= lt(x,0);
        z(~cc)= sub21_q(x(~cc),0,6.18);%do nope except it ensures qformat including sat
        z(cc) = sub21_q(0,x(cc),6.18);
   end;%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
