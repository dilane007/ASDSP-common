function [z w u t] = buffer_manager(bufmess,x,y,a,b) 
%common\buffer_manager
%1.2 <04Mar2007> cosmetics 
%1.2 <11May2009> cosmetics 
fprintf(1,'bufmess  is %s \n',bufmess)

if nargin < 5 ,    b=0; end
if nargin < 4 ,    a=0; end
if nargin < 3 ,    y=0; end

switch(bufmess)
    case('clear')
                z= zeros(x);
                w= zeros(x);
                u= zeros(x);
                t= zeros(x);
    case('connect')
                z= x;
                w= y;
                u= a;
                t= b;
    case('shape1row')
                z= x(:)';
                w= y(:)';
                u= a(:)';
                t= b(:)';
    case('shape1cln')
                z= x(:);
                w= y(:);
                u= a(:);
                t= b(:);
    case('pad')
                ny=length(y)-1;
                z =zeros(1,length(x)+ny);
                for n=1:length(x)
                    z(n+ny)=x(n);end;
    otherwise
        disp('bufmess unknown');
end;%bufmess