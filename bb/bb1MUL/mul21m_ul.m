function ulZ= mul21m_ul(ulX,ulY)
% 32x32 -> 32

%% Input pins: format change and range checking if needed
% do range checking before enforcing input type
cc1= gt(ulX,intmax('uint32')) ;
cc2= lt(ulX,0);
if (any([cc1 cc2])), error('x input not in range');end;
cc1= gt(ulY,intmax('uint32'));
cc2= lt(ulY,0);
if (any([cc1 cc2])), error('y input not in range');end;
% enforce input as integer type (as opposed to fp)
x = uint32(ulX);
y = uint32(ulY);

%% Kernel
%stage1: split the 32-bit word in 16-bit segments
lomask=uint32(hex2dec('0000FFFF'));
xlo=bitand(x,lomask);
ylo=bitand(y,lomask);
xhi=bitshift(x,-16);
yhi=bitshift(y,-16);

%stage2: compute the 3 products 
pll=times(xlo,ylo);
phl=times(xhi,ylo);
plh=times(xlo,yhi);

%stage3: add the 3 products as  
%at this stage the 3 products are right aligned
%first get rid of upper 16bits of mid products  
phl=bitand(phl,lomask);
plh=bitand(plh,lomask);
zmid= plus(phl,plh);
%now take care of lower product by spliting into 2 parts.
pllh=bitshift(pll,-16);
plll=bitand(pll,lomask);
%The hi part will be added to the mid product
zmid= plus(zmid,pllh);
%remask to get rid of possible extra bits, before shifting into place
zmid=bitand(zmid,lomask);
zmid=bitshift(zmid,16);
%at this stage zmid lower 16bits are zero; 
% all is needed is to join with the lower 16bit of pll
% this addition cannot generate any overflow
z =zmid+plll; 

%% Output pins: format change if needed
ulZ = uint32(z);%back to 32-bit width (and type)

%% SIMPLER FP CODE DOES NOT WORK; f**d up by 53bit precision
% %% Input pins: format change and range checking if needed
% % do range checking before enforcing input type
% cc1= gt(ulX,intmax('uint32')) ;
% cc2= lt(ulX,0);
% if (any([cc1 cc2])), error('x input not in range');end;
% cc1= gt(ulY,intmax('uint32'));
% cc2= lt(ulY,0);
% if (any([cc1 cc2])), error('y input not in range');end;
% % enforce input as integer type (as opposed to fp)
% ulX = uint32(ulX);
% ulY = uint32(ulY);
% %conversion to fp necessary to get non-saturated product
% fX = double(ulX); 
% fY = double(ulY); 
% 
% %% Kernel
% fZ = times(fX,fY);
% ueW= uint64(fZ); %back to unsigned integer to bitand the mask
% ueMask =uint64(intmax('uint32'));%zext
% fprintf(1,'%d \n',ueMask);
% ueZ = bitand(ueW,ueMask); %modulo it back in 32-bit range
% 
% %% Output pins: format change if needed
% ulZ = uint32(ueZ);%back to 32-bit width (and type)

 