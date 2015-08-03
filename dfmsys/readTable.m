function SegCount = readTable(sysFileName, scopeFileName, flag)

%% function SegCount = readTable(sysFileName, scopeFileName, flag)
%
% Reads the systemConfig file and the scopeConfig file and creates the global variable SEG2ADDR_TABLE. 
%
% sysFileName =    'auto' to get the file 'SYSTEM_FILENAME' defined in  setup
%                  otherwise, specify the full path of the ACU config file to use.
% scopeFileName =  'auto' to get the file 'SCOPE_FILENAME' defined in setup
%                  otherwise, specify the full path of the ACU config file to  use.
% flag =           (Optional)If true => sysFileName and scopeFileName is interpreted
%                  as xml root elements (already opened files).
%
%%

global SEG2ADDR_TABLE;
global ALL_DONE;


%%%
%% Opening config files
if flag ~= 1
    [systemRoot, scopeRoot] = openConfigFiles(sysFileName, scopeFileName);
elseif flag == 1
    systemRoot = sysFileName;
    scopeRoot = scopeFileName;
end


%%%
%% Getting scope information from scope_##.cfg
Scope = scopeRoot.getElementsByTagName('Scope');
SegCount = str2double(Scope.item(0).getAttribute('SegCount'));


%%%
%% Getting Segment_nn information from the scope_##.cfg
for i = 1:SegCount
    Segment = scopeRoot.getElementsByTagName(['Segment_' sprintf('%02d',i-1)]);
    scuIndex(i) = str2double(Segment.item(0).getAttribute('ScuIndex'));
    xNegMotorIndex(i) = str2double(Segment.item(0).getAttribute('XNegMotorIndex'));
    xPosMotorIndex(i) = str2double(Segment.item(0).getAttribute('XPosMotorIndex'));
    yNegMotorIndex(i) = str2double(Segment.item(0).getAttribute('YNegMotorIndex'));
    yPosMotorIndex(i) = str2double(Segment.item(0).getAttribute('YPosMotorIndex'));
end


%%%
%% Reading SCU parameters unique for each SCU and mapping devAddr to scuIndex
SEG2ADDR_TABLE = zeros(SegCount,5);
ALL_DONE = ones(SegCount,4);

ComponentType = systemRoot.getElementsByTagName('ComponentType');
for i=0:ComponentType.getLength-1
    % Mapping segment to CAN address for all devices
    if strcmp(ComponentType.item(i).getAttribute('Id'), 'Scu')
        DevAddr = str2double(ComponentType.item(i).getAttribute('DevAddr'));
        Index = str2double(ComponentType.item(i).getAttribute('Index'));
        for j=0:SegCount-1
            if (scuIndex(j+1)==Index)
                SEG2ADDR_TABLE(j+1,1)=DevAddr;
            end
        end
    end
end


%%%
%% Mapping axis to motor number
for i = 0:SegCount-1
    SEG2ADDR_TABLE(i+1,2)=xPosMotorIndex(i+1);
    SEG2ADDR_TABLE(i+1,3)=xNegMotorIndex(i+1);
    SEG2ADDR_TABLE(i+1,4)=yPosMotorIndex(i+1);
    SEG2ADDR_TABLE(i+1,5)=yNegMotorIndex(i+1);
end


%%%