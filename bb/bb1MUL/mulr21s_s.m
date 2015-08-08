function z= mulr21s_s(x,y)
% 16q0 x 16q0 -> 31qp1
% promote inputs to avoid sat in intermediate calculations 
 lX= int32(x);
 lY= int32(y); 
%% Kernel
 lZ= times(lX,lY);% 
 lZ= times(lZ,2); % get rid of 1 sign
% rounding is done by adding a 1 at position bit 15
% add is a modulo add  
 rd=power(2,15);
 lZrnd= add21m_l(lZ,rd);
% back to 16-bit; take upper (not lower)    
 sZ=fix(lZrnd * power(2,-16)); 
% cast
 z= int16(sZ); 
end