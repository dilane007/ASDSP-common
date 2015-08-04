function tmon = addrec(tmon, type, info)
%ADDREC Adds a record to the monitor
%
% [ Syntax ]
%   - tmon = addrec(tmon, type, info)
%
% [ Description ]
%   - tmon = addrec(tmon, type, info) appends a new record with the 
%     specified information to the monitor.
%     \[
%       &!  The supported types of records
%       &^  type      &^                description 
%       &----------------------------------------------------------------
%       &   pass      &  An assertion is passed. 
%       &   fail      &  An assertion is failed. 
%       &   fatal     &  A fatal assertion failure. 
%       &   exc       &  An unexpected exception. 
%     \]
%     
%     The info should be a struct scalar with the following fields:
%     \{:
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

%% parse and verify input 

typecheck(type, 'type should be a string', 'string');
strindex(type, {'pass', 'fail', 'fatal', 'exc'}, 'Invalid record type for testmon');
typecheck(info, 'info should be a struct scalar', 'struct');
typecheck(info, 'info should be a struct scalar', 'scalar');
    

%% main

% construct new record
new_rec = struct('type', type, ...
    'file', info.file, ...
    'fname', info.fname, ...
    'line', info.line, ...
    'errmsg', info.errmsg, ...
    'errid', info.errid );
    
% add new record
tmon.n_recs = tmon.n_recs + 1;
tmon.recs = [tmon.recs, {new_rec}];
