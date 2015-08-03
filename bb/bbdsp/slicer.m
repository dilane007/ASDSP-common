% z=SLICER(x,up,lo)   return the signals limited in upper and lower;
% limits do NOT need to be up=positive and lo=negative
% SHAPE= scalar,vector; array fails
% TYPE=unc
% RANGE=unc
function z=slicer(x,kup,klo);
        %stage 1; expand constant
        len=length(x);
        uplim=sca2row(kup,len);
        lolim=sca2row(klo,len);
        %stage 2; slice upper x followed by lower x 
        y=limitup(x,uplim);        
        z=limitlo(y,lolim);        
end


