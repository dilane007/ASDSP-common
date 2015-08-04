function S = tuples2struct(tuples, inds, fieldnames)
%TUPLES2STRUCT Constructs a struct array using the values in tuples
%
% [ Syntax ]
%   - S = tuples2struct(tuples, fieldnames)
%
% [ Arguments ]
%   - tuples:       the cell array of tuples
%   - inds:         the indices of tuple components to be extracted
%   - fieldnames:   the fieldnames of the struct
%   - S:            the created struct array
%
% [ Description ]
%   - S = tuples2struct(tuples, inds, fieldnames) creates a struct array
%     with the fields given by the specified tuples components. 
%
% [ Remarks ]
%   - The size of S will be equal to the size of tuples.
%
% [ Examples ]
%   - Create struct array from a cell array of tuples
%     \{
%         s = tuples2struct({{1, 10}, {2, 'x'}, {3, [30, 1]}}, [1, 2], {'a', 'b'})
%         => s is a 1x3 struct array with fields: a and b
%            s(1) <= a: 1, b: 10
%            s(2) <= a: 2, b: 'x'
%            s(3) <= a: 3, b: [30 1]         
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

%% parse and verify input

error(nargchk(3, 3, nargin));
typecheck(tuples, 'tuples should be a cell array or empty', 'cell', 'empty');
typecheck(fieldnames, 'fieldnames should be a cell array of strings', 'cell');

%% main

if ~isempty(tuples)
    F = fieldnames(:)';
    [V{1:numel(inds)}] = celsplit(tuples, inds);
    FV = [F; V];
    S = struct(FV{:});
else
    S = struct([]);
end