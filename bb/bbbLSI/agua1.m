%AGUA1 AGU type A generating 1 single addresse
% [abus areg] = agua1(base,para,admode,areg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% abus: generated address bus  
% areg: external register (as opposed to having a persistent) saved and restored every cycle
% base: must be at least 1, if 0 there is index=0 error
% para:  is admode dependent; not smart
% admode: addressing mode (0=standard  1=circular 2=block access
%------------------------------------------    
function [abus areg] = agua1(base,para,admode,areg)
    switch(admode)
        case('amode0')
            abus= base+areg;
        case('amode1')
            abus= base + mod(areg,para);%para=modulo limit
        case('amode2')
            abus= base:base+para-1;
        otherwise
            disp('error');
    end;
    switch(admode)
        case('amode0')
            areg= areg+1;
        case('amode1')
            areg= areg+1;
        case('amode2')
        otherwise
            disp('error');
    end;
end
    
    
