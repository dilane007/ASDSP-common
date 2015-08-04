function print(logger, fmt, varargin)
%PRINT Prints information with the logger
%
% [ Syntax ]
%   - print(logger, fmt, ...)
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

str = sprintf(fmt, varargin{:});

tab_len = 4;
if logger.indentlevel > 0
    str = [blanks(logger.indentlevel * tab_len), str];
end

fprintf(logger.fid, '%s\n', str);
