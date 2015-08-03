function zout= FIR1_q(x,k,nstate,qpoint)

 zout = zeros(1,1);
 for n= 1:nstate,
      p = times(x(n),k(n) );
      qP = qformat(p,qpoint);
      zout = add21_q(zout,qP,qpoint);
 end

end