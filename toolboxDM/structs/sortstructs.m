function [Ss, V] = sortstructs(S, f, vtype, mode)
%SORTSTRUCTS Sorts the elements in a struct array
%
% [ Syntax ]
%   - Ss = sortstructs(S, fieldname, vtype)
%   - Ss = sortstructs(S, fcomp, vtype)
%   - Ss = sortstructs(S, f, vtype, mode)
%   - [Ss, V] = sortstructs( ... )
%
% [ Arguments ]
%   - S:            the struct array
%   - fieldname:    the field based on which the elements are sorted
%   - fcomp:        the function handle to compute the value for sorting
%                   f receives a struct scalar as input and returns the
%                   value for sorting.
%   - vtype:        the type of the value as sorting base
%                   \{:
%                       - numeric:    numeric value
%                       - string:     the string value
%                   \:}
%   - mode:        The mode of sorting, 'ascend' or 'descend'.
%                  If the mode is not specified, it uses 'ascend' by
%                  default.
%   - Ss:          The sorted struct array
%   - V:           The values used for sorting. In the output, V is in 
%                  sorted order.
% 
% [ Syntax ]
%   - Ss = sortstructs(S, fieldname, vtype) sorts the elements in a struct
%     array based on one of its fields specified by fieldname. 
%     vtype is used to specify the type of the field values, which can be
%     either numeric or string.
%
%   - Ss = sortstructs(S, fcomp, vtype) sorts the elements in a struct array
%     by using a function handle fcomp to compute a value for each element
%     and performs the sorting based on that value.
%     vtype is used to specify the type of the values returned by fcomp,
%     which can be either numeric or string.
%
%   - Ss = sortstructs(S, f, vtype, mode) specifies whether to sort the
%     elements in ascending order or descending order of the value used,
%     corresponding to the mode 'ascend' or 'descend'.
%
%   - [Ss, V] = sortstructs( ... ) also returns the values for sorting.
%     V is also in sorted order.
%
% [ Examples ]
%   - Sort a struct array by a field 
%     \{
%         S = struct('a', {3, 5, 1}, 'b', {'z3', 'z1', 'a'});
%           
%         T = sortstructs(S, 'a', 'numeric')
%         => T(1): a = 1, b = 'a'
%            T(2): a = 3, b = 'z3'
%            T(3): a = 5, b = 'z1'
%
%         T = sortstructs(S, 'a', 'numeric', 'descend')
%         => T(1): a = 5, b = 'z1'
%            T(2): a = 3, b = 'z3'
%            T(3): a = 1, b = 'a'
%
%         T = sortstructs(S, 'b', 'string')
%         => T(1): a = 1, b = 'a'
%            T(2): a = 5, b = 'z1'
%            T(3): a = 3, b = 'z3'
%     \}
%
%   - Sort a struct array by a computation value
%     \{
%         S = struct('a', {2, 3, 5}, 'b', {4, 1, 2})
%         
%         [T, V] = sortstructs(S, @(s) s.a + s.b, 'numeric')
%         => T(1): a = 3, b = 1      
%            T(2): a = 2, b = 4
%            T(3): a = 5, b = 2
%         => V = [4 6 7]
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 28, 2007
%

%% parse and verify input arguments

error(nargchk(3, 4, nargin));

typecheck(S, 'S should be a struct array or empty', 'struct', 'empty');

if ndims(S) == 2
    [d1, d2] = size(S);
    if d2 == 1
        sdim = 1;
    elseif d1 == 1
        sdim = 2;
    else
        error('dmtoolbox:invalidarg', 'S should be a struct vector');
    end
else
    error('dmtoolbox:invalidarg', 'S should be a struct vector');
end   

typecheck(vtype, 'vtype should be a string', 'string');
switch vtype
    case 'numeric'
        uout = true;
    case 'string'
        uout = false;
    otherwise
        error('dmtoolbox:sortstructs:invalidarg', ...
            'vtype should be either ''numeric'' or ''string''');
end

if nargin < 4
    mode = 'ascend';
else
    typecheck(mode, 'mode should be a string', 'string');
end




%% main

% get values for sorting

if ischar(f)    % use fieldname
    if ~isfield(S, f)
        error('dmtoolbox:sortstructs:unknownfield', ...
            'The field %s is not in the input struct array', f);
    end
    V = arrayfun(@(s) s.(f), S, 'UniformOutput', uout);
elseif isa(f, 'function_handle')    % use computation
    V = arrayfun(f, S, 'UniformOutput', uout);
else
    error('dmtoolbox:sortstructs:invalidarg', ...
        'The 2nd argument for sortstructs must be a string or a function handle');
end

% do sorting

if uout
    [V, I] = sort(V, sdim, mode);
else
    [V, I] = sort(V);
    if strcmp(mode, 'descend')
        V = V(end:-1:1);
        I = I(end:-1:1);
    end
end
Ss = S(I);


