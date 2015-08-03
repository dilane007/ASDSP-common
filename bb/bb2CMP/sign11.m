% SIGN11
% matlab sign function returns 3 values, not a cc; 
% limited to real! NO COMPLEX!!
function z= sign11(x)
 x(x<0)=-1;
 x(x>0)=1;
 z=x;
end