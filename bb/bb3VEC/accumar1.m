% function  z= accumar1(idx,x,xlen,NACC)
function  z= accumar1(idx,x,xlen,NACC)
global PWRONRESET;
global MLABIDX;

    if (PWRONRESET ==0)
        z = int32(zeros(1,NACC)); 
        for iter=0:xlen-1
            n= idx(iter+MLABIDX);
            z(n)= z(n)+ x(iter+MLABIDX);
        end;             
    end;
end
