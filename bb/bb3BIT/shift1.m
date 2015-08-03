function z=shift1(x)
%
[M,N]=size(x);
y=zeros(M,N);
y(:,1:N-1)=x(:,2:N);
y(:,N)=y(:,N-1);
z=y;
