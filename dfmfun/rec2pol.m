%  [mag phase]=rec2pol(complex_number) a vector [magnitude phase]
% Written by S Williams UTS Sydney 9/8/14
% Good for quick conversion between rectangular and polar form of complex numbers
%_
% exampes: a=rec2pol(1+i)% returns double [1.4142 45]
%rec2pol(1-j)
% Answer is a double in format [magnitude   phase(degrees)]
%Results need to be interpreted when entering matrices (not recommended)
function [mag phase] = rec2pol(c)
     mag=abs(c);
     phase=angle(c)*(180/pi);
end
    

