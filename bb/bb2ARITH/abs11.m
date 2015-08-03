%z = abs11(x)
% x 
% no shape,type,range checking
% z
%  TYPE= double
function  z = abs11(x)
       cc=x<0;
       z(cc)= 0-x(cc);
       z(~cc)= x(~cc); 
end
