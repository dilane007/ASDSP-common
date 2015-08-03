function z=cat21(xleft, yright, xlen, ylen)
% type:  binary --> decimal 
% shape: IMPLM=1 : 1 binary array --> scalar 
% shape: IMPLM=11: cln of binary arrays --> cln  
% shape: row of binary arrays is NOT ALLOWED  
global OFP
global verbose
IMPLM=1;

if (verbose >=10) fprintf(OFP,'[CAT21]  IMPLM=%d\n',IMPLM);end;

if (IMPLM ==1)
    left=dec2bf(xleft,xlen) 
    right=dec2bf(yright,ylen)
    za= [left(1:end) right(1:end)]
    z= bf2dec(za,0);%
end;
  
if (IMPLM ==11)
     nrow=size(left,1);
     for ii=1:nrow
              lefta= left(ii,:);
              rigta= right(ii,:);
              za= [lefta(1:end) rigta(1:end)];
              zb(ii)= bin2dec(za);
     end;
     z=zb';% return a column                            
 end;

end

    