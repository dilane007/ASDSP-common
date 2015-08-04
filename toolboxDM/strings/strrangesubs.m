function sstr = strrangesubs(str, ranges, subs)
%STRRANGESUBS Substitutes sub ranges in a string with other strings
%
% [ Syntax ]
%   - sstr = strrangesubs(str, ranges, subs)
%
% [ Arguments ]
%   - str:          the source string
%   - ranges:       the ranges of sub strings to be substituted
%                   it can be given in either a 1 x (2n) row vector
%                   or a 2 x n matrix.
%                   (Please refer to strranges.m for more details)
%   - subs:         the strings to substitute the original parts
%   - sstr:         the resulting string
%
% [ Description]
%   - sstr = strrangesubs(str, ranges, subs) creates a new string by
%     substituting the parts specified by the ranges with the corresponding
%     strings in subs. 
%
%     Here, subs can be either of the following forms 
%       - a cell array of strings with the length equal to the number 
%         of ranges. 
%       - a fixed string: means all ranges are replaced by it
%
% [ Examples ]
%   - Replacing the word 'He' with 'She' and 'his' with 'her' using ranges.
%     \{
%         strrangesubs('He does his work with his hands', ...
%                      [1 2, 9 11, 23 25], {'She', 'her', 'her'})
%         => 'She does her work with her hands'
%
%         strrangesubs('He does his work with his hands', ...
%                      [1 2, 9 11, 23 25], 'her')
%         => 'her does her work with her hands'
%     \}
%
%  [ History ]
%    - Created by Dahua Lin, on Jun 26, 2007
%

if ~isempty(ranges)
    sstr = strrangesubs_cimp(str, int32(ranges), subs);
else
    sstr = str;
end