function z = checkerboard(n, m)
    if nargin <2 m=n; end;
    z = zeros(n,m);

    for i = 1:size(z, 1)
        for j = 1:size(z, 2)
            if (mod(i,2) == 0 && mod(j,2) ~= 0) || (mod(j,2) == 0 && mod(i,2) ~= 0)
                z(i,j) = 1;
            end;
        end;
    end;
end

