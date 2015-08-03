function ubZ = mul21m_ub(ubX,ubY)
% 8x8 -> 8

%% Input pins: format change and range checking if needed
% do range checking
cc1= gt(ubX,intmax('uint8')); 
cc2= lt(ubX,0);
if (any([cc1 cc2])), error('x input not in range');end;
cc1= gt(ubY,intmax('uint8'));
cc2= lt(ubY,0);
if (any([cc1 cc2])), error('y input not in range');end;
%promote is necessary to get non-saturated product
% it also enforce input as integer type (as opposed to fp)
usX = uint16(ubX); 
usY = uint16(ubY); 

%% Kernel
usW = times(usX,usY);
usMask =uint16(intmax('uint8'));%zext
usZ = bitand(usW,usMask); %modulo it back in 8-bit range

%% Output pins: format change if needed
ubZ = uint8(usZ);%back to 8-bit width (and type)
 