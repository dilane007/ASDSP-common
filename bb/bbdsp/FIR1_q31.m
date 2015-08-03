function zout= FIR1_q31(x,k,nstate)
 zout = zeros(1,1);
 for n= 1:nstate,
      p = mul21s_q31(x(n),k(n));
      zout = add21_q(zout,p,1.31);
 end
end
