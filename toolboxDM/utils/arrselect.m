function As = arrselect(A, f)
%ARRSELECT Selects the elements in an array satisfying some conditions
%
% [ Syntax ]
%   - As = arrselect(A, f)
%
% [ Arguments ]
%   - A:            the source array
%   - f:            the predicate function handle
%   - As:           the array of selected elements
%
% [ Description ]
%   - As = arrselect(A, f) selects a subset of elements in A which
%     satisfy the condition specified by the predicate function handle f.
%     f returns true for the elements that meet the condition and false
%     otherwise.
%
% [ Remarks ]
%   - It can be applied to arrays of any types including numeric, logical,
%     struct array, cell array, and others. 
%
%   - However, for numeric and logical arrays, it is not recommended to 
%     use arrselect, directly using logical indexing will be much more
%     efficient. For example, to select all positive values in a numeric
%     matrix A, you may write as A(A > 0).
%
%   - For cell arrays, using celselect is preferrable.
%
%   - This function is typically used for struct arrays.
%     
%
% [ Examples ]
%   - Select the struct elements with the field a > 0
%     \{
%         S = struct('a', {-3, -2, 1, 3, 2}, 'b', {3, 5, 6, 7, 9});
%
%         arrselect(S, @(s) s.a > 0)
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

As = A(arrayfun(f, A));