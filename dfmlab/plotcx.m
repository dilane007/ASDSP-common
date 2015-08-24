% dfmlab\plotcx.m
% plot complex numbers; plotcx(z,type,set1,set2)
% type= 'time'|'xy'| 'mag'
function plotcx(z,type,seto1,seto2)
    
    if nargin < 4 set2='k'; else error('DO NOT USE: failing para');end;
    if nargin < 3 set1='g'; else error('DO NOT USE: failing para');end;
    if nargin < 2 type='time'; end; 
%    
    zr= real(z);
    zi= imag(z);
    zm= cxmag(z);%should be 1
    zm2= abs(zr + zi);% used as scale in plotting
    t=1:length(z);
%
    if strcmp(type,'time'),ch1=zr; ch2=zi; end;    
    if strcmp(type,'mag'), ch1=zm; ch2=zm2; end;
%    
    switch(type)
         case {'time', 'mag'} plot(t,ch1,set1,t,ch2,set2);
         case {'xy'}, plot(zr,zi,set1); 
    end;
     

end