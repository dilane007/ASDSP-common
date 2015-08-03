%[DFM]
%z= rdivide(x,y) returns z = x/y 
% (not standard division) but works the same on scalar, vector but NOT on array!
% shape, type, range checking: none
function z= rdivide(x,y)
    z=x./y;
end
    

