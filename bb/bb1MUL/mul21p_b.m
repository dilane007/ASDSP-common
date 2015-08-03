function z= mul21p_b(x,y)
% 8x8 -> 16

%% Input pins: format change and range checking if needed
% big empty
%% Kernel 
 sX= sex(x,16);  
 sY= sex(y,16); 
 z= times(sX,sY);
%% Output pins: format change if needed
% big empty
end