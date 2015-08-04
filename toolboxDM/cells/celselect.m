function Cs = celselect(C, f)
%CELSELECT Selects the elements in a cell array satisfying some conditions
%
% [ Syntax ]
%   - Cs = celselect(C, f)
%
% [ Arguments ]
%   - C:            the source cell array
%   - f:            the predicate function handle
%   - Cs:           the cell array of selected elements
%
% [ Description ]
%   - Cs = celselect(C, f) selects a subset of elements in C which
%     satisfy the condition specified by the predicate function handle f.
%     f returns true for the elements that meet the condition and false
%     otherwise.
%
% [ Examples ]
%   - Select the strings with length larger than 3
%     \{
%         C = {'a', 'matlab', 'is', 'abcd', 'sample'};
%         celselect(C, @(x) length(x) > 3)
%         => {'matlab', 'abcd', 'sample'}
%     \}
%
%   - Select the numeric values, in a collection
%     \{
%         C = {'a', 1, 2, {3, 5}, [4 7], 'xy'}
%         celselect(C, @isnumeric)
%         => {1, 2, [4 7]}
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

Cs = C(cellfun(f, C));
