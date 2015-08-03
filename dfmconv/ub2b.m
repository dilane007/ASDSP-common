function z = ub2b(x)
%unsigned to signed; simpler to use double
 z=double(x);
 cc1=ge(z,128);
 cc2=lt(z,128);
 z(cc1)= z(cc1)-256;
 z(cc2)= z(cc2);
 z= int8(z);
end