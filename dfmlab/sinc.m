function z = checkerboard(n, m)
    z = zeros(n,m);
    for row = 1:size(z,1)
        for cln= 1:size(z, 2)
            if (mod(row,2) == 0 && mod(cln,2) ~= 0) || (mod(cln,2) == 0 && mod(row,2) ~= 0)
            z(i,j) = 1;
            end
        end
    end
end

