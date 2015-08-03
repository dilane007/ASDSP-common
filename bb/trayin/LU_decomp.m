function [L, U] = LU_decomp(A)

mbrealmatrix(A);

N=size(A,1);
L = zeros(N,N);
U = zeros(N,N);

% Set diagonal of L to all 1
for i=1:N
    L(i,i) = 1;
end

% First line of U is same as A
U(1,:) = A(1,:);

% Iterative LU decomposition
for row = 2:N
    for j = 1:row-1
%         L(row,j) = (A(row,j) - L(row,1:j-1)*U(1:j-1,j) ) / U(j,j);
        sum = 0;
        for k=1:j-1
            sum = sum + L(row,k)*U(k,j);
        end
        L(row,j) = (A(row,j) - sum ) / U(j,j);
    end
    for j = row:N
%         U(row,j) = A(row,j) - L(row,1:row-1)*U(1:row-1,j);
        sum = 0;
        for k=1:row-1
            sum = sum + L(row,k)*U(k,j);
        end
        U(row,j) = A(row,j) - sum;
    end
end

