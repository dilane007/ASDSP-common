function varargout = fields2mat(S, varargin)
%FIELDS2MAT merges the field values in a struct array into arrays
%
% [ Syntax ]
%   - [M1, M2, ...] = fields2mat(S, fieldname1, fieldname2, ...)
%
% [ Arguments ]
%   - S:            the source struct array 
%   - fieldnamei:   the name of the i-th field to be processed
%   - Mi:           the merged array corresponding to the i-th field
%
% [ Description ]
%   - [M1, M2, ...] = fields2mat(S, fieldname1, fieldname2, ...) merges
%     the specified field values into arrays. 
%
%     The fields to be merged should be with scalar values. In the output,
%     all merged arrays have the same size as S.
%
% [ Remarks ]
%   - According to MATLAB's data structure, merging fields of struct array
%     into integral arrays can save considerable overhead for large struct
%     arrays. And it can also lead to considerable performance improvement
%     in runtime computation.
%
% [ Examples ]
%   - Merge fields into arrays
%     \{
%         S = struct('name', {'x', 'y', 'z'; 'a', 'b', 'c'}, ...
%                    'v1', {1, 2, 3; 4, 5, 6}, ...
%                    'v2', {2.4, 1.8, 3.6; 5.2, 6.1, 7.3} );
%
%         fields2mat(S, 'v1')
%         => [ 1 2 3;
%              4 5 6 ];
%
%         [V2, V1] = fields2mat(S, 'v2', 'v1')
%         V2 <= [2.4 1.8 3.6; 
%                5.2 6.1 7.3 ];
%         V1 <= [1 2 3;
%                4 5 6 ];
%     \}
%
%   - Convert from array of structs to struct of arrays
%     \{
%         Sa.name = dealfields(S, 'name');
%         [Sa.v1, Sa.v2] = fields2mat(S, 'v1', 'v2');
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 28, 2007
%

%% parse and verify input

typecheck(S, 'S should be a struct array or empty', 'struct', 'empty');

%% main

if ~isempty(S)
    
    % Notes:
    %   I have tried another implementation
    %       mat = reshape([S.(fieldname)], size(S))
    %   The benchmark shows that it is slower than the current one.
    %   
    %   However, using the old MATLAB version without built-in arrayfun
    %   this implementation is feasible.
    % Dahua
    
    varargout = cellfun( ...
        @(fn) arrayfun(@(s) s.(fn), S, 'UniformOutput', true), ...
        varargin, 'UniformOutput', false);
else
    varargout = cell(1:length(varargin));
end

