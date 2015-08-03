function zout= FIRSB_q(x,k,nstate,nfir,qpoint)

 zout = zeros(1,nfir);
 p = zeros(1,nfir);
 for nn = 1:nfir,
       for nk = 1:nstate,
          p(nn) = mul21(x(nk),k(nn,nk) );
          zout(nn) = add21_q(zout(nn), p(nn),qpoint);
       end
 end
end
