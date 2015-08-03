function z= mul21p_ub(x,y)
% 8x8 -> 16

%% Input pins: format change and range checking if needed
% big empty
%% Kernel
 usX= zext(x,16); 
 usY= zext(y,16); 
 z= times(usX,usY); % _8 x _8 --> 16
%% Output pins: format change if needed
% big empty
end