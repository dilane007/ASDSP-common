function waitForState(device, status)

% function waitForState(device)
%
% Input:
%   device =    Which device to look for
%   status =    Device state/status
%

global SHOW_SMB_STATUS;
global SmbState;
global AcrState;
global HibState;

% Start updating global state variables
SHOW_SMB_STATUS = 1;
switch (device)
    case 'SMB'
        while SmbState ~= status
            pause(0.1); % Not sure if I want a pause...
        end
    case 'ACR'
        while AcrState ~= status
            pause(0.1);
        end
    case 'HIB'
        while HibState ~= status
            pause(0.1);
        end
end
SHOW_SMB_STATUS = 0;
