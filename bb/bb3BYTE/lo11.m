% extract lower 16bit from 32bit; Type=double
function z=lo11(x)
  verbose=0;
  if (verbose >=10),  disp('LO11 IMPLM=11 TYPE=double');end; 
  %%%%%%%%%%%%%%%%%%%%
  fx=cast(x,'double');
  cc = x <0;
  kk(cc)= 65536; kk(~cc)= -65537;
  z= rem(fx,kk);
end
 



