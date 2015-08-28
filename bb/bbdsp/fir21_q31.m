function z= fir21_q31(x,k,nstate)
     qpoint=1.31;
     xq= qformat(x(1:nstate),qpoint);%qpoint in input
     kq= qformat(k(1:nstate),qpoint);%
     p= mul21s_q31(xq,kq);%  1q31 * 1q31 --> 2q62 --> (sat)1q31
     z= addV1_q(p,1.31); % 1q31+ 1q31+ ... +1q31   --> sum --(sat)->1q31
end
