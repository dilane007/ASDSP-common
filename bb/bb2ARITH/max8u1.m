% z=max8u1(bank)   return the max of an unary lane of 8
%
function z=max8u1(bank);
IMPLM=3;
    if IMPLM==2  
        [x y]= deinter(bank);
        cc= gt(x,y); 
        v(1)= mux21(y(1),x(1),cc(1));
        v(2)= mux21(y(2),x(2),cc(2));
        v(3)= mux21(y(3),x(3),cc(3));
        v(4)= mux21(y(4),x(4),cc(4));
        %
        [r s]= deinter(v);
        cc1= gt(r,s);
        w(1)= mux21(s(1),r(1),cc1(1));
        w(2)= mux21(s(2),r(2),cc1(2));
        %
        cc2= gt(w(1),w(2)); 
        z = mux21(w(2),w(1),cc2);
       % 
    end%
    if IMPLM==3  
        [x y]= deinter(bank);
        cc= gt(x,y);
        v= omux21(y,x,cc,4);
        %
        [r s]= deinter(v);
        cc1= gt(r,s);
        w= omux21(s,r,cc1,2);
        %
        cc2= gt(w(1),w(2)); 
        z = omux21(w(2),w(1),cc2,1);
    end;%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

