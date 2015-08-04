function n = nfuns(tcase)
%NFUNS Gets the number of test functions in the test case
%
% [ Syntax ]
%   - n = nfuns(tcase)
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

n = numel(tcase.testfuns);
