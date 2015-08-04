function C = celremove_if(C, f)
%CELREMOVE_IF Removes the elements satisfying some conditions
%
% [ Syntax ]
%   - C = celremove_if(C, f)
%
% [ Arguments ]
%   - C:        the cell array
%   - f:        the predicate function handle
%
% [ Description ]
%   - C = celremove_if(C, f) removes the elements from C for
%     which f returns true.
%
% [ Examples ]
%   - Remove the negative elements
%     \{
%         celremove_if({-1 -2, 1, 0, 2, 3}, @(x) x < 0)
%         => {[1], [0], [2], [3]}
%     \}
%
%   - Remove the strings whose lengths are less than 3
%     \{
%         celremove_if({'abcd', 'a', 'matlab', 'b'}, @(x) length(x) < 3)
%         => {'abcd', 'matlab'}
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

C(cellfun(f, C)) = [];
