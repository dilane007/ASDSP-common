function val = stringmap(key, keys, values, defaultval)
%STRINGMAP Maps a string key to a value in a cell array
%
% [ Syntax ]
%   - val = stringmap(key, keys, values)
%   - val = stringmap(key, keys, values, defaultval)
%
% [ Arguments ]
%   - key:          the key of which the corresponding value is queried
%   - keys:         the set of all keys in the map
%                   the keys must be a cell array of strings
%   - values:       the set of all corresponding values
%                   the values should be a cell array of any values.
%   - defaultval:   the default value returned when key is not found
%   - val:          the value corresponding to the key
%
% [ Description ]
%   - val = stringmap(key, keys, values) looks up the key-value map and
%     returns the value corresponding to the key. The map is characterized
%     by a set of keys and the corresponding set of values. If the key
%     is not found in keys, an empty array will be returned.
%
%   - val = stringmap(key, keys, values, defaultval) specifies the default
%     value which is returned when the specified key is not found.
%
% [ Remarks ]
%   - If the keys contains multiple element that is equal to key, then only
%     the first one take effects.
%
% [ Examples ]
%   - Look up the string map
%     \{
%         stringmap('ch', 
%                   {'ch', 'en', 'jp'}, {'Chinese', 'English', 'Japanese'})
%         => 'Chinese'
%
%         stringmap('two', {'one', 'two', 'three'}, {1, 2, 3})
%         => 2
%
%         stringmap('u', {'x', 'y', 'z'}, {1.2, 2.3, 3.4})
%         => []
%     \}
%
%   - Look up with default value
%     \{
%         stringmap('u', {'x', 'y', 'z'}, {1.2, 2.3, 3.4}, 0)
%         => 0
%     \}
%
%   - Making a query function
%     \{
%         K = {'ch', 'en', 'jp'};
%         V = {'Chinese', 'English', 'Japanese'};
%         qf = @(x) stringmap(x, K, V);
%           
%         qf('ch') => 'Chinese'
%         qf('en') => 'English'
%         qf('xyz') => []
%
%         cellfun(qf, {'ch', 'ch', 'jp', 'en'}, 'UniformOutput', false)
%         => {'Chinese', 'Chinese', 'Japanese', 'English'}
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
    val = values{idx};
else
    val = defaultval; 
end



