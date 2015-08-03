% [zhh zhl zlh zll]= unpack14_l2b(x)  
% [7u0 7u0 7u0 7u0]= unpack14_l2b(31u0)  
% shape: unc
% type: unc but return a flint
% range: integer
function [zhh zhl zlh zll]= unpack14_l2b(x)  
    zll= mod(fix(x),256);
    zlh= mod(fix((x-zll)/256),256);
    zhl= mod(fix((x-zlh)/power(2,16)),256);
    zhh= mod(fix((x-zhl)/power(2,24)),256);
end 

