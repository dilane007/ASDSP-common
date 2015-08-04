function val = scalarmap(key, keys, values, defaultval)
%SCALARMAP Maps a scalar to a value in a cell array
%
% [ Syntax ]
%   - val = scalarmap(key, keys, values)
%   - val = scalarmap(key, keys, values, defaultval)
%
% [ Arguments ]
%   - key:          the key of which the corresponding value is queried
%   - keys:         the set of all keys in the map
%                   the keys be an array
%   - values:       the set of all corresponding values
%                   the values should be a cell array of any values.
%   - defaultval:   the default value returned when key is not found
%   - val:          the value corresponding to the key
%
% [ Description ]
%   - val = scalarmap(key, keys, values) looks up the key-value map and
%     returns the value corresponding to the key. The map is characterized
%     by a set of keys and the corresponding set of values. If the key
%     is not found in keys, an empty array will be returned.
%
%   - val = scalarmap(key, keys, values, defaultval) specifies the default
%     value which is returned when the specified key is not found.
%
% [ Remarks ]
%   - If the keys contains multiple element that is equal to key, then only
%     the first one take effects.
%
% [ Examples ]
%   - Retrieve an object from its id
%     \{
%         scalarmap(1681, [1124, 1382, 1681], {'C++', 'Java', 'MATLAB'})
%         => 'MATLAB'
%
%         scalarmap(1382, [1124, 1382, 1681], {'C++', 'Java', 'MATLAB'})
%         => 'Java'
%
%         scalarmap(1793, [1124, 1382, 1681], {'C++', 'Java', 'MATLAB'})
%         => []
%
%         scalarmap(1793, [1124, 1382, 1681], {'C++', 'Java', 'MATLAB'}, 'none')
%         => 'none'
%     \}
%
%   - Retrieve multiple objects from ids by making a query function
%     \{
%         K = [1124, 1382, 1681];
%         V = {'C++', 'Java', 'MATLAB'};
%         qf = @(x) scalarmap(x, K, V);
%
%         qf(1681) => 'MATLAB'
%         qf(1124) => 'C++'
%
%         ids = [1124 1382 1382 1681 1124];
%         arrayfun(qf, ids, 'UniformOutput', false);
%         => {'C++', 'Java', 'Java', 'MATLAB', 'C++'}
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

if nargin < 4
    defaultval = [];
end
    
idx = find(keys == key, 1);
if ~isempty(idx)
    val = values{idx};
else
    val = defaultval; 
end

    

