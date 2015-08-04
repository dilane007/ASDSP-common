function s = strsubsfmt(str, pattern, fmt, op)
%STRSUBSFMT Replaces specified patterns in a string with new format
%
% [ Syntax ]
%   - s = strsubsfmt(str, pattern, fmt)
%   - s = strsubsfmt(str, pattern, fmt, op)
%
% [ Arguments ]
%   - str:      the source string
%   - pattern:  the regexp pattern to be searched and replaced
%   - fmt:      the formatter of the found patterns to new string
%   - op:       the option string of pattern formatting
%               \{:
%                   - ord:    using token order
%                   - named:  using named token
%               \:}
%
% [ Description ]
%   - s = strsubsfmt(str, pattern, fmt) finds all sub-strings that match
%     the specified regular expression pattern and replace them with by
%     a new string yielded by re-formatting the matched tokens using fmt.
%
%     The format specification fmt should be given follows the rule 
%     introduced in the function strformat. Actually strformat is used to
%     finish the formatting. Please note that all tokens are strings.
%
%     By default, the function uses the order of the tokens to identify which
%     token to be used to fill the holes in the formatter. This is
%     equivalent to
%       $ strsubsfmt(str, pattern, fmt, 'ord') $
%
%   - s = strsubsfmt(str, pattern, fmt, op) can specify the option of
%     formatting. By setting op to 'ord', it means identifying the tokens
%     by their order in the pattern, while setting op to 'named' means 
%     the tokens are identified by names.
%
% [ Examples ]
%   - Replace formatting
%     \{
%         strsubsfmt('I use MATLAB 7.4 and Java 1.6', '(\w+)\s+(\d+\.\d+)', ...
%                    '#{1:%s} of version #{2:%s}')
%         => 'I use MATLAB of version 7.4 and Java of version 1.6'
%     \}
%
%   - Replace formatting with named tokens
%     \{
%         strsubsfmt('I use MATLAB 7.4 and Java 1.6', '(?<name>\w+)\s+(?<ver>\d+\.\d+)', ...
%                    '#{name:%s} of version #{ver:%s}', 'named')
%         => 'I use MATLAB of version 7.4 and Java of version 1.6'         
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 28, 2007
%

%% parse and verify input arguments

error(nargchk(3, 4, nargin));
typecheck(str, 'str should be a string or empty', 'string', 'empty');
typecheck(pattern, 'pattern should be a string', 'string');
typecheck(fmt, 'fmt should be a string', 'string');

if nargin < 4
    op = 'ord';
end

%% main

switch op
    case 'ord'
        [tokens, starts, ends] = regexp(str, pattern, 'tokens','start','end');
        rstrs = cellfun(@(c) strformat(fmt, c), tokens, 'UniformOutput', false);
        s = strrangesubs(str, [starts; ends], rstrs);
    case 'named'
        [tokens, starts, ends] = regexp(str, pattern, 'names','start','end');
        rstrs = arrayfun(@(st) strformat(fmt, st), tokens, 'UniformOutput', false);
        s = strrangesubs(str, [starts; ends], rstrs);
    otherwise
        error('dmtoolbox:strsubsfmt:invalidop', ...
            'Invalid option for strsubsfmt: %s', op);
end





