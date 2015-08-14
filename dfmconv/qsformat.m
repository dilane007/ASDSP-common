function z = qsformat(x,qpoint,IMPLM)
 if nargin<3, IMPLM=1; end;

 if IMPLM==1
    t =int16(round(x*power(2,qpoint)));
    z= double(t)/(power(2,qpoint)); 
 end;
 if IMPLM==2
    t =int16(round(x*power(2,qpoint)));
    z= soq(t,qpoint); 
 end;
 
end
