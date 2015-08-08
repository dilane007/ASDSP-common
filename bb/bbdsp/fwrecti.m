% z= FWRECTI(x)   returns a fully rectified wave 
% TYPE=unc
% SHAPE= scalar,vector; if input is an array the function returns a column
% RANGE=unc
function z=fwrecti(x);
        y= -x; 
        k= x.*0; 
        cc1= x>k;        
        z1(cc1)=x(cc1);        
        z1(~cc1)=k(~cc1);
        cc2= y>k;
        z2(cc2)=y(cc2);        
        z2(~cc2)=k(~cc2);
        z=z1+z2;
end

