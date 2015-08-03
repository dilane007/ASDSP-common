function z=muxa21(x,y,c)
% x,y are numeric 
% c is logical
    z(~c) = x(~c);
    z(c)  = y(c);
end