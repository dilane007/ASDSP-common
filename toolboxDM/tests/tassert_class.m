function b = tassert_class(classname, x, level, rstack)
%TASSERT_CLASS Testing an assertion on the class of a value
%
% [ Syntax ]
%   - tassert_class(classname, x)
%   - tassert_class(classname, x, level)
%   - b = tassert_class(...)
%
% [ Arguments ]
%   - x:            the two value to be tested
%   - classname:    the name of the class that x is asserted to be 
%   - level:        the level of the assertion ('normal' or 'fatal')
%   - b:            whether x is a value of the specified class
%
% [ Description ]
%   - tassert_class(classname, x) tests the assertion of class in normal 
%     level, and records the the testing result in the current test monitor.
%
%   - tassert_class(classname, x, level) tests the assertion in the 
%     specified level and records the testing result.
%
%   - b = tassert_class(...) returns the whether x is a value of the 
%     specified class
%
% [ Remarks ]
%   - The MATLAB function isa is used to test.
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

b = tassert(isa(x, classname), level, rstack+1);

