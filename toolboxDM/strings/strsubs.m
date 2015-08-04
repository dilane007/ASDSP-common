function strnew = strsubs(str, pattern, rule, varargin)
%STRTOKENSUBS Substitute the tokens in a string by converted strings
%
% [ Syntax ]
%   - strnew = strsubs(str, pattern, rule, ...)
%
% [ Arguments ]
%   - str:          the source string
%   - pattern:      the regular expression 
%   - rule:         the substitution rule
%                   \{:
%                       - fixstr: replace each matched sub string with 
%                         a fixed string                       
%                       - conv: replace each matched sub string by
%                         applying a conversion function on the matched
%                       - t-str: replace each token with given strings
%                       - t-conv: replace each token by applying a 
%                         conversion functions on it                                          
%                   \:}
%   - strnew:       the resulting string
%
% [ Description ]
%   - strnew = strsubs(str, pattern, 'fixstr', rstr) replaces all the
%     matched sub strings with a fixed string rstr.
%
%   - strnew = strsubs(str, pattern, 'conv', f, inputform) replaces each
%     matched sub string by applying a conversion function f. Here, f can
%     should be a function handle.
%
%     The inputform specifies what inputs are given to f. It can be
%     \{:
%         - str:    input the whole matched sub string
%                    $ rstr = f(str) $
%         - tokens: input the extracted tokens specified by the pattern
%                    $ rstr = f(token1, token2, ...) $
%         - tkcell: input the cell array of extracted tokens
%                    $ rstr = f({token1, token2, ...}) $
%         - tkstruct: input the struct of named tokens
%                       $ rstr = f(s) $
%                     s is a struct with field names being the token name
%                     and field values being the tokens.         
%     \:}
%
%   - strnew = strsubs(str, pattern, 't-str', rstr) replaces all tokens
%     in each matched sub string with a fixed string rstr.
%
%   - strnew = strsubs(str, pattern, 't-str', rstrs) replaces each token
%     in every matched sub string with the corresponding string in rstrs.
%     If there are nt tokens specified by pattern ,then rstrs should be a
%     cell array with nt strings.
%
%   - strnew = strsubs(str, pattern, 't-conv', f) replaces each token in 
%     every matched sub string by applying the conversion function f as
%        $ rstr = f(token) $
%
%   - strnew = strsubs(str, pattern, 't-conv', fs) replaces each token in
%     every matched sub string by applying the corresponding function. fs
%     is a cell array of nt functions (in function name of function
%     handle).
%
% [ Examples ]
%   - Convert every word 'good' to 'great'
%     \{
%         strsubs('It is a good thing. He is a good man', 'good', 'fixstr', 'great')
%         => 'It is a great thing. He is a great man'  
%     \}
%
%   - Capitalize every word in a title
%     \{
%         strsubs('MATLAB plays an important role', '\w+',  ...
%                 'conv', @(x) [upper(x(1)), x(2:end)], 'str')
%         => 'MATLAB Plays An Important Role'
%     \}
%
%   - Replace each pair of numbers in braces to an addition formula
%     \{
%         strsubs('Look at (1, 2) and (3, 4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)', ...
%                 'conv', @(x, y) [x, '+', y, '=', num2str(str2double(x) + str2double(y))], ...
%                 'tokens')
%         => 'Look at 1+2=3 and 3+4=7'
%     \}
%
%   - Replace convert a simple for-loop in Matlab to C-syntax with named
%     tokens
%     \{
%         strsubs('for i = 1 : n', 
%                 'for\s+(?<var>\w+)\s*=\s*(?<init>\w+)\s*\:\s*(?<last>\w+)', ...
%                 'conv', @(x) sprintf('for(int %s = %s; %s <= %s; ++%s)', ...
%                                      x.var, x.init, x.var, x.last, x.var), ...
%                 'tkstruct')
%         => 'for(int i = 1; i <= n; ++i)'
%     \}
%
%   - Replace every ip address in the string with xxx.xxx.xxx.xxx
%     \{
%         strsubs('My IP is 123.456.789.012', '(\d+).(\d+).(\d+).(\d+)', ...
%                 't-str', 'xxx')
%         => 'My IP is xxx.xxx.xxx.xxx'
%     \}
%
%   - Suppose in some text, it defines a section 
%     like 'start ... completed', 
%     and we like to convert it to 'begin ... end'
%     \{
%         strsubs('start abc completed  start xyz completed', ...
%                 '(start)\s*\w+\s*(completed)', ...
%                 't-str', {'begin', 'end'})
%         => 'begin abc end  begin xyz end'
%     \}
%
%   - Append each operand of an addition formula with a char a
%     \{
%         strsubs('Here are 1+2 and 4+5', '(\d+)\+(\d+)', ...
%                 't-conv', @(x) ['a', x])
%         => 'Here are a1+a2 and a4+a5'
%     \}
%
%   - Convert all forms like xxx.yyy to [xxx].(yyy)
%     \{
%         strsubs('abc.name1, xyz.field2', '(\w+)\.(\w+)', ...
%                 't-conv', {@(x)['[', x, ']'], @(x)['(', x, ')']})
%         => '[abc].(name1), [xyz].(field2)'
%     \}
%
% [ History]
%   - Created by Dahua Lin, on Jun 26, 2007
%

