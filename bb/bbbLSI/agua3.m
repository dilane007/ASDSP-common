%AGUA3 AGU type A generating 3 addresses
% [adx ady adz regfile] = agua3(admod,regfile)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adx, ady, adz: generated address bus  
% regfile: external register file(as opposed to having a persistent) saved and restored every call
% admode: addressing mode
% base: must be at least 1, if 0 there is index=0 error
% stride: number of elements per access
% step: next access 
% modo: modulo limit; used in circular addressing
function [adx ybus zbus regfile] = agua3(admod,regfile)
    switch(admode)
        case('amode0')
            adx= regfile.xbase+regfile.xreg;
            ady= regfile.ybase+regfile.yreg;
            adz= regfile.zbase+regfile.zreg;
        case('amode1')
            adx= regfile.xbase+mode(regfile.xreg,regfile.xmodo);
            ady= regfile.ybase+mode(regfile.yreg,regfile.ymodo);
            adz= regfile.zbase+mode(regfile.zreg,regfile.zmodo);
        otherwise
            disp('error');
    end;
    regfile.xreg= regfile.xreg+ regfile.xstep;
    regfile.yreg= regfile.yreg+ regfile.ystep;
    regfile.zreg= regfile.zreg+ regfile.zstep;
end
    
    
