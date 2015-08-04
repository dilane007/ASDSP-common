function b = celinclude(C, x)
%CELINCLUDE Tests whether a cell array includes a specified element
%
% [ Syntax ]
%   - b = celinclude(C, x)
%
% [ Arguments ]
%   - C:        the cell array
%   - x:        the element to be tested
%   - b:        whether the testing element is in the cell array
%
% [ Description ]
%   - b = celinclude(C, x) gets whether there is an element in C that
%     is equal to x.
% 
% [ Remarks ]
%   - It can be applied to any type of values/arrays that support 
%     isequal comparison. Thus it works in a broader area than ismember.
%
% [ Examples ]
%   - Test the existence of an element
%     \{
%         celinclude({1, 2, 3}, 1) => true
%
%         celinclude({1, 2, 3}, 4) => false
%
%         celinclude({1, 2, 3; 4, 5, 6}, 5) => true
%     \}
%
%   - Test the existence of an array
%     \{
%         celinclude({[1 2], [3 4], [5 6]}, [3 4]) => true
%
%         celinclude({[1 2], [3 4], [5 6]}, [1 3]) => false
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

b = anytrue(cellfun(@(e) isequal(e, x), C));






