function info = dmtoolbox_info()
%DMTOOLBOX_INFO Gets the information of the dmtoolbox
%
% [ Syntax ]
%   - info = dmtoolbox_info()
%
% [ Description ]
%   - info = dmtoolbox_info() returns a struct containing the basic 
%     information of the toolbox. info has the following fields
%     \{:
%         - name:           the toolbox name
%         - ver:            the version of the toolbox
%         - release_date:   when the current version is released
%                           (in yyyy-mm-dd format)
%         - root:           the root path of the toolbox
%         - docpath:        the document path of the toolbox
%     \:}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

root = fileparts(mfilename('fullpath'));

info = struct( ...
    'name', 'Data Manipulation', ...
    'ver', '1.00', ...
    'release_date', '2007-06-30', ...
    'root',  root, ...
    'docpath',  fullfile(root, 'doc') );

