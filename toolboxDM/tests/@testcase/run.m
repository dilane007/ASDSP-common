function [info, logger] = run(tcase, logger)
%RUN Runs the test case
%
% [ Syntax ]
%   - info = run(tcase)
%   - info = run(tcase, logger)
%
% [ Arguments ]
%   - tcase:        the test case to run
%   - logger:       the logger to handle testing events
%                   (if not specified, it uses the testlog() as default)
%   - info:         the struct of testing information
%                   It contains three fields:
%                   \{:
%                       - tag:          'case_info'
%                       - case_name:    the name of the test case
%                       - tinfo:        the struct array recording the test
%                                       information.
%                                       It contains all monitored records.
%                                       There are 6 fields:
%                                       \{:
%                                           - type: 'pass'|'fail'|'fatal'|'exc'
%                                           - file: the m-file path of the
%                                                   test function
%                                           - fname: the function name
%                                           - line: the line number
%                                           - errmsg: error message
%                                           - errid: error identifier
%                                       \:}
%                                       Please refer to the help of testmon 
%                                       class for more information.
%                       - tstats:       a struct of some statistics
%                                       \{:
%                                           - records: a 1 x 4 vector of
%                                                      the numbers of different 
%                                                      types of records
%                                           - cases: a 1 x 2 vector of the
%                                                    number of passed cases
%                                                    and that of the failed
%                                                    cases
%                                       \:}
%                   \:}
%
% [ Description ]
%   - info = run(tcase) runs the testing functions in the case and monitors
%     the running. The running information will be output.
%
%     The procedure of running a test case is described as follows:
%     For each testing function
%       # if startfun is specified, run the startfun and use its outputs
%         as the test function's input
%       # run the testing function (under monitoring)
%       # the testing function may call the assertion functions, like
%         tassert, tassert_eq, tassert_exc, tassert_class, etc to check
%         some conditions.
%       # if the assertion checking result will be recorded in the monitor.
%       # Generally, the whole testing function will be executed no matter
%         whether the assertion checking succeeded or failed (this will be
%         recorded, but does not affect the execution)
%       # In the following cases, the execution of the remaining part of the
%         testing function will be stoped
%           - a fatal assertion failure occurred
%           - an unexpected exception occurred 
%         These cases will only stop the execution of the current testing
%         function. The remaining functions in the test case will be run.
%
%   - info = run(tcase, logger) uses a logger to handle the testing events
%     which happen during testing.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

%% main

if nargin < 2
    logger = testlog();
end

info = struct('tag', 'case_info', ...
    'case_name', tcase.name, ...
    'tinfo', [], ...
    'tstats', []);

logger = on_tevent(logger, 'enter_case', tcase);

if ~isempty(tcase.testfuns)
    if iscell(tcase.testfuns)
        C = cellfun(@monitor_run_f, tcase.testfuns, 'UniformOutput', false);
        info.tinfo = vertcat(C{:});
    else
        info.tinfo = monitor_run_f(tcase.testfuns);
    end
        
    % do statistics
    nrecs = cellfun(@(tn) counttrue(arrayfun(@(s) strcmp(s.type, tn), info.tinfo)), ...
        {'pass', 'fail', 'fatal', 'exc'});
    if any(nrecs(2:end))
        ncases = [0 1];
    else
        ncases = [1 0];
    end
    info.tstats = struct('records', nrecs, 'cases', ncases);
    
end

logger = on_tevent(logger, 'exit_case', info);


%% Core monitoring function

function info = monitor_run_f(f)

% set new monitor
global DMTB_TESTS_TESTCASE_MONITOR;
DMTB_TESTS_TESTCASE_MONITOR = testmon();

try
    f();
catch
    e = lasterror();    
    
    % record the exception info to monitor
    if ~strstart(e.identifier, 'tests:tassert:') % the tassert info has been recorded
        einfo = make_exception_info(e);        
    
        DMTB_TESTS_TESTCASE_MONITOR = addrec( ...
            DMTB_TESTS_TESTCASE_MONITOR, 'exc', einfo);
    end
end

info = get_testinfo(DMTB_TESTS_TESTCASE_MONITOR);

% close monitor
DMTB_TESTS_TESTCASE_MONITOR = [];


%% Auxiliary function

function einfo = make_exception_info(e)

db = e.stack(1);

einfo = struct( ...
    'file', db.file, ...
    'fname', db.name, ...
    'line', db.line, ...
    'errmsg', e.message, ...
    'errid', e.identifier);

