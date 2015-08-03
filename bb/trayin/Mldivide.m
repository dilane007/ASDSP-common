%==================================================
function x = Mldivide(A,b)
N = size(A,1);

% LU decomposition
[L, U] = LU_decomp(A);

% Solve Ly = b
y = zeros(1,N);
for i = 1:N
%     y(i) = b(i) - L(i,1:i-1)*y(1:i-1)';
    sum = 0;
    for j=1:i-1
        sum = sum + L(i,j)*y(j);
    end
    y(i) = b(i) - sum;
end

% Solve Ux = y
x = zeros(1,N);
for i = N:-1:1
%     x(i) = ( y(i) - U(i,i+1:N)*x(i+1:N)' ) / U(i,i);
    sum = 0;
    for j=i+1:N
        sum = sum + U(i,j)*x(j);
    end
    x(i) = ( y(i) - sum ) / U(i,i);
end

