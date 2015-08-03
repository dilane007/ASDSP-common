% z=sca2cln(x,len)  
% expand a scalar(x) to a cln vector z(1:len)
function z=sca2cln(x,len)
    z=x(ones(1,len));%this construct always returns a column independently of the shape of ones
end

