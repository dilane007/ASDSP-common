function c = countfalse(V)
%COUNTFALSE Counts the number of false values in a logical array
%
% [ Syntax ]
%   - c = countfalse(V)
%
% [ Arguments ]
%   - V:        the logical array to be tested
%   - c:        the number of false values
%   
% [ Description ]
%   - c = countfalse(V) counts the number of false values in the logical
%     array V.
%
% [ Remarks ]
%   - It is functionally equivalent to sum(1 - V(:)). However, it is much more
%     efficient to deal with large arrays and multi-dimensional arrays.
%
%   - The addition to the counter only takes place when a false value is 
%     encountered. Thus it is generally more faster when the false value is
%     less. Hence, when the majority are true, using countfalse is faster,
%     otherwise, using counttrue is faster.
%
% [ Examples ]
%   - Count how many values that are not positive
%     \{
%         X = [-2 1 0; 3 -4 -5];
%         countfalse(X > 0) => 4
%     \}
% 
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

c = countfalse_cimp(V);