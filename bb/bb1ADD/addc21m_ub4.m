function [z cout]= addc21m_ub4(x,y,cin)

% input pins    
    ttx= fix(x);%ensure no fractional parts
    tty= fix(y);
    err1= (ttx ~=x);%return error if any
    err2= (tty ~=y);
    if any(err1), error('fractional parts found in adder input x');end;
    if any(err2), error('fractional parts found in adder input y');end;
% kernel    
    ttw= plus(ttx,tty); 
    ttw= plus(ttw,cin); 
    cc1= gt(ttw,15); % if pos. ovf
    ttw(cc1)= fix(ttw(cc1) - 16); % put result back in range
% carry out    
    cout=zeros(1,length(ttw));
    cout(cc1)=1; %if pos. ovf
% output pins    
    z=ttw;
end
