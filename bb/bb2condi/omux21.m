% z=omux21(y,x,cc,topology) 
% topology=1,2,4,8 : used as single,double,quad,octo mux;
% note inversion x y    
% tested: not exhaustive in (original) ariti\max8u1

function z=omux21(y,x,cc,topology)
    switch(topology) 
         case 1
             z= mux21(y,x,cc);
         case 2
             z(1)= mux21(y(1),x(1),cc(1));
             z(2)= mux21(y(2),x(2),cc(2));
         case 4
             z(1)= mux21(y(1),x(1),cc(1));
             z(2)= mux21(y(2),x(2),cc(2));
             z(3)= mux21(y(3),x(3),cc(3));
             z(4)= mux21(y(4),x(4),cc(4));
         case 8
             z(1)= mux21(y(1),x(1),cc(1));
             z(2)= mux21(y(2),x(2),cc(2));
             z(3)= mux21(y(3),x(3),cc(3));
             z(4)= mux21(y(4),x(4),cc(4));
             z(5)= mux21(y(5),x(5),cc(5));
             z(6)= mux21(y(6),x(6),cc(6));
             z(7)= mux21(y(7),x(7),cc(7));
             z(8)= mux21(y(8),x(8),cc(8));
         otherwise
             disp('[OMUX21]NOT IMPLEMENTED');
    end;
end


