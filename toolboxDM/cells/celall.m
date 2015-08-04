function b = celall(C, f)
%CELALL whether all elements in the cell array satisfy some conditions
%
% [ Syntax ]
%   - b = celall(C, f)
%
% [ Arguments ]
%   - C:        the source cell array
%   - f:        the predicate function handle
%   - b:        the judgment
%
% [ Description ]
%   - b = celall(C, f) tests whether all elements in the cell array C
%     that satisfies the condition given by f. f is a predicate function 
%     handle applied on each element.
%
% [ Examples ]
%   - Test whether the lengths of all strings are larger than 3
%     \{
%         celall({'abcd', 'matlab', 'tiger'}, @(x) length(x) > 3)
%         => true
%
%         celall({'ab', 'mat', 'tiger'}, @(x) length(x) > 3)
%         => false
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

b = alltrue(cellfun(f, C));
