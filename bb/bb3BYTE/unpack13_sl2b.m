% [zhi zmid zlo]= unpack13_sl2b(x)  
% [7u0 7u0 7u0]= unpack13_sl2b(23q0)  
% shape: unc
% type: unc but return a flint
% range: integer
function [zhi zmid zlo]= unpack13_sl2b(x)  
    zlo= mod(fix(x),256);
    zmid=mod(fix((x-zlo)/256),256);
    zhi= mod(fix((x-zmid)/65536),256);
end 

