 function z =multwoti21(x,algo)
% z= x *2/3
% input range  = float
% output range = -2/3....2/3

%% Input pins: format change and range checking if needed
x = double(x);  % force data as double 


%% Kernel
if (algo==1)
 x1= (x*4+x);       %  x*5       
 x4= (x1*16+x1);    % (x*5)*17) (17=16+1) ==x*85       
 x8= (x4*256)+x4;   % (x*5)*17)*257)  =x*21845(==85*257)
 z = x8/power(2,15);% (x*21845)/32768;  
else
 x1= (x*4+x);       %  x*5       
 x4= (x1*16+x1);    % (x*5)*17) (17=16+1) ==x*85       
 x8= (x4*256)+x4;   % (x*5)*17)*257)  =x*21845(==85*257)
 x15= x8*power(2,-15);  
 x23= (x*85)* power(2,-23);      
 z  =  x15+x23;  
end;
%% Output pins: format change if needed
 