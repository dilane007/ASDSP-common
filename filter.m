% z = filter(num,deno,x) filters the data x with the filter described by vectors a and b
% x= input vector.
% num= numerator coefficients 
% deno= denominator coefficients 
% If deno(1) is not equal to 1, filter normalizes the filter coefficients by deno(1). 
% If deno(1) equals 0, filter returns an error.
%
% This is a subset of the functionality of the MATLAB filter. 
%----------------------------------------------
% Date: 6/11/2014 
% Version: v1.0
% Licensed under the GPL
% Copyright (C) 2014 Jonathan Weaver <jonw0224@aim.com>
%----------------------------------------------
% dfm was here
% 1) compute numerator and resize
% 2) feedback result in denominator
% 3) add num and denum
% 4) normalize
%----------------------------------------------
function z = filter(b,a,x)% a and b are inverted as my terminology goes
IMPLM=2;
    if a(1) == 0 
        error('a(1) must be nonzero');
    end
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if IMPLM==1
        z = conv(b,x);%compute num
        y = z(1:length(x));
        ap = [0 -1*a(2:end)];
        ya = y;
        for n = 1:(length(x))
            ya = conv(ya,ap);%compute denom 
            ya = ya(1:length(x));
            y = ya + y;%add num and denom 
        end
    end;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if IMPLM==2% still a bit buggy; 
        ap = [0 -1*a(2:end)];
        %
        z = conv(b,x);%compute num
        yb = z(1:length(x));%; %reduce length= ntaps+length(x)
        ya = conv(yb,ap);%compute denom
        %still a bit buggy; a and b length need to be the same
        if length(ya) > length(yb), 
            ya=ya(1:length(yb)); 
        else yb=yb(1:length(ya)); 
        end;
        y=  ya + yb;%add num and denom 
    end;
    z = y ./ a(1); %normalise
%%%
end