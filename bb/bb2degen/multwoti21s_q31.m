function z=multwoti21s_q31(x)
% x=x *2/3
% do range checking
 % z= x *2/3
% input range = 1q31
% output range = -2/3....2/3-epsilon

IMPLM=1;    
%% Input pins: format change and range checking if needed
% do range checking
cc1= ge(x,1); 
cc2= lt(x,-1);
if (any([cc1 cc2])), error('x input not in range');end;
x1q31 = double(x);  % force data as double 

%% Kernel
%work in 18q25, because the way the algo works is
% the MATH way: first growth left, then shift right
 x3q29   = shift(x1q31,2);           
 x4q31   = add21_q(x3q29,x1q31,32);  % x*5          
 x8q27   = shift(x4q31,4);           
 x8q31   = add21_q(x8q27,x4q31,32); % x*85 (==5*17)        
 x16q23  = shift(x8q31,8);           
 x16q31  = add21_q(x16q23,x8q31,32);  % x* 21845(== 85*257)      
 x18q25  = shift(x16q31,2); %x *87380 (==21845*4)          
 k       = qformat(1.3333,32);  %       
 z18q25  = add21_q(x18q25,k,32);  %       
 z1q46   = shift(z18q25,-17) ;% x=87381.33333/(128K)
 z1q31   = qformat(z1q46,31); %back to 32-bit precision
%% Output pins: format change if needed
z=z1q31;

if IMPLM==0
%% Kernel
%work in 16q16, because the way the algo works is
% the MATH way: first growth left, then shift right
 x3q29   = shift(x1q31,2);           
 x4q31   = add21_q(x3q29,x1q31,32);  % x*5          
 x8q27   = shift(x4q31,4);           
 x8q31   = add21_q(x8q27,x4q31,32); % x*85 (==5*17)        
 x16q23  = shift(x8q31,8);           
 z16q31  = add21_q(x16q23,x8q31,16);  % x* 21847(==85*257)      
 z1q46   = shift(z16q31,-15) ;% x * 21847/32768 (~=2/3)
 z1q31   = qformat(z1q46,31); %back to 16-bit precision
%% Output pins: format change if needed
z=z1q31;
end