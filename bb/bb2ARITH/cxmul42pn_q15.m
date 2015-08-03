function  [zr zi] = cxmul42pn_q15(xr,xi,yr,yi,strucpara)
% 1q15 x 1q15 -> 2q14
% 1q15 x 1q15 -> 3q13
%Structure Parameters
% growthmode: 
%    0= The cplx nmber is on the unit circle and can ovflow only by 1 bit    
%    1= The cplx nmber is not on the unit circle and can overflow 2 bits; output is 3q13 
%-------------------------------------------
if (nargin< 5)
    growth=0;
else
    growth=~strucpara.growthmode;
end;


%% Input pins: format change and range checking if needed
xr= qformat(xr,1.15); 
xi= qformat(xi,1.15); 
yr= qformat(yr,1.15); 
yi= qformat(yi,1.15); 

%% Kernel
 a= times(xr,yr);
 b= times(xi,yi);
 c= times(xr,yi);
 d= times(xi,yr);
 zr= minus(a,b);
 zi= plus(c,d);
 
%% Output pins: format change if needed
 switch(growth) 
     case(0) 
        zr= qformat(zr,2.14); 
        zi= qformat(zi,2.14); 
     case(1)
        zr= qformat(zr,3.13);
        zi= qformat(zi,3.13); 
     % for 3.14 use 3.29 instead
end
