function dmtoolbox_install(varargin)
%DMTOOLBOX_INSTALL Installs the toolbox into MATLAB 
%
% [ Syntax ]
%   - dmtoolbox_install
%   - dmtoolbox_install ...
%
% [ Description ]
%   - dmtoolbox_install install the toolbox using default options.
%     It adds the paths to the MATLAB without re-compiling the mex
%     files.
%     
%     It is equivalent to 
%         $ dmtoolbox_install -path $
%
%   - dmtoolbox_install ... install the toolbox with user-specified 
%     options. Here are the supported options
%     \{:
%         - -path:      add paths to MATLAB
%         - -mex:       re-compiling all mex files
%     \:}
%
%     - If you want to only add paths, you can write
%         $ dmtoolbox_install -path $
%       or just write
%         $ dmtoolbox_install $
%     - If you want to only re-compile all mex files, you can write
%         $ dmtoolbox_install -path -mex $
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%     

%% check version

v_matlab = ver('MATLAB');
v_matlab = str2double(v_matlab.Version);
if v_matlab < 7.2
    warning('dmtoolbox:install:lowversion', ...
        'The MATLAB version is too low. Some functions may not work properly');
end


%% parse and verify input

if isempty(varargin)
    args = {'-path'};
else
    if ~iscellstr(varargin)
        error('dmtoolbox:install:invalidarg', ...
            'All input arguments to dmtoolbox_install should be string options.');
    end
    args = varargin;
end

%% take actions

tbinfo = dmtoolbox_info();
fprintf('Installing %s version %s (released on %s) ...\n', ...
    tbinfo.name, tbinfo.ver, tbinfo.release_date);

na = length(args);
for i = 1 : na
    arg = args{i};
    switch arg
        case '-path'
            install_paths(tbinfo.root);
        case '-mex'
            install_remex(tbinfo.root);
        otherwise
            error('dmtoolbox:install:invalidarg', ...
                'Invalid option to dmtoolbox_install: %s', arg);
    end
end

disp(' ');


%% action functions

function install_paths(root)

disp('Installing paths ...');

dirs = { ...
    '', ...         % self
    'utils', ...
    'strings', ...
    'cells', ...
    'structs', ...
    'maps', ...
    'tests' ...
    };

ndirs = length(dirs);
for i = 1 : ndirs
    dirs{i} = fullfile(root, dirs{i});
end

addpath(dirs{:});
savepath();


function install_remex(root)

disp('Re-compiling mex files ...');

cpp_files = { ...
    {'utils', 'private', 'alltrue_cimp.cpp'}; ...
    {'utils', 'private', 'anytrue_cimp.cpp'}; ...
    {'utils', 'private', 'counttrue_cimp.cpp'}; ...
    {'utils', 'private', 'countfalse_cimp.cpp'}; ...
    {'strings', 'private', 'strranges_cimp.cpp'}; ...
    {'strings', 'private', 'strrangesubs_cimp.cpp'}; ... 
    {'strings', 'private', 'strsplit_core.cpp'} ...
    };

nfiles = length(cpp_files);
for i = 1 : nfiles
    curfile = cpp_files{i};
    filename = fullfile(curfile{:});
    filepath = fullfile(root, filename);
    dirpath = fileparts(filepath);
    
    fprintf('\t%s ...\n', filename);
    mex('-O', '-outdir', dirpath, filepath);    
end


