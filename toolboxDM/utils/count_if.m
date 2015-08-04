function n = count_if(A, f)
%COUNT_IF Counts the number of elements satisfying some conditions
%
% [ Syntax ]
%   - n = count_if(A, f)
%
% [ Arguments ]
%   - A:        the source array
%   - f:        the predicate function handle
%   - n:        the number of the elements satisfying the condition
%
% [ Description ]
%   - n = count_if(C, f) gets the number of elements in C for which
%     the predicate f returns true.
%
% [ Examples ]
%   - Counts the number of struct elements with field name equaling 1
%     \{
%         S = struct('a', {1, 2, 1}, 'b', {3, 4, 5});
%         count_if(S, @(s) s.a == 1)  => 2
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

n = counttrue(arrayfun(@(x) f(x), A));
