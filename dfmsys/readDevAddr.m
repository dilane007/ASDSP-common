function devAddr = readDevAddr (sysFileName, scopeFileName, flag)

% function devAddr = readDevAddr (sysFileName, scopeFileName, flag)
% (sysFileName, scopeFileName, flag)
%
% Input
%   sysFileName =   'auto' to get the file 'SYSTEM_FILENAME' defined in                 setup
%                   otherwise, specify the full path of the ACU config file to
%                   use.
%   scopeFileName = 'auto' to get the file 'SCOPE_FILENAME' defined in setup
%                   otherwise, specify the full path of the ACU config file to
%                   use.
%   flag =          If true => function input is xml root handles.
%
% Output
%   devAddr =       Cell that contains the addresses in the following
%                   order; {1,2} is Smu, {2,2} is Fpib, {3,2} is Handle,
%                   {4,2} is Smb and {5,2} is Lsu
%

if flag ~= 1
    [systemRoot, scopeRoot] = openConfigFiles(sysFileName, scopeFileName);
elseif flag == 1
    systemRoot = sysFileName;
    scopeRoot = scopeFileName;
end

ComponentType = systemRoot.getElementsByTagName('ComponentType');
devAddr = cell(5,2);
for i=0:ComponentType.getLength-1
    % Getting scalar CAN address for other nodes.
    if strcmp(ComponentType.item(i).getAttribute('Id'), 'Smu')
        SmuAddr = str2double(ComponentType.item(i).getAttribute('DevAddr'));
        devAddr{1,1} = 'Smu'; devAddr{1,2} = SmuAddr;
    end
    if strcmp(ComponentType.item(i).getAttribute('Id'), 'Fpib')
        FpibAddr = str2double(ComponentType.item(i).getAttribute('DevAddr'));
        devAddr{2,1} = 'Fpib'; devAddr{2,2} = FpibAddr;
    end
    if strcmp(ComponentType.item(i).getAttribute('Id'), 'Handle')
        HandleAddr = str2double(ComponentType.item(i).getAttribute('DevAddr'));
        devAddr{3,1} = 'Handle'; devAddr{3,2} = HandleAddr;
    end
    if strcmp(ComponentType.item(i).getAttribute('Id'), 'Smb')
        SmbAddr = str2double(ComponentType.item(i).getAttribute('DevAddr'));
        devAddr{4,1} = 'SmbAddr'; devAddr{4,2} = SmbAddr;
    end
    if strcmp(ComponentType.item(i).getAttribute('Id'), 'Lsu')
        LsuAddr = str2double(ComponentType.item(i).getAttribute('DevAddr'));
        devAddr{5,1} = 'LsuAddr'; devAddr{5,2} = LsuAddr;
    end
end