%% parse and verify input arguments

error(nargchk(4, 5, nargin));

typecheck(str, 'str should be a string or empty', 'string', 'empty');
typecheck(pattern, 'pattern should be a string', 'string');
typecheck(rule, 'rule should be a string', 'string');

%% main delegate

switch rule
    case 'fixstr'
        strnew = strsubs_fixstr(str, pattern, varargin{1});
    case 'conv'
        strnew = strsubs_conv(str, pattern, varargin{1}, varargin{2});
    case 't-str'
        strnew = strsubs_tstr(str, pattern, varargin{1});
    case 't-conv'
        strnew = strsubs_tconv(str, pattern, varargin{1});
    otherwise
        error('string:strsubs:invalidarg', 'Invalid rule %s for strsubs', rule);
end


%% Core functions

function strnew = strsubs_fixstr(str, pattern, rstr)

typecheck(rstr, 'rstr should be a string', 'string');

[sp, ep] = regexp(str, pattern, 'start', 'end');
ranges = [sp; ep];
strnew = strrangesubs(str, ranges, rstr);


function strnew = strsubs_conv(str, pattern, f, inputform)

typecheck(f, 'f should be a function handle', 'function_handle');    
typecheck(inputform, 'inputform should be a string', 'string');

switch inputform
    case 'str'
        [args, sp, ep] = regexp(str, pattern, 'match', 'start', 'end');
        rstrs = cellfun(f, args, 'UniformOutput', false);
    case 'tokens'
        [args, sp, ep] = regexp(str, pattern , 'tokens', 'start', 'end');
        rstrs = cellfun(@(c) f(c{:}), args, 'UniformOutput', false);
    case 'tkcell'
        [args, sp, ep] = regexp(str, pattern, 'tokens', 'start', 'end');
        rstrs = cellfun(f, args, 'UniformOutput', false);
    case 'tkstruct'
        [args, sp, ep] = regexp(str, pattern, 'names', 'start', 'end');
        rstrs = arrayfun(f, args, 'UniformOutput', false);
    otherwise
        error('dmtoolbox:strsubs', ...
            'Invalid inputform %s for the conv rule', inputform);
end

ranges = [sp; ep];
strnew = strrangesubs(str, ranges, rstrs);


function strnew = strsubs_tstr(str, pattern, rstr)

typecheck(rstr, 'rstr should be a either a string or a cell array', ...
        'string', 'cell');

r = regexp(str, pattern, 'tokenExtents');
nm = length(r);

ranges = cellfun(@(x) x', r, 'UniformOutput', false);
ranges = horzcat(ranges{:});

if iscell(rstr)
    rstr = repmat(rstr, 1, nm);
end

strnew = strrangesubs(str, ranges, rstr);



function strnew = strsubs_tconv(str, pattern, conv)

typecheck(conv, 'conv should be either a function handle or a cell of function handles', ...
        'function_handle', 'cell');
    
[tks, r] = regexp(str, pattern, 'tokens', 'tokenExtents');

ranges = cellfun(@(x) x', r, 'UniformOutput', false);
ranges = horzcat(ranges{:});

if iscell(conv)
    rstrs = cellfun(@(c) cellfun(@(tk, f) f(tk), c, conv, 'UniformOutput', false), ...
        tks, 'UniformOutput', false);        
else
    rstrs = cellfun(@(c) cellfun(conv, c, 'UniformOutput', false), ...
        tks, 'UniformOutput', false);
end

rstrs = [rstrs{:}];

strnew = strrangesubs(str, ranges, rstrs);


