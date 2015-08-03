function lZ= mul21m_l(lX,lY)
% 32x32 -> 32
fX = double(lX); 
fXh= fix(rdivide(fX,power(2,16)));
fXl= rem(fX,65536);

fY = double(lY); 
fYh= fix(rdivide(fY,power(2,16)));
fYl= rem(fY,65536);

pll = times(fXl,fYl);
phl = times(fXh,fYl);
plh = times(fXl,fYh);
zmid= phl+plh;
z= zmid*power(2,16)+pll;
z= rem(z,power(2,31));
lZ = int32(z);%back to 32-bit width (and type)
 