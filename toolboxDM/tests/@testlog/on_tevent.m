function logger = on_tevent(logger, eventtype, param)
%ON_TEVENT Handles the testing event
%
% [ Syntax ]
%   - on_tevent(logger, eventtype, ...)
%
% [ History ]
%   - Created by Dahua Lin, on Jun 29, 2007
%


%% Event dispatch

switch eventtype
    case 'enter_case'
        logger = on_enter_case(logger, param);
    case 'exit_case'
        logger = on_exit_case(logger, param);
    case 'enter_suite'
        logger = on_enter_suite(logger, param);
    case 'exit_suite'
        logger = on_exit_suite(logger, param);
end


%% Handling functions

function L = on_enter_case(L, tcase)

print(L, 'Case %s', getname(tcase));
L = indent(L, 1);


function L = on_exit_case(L, info)

print_case_info(L, info);
L = indent(L, -1);


function L = on_enter_suite(L, tsuite)

print(L, 'Suite %s start.', getname(tsuite));
L = indent(L, 1);


function L = on_exit_suite(L, info)

L = indent(L, -1);
print(L, 'Suite %s end.', info.suite_name);

print_suite_info(L, info);
print(L, '');



%% Information Printing function

function print_case_info(L, info)

S = arrselect(info.tinfo, @(s) ~strcmp(s.type, 'pass'));
if ~isempty(S)
    L = indent(L, 1);
    arrayfun(@(s) print_entry(L, s), S);
    L = indent(L, -1);
end

ntys = info.tstats.records;
print(L, '%d pass, %d fail (%d fatal), %d exception', ...
    ntys(1), ntys(2)+ntys(3), ntys(3), ntys(4));


function print_entry(L, s)

[pathstr, name, ext] = fileparts(s.file);
filename = [name, ext];

if ~strcmp(s.type, 'exc')
    print(L, '%s ==> <a href="error:%s,%d,1">%s at %d</a>', ...
        s.type, s.file, s.line, filename, s.line);
else
    print(L, 'exception ==> <a href="error:%s,%d,1">%s at %d</a>:  %s', ...
        s.file, s.line, filename, s.line, s.errmsg);
end


function print_suite_info(L, info)

L = indent(L, 1);

a = info.tstats.records;
c = info.tstats.cases;

if c(2) == 0
    print(L, 'All cases passed. (Total %d records in %d cases)', ...
        sum(a), sum(c));
else
    print(L, '%d records in %d cases failed. (Total %d records in %d cases)', ...
        sum(a(2:end)), c(2), sum(a), sum(c));
end







