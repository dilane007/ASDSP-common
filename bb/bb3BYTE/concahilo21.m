% concatenate upper and lower 16bit; Type: double
function z=concahilo21(xlo,xhi)
  verbose=0;
  if (verbose >=10),  disp('CONCAHILO21 IMPLM=11 TYPE=double');end; 
  %%%%%%%%%%%%%%%%%%%%
  fxlo=cast(xlo,'double');
  fxhi=cast(xhi,'double');
%   z=plus(fxlo,times(fxhi,65536)); [FREEM]fail
  z=plus(fxlo,fxhi.*65536);
end
 



