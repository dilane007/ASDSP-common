function z = b2ub(x)
%signed to unsigned; simpler to use double
 z=  double(x);
 cc1= ge(z,0);
 cc2= lt(z,0);
 z(cc1)= z(cc1);
 z(cc2)= z(cc2)+256;
 z= uint8(z);
end