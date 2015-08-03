function z=ishift1(x)
% z^{-1}
[M,N]=size(x);
y=zeros(M,N);
y(:,2:N)=x(:,1:N-1);
y(:,1)=y(:,2);
z=y;
