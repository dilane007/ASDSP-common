% 24-bit qformat
% <25jun2015> length(x() changed to size(x,1)*size(x,2) to cover 2D case 
function z = qoformat(x,qpoint)
    xr= int32(round(x*power(2,qpoint)));%be sure to get rid of anything below q18 
    tt=  xr.*256;%be sure to sat if needed; 32bit - 24bit = 8
    %here i need a kludge for pmax
    pmax= (power(2,31)-256).* ones(1,size(x,1)*size(x,2));
    cc= xr>=power(2,23);
    t(cc)= pmax(cc);
    t(~cc)=tt(~cc);
    %
    z= double(t)/(power(2,qpoint+8)); 
end
