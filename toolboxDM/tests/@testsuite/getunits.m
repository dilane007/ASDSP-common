function units = getunits(tsuite)
%GETUNITS Gets the cell array of units of the test suite
%
% [ Syntax ]
%   - units = getunits(tsuite)
%
% [ Description ]
%   - units = getunits(tsuite) gets the cell array of the units contained
%     in this test suite.
% 
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

units = tsuite.units;
