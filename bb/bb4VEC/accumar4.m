% function  z= accumar4(idx,x,xlen,NACC)
function  z= accumar4(idx,x,xlen,NACC)
global PWRONRESET;
global MLABIDX;

    if (PWRONRESET ==0)
        NLANE=4;
        z   = int32(zeros(1,NACC)); 
        zhh = z;
        zhl = z; 
        zlh = z; 
        zll = z; 
        NK = floor((xlen-1)/NLANE); 
        for iter=0:NK
            xhh =  x(NLANE*iter+0+MLABIDX);
            xhl =  x(NLANE*iter+1+MLABIDX);
            xlh =  x(NLANE*iter+2+MLABIDX);
            xll =  x(NLANE*iter+3+MLABIDX);
            n3= idx(NLANE*iter+0+MLABIDX);
            n2= idx(NLANE*iter+1+MLABIDX);
            n1= idx(NLANE*iter+2+MLABIDX);
            n0= idx(NLANE*iter+3+MLABIDX);
            zhh(n3) = zhh(n3)+ xhh;
            zhl(n2) = zhl(n2)+ xhl;
            zlh(n1) = zlh(n1)+ xlh;
            zll(n0) = zll(n0)+ xll;
        end     
        for n=1:NACC
           z(n)= add41(zhh(n),zhl(n),zlh(n),zll(n));
        end;
    end;
end
