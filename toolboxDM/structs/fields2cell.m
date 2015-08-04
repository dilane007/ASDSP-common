function C = fields2cell(s, fieldnames)
%FIELDS2CELL Gets multiple fields of a struct and form a cell array
%
% [ Syntax ]
%   - C = field2cell(s)
%   - C = fields2cell(s, fieldnames)
%
% [ Arguments ]
%   - s:            the source struct
%   - fieldnames:   the cell array of fieldnames to be retrieved
%   - C:            the cell array of extracted fields
%
% [ Description ]
%   - C = fields2cell(s) extracts all fields of s and groups them
%     into a cell array.
%   
%     It is functionally equivalent to fields2cell(s, fieldnames(s))
%
%   - C = fields2cell(s, fieldnames) extracts the fields specified
%     by the fieldnames from a struct and group them into a cell array.
%   
% [ Remarks ]
%   - s should be s scalar struct (have only one element). The names
%     in fieldnames can be repeated.
%
%   - The size of C will be equal to the size of fieldnames.
%
% [ Examples ]
%   - Extract all fields to form a cell array
%     \{
%         s = struct('name', 'abc', 'id', 1, 'value', 'xyz');
%
%         fields2cell(s)
%         => {'abc'; [1]; 'xyz'}
%     \}
%
%   - Extract multiple fields to form a cell array
%     \{
%         s = struct('name', 'abc', 'id', 1, 'value', 'xyz');
%
%         fields2cell(s, {'id', 'name'})
%         => {[1], 'abc'}
%
%         fields2cell(s, {'name', 'value', 'value'});
%         => {'abc', 'xyz', 'xyz'}
%
%         fields2cell(s, {});
%         => {}
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 26, 2007
%

error(nargchk(1, 2, nargin));

typecheck(s, 's should be a scalar struct', 'struct');
typecheck(s, 's should be a scalar struct', 'scalar');

if nargin == 1
    C = struct2cell(s);
else
    typecheck(fieldnames, 'fieldnames should be a cell array of strings', ...
        'cell', 'empty');
    
    C = cellfun(@(fn) s.(fn), fieldnames, 'UniformOutput', false);    
end






