function varargout = celsplit(tuples, inds)
%CELSPLIT Splits the cell array of tuples into multiple cell arrays
%
% [ Syntax ]
%   - [C1, C2, ...] = celsplit(tuples, [idx1, idx2, ...])
%
% [ Description ]
%   - [C1, C2, ...] = celsplit(tuples, [idx1, idx2, ...]) splits the
%     cell array of tuples into multiple cell arrays. 
%
%     A tuple is a cell array of several elements. Suppose tuples are
%     in the form as {{e11, e12, ...}, {e21, e22, ...}, ...}, then
%     in the output, we have
%       C1 = {e11, e21, ...}, and C2 = {e12, e22, ...}
%     C1, C2, ... have the same size as tuples.
%
% [ Remarks ]
%   - The indices must be given in form of an integer vector. The number
%     of output arguments should be equal to the number of indices.
%     
% [ Examples ]
%   - Split a cell array of tuples
%     \{
%         tuples = {{'a', 1, 0.2}, {'xy', 3, 4.7}, {'uv', 8, 3.1}};
%         [C1, C2, C3] = celsplit(tuples, 1:3)
%         C1 <= {'a', 'xy', 'uv'}
%         C2 <= {[1], [3], [8]}
%         C3 <= {[0.2], [4.7], [3.1]}
%     \}
%
%   - The indices can be in any order or even repeated
%     \{
%         [A, B, C] = celsplit(tuples, [1 2 1])
%         A <= {'a', 'xy', 'uv'}
%         B <= {[1], [3], [8]}
%         C <= {'a', 'xy', 'uv'}
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

[varargout{1:nargout}] = cellfun(@(t) deal(t{inds}), tuples, 'UniformOutput', false); 
