function C = strranges(str, ranges)
%STRRANGES Create a set of sub string specified by ranges
%
% [ Syntax ]
%   - C = strranges(str, ranges)
%
% [ Arguments ]
%   - str:          the source string
%   - ranges:       the ranges of the sub strings
%                   it can be given in either a 1 x (2n) row vector
%                   or a 2 x n matrix.
%   - C:            the cell array of sub strings
%
% [ Description ]
%   - C = strranges(str, ranges) extracts sub strings from a source
%     string, in which the sub strings are specified by ranges.
%
% [ Examples ]
%   - Extracting sub strings by ranges
%     \{
%        C = strranges('Compute with MATLAB', [1 7, 9 12, 14 19])
%        => {'Compute', 'with', 'MATLAB'}
%
%        C = strranges('abc-xyz', [1 3; 5 7]')
%        => {'abc', 'xyz'}
%     \}
%
% [ Remarks ]
%   - if ranges is empty, then the output C is an empty cell array.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 26, 2007
%

if ~isempty(ranges)
    C = strranges_cimp(str, int32(ranges));
else
    C = {};
end