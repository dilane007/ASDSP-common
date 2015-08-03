function sZ= mul21m_s(sX,sY)
% 16x16 -> 16

%% Input pins: format change and range checking if needed
% do range checking
cc1= gt(sX,intmax('int16')); 
cc2= lt(sX,intmin('int16'));
if (any([cc1 cc2])), error('x input not in range');end;
cc1= gt(sY,intmax('int16')); 
cc2= lt(sY,intmin('int16'));
if (any([cc1 cc2])), error('y input not in range');end;

%% Kernel
usX= s2us(sX); 
usY= s2us(sY); 
%promote is necessary to get non-saturated product
ulX= zext(usX,32); 
ulY= zext(usY,32); 
ulW= times(ulX,ulY);
ulM= zext(intmax('uint16'),32);
ulZ= bitand(ulW,ulM); %modulo it back in 16-bit range

%% Output pins: format change if needed
usZ= uint16(ulZ);%back to 16-bit width 
sZ = int16(us2s(usZ));%back to signed type
 
 