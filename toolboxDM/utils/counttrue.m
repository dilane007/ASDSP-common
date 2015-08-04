function c = counttrue(V)
%COUNTTRUE Counts the number of true values in a logical array
%
% [ Syntax ]
%   - c = counttrue(V)
%
% [ Arguments ]
%   - V:        the logical array to be tested
%   - c:        the number of true values
%   
% [ Description ]
%   - c = counttrue(V) counts the number of true values in the logical
%     array V.
%
% [ Remarks ]
%   - It is functionally equivalent to sum(V(:)). However, it is much more
%     efficient to deal with large arrays and multi-dimensional arrays.
%
%   - The addition to the counter only takes place when a true value is 
%     encountered. Thus it is generally more faster when the true value is
%     less. Hence, when the majority are true, using countfalse is faster,
%     otherwise, using counttrue is faster.
%
% [ Examples ]
%   - Count how many positive values
%     \{
%         X = [-2 1 0; 3 -4 -5];
%         counttrue(X > 0) => 2
%     \}
% 
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

c = counttrue_cimp(V);
