function C = strscant(str, pattern, f, inputform)
%STRSCANT Scans the tokens of sub strings matching the specified patterns
%
% [ Syntax ]
%   - C = strscant(str, pattern, f)
%   - C = strscant(str, pattern, f, inputform)
%
% [ Arguments ]
%   - strs:         the source string to be scanned
%   - pattern:      the regular expression pattern (with tokens)
%   - f:            the method to produce results from extracted tokens
%                   when f is empty, it can be omitted.
%   - inputform:    the form of arguments input to f
%                   \{:
%                       - 'free': The default form
%                                 $ r = f(token1, token2, ...) $
%                       - 'cell': the tokens are grouped into a cell
%                                 $ r = f({token1, token2, ...}) $
%                       - 'struct': the struct with named tokens
%                                 $ r = f(s) $
%                   \:}
%   - C:            the cell array of generated results
%
% [ Description ]
%   - C = strscant(str, pattern, f) scans the string using a regular 
%     expression pattern with tokens to capture.
%     The extracted tokens for each matched sub string will be used by the
%     the method specified in f to produce the corresponding results.
%     
%     f can be a function name, or a function handle. In these cases,
%     the result for each match will be generated by invoking the function
%     with free form.
%
%     f can also be empty, then each element of C is a cell array of 
%     extracted tokens.
%     
%     If there are matched sub strings, the corresponding generated results
%     will be grouped in a 1 x n cell array C and returned, where n is the
%     number of matches. If str is empty or no matched sub strings are
%     found, then an empty cell array will be returned.
%
%   - C = strscant(str, pattern, f, inputform) scans the string and
%     generate the results with specified form. 
%
% 
% [ Examples ]
%   - Finds all the braced pairs of numbers in a string and group them into
%     cell arrays.
%     \{
%          strscant('(1,2), (3, 4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)');
%          => {{'1'  '2'}, {'3'  '4'}}
%     \}
%     If you need to further convert the tokens into addition formulas:
%     \{
%          strscant('(1,2), (3, 4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)', ...
%                   @(x, y) [x ' + ' y]); 
%          => {'1 + 2', '3 + 4'} 
%     \}
%     Or, if you need to compute the sum of each pair of values:
%     \{
%          strscant('(1,2), (3, 4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)', ...
%                   @(x, y) eval([x '+' y]));
%          => {[3], [7]}
%     \}
%
%   - The following example shows a more complicated case: to produce
%     addition formulas in string from the braced pairs of values.
%     \{
%          strscant('(1,2), (3,4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)', ...
%                   @(x, y) [x ' + ' y ' = ' num2str(eval([x '+' y]))] );
%          => {'1 + 2 = 3',  '3 + 4 = 7'}      
%     \}
%     
%   - Using cell form for the result making function.
%     \{
%          strscant('(1,2,3) (a,b,c)', '\((\w+),(\w+),(\w+)\)', ...
%                   @(c) [c{1}, '+', c{2}, '+', c{3}], 'cell');
%          => {'1+2+3', 'a+b+c'}
%     \}
%
%   - Using named tokens to convert the scope synax from 
%     parent.child to parent::child
%     \{
%          strscant('space.name class.method', ...
%                   '(?<parent>\w+)\.(?<child>\w+)', ...
%                   @(s) [s.parent, '::', s.child], 'struct');
%          => {'space::name', 'class::method'}
%     \}
%
% [ Remarks ]
%   - This function wraps the regexp function with a concise
%     interfac to handle tokens.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 24, 2007
%

%% parse and verify input arguments

error(nargchk(2, 4, nargin));

typecheck(str, 'str should be a string or empty', 'string', 'empty');
typecheck(pattern, 'pattern should be a string', 'string');

if nargin < 3
    f = [];
else
    typecheck(f, 'f should be a string or a function handle', ...
        'string', 'function_handle', 'empty');
end

if nargin < 4
    inputform = 'free';
else
    typecheck(inputform, 'inputform should be a string', 'string');
end


%% main delegate

switch inputform
    case 'free'
        C = scant_free(str, pattern, f);
    case 'cell'
        C = scant_cell(str, pattern, f);
    case 'struct'
        C = scant_struct(str, pattern, f);
    otherwise
        error('dmtoolbox:strscant:invalidarg', ...
            'Unknown inputform for strscant: %s', inputform);
end


%% Core functions

function C = scant_free(str, pattern, f)

tokens = regexp(str, pattern, 'tokens');
if ~isempty(f)
    if ischar(f)
        fh = @(x) feval(f, x{:});
    else
        fh = @(x) f(x{:});
    end    
    C = cellfun(fh, tokens, 'UniformOutput', false);    
else
    C = tokens;
end


function C = scant_cell(str, pattern, f)

tokens = regexp(str, pattern, 'tokens');
if ~isempty(f)
    if ischar(f)
        fh = @(x) feval(f, x);
    else
        fh = @(x) f(x);
    end    
    C = cellfun(fh, tokens, 'UniformOutput', false);    
else
    C = tokens;
end


function C = scant_struct(str, pattern, f)

named_tokens = regexp(str, pattern, 'names');
if isempty(f)
    fh = @(x) x;
elseif ischar(f)
    fh = @(x) feval(f, x);
else
    fh = @(x) f(x);
end    
C = arrayfun(fh, named_tokens, 'UniformOutput', false);    







