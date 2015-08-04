function tlog = testlog()
%TESTLOG Constructs a logger of testing
%
% [ Syntax ]
%   - tlog = testlog()
%
% [ Description ]
%   - tlog = testlog() constructs a logger which prints testing info
%     during testing.
%
% [ Remarks ]
%   - testlog is a class offering a simple implementation of test logger.
%     The user can implement its own logger class to finish customized
%     logging activities. 
%
%     In essence, a logger is an event handler that handles testing events.
%     A logger that can be used in testing should support the following
%     syntax:
%        $ logger = on_tevent(logger, eventtype, ...) $
%
%     In detail, the following events will be reported
%      \{:
%           - enter_suite:      enter a test suite
%             $ logger = on_tevent(logger, 'enter_suite', tsuite) $
%           - exit_suite:       exit a test suite
%             $ logger = on_tevent(logger, 'exit_suite', info) $
%             Here, the info is that returned by testsuite/run
%           - enter_case:       enter a test case
%             $ logger = on_tevent(logger, 'enter_case', tcase) $
%           - exit_case:        exit a test case
%             $ logger = on_tevent(logger, 'exit_case', info) $
%             Here, the info is that returned by testcase/run
%      \:}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

tlog = class(struct('fid', 1, 'indentlevel', 0), 'testlog');


