function z=bitrev11(x,nbits)
% TYPE:  integer decimal --> integer decimal
% SHAPE: scalar, row or cln vectors fail
    
global verbose
global OFP;
IMPLM=2;


if (verbose ==10) fprintf(OFP,'[BITREV11]  IMPLM=%d\n',IMPLM);end;

if (IMPLM ==1)
    bfin= dec2bin(x,nbits);     
    bfout= bfin(end:-1:1);
    z=bin2dec(bfout);
end;

if (IMPLM ==2)
    bfin= dec2bf(x,nbits)   
    bfout= bfin(end:-1:1)
    z= bf2dec(bfout,1);
end;
end
% 
% 
% function z=bf2dec11_local(x,signed,qpoint)
%  y= bin2dec(x);
%  if (signed == 1)
%      if (x(1)==1), y =  y - power(2,32);end;
%   end;
%   z= y * power(2,qpoint);  
% end
%     