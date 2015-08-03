% [zhi zlo]= unpack12_s2b(x)  
% [7u0 7u0]= unpack12_s2b(15u0)  
% shape: unc
% type: unc but return a flint
% range: integer
function [zhi zlo]= unpack12_s2b(x)  
    zlo=mod(fix(x),256);
    zhi=mod(fix((x-zlo)/256),256);
end 
