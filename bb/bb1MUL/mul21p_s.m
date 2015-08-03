function z= mul21p_s(x,y)
% 16x16 -> 32

%% Input pins: format change and range checking if needed
% big empty
%% Kernel 
 lX= sex(x,32);  
 lY= sex(y,32); 
 z=  times(lX,lY);
%% Output pins: format change if needed
% big empty
end