function  z= aaatemplate(idx,x,xlen,NACC)
global PWRONRESET;
global verbose;
global MLABIDX;

    if (PWRONRESET ==0)
        z = zeros(1,NACC); 
        for iter=0:xlen-1
            n= idx(iter+MLABIDX);
            z(n)= z(n)+ x(iter+MLABIDX);
        end;             
        if (verbose >=10), display(z);end;
    end;
end
