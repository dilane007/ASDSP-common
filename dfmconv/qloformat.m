% 48-bit qformat
function z = qloformat(x,qpoint)
    xr=int64(round(x*power(2,qpoint)));%get rid of under the lsb
    tt= xr.*65536;% another 16<< to saturate
    %here i need a kludge for pmax
     pmax= (power(2,64)-65536).* ones(1,length(x));
     cc= xr>=power(2,48);
     t(cc)= pmax(cc);
     t(~cc)=tt(~cc)
    % 
    z= double(t)/power(2,qpoint+16); %64-48=16
end
