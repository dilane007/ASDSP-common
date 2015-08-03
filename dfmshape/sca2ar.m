% z=sca2ar(x,dim)  
% expand a scalar(z) to an array(n,m)
function z=sca2ar(x,dim)
    n=dim(1);
    if length(dim) ==2, 
        m=dim(2); else m=n; 
    end;
    z=x(ones(n,m));
end

