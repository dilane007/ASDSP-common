% extract upper 16bit from 32bit; Type=double;
function z=hi11(x)
 verbose=0;
  if (verbose >=10),  disp('HIO11 IMPLM=11 TYPE=double');end; 
  %%%%%%%%%%%%%%%%%%%%
  fx=cast(x,'double');
%   za= rdivide(fx,65536); unknown freemat
  za= fx./65536;
  z = fix(za);
  end
 



