function testunit_example()
%TESTUNIT_EXAMPLE A set of examples showing how to use the unit testing
%framework.
%
% [ Syntax ]
%   - testunit_example
%
% [ Description ]
%   - testunit_example shows how to use the unit testing framework. 
%     It involves the following steps:
%       # Write test functions with assertions
%       # Group the test functions into test units (test cases and test
%         suites)
%       # Run the root unit by 
%           $ info = run(tunit) $
%         or if you have your own logger to handle the testing events,
%         you can write
%           $ info = run(tunit, logger) $
% 
% [ Remarks ]
%   - In this example, all test functions are in the same m-file. It is
%     mainly for convenience. In practice, you can distribute the test
%     functions, test cases, and test suites in multiple files.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%


%% Main 

% create test suite
tsuite = testsuite('example-suite', ...
    {test_case1(), ...
     test_case2() });
 
% run the test suite
run(tsuite);


%% Test Case 1

function tcase = test_case1()

% group test cases
tcase = testcase('example-case 1 (should have 7 pass and 3 fail)', ...
    {@case1_fun1, ...
     @case1_fun2, ...
     @case1_fun3});
 

function case1_fun1()

x = 'abcde';

% use logical expression for assertion 
tassert(length(x) == 5); % pass

% use equality assertion
tassert_eq(x, 'abcde'); % pass

% use class assertion
tassert_class('char', x); % pass
tassert_class('double', x); % fail


function case1_fun2()

x = [1 2 3; 4 5 6];

% use logical array for assertion
tassert(x > 0); % pass
tassert(x > 2); % fail

% generate fatal assertion
tassert(x > 0, 'fatal'); % pass
tassert(x > 2, 'fatal'); % fatal failure

% the remaining part of this function will not be executed
tassert(x > 3);  % not run (ignore)


function case1_fun3()

strs = {'abc', 'matlab', 'test'};
lens = [3, 6, 4];

% do assertion in batch
tassert_eq(cellfun(@length, strs), lens);  % pass

% the above assertion can also be written as
tassert(cellfun(@length, strs) == lens);  % pass


%% Test Case 2

function tcase = test_case2()

% group test cases
tcase = testcase('example-case 2 (should have 8 pass)', ...
    {@case2_fun1, ...
     @case2_fun2} );


function case2_fun1()

x = [1 2 3];
y = [5 6 7 8];

% assert that an exception will be raised
tassert_exc([], @() x + y);  % pass

% assert that an exception of specific identifier will be raised
tassert_exc('myerror:err1', @() error('myerror:err1', 'It is an error')); % pass  

% assert that an array is empty
tassert_empty('');      % pass
tassert_empty({});      % pass
tassert_empty([]);      % pass



function case2_fun2()

% batch experiments

params = {{1, 2, 3}, {4, 5, 9}, {10, 11, 21}};
exp_fun = @(c) tassert_eq(c{1} + c{2}, c{3});

cellfun(exp_fun, params);  % pass 3 times


