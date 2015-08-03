function [z w]=split12(x,left,right,bflen,signed)
% there is a special case: if x=0 the bin. array length is only 1 digit
%    
global verbose
IMPLM=1;

if nargin <5 signed=0; end;

 if (verbose >=10) fprintf(1,'======DATA PATH ======  IMPLM=%d\n',IMPLM);end;

 if (IMPLM ==1)
    y=dec2bin(x,bflen);
    if (x==0) 
             y(1:bflen)='0';
    end;
    z=bf2dec(y(1:left),signed); 
    w=bf2dec(y(right:end),signed); 
 end;
 
 if (IMPLM ==11)
     nrow=size(x,1)
         for ii=1:nrow
             xa=x(ii);
             ya=dec2bin(xa,bflen);
             if (xa==0) 
                 ya(1:bflen)='0';
             end;
             za=ya(1:left) ;
             wa=ya(right:end);
            z(ii,:)= za;
            w(ii,:)= wa;
        end;
 end;

 if (IMPLM ==12)
     ncln=size(x,2)
     begz=1; begw=1;
     for ii=1:ncln
             xa=x(ii);
             ya=dec2bin(xa,bflen);
             if (xa==0) 
                 ya(1:bflen)='0';
             end;
             za=ya(1:left) ;
             wa=ya(right:end);
             % multiple rows
             endz= ii.*length(za);
             z(1,begz:endz)= za;
             begz= endz+1;
             %
             endw= ii.*length(wa);
             w(1,begw:endw)= wa;
             begw=endw+1;
     end;
 end;

 if (IMPLM ==1.55)
     yes=isscalar(x);
     if (yes==0) error('x must be a scalar') ; end;
     if (x==0) xa=1; end;  %special case
     y=dec2bin(xa,bflen);
     if (x==0), y(end)='0'; end; %special case
     z=y(1:left); 
     w=y(right:end); 
 end
  
end



    