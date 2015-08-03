function [systemRoot, scopeRoot] = openConfigFiles(sysFileName, scopeFileName)

% function [systemRoot, scopeRoot] = openConfigFiles(sysFileName,
% scopeFileName)
%
% Input
%   sysFileName =   'auto' to get the file 'SYSTEM_FILENAME' defined in
%                   setup.
%                   otherwise, specify the full path of the ACU config file to
%                   use.
%   scopeFileName = 'auto' to get the file 'SCOPE_FILENAME' defined in setup
%                   otherwise, specify the full path of the ACU config file to
%                   use.
%
% Output
%   systemRoot =    xml root element for system config file.
%   scopeRoot =     xml root element for scope config file.

global SCOPE_FILENAME;
global SYSTEM_FILENAME;

% System config file
if strcmp(sysFileName,'auto')
    systemDoc = xmlread(SYSTEM_FILENAME);
else
    systemDoc = xmlread(sysFileName);
end
systemRoot = systemDoc.getDocumentElement;  % Getting the root element of the configuration xml-file

% Scope config file
if strcmp(scopeFileName, 'auto')
    scopeDoc = xmlread(SCOPE_FILENAME);
else
    scopeDoc = xmlread(scopeFileName);
end
scopeRoot = scopeDoc.getDocumentElement;    % Getting the root element of the configuration xml-file
