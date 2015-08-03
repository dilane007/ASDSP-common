function z = s2ul(x) 
% signed short to unsigned long; 
% usage is to a left shift
% simpler to use double
 z=  double(x);
 cc1= ge(z,0);
 cc2= lt(z,0);
 z(cc1)= z(cc1);
 z(cc2)= z(cc2)+32768;
 z= uint32(z);
end


