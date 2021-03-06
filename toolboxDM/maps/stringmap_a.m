function val = stringmap_a(key, keys, values, defaultval)
%STRINGMAP_A Maps a string key to a value in an array
%
% [ Syntax ]
%   - val = stringmap_a(key, keys, values)
%   - val = stringmap_a(key, keys, values, defaultval)
%
% [ Arguments ]
%   - key:          the key of which the corresponding value is queried
%   - keys:         the set of all keys in the map
%                   the keys must be a cell array of strings
%   - values:       the set of all corresponding values
%                   the values is an array
%   - defaultval:   the default value returned when key is not found
%   - val:          the value corresponding to the key
%
% [ Description ]
%   - val = stringmap_a(key, keys, values) looks up the key-value map and
%     returns the value corresponding to the key. The map is characterized
%     by a set of keys and the corresponding set of values. If the key
%     is not found in keys, an empty array will be returned.
%
%   - val = stringmap_a(key, keys, values, defaultval) specifies the default
%     value which is returned when the specified key is not found.
%
% [ Remarks ]
%   - If the keys contains multiple element that is equal to key, then only
%     the first one take effects.
%
% [ Examples ]
%   - Look up a number according to its name
%     \{
%         stringmap_a('two', {'one', 'two', 'three'}, 1:3)
%         => 2
%
%         stringmap_a('four', {'one', 'two', 'three'}, 1:3)
%         => []
%
%         stringmap_a('four', {'one', 'two', 'three'}, 1:3, 0)
%         => 0
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

%% process input

if nargin < 4
    defaultval = [];
end


%% main

idx = find(strcmp(key, keys), 1);
if ~isempty(idx)
    val = values(idx);
else
    val = defaultval; 
end

