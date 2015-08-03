% z=CADD21(x,y,cc) 
% x,y,z numeric
% cc: logical    
% tested: no

function z=cadd21(x,y,cc)
    tsum= add21(x,y);
    z= muxcc21(tsum,x,cc);
end


