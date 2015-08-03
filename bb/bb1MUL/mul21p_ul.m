function ueZ= mul21p_ul(ulX,ulY)
% 32x32 -> ~53

%% Input pins: format change and range checking if needed
% big empty

%% Kernel 
 fX= double(ulX); 
 fY= double(ulY); 
 fZ= times(fX,fY);
%% Output pins: format change if needed
 ueZ= uint64(fZ);
end