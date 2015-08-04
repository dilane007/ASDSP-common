function matches = strscan(str, pattern)
%STRSCAN Scans the sub strings that match the specified regular pattern
%
% [ Syntax ]
%   - matches = strscan(str, pattern)
%
% [ Arguments ]
%   - str:          the source string to be scanned
%   - pattern:      the regular expression pattern
%   - matches:      the cell array of the matched sub strings
%
% [ Description ]
%   - matches = strscan(str, pattern) finds all occurrences of the sub
%     strings that match the specified regular expression pattern and
%     outputs them by the cell array matches.
%
% [ Examples ]
%   - Finds all words in a sentence (the pattern for a word is /\w+/):
%     \{
%         strscan('I am writing code in MATLAB', '\w+')
%         => {'I'  'am'  'writing'  'code'  'in'  'MATLAB'}
%     \}
%
%   - Finds all integer numbers in a string (with pattern /\d+/):
%     \{
%         strscan('34 + 52 = 86', '\d+')
%         => {'34'  '52'  '86'}
%     \}
%
% [ Remarks ]
%   - If str is empty or no matched sub strings are found, then the output
%     matches will be an empty array.
%
%   - The function simply wraps the regexp function to offer a more
%     concise interface.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 24, 2007
%

%% parse and verify input

nargchk(2, 2, nargin);

typecheck(str, 'str should be a string or empty', 'string', 'empty');
typecheck(pattern, 'pattern should be a string', 'string');

%% Find matches

matches = regexp(str, pattern, 'match');






