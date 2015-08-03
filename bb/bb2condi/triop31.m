%z=TRIOP31(cc,x,y)
% (equivalent C) z(ii) = cc(ii)?x(ii):y(ii)  
% x,y are numeric 
% cc is logical; z=x (cc is true) else z=y (cc is false)
% <14jul2015> changed cc and ~cc to cc==1  and cc==0
function z=triop31(cc,x,y)
    z(cc==1)= x(cc==1);
    z(cc==0)= y(cc==0);
end