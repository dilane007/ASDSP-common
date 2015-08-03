% z=MIN21(x,y)
% x,y,z are numeric 
function z=min21(x,y)
    cc=lt21(x,y);
    z=muxcc21(x,y,cc);
end