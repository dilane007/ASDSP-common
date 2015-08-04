function tuples = struct2tuples(S, fieldnames)
%STRUCT2TUPLES Converts a struct array into a cell array of tuples
%
% [ Syntax ]
%   - tuples = struct2tuples(S, fieldnames)
%
% [ Arguments ]
%   - S:            the source struct array
%   - fieldnames:   the names of the fields to be extracted
%   - tuples:       the created cell array of tuples
%
% [ Description ]
%   - tuples = struct2tuples(S) creates a cell array of tuples
%     by extracting all fields in S.
%
%     It is equivalent to struct2tuples(S, fieldnames(S))
%
%   - tuples = struct2tuples(S, fieldnames) creates a cell array of
%     tuples by extracting the specified fields in a struct to form 
%     the tuples.
%
% [ Remarks ]
%   - The size of the cell array of tuples will be equal to that of S.
%     While the size of each tuple will be equal to that of fieldnames.
%
% [ Examples ]
%   - Construct the tuple array by extracting all fields
%     \{
%         S = struct('a', {1, 2, 3}, 'b', {'x', 'y', 'z'})
%
%         struct2tuples(S)
%         => {{[1]; 'x'}, {[2]; 'y'}, {[3]; 'z'}}
%     \}
%
%   - Construct the tuple array by extracting specified fields
%     \{
%         struct2tuples(S, {'a'})
%         => {{[1]}, {[2]}, {[3]}}
%
%         struct2tuples(S, {'b', 'a'})
%         => {{'x', [1]}, {'y', [2]}, {'z', [3]}}
%
%         struct2tuples(S, {'a', 'b'; 'b', 'a'})
%         => {{[1], 'x'; 'x', [1]}, {[2], 'y'; 'y', [2]}, {[3], 'z'; 'z', [3]}}
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%


typecheck(S, 'S must be a struct array or empty', 'struct', 'empty');
if nargin >= 2
    typecheck(fieldnames, 'fieldnames must be a cell array of strings', 'cell');
end

if ~isempty(S)    
    if nargin < 2
        tuples = arrayfun(@struct2cell, S, 'UniformOutput', false);
    else
        tuples = arrayfun(@(s) cellfun(@(fn) s.(fn), fieldnames, 'UniformOutput', false), ...
            S, 'UniformOutput', false);
    end
else
    tuples = {};
end

