% a= accumar2(idx,x,xlen,NACC)
function  a= accumar2(idx,x,xlen,NACC)
global PWRONRESET;
global MLABIDX;
IMPLM=2;

    if ( (PWRONRESET ==0) && (IMPLM==1))
        a = int32(zeros(1,NACC)); 
        aeve = a; 
        aodd = a; 
        NK = floor((xlen-1)/2); 
        for iter=0:NK
            neve= idx(2*iter+MLABIDX);
            nodd= idx(2*iter+1+MLABIDX);
            aeve(neve) = aeve(neve)+ x(2*iter+MLABIDX);
            aodd(nodd) = aodd(nodd)+ x(2*iter+1+MLABIDX);
        end     
        for n=1:NACC
           a(n)= aeve(n) + aodd(n);
        end;
    end;

    if ( (PWRONRESET ==0) && (IMPLM==2))
        a = int32(zeros(1,NACC)); 
        NK = floor((length(x)-1)/2); 
        for kk=0:NK
            neve= idx(2*kk+MLABIDX);
            nodd= idx(2*kk+1+MLABIDX);
            if (neve ==nodd), passgate=0; else passgate=1; end;%fused add
            beve = a(neve)+ x(2*kk+MLABIDX);
            bodd = passgate*a(nodd)+ x(2*kk+1+MLABIDX);
            if (neve==nodd)
                a(neve)=beve+bodd; %fused add
            else
                a(neve)= beve;
                a(nodd)= bodd; 
            end;
        end     
    end;

end
