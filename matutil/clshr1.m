function z=clshr1(x)
% cln >> 1 ;  first cln is duplicated
% before  abcdefgh 
% after   aabcdefg 
%
[M,N]=size(x);
y=zeros(M,N);
y(:,2:N)=x(:,1:N-1); 
y(:,1)=y(:,2);
z=y;
