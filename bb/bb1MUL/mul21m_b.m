function bZ= mul21m_b(bX,bY)
% 8x8 -> 8

%% Input pins: format change and range checking if needed
% do range checking
cc1= gt(bX,intmax('int8')); 
cc2= lt(bX,intmin('int8'));
if (any([cc1 cc2])), error('x input not in range');end;
cc1= gt(bY,intmax('int8')); 
cc2= lt(bY,intmin('int8'));
if (any([cc1 cc2])), error('y input not in range');end;

%% Kernel
ubX = b2ub(bX); 
ubY = b2ub(bY); 
%promote is necessary to get non-saturated product
usX = zext(ubX,16); 
usY = zext(ubY,16); 
usW = times(usX,usY);
usMask =zext(intmax('uint8'),16);
usZ = bitand(usW,usMask); %modulo it back in 8-bit range

%% Output pins: format change if needed
ubZ = uint8(usZ);%back to 8-bit width 
bZ = int8(ub2b(ubZ));%back to signed type
 
 