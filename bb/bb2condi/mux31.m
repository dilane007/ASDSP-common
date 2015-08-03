function z = mux31(x,y,v,slct) 
switch(slct)
    case(0),z=x; 
    case(1),z=y; 
    case(2),z=v; 
end