function z = s2us(x) 
%implement1
%signed to unsigned; simpler to use double
 z=  double(x);
 cc1= ge(z,0);
 cc2= lt(z,0);
 z(cc1)= z(cc1);
 z(cc2)= z(cc2)+32768;
 z= uint16(z);
end

% %implement2
%  strTmp= s2hex(sX);
%  usZ= hex2us(strTmp);


