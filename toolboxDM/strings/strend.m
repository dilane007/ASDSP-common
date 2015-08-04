function b = strend(str, endstr)
%STREND Tests whether a string ends with a specified substring
%
% [ Syntax ]
%   - b = strend(str, endstr)
%
% [ Description ]
%   - b = strend(str, endstr) returns whether the string str ends
%     with the substring endstr.
%
% [ Remarks ]
%   - if endstr is empty, it always return true.
%
% [ Examples ]
%   - Testing string end
%     \{
%         strend('abc.m', '.m') => true
%
%         strend('abc', 'xabc') => false
%
%         strend('abcd--', '-+') => false
%
%         strend('abc', []) => true
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

if ~isempty(endstr)    
    b = length(str) >= length(endstr) && strcmp(str(end-length(endstr)+1:end), endstr);    
else
    b = true;
end