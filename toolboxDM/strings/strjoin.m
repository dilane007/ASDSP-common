function s = strjoin(strs, delimiter)
%STRJOIN Joins multiple strings with delimiters
%
% [ Syntax ]
%   - s = strjoin(strs)
%   - s = strjoin(strs, delimiter)
%
% [ Arguments ]
%   - strs:         the cell array of strings to be joined
%   - delimiter:    the delimiter string to connect the strings
%   - s:            the resulting joined string
%
% [ Description ]
%   - s = strjoin(strs) joins multiple strings together with them delimited
%     by a single space. 
%
%     It is equivalent to calling s = strjoin(strs, ' ').
%
%   - s = strjoin(strs, delimiter) joins multiple strings together with 
%     the specified delimiter.
%
% [ Examples ]
%   - Join multiple strings with spaces
%     \{
%         strjoin({'fish', 'tiger', 'cat'}) => 'fish tiger cat'
%     \}
%
%   - Join multiple strings with specified delimiter
%     \{
%         strjoin({'x', 'y', 'z'}, '+') => 'x+y+z'
%         strjoin({'x', 'y', 'z'}, ' + ') => 'x + y + z'
%         strjoin({'you', 'he', 'I'}, ' and ') => 'you and he and I'
%     \}
%
% [ Remarks ]
%   - If strs is empty, then an empty string will be returned
%
% [ History ]
%   - Created by Dahua Lin, on Jun 24, 2007
%

%% parse and verify input arguments

nargchk(1, 2, nargin);

typecheck(strs, 'strs should be a cell array of strings or empty', ...
    'cell', 'empty');

if nargin < 2
    delimiter = ' ';
end

typecheck(delimiter, 'delimiter should be a string or empty', ...
    'string', 'empty');
    
%% main

if ~isempty(strs)
    n = numel(strs);
    if n > 1        
        % augment the elements with delimiter
        if ~isempty(delimiter)
            astrs = [cellfun(@(x) [x, delimiter], strs(1:end-1), 'UniformOutput', false), ...
                strs(end)];            
        else
            astrs = strs;
        end
        
        % concatenate them 
        s = [astrs{:}];
    else
        s = strs{1};
    end
else
    s = '';
end


