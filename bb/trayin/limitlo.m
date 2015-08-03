% z=limitlo(x,y)  limit signal (x) with lower limit (y)
% tested: not exhaustive in (original) ariti\max168
%
function dout=limitlo(a,b)
    c=gt(a,b);
    dout(c)=a(c);        
    dout(~c)=b(~c);
end