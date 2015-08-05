% z=ADD161_Q(x(1:16),qpoint)
%=======================================================
% TYPE= unc (input)  qtype (output)
% SHAPE= vector 1 x 16; row,cln tested
% RANGE= unc (input) given by qtype (output) 
% modal= internally promoted (allow growth)
%        output: saturated to qformat 
%--------------------------------------------    
function  z = add161_q(x,qpoint)
IMPLM=1;
    
if IMPLM == 1    
       b0 = x(1)   + x(2);
       b1 = x(3)   + x(4);
       b2 = x(5)   + x(6);
       b3 = x(7)   + x(8);
       b4 = x(9)   + x(10);
       b5 = x(11)  + x(12);
       b6 = x(13)  + x(14);
       b7 = x(15)  + x(16);
       c0 = b0 + b1; 
       c2 = b2 + b3;
       c4 = b4 + b5; 
       c6 = b6 + b7;
       e0 = c0 + c2; 
       e4 = c4 + c6;
       z = e0+e4;
end;

end