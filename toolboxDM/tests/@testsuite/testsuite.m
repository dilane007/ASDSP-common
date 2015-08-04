function tsuite = testsuite(name, units)
%TESTSUITE Constructs a test suite 
%
% [ Syntax ]
%   - tsuite = testsuite(name, units)
%
% [ Arguments ]
%   - name:     the name of the test suite
%   - units:    the cell array of units
% 
% [ Description ]
%   - tsuite = testsuite(name, units) constructs a test suite, which is a
%     set of test units (test cases or test suites). By this way, we can
%     can build a hierarchy of test units.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

%% parse and verify input arguments

typecheck(name, 'The name of the suite should be a string', 'string');
typecheck(units, 'The units should be a cell array of test units', 'cell');

if ~isempty(units)
    cellfun(@(u) typecheck(u, ...
        'Each element in the units should be either a testcase or a testsuite', ...
        'testcase', 'testsuite'), units);
end

%% main 

tsuite = struct('name', name, 'units', []);
tsuite.units = units;

tsuite = class(tsuite, 'testsuite');

