function z = mux41(x,y,v,l,slct) 
switch(slct)
    case(0),z=x; 
    case(1),z=y; 
    case(2),z=v; 
    case(3),z=l; 
end