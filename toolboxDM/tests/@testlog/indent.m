function logger = indent(logger, d)
%Change the indent of the printing by some levels
%
% [ Syntax ]
%   - logger = indent(logger, d)
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

logger.indentlevel = logger.indentlevel + d;
