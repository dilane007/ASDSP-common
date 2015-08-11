% z= FIRSB_Q(x,k,nstate,nfir,qpoint)  FIR SYMMETRIC BLOCK
% TYPE= unc
% SHAPE= vectors
% MODAL= 
function z= firsb_q(x,k,nstate,nfir,qpoint)
 z = zeros(1,nfir);
 p = zeros(1,nfir);
 xq= qformat(x,qpoint);
 kq= qformat(k,qpoint);
 for nn = 1:nfir,
       for nk = 1:nstate,
           pq(nn) = mul21_q(xq(nk),kq(nn,nk),qpoint );
           z(nn) = add21_q(z(nn), pq(nn),qpoint);
       end;
 end
end
