function z= add21m_ubN(x,y)
% x, y must be in range 0..HARDMAX
global NBITS;
global HARDMAX;

% input pins    
    ttx= fix(x);%ensure no fractional parts
    tty= fix(y);
    err1= (ttx ~=x);%return error if any
    err2= (tty ~=y);
    if any(err1), error('fractional parts found in adder input x');end;
    if any(err2), error('fractional parts found in adder input y');end;
% kernel    
    ttw= plus(ttx,tty); 
    cc1= ttw > HARDMAX   ; % if pos. ovf
    ttw(cc1)= fix(ttw(cc1) - power(2,NBITS)); % put result back in range
% output pins    
    z=ttw;
end
