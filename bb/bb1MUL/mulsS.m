function z= mulsS(x,y)
fxp_init('sw','s','f',0,0,0,0,'prop_on');

fxp_short_mode('on');
fxp_integer_mode('off');
fxp_saturate('on');

mbfxpscalar(1,15,'s',x,y);

z = x.*y;

