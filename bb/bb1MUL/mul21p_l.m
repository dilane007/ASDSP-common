function eZ= mul21p_l(lX,lY)
% 32x32 -> ~53

%% Input pins: format change and range checking if needed
% big empty

%% Kernel 
 fX = double(lX); 
 fY = double(lY); 
 fZ = times(fX,fY);
%% Output pins: format change if needed
 eZ = int64(fZ);
end 