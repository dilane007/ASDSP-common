function b = celany(C, f)
%CELANY whether there are elements in the cell array satisfying some conditions
%
% [ Syntax ]
%   - b = celany(C, f)
%
% [ Arguments ]
%   - C:        the source cell array
%   - f:        the predicate function handle
%   - b:        the judgment
%
% [ Description ]
%   - b = celany(C, f) tests whether there exist elements in the cell array C
%     that satisfies the condition given by f. f is a predicate function handle 
%     applied on each element.
%
% [ Examples ]
%   - Test whether the lengths of some strings are larger than 3
%     \{
%         celany({'ab', 'm', 'tig'}, @(x) length(x) > 3)
%         => false
%
%         celany({'ab', 'mat', 'tiger'}, @(x) length(x) > 3)
%         => true
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

b = anytrue(cellfun(f, C));
