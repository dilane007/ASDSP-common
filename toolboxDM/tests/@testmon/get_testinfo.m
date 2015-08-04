function tinfo = get_testinfo(tmon)
%GET_TESTINFO Gets recorded the testing information from the monitor
%
% [ Syntax ]
%   - tinfo = get_testinfo(tmon)
%
% [ Description ]
%   - tinfo = get_testinfo(tmon) returns all the recorded information
%     of the monitor in form of a struct array of records. 
%     The struct has following fields:
%     \{:
%         - type:    the record type. (see addrec.m)
%         - file:    the source m-file in which the event occurs
%         - fname:   the function name in which the event occurs
%         - line:    the line number
%         - errmsg:  the error message of the exception
%         - errid:   the error identifier of the exception
%     \:}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

if tmon.n_recs > 0
    C = tmon.recs(1:tmon.n_recs);
    tinfo = vertcat(C{:});    
else
    tinfo = [];
end