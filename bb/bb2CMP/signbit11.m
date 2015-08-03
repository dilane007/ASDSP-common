% z= signbit11(x) returns sign bit (0 or 1)
% this is NOT matlab sign() which returns 3 values
function z= signbit11(x)
    x(x>=0)=0;
    x(x<0)=1;
    z=x;
end