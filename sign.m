% [freemat]matlab sign function; 
% limited to real! NO COMPLEX!!
function z= sign(x)
 x(x<0)=-1;
 x(x>0)=1;
 z=x;
end