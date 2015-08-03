% z= PADEVEN(x,len,k)  if length of vector X of is odd, pad 1 additional element of value k  
%-----------------------------------------------
function z=padeven(x,len,k);
verbose=0;
OFP=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if verbose >= 10 fprintf(OFP,'[PADEVEN]IMPLM=11 \n');end; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  cc= fix(len/2)*2 ==len;        
  if cc z=x; else z=[x k]; end;        
end

