% z=sca2row(x,len)  
% expand a scalar(x) to a row vector z(1:len)
function z=sca2row(x,len)
    z=x(ones(1,len))';
end

