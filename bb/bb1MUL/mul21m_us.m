function usZ = mul21m_us(usX,usY)
% 16x16 -> 16

%% Input pins: format change and range checking if needed
% do range checking
cc1= gt(usX,intmax('uint16'));
cc2= lt(usX,0);
if (any([cc1 cc2])), error('x input not in range');end;
cc1= gt(usY,intmax('uint16'));
cc2= lt(usY,0);
if (any([cc1 cc2])), error('y input not in range');end;
%promote is necessary to get non-saturated product
% it also enforce input as integer type (as opposed to fp)
ulX = uint32(usX); 
ulY = uint32(usY); 

%% Kernel
ulW = times(ulX,ulY);
ulMask = uint32(intmax('uint16')); 
ulZ = bitand(ulW,ulMask); %modulo it back in 16-bit range

%% Output pins: format change if needed
usZ = uint16(ulZ);%back to 16-bit width (and type)
 