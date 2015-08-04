function tuples = celmerge(varargin)
%CELMERGE Merges multiple cell arrays into a cell array of tuples
%
% [ Syntax ]
%   - tuples = celmerge(C1, C2, ...)
%
% [ Description ]
%   - tuples = celmerge(C1, C2, ...) merges the cell arrays C1, C2, ...
%     to construct a cell array of tuples. Each tuple is a cell array in 
%     which each element is from the corresponding element of the input
%     cell arrays.
%
%     Suppose C1, C2, ... are respectively in the form as
%     C1 = {e11, e12, ...}, C2 = {e21, e22, ...}, then
%     the output tuples will be 
%     tuples = {{e11, e21, ...}, {e12, e22, ...}}.
%
% [ Remarks ]
%   - C1, C2, ... should be cell arrays of equal size. 
%
% [ Examples ]
%   - Construct tuple array 
%     \{
%         C1 = {'xyz', 'abc', 'uv'};
%         C2 = {3, 6, 8};
%         C3 = {[1 2], [3 4], [8 7]};
%         celmerge(C1, C2, C3)
%         => {{'xyz', [3], [1 2]}, {'abc', [6], [3 4]}, {'uv', [8], [8 7]}}
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

tuples = cellfun(@(varargin) varargin, varargin{:}, 'UniformOutput', false);

