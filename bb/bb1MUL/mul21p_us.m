function z= mul21p_us(x,y)
% 16x16 -> 32

%% Input pins: format change and range checking if needed
% big empty
%% Kernel 
 ulX= zext(x,32); 
 ulY= zext(y,32); 
 z= times(ulX,ulY); % ss_16 x ss_16 --> 32
%% Output pins: format change if needed
% big empty
end