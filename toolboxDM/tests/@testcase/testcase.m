function tcase = testcase(name, F, varargin)
%TESTCASE Constructs a test case
%
% [ Syntax ]
%   - tcase = testcase(name, f, ...)
%   - testcase(name, {f1, f2, ...}, ...)
%  
% [ Description ] 
%   - tcase = testcase(name, f, ...) constructs a test case using a single
%     testing function f. 
%
%   - testcase(name, {f1, f2, ...}, ...) constructs a test case with
%     multiple testing functions. 
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%


%% parse and verify input

typecheck(name, 'name should be a string', 'string');
typecheck(F, 'the functions should be a function handle or a cell array', ...
    'function_handle', 'cell', 'empty');

tcase = setopts([], ...
    'name', name, ...
    'testfuns', F);

tcase = class(tcase, 'testcase');
