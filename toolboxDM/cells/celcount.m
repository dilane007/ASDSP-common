function n = celcount(C, x)
%CELCOUNT Counts the number of occurrences of the specified element
%
% [ Syntax ]
%   - n = celcount(C, x)
%
% [ Arguments ]
%   - C:        the source cell array
%   - x:        the element to be tested
%   - n:        the number of occurrences of x in C
%
% [ Description ]
%   - n = celcount(C, x) gets the number of elements in C that is
%     equal to x.
%
% [ Examples ]
%   - Counts the occurrences of some elements
%     \{
%         celcount({1, 2, 2, 3, 5}, 2) => 2
%
%         celcount({'a', 'b', 'x', 'a', 'a'}, 'a') => 3
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

n = counttrue(cellfun(@(e) isequal(e, x), C));