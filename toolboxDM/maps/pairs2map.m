function [keys, values] = pairs2map(pairs, op)
%PAIRS2MAP Constructs a map from a cell array of key-value pairs
%
% [ Syntax ]
%   - [keys, values] = pairs2map(pairs)
%
% [ Arguments ]
%   - pairs:        the cell array of pairs
%   - op:           the options of pairs
%                   \{:
%                      - normal: the pairs is in normal form
%                                each cell contains a cell array
%                                of two elements: key and value.
%                      - reverse: each cell contains a cell array
%                                 of two elements: value and key.
%                   \:}
%   - keys:         the cell array of keys
%   - values:       the cell array of values
%
% [ Description ]
%   - [keys, values] = pairs2map(pairs) constructs a map from a cell 
%     array of pairs. Each cell in pairs is a cell array of two elements.
%     The first one is key, while the latter is value.
%
%   - [keys, values] = pairs2map(pairs, op) specifies the form of the 
%     elements in the pairs. 
%
% [ Examples ]
%   - Construct a map from the pairs in normal order
%     \{
%         [K, V] = pairs2map({ ...
%                       {'ch', 'Chinese'}, ...
%                       {'en', 'English'}, ...
%                       {'jp', 'Japanese'}});
%         K <= {'ch', 'en', 'jp'}
%         V <= {'Chinese', 'English', 'Japanese'}
%
%         [K, V] = pairs2map({{'x', 12}, {'y', 24}, {'z', 31}});
%         K <= {'x', 'y', 'z'}
%         V <= {12, 24, 31}
%     \}
%
%   - Construct a map from the pairs in reverse order
%     \{
%         [K, V] = pairs2map({ ...
%                       {'Chinese', 'ch'}, ...
%                       {'English', 'en'}, ...
%                       {'Japanese', 'jp'}}, 'reverse');
%         K <= {'ch', 'en', 'jp'}
%         V <= {'Chinese', 'English', 'Japanese'}
%     \}
%     
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

%% parse and verify input

error(nargchk(1, 2, nargin));
error(nargoutchk(2, 2, nargout));

if nargin < 2
    op = 'normal';
else
    typecheck(op, 'op should be a string', 'string');
end

%% main

switch op
    case 'normal'
        [keys, values] = celsplit(pairs, [1 2]);
        
    case 'reverse'
        [keys, values] = celsplit(pairs, [2 1]);
        
    otherwise
        error('dmtoolbox:pairs2map:invalidarg', ...
            'Invalid option for pairs2map: %s', op);
end


    
    
    