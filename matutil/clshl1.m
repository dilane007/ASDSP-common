function z=clshl1(x)
% cln << 1 ;  last cln is duplicated
% before  abcdefgh 
% after   bcdefghh 
%
[M,N]=size(x);
y=zeros(M,N);
y(:,1:N-1)=x(:,2:N);
y(:,N)=y(:,N-1);
z=y;
