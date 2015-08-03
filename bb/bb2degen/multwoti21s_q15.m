 function z =multwoti21s_q15(x)
% z= x *2/3
% input range = 1q15
% output range = -2/3....2/3-epsilon

IMPLM=1;
%% Input pins: format change and range checking if needed
% do range checking
cc1= ge(x,1); 
cc2= lt(x,-1);
if (any([cc1 cc2])), error('x input not in range');end;
x1q15 = double(x);  % force data as double 

%% Kernel
%work in 16q16, because the way the algo works is
% the MATH way: first growth left, then shift right
 x3q13   = shift(x1q15,2);           
 x4q15   = add21_q(x3q13,x1q15,16);  % x*5          
 x8q11   = shift(x4q15,4);           
 x8q15   = add21_q(x8q11,x4q15,16); % x*85 (==5*17)        
 x16q9   = shift(x8q15,8);           
 z16q15  = add21_q(x16q9,x8q15,16);  % x* 21847(==85*257)      
 z1q30   = shift(z16q15,-15) ;% x * 21847/32768 (~=2/3)
 z1q15   = qformat(z1q30,15); %back to 16-bit precision
%% Output pins: format change if needed
 z=z1q15;
 
if IMPLM==0 
 %% Kernel
%% systemC code
%     sX = (short) lIN0.read();  // pin is long but data in is short and right aligned  
% 	  w19X1 = (sX<<2)  + sX;   //            
% 	  w23X2 = (w19X1<<4) + w19X1;//           
% 	  w31X3 = (w23X2<<8) + w23X2;//          
%  	  sY    = w31X3.range(30,15);  // back to short format
% 	  lOUT = (long)sY;  // data out is short and right aligned
 fX = double(sX);  %  
 w19X1 = plus(fX*4,fX);            
 w23X2 = plus(w19X1*16,w19X1);          
 w31X3 = plus(w23X2*256,w23X2);         
 w16X4 = w31X3/32768 ;% back to short format
 sZ =    int16(w16X4);% and keep lower part
end 