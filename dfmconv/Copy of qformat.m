function z = qformat(x,qpoint)
% <060609> addition bytes; limits
% <060609> limits are 8q8 and 16q16
% <060609> upper limit to 40bits
% <070909> upper limit to 50bits; addition format q extended
% <071709> return on 53q53; meaning q format is double fp
if (eq(qpoint,5353)), z=x; return; end; %donothing%
if (gt(qpoint,50)),error('q point must be between 0 and 50');end;
if (lt(qpoint,0 )),error('q point must be between 0 and 50');end;
    if (gt(qpoint,31))
        z=qeformat(x,qpoint);   
    else
        if (gt(qpoint,15))
            z=qlformat(x,qpoint);    
        else
            if (gt(qpoint,7))
                z=qsformat(x,qpoint);
            else
                z=qbformat(x,qpoint); 
            end;
        end;
    end;
end
