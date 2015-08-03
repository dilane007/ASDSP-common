% Z= BIN2Q
% fz= bin2q(binstring,qpoint)
% binstring: binary string; width is given by qformat
% qpoint: qpoint syntax is finnicky( ex:8.8 is wrong; use 8.08 instead
%--------------------------------------------------------------------------
function fz= bin2q(binstring,qpoint)
    % (1) Binstring 
    cc= (binstring(1)=='1');
    % (2) qpoint: extract integer width and fractional width    
    % must always work in flint
    qint= fix(qpoint);
    qfrac= fix(round((qpoint - qint)*100));
    qwidth= qint + qfrac;
    % kernel 
    iz = bin2int(binstring == '1');
    izneg= iz - power(2,qwidth);
    z= triop31(cc,izneg,iz);
    fz= z* power(2,-qfrac);% flint to fxp
end
  
