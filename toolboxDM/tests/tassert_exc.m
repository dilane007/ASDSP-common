function b = tassert_exc(errid, f, level, rstack)
%TASSERT_EXC Tests the assertion on exception 
%
% [ Syntax ]
%   - tassert_exc(errid, f)
%   - tassert_exc(errid, f, level)
%   - b = tassert_exc(...)
%
% [ Arguments ]
%   - errid:        the expected identifier of the exception.
%                   if errid is empty, then any type of exception is 
%                   allowed.
%   - f:            the function handle to be run
%   - level:        the level of the assertion ('normal' or 'fatal')
%   - b:            whether an expected exception is caught
%
% [ Description ]
%   - tassert_exc(x, classname) tests whether assertion that an expected 
%     exception will be raised, and records the the testing result in 
%     the current test monitor.
%
%   - tassert_exc(x, classname, level) tests the assertion in the specified 
%     level and records the testing result.
%
%   - b = tassert_exc(...) returns the whether x is a value of the specified
%     class.
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

try
    f();
    
    % no exception is caught
    b = tassert(false, level, rstack+1);
    
catch
    err = lasterror();
    if isempty(errid) || strcmp(err.identifier, errid)
        b = tassert(true, level, rstack+1);
    else
        b = false;
        rethrow(err);
    end
end
