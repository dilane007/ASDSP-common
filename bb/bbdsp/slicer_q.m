% z=SLICER_Q(x,up,lo,qpoint)   return the signals limited in upper and lower;
% limits do NOT need to be up=positive and lo=negative
%-------------------------------------------------
% TYPE=unc 
% SHAPE= scalar,vector; array fails
% RANGE= as qpoint
% modal= using 2 blocks which are not q format; ??
function z=slicer_q(x,kup,klo,qpoint)
    
if nargin < 4, qpoint=53.53; end;
    
    %stage 1; expand constant
    len=length(x);
    uplim=qformat(sca2row(kup,len),qpoint);
    lolim=qformat(sca2row(klo,len),qpoint);
    %stage 2; slice upper x followed by lower x 
    xq= qformat(x,qpoint);
    y=limitup(xq,uplim);        
    yq= qformat(y,qpoint);
    z=limitlo(yq,lolim);        
end


