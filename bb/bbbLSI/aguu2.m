%AGUU2 AGU Universal type 2
% [abus areg] = aguu2(base,stride,step,modulim,admode,areg)
% abus: generated address bus  
% areg: external register (as opposed to having a persistent) saved and restored every cycle
% base: must be at least 1, if 0 there is index=0 error
% stride: number of elements per access
% step: next access <-- this is not very good
% modulim: modulo limit; used in circular addressing
% admode: addressing mode
function [abus areg] = aguu2(base,stride,step,modulim,admode,areg)
    strider= areg:areg+stride-1;
    switch(admode)
        case('amode0')
            abus= base+strider;
        case('amode1')
            abus= base+ mod(strider,modulim);
        otherwise
            disp('error');
    end;
    areg= areg+step;
end
    
    

