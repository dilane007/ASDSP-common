%    Sccs Identification (SID) : 1.2

function [ out ] = limit(x, minVal, maxVal)
%LIMIT forces x to between min and max: x, minVal, maxVal
if (minVal >= maxVal)
    disp('Error!');
    return;
end;

out = max(x, minVal);
out = min(out, maxVal);

