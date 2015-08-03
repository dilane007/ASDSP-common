function z= add21m_ub4(x,y)
% x, y must be in range 0..15

% input pins    
    ttx= fix(x);
    tty= fix(y);
    err1= (ttx ~=x);%return error if any fractional parts
    err2= (tty ~=y);
    if any(err1), error('fractional parts found in adder input x');end;
    if any(err2), error('fractional parts found in adder input y');end;
% kernel    
    ttw= plus(ttx,tty); 
    cc1= ttw > 15   ; % if pos. ovf
    ttw(cc1)= fix(ttw(cc1) - 16); % put result back in range
% output pins    
    z=ttw;
end
