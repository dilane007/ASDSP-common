function dmtoolbox_test(varargin)
%DMTOOLBOX_TEST Performs testing on the functionality of the toolbox
%
% [ Syntax ]
%   - dmtoolbox_test
%   - dmtoolbox_test module1 module2
%
% [ Description ]
%   - dmtoolbox_test performs the testing of all modules in the toolbox.
%     and prints the testing information.
%
%     The testing is conducted with the unit-test framework offered by
%     the toolbox itself. The unit-test framework is in the tests
%     sub-directory. It is a general test framework like JUnit in Java.
%     
%     This function is mainly for testing whether the functions in the
%     toolbox work correctly after deployment. However, the function in
%     itself is a good example to show how to use the unit test framework.
%
%   - dmtoolbox_test module1 module2 ... performs the testing of specified
%     modules and prints the corresponding testing information.
%
%     You can also write it in a function form as
%       $ dmtoolbox_test(module1, module2, ...) $
%     
%     The testable module list
%     \{:
%         - utils:      the common utilities to process arrays
%         - strings:    the functions to manipulate, format strings
%                       and extract information from strings
%         - cells:      the functions to manipulate cell arrays
%         - structs:    the functions to manipulate struct arrays
%                       and convert between struct arrays and other
%                       data forms
%         - maps:       the functions to help mapping a value to another,
%                       and dictionary (like hash table) query        
%     \:}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 30, 2007
% 

%% decide the modules to test

if nargin == 0
    modules = {'utils', 'strings', 'cells', 'structs', 'maps'};
else
    modules = varargin;
    if ~iscellstr(modules)
        error('dmtoolbox:test:invalidarg', ...
            'All modules should be specified in form of string');
    end
end

%% main

% construct the test suite

nm = length(modules);
tsuites = cell(nm, 1);

for i = 1 : nm
    switch modules{i};
        case 'utils'
            ts = testsuite_utils();
        case 'strings'
            ts = testsuite_strings();
        case 'cells'
            ts = testsuite_cells();
        case 'structs'
            ts = testsuite_structs();
        case 'maps'
            ts = testsuite_maps();
        otherwise
            error('dmtoolbox:test:unknownmodule', ...
                'The module %s is not known', modules{i});
    end
    tsuites{i} = ts;
end

root_suite = testsuite('dmtoolbox-checking', tsuites);

% run the test

run(root_suite);


    



