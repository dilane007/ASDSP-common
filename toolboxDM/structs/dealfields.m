function varargout = dealfields(S, varargin)
%DEALFIELDS Deals field values to cell arrays
%
% [ Syntax ]
%   - [C1, C2, ...] = dealfields(S, fieldname1, fieldname2, ...)
%
% [ Arguments ]
%   - S:            the source struct array
%   - fieldnamei:   the name of the i-th field to be dealed
%   - Ci:           the cell array of the i-th field values
%
% [ Description ]
%   - [C1, C2, ...] = dealfields(S, fieldname1, fieldname2, ...) deals
%     the specified fields to the cell arrays.
%
%     All output cell arrays have the same size as that of S.
%
% [ Examples ]
%   - Deal the fields to cell arrays
%     \{
%         S = struct('name', {'x', 'y', 'z'; 'a', 'b', 'c'}, ...
%                    'v1', {1, 2, 3; 4, 5, 6}, ...
%                    'v2', {2.4, 1.8, 3.6; 5.2, 6.1, 7.3} );
%
%         [Cn, Cv1] = dealfields(S, 'name', 'v1');
%         Cn <= {'x', 'y', 'z'; 'a', 'b', 'c'};
%         Cv1 <= {1, 2, 3; 4, 5, 6};
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 28, 2007
%

%% parse and verify input

typecheck(S, 'S should be a struct array or empty', 'struct', 'empty');

%% main

if ~isempty(S)
    varargout = cellfun( ...
        @(fn) arrayfun(@(s) s.(fn), S, 'UniformOutput', false), ...
        varargin, 'UniformOutput', false);
else
    varargout = cell(1:length(varargin));
end


