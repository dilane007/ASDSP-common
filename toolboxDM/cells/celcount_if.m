function n = celcount_if(C, f)
%CELCOUNT Counts the number of elements satisfying some conditions
%
% [ Syntax ]
%   - n = celcount_if(C, f)
%
% [ Arguments ]
%   - C:        the source cell array
%   - f:        the predicate function handle
%   - n:        the number of the elements satisfying the condition
%
% [ Description ]
%   - n = celcount_if(C, f) gets the number of elements in C for which
%     the predicate f returns true.
%
% [ Examples ]
%   - Counts the number of strings with length smaller than 3
%     \{
%         celcount_if({'a', 'matlab', 'b', 'c1'}, @(x) length(x) < 3) 
%         => 3
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

n = counttrue(cellfun(f, C));