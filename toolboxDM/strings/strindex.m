function r = strindex(s, strs, h)
%STRINDEX Determines the index of a string in a set of strings
%
% [ Syntax ]
%   - r = strindex(s, strs)
%   - r = strindex(s, strs, errmsg)
%   - r = strindex(s, strs, handler)
%
% [ Arguments ]
%   - s:            the string to be tested
%   - strs:         the set of strings (in form of cell arrays)
%   - errmsg:       the string of error message to be shown when
%                   s is not found in the strs
%   - handler:      the function handler to handle the case when s is 
%                   not found in strs
%   - r:            the result.
%                   If s is found, it returns the one-based index.
%                   If s is not found, it returns an empty array or the 
%                   objects returned by the handler if the handler is 
%                   specified.
%
% [ Description ]
%   - r = strindex(s, strs) finds the string s in strs and returns
%     the index of s. If s is not found, it returns [].
%
%   - r = strindex(s, strs, errmsg) finds the string s in strs and
%     returns the index of s. If s is not found, it raises an error.
%
%   - r = strindex(s, strs, handler) finds the string s in strs and
%     returns the index of s. If s is not found, it invokes the 
%     handler on s, and returns the value returned by the handler
%     as
%       $ r = handler(s) $
%
% [ History ]
%   - Created by Dahua Lin, on Jun 28, 2007
%

error(nargchk(2, 3, nargin));

r = find(strcmp(s, strs), 1);

if isempty(r)
    if nargin < 3
        r = [];
    else
        if ischar(h)
            error('dmtoolbox:strindex:notfound', h);
        else
            r = h(s);
        end
    end
end

    