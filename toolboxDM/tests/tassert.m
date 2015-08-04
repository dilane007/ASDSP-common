function r = tassert(expr, level, rstack)
%TASSERT Testing an assertion
%
% [ Syntax ]
%   - tassert(expr)
%   - tassert(expr, level)
%   - r = tassert(...)
%
% [ Arguments ]
%   - expr:         the logical expression to test
%   - level:        the level of the assertion
%                   \{:
%                        - normal:  the failure will not stop the execution
%                                   of the remaining part of the testing
%                                   function
%                        - fatal:   the failure will stop the execution of
%                                   the current testing function
%                   \:}
%   - r:            the value returned by expr
%
% [ Description ]
%   - tassert(expr) tests the assertion in normal level, and records the 
%     the testing result in the current test monitor.
%
%   - tassert(expr, level) tests the assertion in the specified level and
%     records the testing result.
%
%   - r = tassert(...) returns the value of the testing expression.
%
% [ Remarks ]
%   - The expression is allowed to be a non-scalar array, then if and only
%     if all elements are true or non-zeros, the assertion is passed.
%     This strategy is conformal to the MATLAB builtin if-statement.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

%% check monitor

global DMTB_TESTS_TESTCASE_MONITOR;
if isempty(DMTB_TESTS_TESTCASE_MONITOR)
    error('tests:nomonitor', 'The testing monitor is not set');
end
if ~isa(DMTB_TESTS_TESTCASE_MONITOR, 'testmon')
    error('tests:illegalmonitor', 'The testing monitor is not a legal one');
end

%% parse and verify input

if nargin < 2
    is_fatal = false;
else
    is_fatal = (strindex(level, {'normal', 'fatal'}, 'Invalid tassert level') == 2);
end

if nargin < 3
    rstack = 0;
end

%% prepare information

r = expr;

stack = dbstack('-completenames');
db = stack(rstack + 2);

info = struct( ...
    'file', db.file, ...
    'fname', db.name, ...
    'line', db.line, ...
    'errmsg', [], ...
    'errid', []);


%% reporting

if r    % pass
    DMTB_TESTS_TESTCASE_MONITOR = addrec( ...
        DMTB_TESTS_TESTCASE_MONITOR, 'pass', info);
else
    if ~is_fatal
        DMTB_TESTS_TESTCASE_MONITOR = addrec( ...
            DMTB_TESTS_TESTCASE_MONITOR, 'fail', info);
    else
        DMTB_TESTS_TESTCASE_MONITOR = addrec( ...
            DMTB_TESTS_TESTCASE_MONITOR, 'fatal', info);        
    
        if strcmp(level, 'fatal')
            error('tests:tassert:fatalfailure', 'Fatal assertion failure');
        end
    end
end





