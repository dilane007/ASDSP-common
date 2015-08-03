function [z cout]= addc21m_ubN(x,y,cin)
global HARDMAX;
global RANGEMAX;

% input pins    
    ttx= fix(x);
    tty= fix(y);
    err1= (ttx ~=x);
    err2= (tty ~=y);
    if any(err1), error('fractional parts found in adder input x');end;
    if any(err2), error('fractional parts found in adder input y');end;
% kernel    
    ttw= plus(ttx,tty); 
    ttw= plus(ttw,cin); 
    cc1= gt(ttw,HARDMAX)   ; % if pos. ovf
    ttw(cc1)= fix(ttw(cc1) - RANGEMAX); % put result back in range
    cout=zeros(1,length(ttw));
    cout(cc1)=1;% and generate carry out 
% output pins    
    z=ttw;
end
