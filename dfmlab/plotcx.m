function plotcx(z,type,set1,set2)
% plot complex numbers; plotcx(z,type,set1,set2)
% type= 'time'|'xy'| 'mag'
    
    if nargin < 3 set1='-';end;
    if nargin < 4 set2=set1;end;
%    
     zr= real(z);
     zi= imag(z);
     zm= cxmag(z);
     t=1:length(z);
%
    if strcmp(type,'time')    plot(t,zr,set1,t,zi,set2);
    elseif strcmp(type,'xy')  plot(zr,zi,set1)
    elseif strcmp(type,'mag') plot(t,zm,set1),
    end;
end