%z=MUXCC21(x,y,cc)
% x,y are numeric 
% cc is logical; z=x (cc is true) else z=y (cc is false)
% z = cc?x:y  equivalent C
function z=muxcc21(x,y,cc)
    z(cc) = x(cc);
    z(~cc)  = y(~cc);
end