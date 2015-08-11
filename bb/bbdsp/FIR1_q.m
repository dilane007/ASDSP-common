% z= fir1_q(x,k,nstate,qpoint) Fir Filter of length=nstates
function z= fir1_q(x,k,nstate,qpoint)
%%%
    if nargin < 4, qpoint=53.53; end;      
%%%
 IMPLM=12;

%%%
%MODAL: Mtimes internal is 53q53; q format only on output       
 if IMPLM == 1 %vectorized function 
     s= mtimes(x,k');% mtimes == times where m means matrix --> requires row x cln
     z= qformat(s,qpoint);
 end;
%%%
%MODAL: Mult, Add in qformat       
 if IMPLM == 11 %non vectorized function 
     z = zeros(1,1);
     % ensures inputs are qformat, b'cause first operation is mult
     xq= qformat(x(1:nstate),qpoint);%qpoint in input
     kq= qformat(k(1:nstate),qpoint);%
     for n= 1:nstate,
         p = times(xq(n),kq(n) );
         pq = qformat(p,qpoint);
         z = add21_q(z,pq,qpoint);
     end;
 end;
%%%
%SHAPE: mult in parallel; accum. is tricky --> uses addV1 which is an alias name for sum()     
%MODAL: mult is q format; addv1 promotes before scaling to qformat     
 if IMPLM == 12 %vectorized function 
     % ensures inputs are qformat, b'cause first operation is mult
     xq= qformat(x(1:nstate),qpoint);%qpoint in input
     kq= qformat(k(1:nstate),qpoint);%
     p= mul21_q(xq,kq,qpoint);
     z= addV1_q(p,qpoint);
  end;
 
end



