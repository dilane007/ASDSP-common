function C = celosf(S, fieldname)
%CELOSF Takes all values of a specified field of struct S to form a cell
%array
%
% [ Syntax ]
%   C = celosf(S, fieldname)
%
% [ Arguments ]
%   - S:          the struct array
%   - fieldname:  the name of the field to be extracted
%   - C:          the cell of struct field values
%
% [ Description ]
%   - C = celosf(S, fieldname) creates a cell array of struct field.
%     It takes the field specified by fieldname of all elements in S
%     and forms the cell array C with the same size as S.
%
% [ Examples ]
%   - Create a cell array of struct field
%     \{
%         S = struct('a', {1, 2, 3; 4, 5, 6}, ...
%                    'b', {'a', 'b', 'c'; 'x', 'y', 'z'})
%
%         celosf(S, 'a')
%         => { [1], [2], [3]; 
%              [4], [5], [6] }
%
%         celosf(S, 'b')
%         => {'a', 'b', 'c'; 
%             'x', 'y', 'z'  }
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 28, 2007
%

%% parse and verify input

typecheck(S, 'S should be a struct array or empty', 'struct', 'empty');
typecheck(fieldname, 'fieldname should be a string', 'string');

%% main

if ~isempty(S)
    
    if ~isfield(S, fieldname)
        error('dmtoolbox:celosf:notfield', ...
            'The input struct does not have a field %s', fieldname);
    end
    
    % Notes:
    %   I have tried another implementation
    %       C = reshape({S.(fieldname)}, size(S))
    %   The benchmark shows that it is slower than the current one.
    %   
    %   However, using the old MATLAB version without built-in arrayfun
    %   this implementation is feasible.
    % Dahua
            
    C = arrayfun(@(s) s.(fieldname), S, 'UniformOutput', false);
else
    C = {};
end


    