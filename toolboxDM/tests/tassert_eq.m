function b = tassert_eq(x, y, level, rstack)
%TASSERT_EQ Testing an assertion of equality
%
% [ Syntax ]
%   - tassert_eq(x, y)
%   - tassert_eq(x, y, level)
%   - b = tassert_eq(...)
%
% [ Arguments ]
%   - x, y:         the two values/arrays to be compared
%   - level:        the level of the assertion ('normal' or 'fatal')
%   - b:            whether x and y are equal
%
% [ Description ]
%   - tassert_eq(x, y) tests the equality assertion in normal level, and 
%     records the the testing result in the current test monitor.
%
%   - tassert_eq(x, y, level) tests the assertion in the specified level 
%     and records the testing result.
%
%   - r = tassert_eq(...) returns the whether the equality is true.
%
% [ Remarks ]
%   - The MATLAB function isequal is used to test the equality.
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

b = tassert(isequal(x, y), level, rstack + 1);
