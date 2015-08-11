% z=ADDV1_Q(x(1:N),qpoint)
%=======================================================
% TYPE= unc (input)  qtype (output)
% SHAPE= vector 1 x n; row,tested
% RANGE= unc (input) given by qtype (output) 
% modal= internally promoted (allow growth)
%        output: saturated to qformat 
%--------------------------------------------    
function  z = addV1_q(x,qpoint)
IMPLM=1;
    
    if IMPLM == 1    
       s = sum(x);
       z = qformat(s,qpoint);
    end;

end