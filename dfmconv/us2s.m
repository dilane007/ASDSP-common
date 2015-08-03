function z = us2s(x)
%unsigned to signed; simpler to use double
 z=double(x);
 cc1=ge(z,32768);
 cc2=lt(z,32768);
 z(cc1)= z(cc1)-32768;
 z(cc2)= z(cc2);
 z= int16(z);
end