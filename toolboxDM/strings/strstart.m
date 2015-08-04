function b = strstart(str, startstr)
%STRSTART Tests whether a string starts with a specified substring
%
% [ Syntax ]
%   - b = strstart(str, startstr)
%
% [ Description ]
%   - b = strstart(str, startstr) returns whether the string str starts
%     with the substring startstr.
%
% [ Remarks ]
%   - if startstr is empty, it always return true.
%
% [ Examples ]
%   - Testing string start
%     \{
%         strstart('strstart', 'str') => true
%
%         strstart('abc', 'abcd') => false
%
%         strstart('--abcd', '-+') => false
%
%         strstart('abc', []) => true
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

if ~isempty(startstr)    
    b = length(str) >= length(startstr) && strcmp(str(1:length(startstr)), startstr);    
else
    b = true;
end