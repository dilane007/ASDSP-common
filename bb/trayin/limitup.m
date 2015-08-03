% z=limitup(x,y)  limit signal (x) with upper limit (y)
% tested: not exhaustive in (original) ariti\max168
%
function dout=limitup(a,b)
    c=lt(a,b);
    dout(c)=a(c);        
    dout(~c)=b(~c);
end
