function [info, logger] = run(tsuite, logger)
%RUN Runs the test suite
%
% [ Syntax ]
%   - info = run(tsuite)
%   - info = run(tsuite, logger)
%
% [ Arguments ]
%   - tcase:        the test case to run
%   - logger:       the logger to handle testing events
%                   (if not specified, it uses the testlog() as default)
%   - info:         the struct of testing information
%                   It has three fields:
%                   \{:
%                       - tag:         'suite_info'
%                       - suite_name:  the name of the test suite
%                       - sub_info:    the cell array of the info of
%                                      the units
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
%   - info = run(tsuite) runs all test units of the test suite,
%     and returns the recorded information. It uses the default logger
%     to handle the testing events.
%
%   - info = run(tsuite, logger) runs all test units in the test suite,
%     and returns the recorded information, with a specified logger to
%     handle the testing events.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%

%% main

if nargin < 2
    logger = testlog();
end

info = struct('tag', 'suite_info', ...
    'suite_name', tsuite.name, ...
    'sub_info', [], ...
    'tstats', []);

logger = on_tevent(logger, 'enter_suite', tsuite);

if ~isempty(tsuite.units)
    nu = numel(tsuite.units);
    info.sub_info = cell(size(tsuite.units));
            
    for i = 1 : nu
        [info.sub_info{i}, logger] = run(tsuite.units{i}, logger);
    end
    
    % do statistics
    
    nrecs = cellfun(@(x) x.tstats.records, info.sub_info, 'UniformOutput', false);
    ncases = cellfun(@(x) x.tstats.cases, info.sub_info, 'UniformOutput', false);
    
    info.tstats = struct( ...
        'records', sum(vertcat(nrecs{:}), 1), ...
        'cases', sum(vertcat(ncases{:}), 1));
    
else
    info.sub_info = {};
end

logger = on_tevent(logger, 'exit_suite', info);