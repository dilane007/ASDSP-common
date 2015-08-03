function z=bf2dec(x,signed)
% TYPE:  string --> decimal 
% SHAPE: row (of chars) --> scalar
% RANGE: as given by number of bits (==length of string)     
global verbose
global IMPLM
IMPLM=1;
if (verbose >=50) fprintf(1,'=== BF2DEC ===  IMPLM=%d\n',IMPLM);end;

if (IMPLM ==1)
    len=length(x);     
    y= bin2dec(x);
    if (signed == 1)&&(x(1)=='1'), y = y - power(2,len);
    end;
    z= y;     
end;

    