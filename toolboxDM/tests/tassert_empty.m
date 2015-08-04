function b = tassert_empty(x, level, rstack)
%TASSERT_EMPTY Test an assertion that a variable is empty
%
% [ Syntax ]
%   - tassert_empty(x)
%   - tassert_empty(x, level)
%   - b = tassert_empty(...)
%
% [ Arguments ]
%   - x:            the value to be tested
%   - level:        the level of the assertion ('normal' or 'fatal')
%   - b:            whether x is empty
%
% [ Description ]
%   - tassert_empty(x) tests whether x is empty in normal level, and 
%     records the the testing result in the current test monitor.
%
%   - tassert_empty(x, y, level) tests the assertion in the specified level 
%     and records the testing result.
%
%   - r = tassert_empty(...) returns the whether x is empty.
%
% [ Remarks ]
%   - The MATLAB function isempty is used to do the testing.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

if nargin < 3
    level = 'normal';
end
if nargin < 4
    rstack = 0;
end

b = tassert(isempty(x), level, rstack + 1);