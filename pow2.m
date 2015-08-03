%[DFM]
%z= POW2(x) returns z = 2.^x
%z= POW2(frac,expo) inverse of log2 returns z = FRAC.*2.^EXPO
% frac and expo are real and integer, respectively
% shape, type, range checking: none
function z= pow2(x,y)
    if nargin < 2, 
        z= 2.^x;
    else
        x= frac; y= expo;
        z= frac.*2.^expo;
    end;
end
    

