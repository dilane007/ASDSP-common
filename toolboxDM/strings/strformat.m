function s = strformat(fmt, varargin)
%STRFORMAT Formats a string using an ordered/named formatter
%
% [ Syntax ]
%   - s = strformat(fmt, param1, param2, ...)
%   - s = strformat(fmt, {param1, param2, ... })
%   - s = strformat(fmt, param_struct)
%   
% [ Arguments ]
%   - fmt:              the string giving the format specification
%   - parami:           the i-th parameter
%   - param_struct:     the struct of the parameters 
%   - s:                the formatted string
%
% [ Description ]
%   - s = strformat(fmt, param1, param2, ...) using an ordered formatter 
%     to format a string. 
%
%     It is a modification to the sprintf formatter to allow the flexible
%     arrangement and reusing of parameters.
%     For example, in sprintf, the format specification may be written as
%        $ 'I like %s, whose value is %d' $
%     Then in strformat it should be in the following form
%        $ 'I like #{1:%s}, whose value is #{2:%d}' $
%     Here, it uses the order 1 and 2 to specify which parameter to be used
%     to fill the hole.
%
%     The index can be in any order and reused, like 
%        $ 'begin #{1:%s}  value = #{2:%d} end #{1:%s}' $
%     Here, the first parameter is used twice.
%
%   - s = strformat(fmt, {param1, param2, ...}) formats a string using
%     the parameters grouped in a cell array.
%
%     Hence, strformat can be applied to the parameters no matter whether
%     they are encapsulated in a cell array.
%
%   - s = strformat(fmt, param_struct) formats a struct using a named
%     formatter. For example, we can write the fmt as
%        $ 'I like #{name:%s}, whose value is #{value:%d}' $
%     then the field param_struct.name will be used to fill the first hole,
%     while the field param_struct.value will be used to fill the other.
%
%     PLease note that param_struct must be a scalar struct.
%
% [ Remarks ]
%   - If no extra parameters, it simple returns the formatter string.
%
% [ Examples ]
%   - Using ordered formatter
%     \{
%         strformat('#{1:%s} of version #{2:%g} is good.', 'MATLAB', 7.4)
%         => 'MATLAB of version 7.4 is good.'
%
%         strformat('#{1:%.1f}, #{1:%.2f}, #{1:%.3f}.', pi)
%         => '3.1, 3.14, 3.142.'
%     \}
%
%   - Format tuples
%     \{
%         tuple = {'MATLAB', 7.4}
%         
%         strformat('#{1:%s} of version #{2:%g}', tuple)
%         => 'MATLAB of version 7.4'
%
%         tools = {{'MATLAB', 7.4}, {'Java', 1.6}, {'C#', 2.0}}
%         
%         cellfun(@(c) strformat('#{1:%s} [v #{2:%g}]', c), tools, ...
%                 'UniformOutput', false);
%         => {'MATLAB [v 7.4]', 'Java [v 1.6]', 'C# [v 2]'}
%     \}
%
%   - Format the same thing with different formatter
%     \{
%         fmts = {'#{1:%s} of version #{2:%g}', '#{1:%s} #{2:%g}', '#{1:%s} (v#{2:%g})'}
%         tuple = {'MATLAB', 7.4}
%
%         cellfun(@(fmt) strformat(fmt, tuple), fmts, 'UniformOutput', false)
%         => {'MATLAB of version 7.4', 'MATLAB 7.4', 'MATLAB (v7.4)'}       
%     \}
%
%   - Format a struct
%     \{
%         tool.name = 'MATLAB'
%         tool.ver = 7.4
%
%         strformat('#{name:%s} of version #{ver:%g}', tool)
%         => 'MATLAB of version 7.4'
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 28, 2007
%

%% parse and verify input

typecheck(fmt, 'fmt must be a string', 'string');

%% main

if nargin > 1
    
    % process parameters
    param1 = varargin{1};
    if isstruct(param1)
        params = param1;
        op = 'named';
    elseif iscell(param1)
        params = param1;
        op = 'ord';
    else
        params = varargin;
        op = 'ord';
    end
    
    % process format string   
    [spfmt, inds] = strfmt2sprintffmt(fmt, op);
    
    % prepare parameters
    if iscell(params)
        sp_params = params(inds);        
    else % isstruct
        sp_params = cellfun(@(fn) params.(fn), inds, 'UniformOutput', false);
    end
    
    s = sprintf(spfmt, sp_params{:});
    
else
    s = fmt;
end

