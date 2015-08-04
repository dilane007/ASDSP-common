function dmdoc(name)
%DMDOC Opens the HTML document in the MATLAB web browser
%
% [ Syntax ]
%   - dmdoc 
%   - dmdoc name
%
% [ Description ]
%   - dmdoc  opens the home page of the toolbox's documents.
%
%   - dmdoc name   opens the HTML document for a function or module in the 
%     MATLAB web browser.
%
%     Here, the name can be function name, a module name, or a class name.
%     For class methods, the name can be written in the form like 
%     classname.method_name.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 30, 2007
%

%% Get document path

tbinfo = dmtoolbox_info();
helproot = fullfile(tbinfo.docpath, 'helps');

%% Determine the filename

if nargin == 0  % the home
    fname = 'mdoc.dmtoolbox.mdir.xml';    
else
    if ~ischar(name) 
        error('dmtoolbox:dmdoc:invalidarg', 'name should be a string');
    end
    
    if ~isempty(regexp(name, '^\w+$', 'once'))      % a normal name        
        
        % try as a function
        ret = dir(fullfile(helproot, sprintf('*.%s.mfile.xml', name)));
        
        % try as a class
        if isempty(ret)
            ret = dir(fullfile(helproot, sprintf('*.@%s.mdir.xml', name)));
        end
        
        % try as a module
        if isempty(ret)
            ret = dir(fullfile(helproot, sprintf('*.%s.mdir.xml', name)));
        end
                                
    else
    
        tks = regexp(name, '^(\w+)\.(\w+)$', 'tokens');
        if ~isempty(tks)    % a class method     
            tks = tks{1};
            [class_name, method_name] = deal(tks{:});
            ret = dir(fullfile(helproot, ...
                sprintf('*.@%s.%s.mfile.xml', class_name, method_name)));                                    
        else
            error('dmtoolbox:dmdoc:invalidname', ...
                'The name %s is not valid for dmdoc query', name);
        end
        
    end
    
    if isempty(ret)
        error('dmtoolbox:dmdoc:docnotfound', ...
            'The name %s is not found in dmtoolbox''s documents', name);
    end
    
    % take the fname
    fname = ret.name;        
end

%% Open the document

fpath = fullfile(helproot, fname);
if ~exist(fpath, 'file')
    error('dmtoolbox:dmdoc:filenotfound', ...
        'The document file %s does not exist', fpath);
end

url = ['file:///', strrep(fpath, '\', '/')];
web(url, '-noaddressbox');




