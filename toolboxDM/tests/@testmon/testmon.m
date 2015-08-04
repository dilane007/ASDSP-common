function tmon = testmon()
%TESTMON Constructs a testing monitor
%
% [ Syntax ]
%   - tmon = testmon();
%
% [ Description ]
%   - tmon = testmon() constructs a testing monitor. It can be used to
%     monitor the running of testing functions, checking the assertions
%     and capturing the exceptions, and making records.
%
% [ Remarks ]
%   - The monitor keeps the recorded information in a single linked list,
%     in order to facilitate dynamic appending.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%


tmon = struct( ...    
    'recs', [],  ...
    'n_recs', 0 );                  % the actual number of records

tmon = class(tmon, 'testmon');
