% function  z= accumar16(idx,x,xlen,NACC)
function  z= accumar16(idx,x,xlen,NACC)
global PWRONRESET;
global MLABIDX;

    if (PWRONRESET ==0)
            NLANE=16;
            z = int32(zeros(1,NACC)); 
            b = int32(zeros(NLANE,NACC));
            NK = floor((xlen-1)/NLANE); 
            for iter=0:NK
                for lane=0:NLANE-1
                   a  = x(NLANE*iter+lane+MLABIDX);
                   n  = idx(NLANE*iter+lane+MLABIDX);
                   b(lane+MLABIDX,n)= b(lane+MLABIDX,n)+ a;
                end
            end
            %replicate add16to1 NACC times        
            for n=1:NACC,  z(n)= add161(b(:,n)); end;
    end;
end
