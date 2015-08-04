function tsuite = testsuite_strings()
%TESTSUITE_STRINGS Constructs the test suite for the strings module
%
% [ History ]
%   - Created by Dahua Lin, on Jun 30, 2007
%

%% Test suite

tsuite = testsuite('dmtoolbox::strings', { ...
    testcase('strstart', @tf_strstart), ...
    testcase('strend', @tf_strend), ...
    testcase('strindex', @tf_strindex), ...
    testcase('strjoin', @tf_strjoin), ...
    testcase('strranges', @tf_strranges), ...
    testcase('strrangesubs', @tf_strrangesubs), ...
    testcase('strscan', @tf_strscan), ...
    testcase('strscant', @tf_strscant), ...
    testcase('strsplit', @tf_strsplit), ...
    testcase('strformat', @tf_strformat), ...    
    testcase('strsubs', @tf_strsubs), ...
    testcase('strsubsfmt', @tf_strsubsfmt) ...
    });


%% Test cases


%% strstart

function tf_strstart()

s0 = 'abc-1234';

tassert_eq(strstart('', []), true);
tassert_eq(strstart('', ''), true);
tassert_eq(strstart('', 'abc'), false);

tassert_eq(strstart(s0, []), true);
tassert_eq(strstart(s0, ''), true);
tassert_eq(strstart(s0, 'a'), true);
tassert_eq(strstart(s0, 'abc'), true);
tassert_eq(strstart(s0, s0), true);

tassert_eq(strstart(s0, 'b'), false);
tassert_eq(strstart(s0, 'abc+'), false);
tassert_eq(strstart(s0, 'abc-12345'), false);
tassert_eq(strstart(s0, ' '), false);

tassert_eq(strstart('strstart', 'str'), true);
tassert_eq(strstart('abc', 'abcd'), false);
tassert_eq(strstart('--abcd', '-+'), false);
tassert_eq(strstart('abc', []), true);


%% strend

function tf_strend()

s0 = 'abc-1234';

tassert_eq(strend('', []), true);
tassert_eq(strend('', ''), true);
tassert_eq(strend('', 'abc'), false);

tassert_eq(strend(s0, []), true);
tassert_eq(strend(s0, ''), true);
tassert_eq(strend(s0, '4'), true);
tassert_eq(strend(s0, '1234'), true);
tassert_eq(strend(s0, s0), true);

tassert_eq(strend(s0, '5'), false);
tassert_eq(strend(s0, '+1234'), false);
tassert_eq(strend(s0, 'xabd-1234'), false);
tassert_eq(strend(s0, ' '), false);

tassert_eq(strend('abc.m', '.m'), true);
tassert_eq(strend('abc', 'xabc'), false);
tassert_eq(strend('abcd--', '-+'), false);
tassert_eq(strend('abc', []), true);


%% strindex

function tf_strindex()

strs1 = {'abc'};
strs2 = {'tiger', 'fish', 'cat'};

tassert_eq(strindex('', {}), []);
tassert_eq(strindex('abc', {}), []);

tassert_eq(strindex('', strs1), []);
tassert_eq(strindex('abc', strs1), 1);

tassert_eq(strindex('', strs2), []);
tassert_eq(strindex('abc', strs2), []);
tassert_eq(strindex('tiger', strs2), 1);
tassert_eq(strindex('fish', strs2), 2);
tassert_eq(strindex('cat', strs2), 3);

tassert_exc([], @() strindex('xyz', strs2, 'string not found'));
tassert_eq(strindex('xyz', strs2, @(s) 'none'), 'none');
tassert_eq(strindex('xyz', strs2, @(s) ['-', s]), '-xyz');


%% strjoin

function tf_strjoin()

strs1 = {'abc'};
strs2 = {'tiger', 'fish', 'cat'};
strs3 = {'you', '', 'me'};
strs4 = {'', '', ''};

tassert_eq(strjoin({}), '');
tassert_eq(strjoin({}, '-'), '');

tassert_eq(strjoin(strs1), 'abc');
tassert_eq(strjoin(strs1, '-'), 'abc');

tassert_eq(strjoin(strs2), 'tiger fish cat');
tassert_eq(strjoin(strs2, ''), 'tigerfishcat');
tassert_eq(strjoin(strs2, '-'), 'tiger-fish-cat');
tassert_eq(strjoin(strs2, ' '), 'tiger fish cat');
tassert_eq(strjoin(strs2, ', '), 'tiger, fish, cat');
tassert_eq(strjoin(strs2, ' and '), 'tiger and fish and cat');

tassert_eq(strjoin(strs3), 'you  me');
tassert_eq(strjoin(strs3, ''), 'youme');
tassert_eq(strjoin(strs3, '-'), 'you--me');
tassert_eq(strjoin(strs3, ' '), 'you  me');

tassert_eq(strjoin(strs4), '  ');
tassert_eq(strjoin(strs4, '-'), '--');
tassert_eq(strjoin(strs4, ' '), '  ');

tassert_eq(strjoin({'fish', 'tiger', 'cat'}), 'fish tiger cat');
tassert_eq(strjoin({'x', 'y', 'z'}, '+'), 'x+y+z');
tassert_eq(strjoin({'x', 'y', 'z'}, ' + '), 'x + y + z');
tassert_eq(strjoin({'you', 'he', 'I'}, ' and '), 'you and he and I');


%% strranges

function tf_strranges()

s0 = 'abc-1234';

tassert_exc([], @() strranges('', [1 1]));
tassert_exc([], @() strranges('', [1 2, 3 4]));
tassert_eq(strranges('', []), {});

tassert_eq(strranges(s0, [1 1]), {'a'});
tassert_eq(strranges(s0, [1 3]), {'abc'});
tassert_eq(strranges(s0, [5 8]), {'1234'});
tassert_eq(strranges(s0, [8 8]), {'4'});
tassert_eq(strranges(s0, [3 5]), {'c-1'});

tassert_eq(strranges(s0, [1 3, 5 8]), {'abc', '1234'});
tassert_eq(strranges(s0, [1 1, 8 8]), {'a', '4'});
tassert_eq(strranges(s0, [1 3, 5 8, 3 5]), {'abc', '1234', 'c-1'});
tassert_eq(strranges(s0, [2 3, 3 4, 4 6]), {'bc', 'c-', '-12'});
tassert_eq(strranges(s0, [1 3; 5 8; 3 5]'), {'abc', '1234', 'c-1'});

tassert_exc([], @() strranges(s0, [0 1]));
tassert_exc([], @() strranges(s0, [7 9]));
tassert_exc([], @() strranges(s0, [1 2, 3 4, 6 9]));

tassert_eq(strranges('Compute with MATLAB', [1 7, 9 12, 14 19]), {'Compute', 'with', 'MATLAB'});
tassert_eq(strranges('abc-xyz', [1 3; 5 7]'), {'abc', 'xyz'});
    

%% strrangesubs

function tf_strrangesubs()

s0 = 'abc-1234';

tassert_eq(strrangesubs(s0, [1 1], 'x'), 'xbc-1234');
tassert_eq(strrangesubs(s0, [1 1], 'xyz'), 'xyzbc-1234');
tassert_eq(strrangesubs(s0, [1 3], 'xyz'), 'xyz-1234');
tassert_eq(strrangesubs(s0, [1 3], 'good'), 'good-1234');
tassert_eq(strrangesubs(s0, [5 8], '5678'), 'abc-5678');
tassert_eq(strrangesubs(s0, [5 8], 'xyz'), 'abc-xyz');
tassert_eq(strrangesubs(s0, [8 8], '5'), 'abc-1235');
tassert_eq(strrangesubs(s0, [8 8], 'uv'), 'abc-123uv');
tassert_eq(strrangesubs(s0, [3 5], 'd-0'), 'abd-0234');
tassert_eq(strrangesubs(s0, [3 5], 'cd-01'), 'abcd-01234');

tassert_eq(strrangesubs(s0, [1 3, 5 8], {'abcd', '123'}), 'abcd-123');
tassert_eq(strrangesubs(s0, [1 1, 8 8], {'A', ''}), 'Abc-123');
tassert_eq(strrangesubs(s0, [1 1, 8 8], {'', '45'}), 'bc-12345');
tassert_eq(strrangesubs(s0, [1 3, 5 8], {'ABCD', '987'}), 'ABCD-987');
tassert_eq(strrangesubs(s0, [1 3, 5 8], {'', '12345'}), '-12345');
tassert_eq(strrangesubs(s0, [1 3, 5 8], {'XYZ', ''}), 'XYZ-');

tassert_eq(strrangesubs(s0, [3 2], 'cde'), 'abcdec-1234');
tassert_eq(strrangesubs(s0, [1 3, 4 3], {'ABC' 'DE'}), 'ABCDE-1234');
tassert_eq(strrangesubs(s0, [1 3, 4 3, 4 3], {'ABC' 'D', 'E'}), 'ABCDE-1234');
tassert_eq(strrangesubs(s0, [1 3, 4 3, 4 3], {'ABCD' 'E', 'FG'}), 'ABCDEFG-1234');
tassert_eq(strrangesubs(s0, [1 3, 4 3, 5 8], 'xyz'), 'xyzxyz-xyz');

tassert_eq( ...
    strrangesubs('He does his work with his hands', [1 2, 9 11, 23 25], {'She', 'her', 'her'}), ...
    'She does her work with her hands');

tassert_eq( ...
    strrangesubs('He does his work with his hands', [1 2, 9 11, 23 25], 'her'), ...
    'her does her work with her hands');


%% strscan

function tf_strscan()

tassert_eq(strscan('', '\w+'), {});

tassert_eq( ...
    strscan('I am writing code in MATLAB', '\w+'), ...
    {'I'  'am'  'writing'  'code'  'in'  'MATLAB'});

tassert_eq( ...
    strscan('34 + 52 = 86', '\d+'), ...
    {'34'  '52'  '86'});


%% strscant

function tf_strscant()

tassert_eq(strscant('abc', '\d+'), {});
tassert_eq(strscant('abc', '\d+', @(x) x), {});
tassert_eq(strscant('abc', '\d+', @(x) x, 'cell'), {});
tassert_eq(strscant('abc', '\d+', @(x) x, 'struct'), {});

tassert_eq( ...
    strscant('(1,2), (3, 4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)'), ...
    {{'1'  '2'}, {'3'  '4'}});

tassert_eq( ...
    strscant('(1,2), (3, 4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)', @(x, y) [x ' + ' y]), ...
    {'1 + 2', '3 + 4'});

tassert_eq( ...
    strscant('(1,2), (3, 4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)', @(x, y) eval([x '+' y])), ...
    {3, 7});

tassert_eq( ...
    strscant('(1,2), (3,4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)', ...
        @(x, y) [x ' + ' y ' = ' num2str(eval([x '+' y]))]), ...
    {'1 + 2 = 3',  '3 + 4 = 7'});

tassert_eq( ...
    strscant('(1,2,3) (a,b,c)', '\((\w+),(\w+),(\w+)\)', ...
        @(c) [c{1}, '+', c{2}, '+', c{3}], 'cell'), ...
    {'1+2+3', 'a+b+c'});

tassert_eq( ...
    strscant('space.name class.method', '(?<parent>\w+)\.(?<child>\w+)', ...
        @(s) [s.parent, '::', s.child], 'struct'), ...
    {'space::name', 'class::method'});


%% strsplit

function tf_strsplit()

s1 = 'abc-uvxyz 1234-567 ijk';

tassert_eq(strsplit('', '-'), {});

tassert_exc([], @() strsplit(s1, ''));
tassert_eq(strsplit(s1, '\s+'), {'abc-uvxyz', '1234-567', 'ijk'});
tassert_eq(strsplit(s1, '-'), {'abc', 'uvxyz 1234', '567 ijk'});
tassert_eq(strsplit(s1, '[\-\s]+'), {'abc', 'uvxyz', '1234', '567', 'ijk'});
tassert_eq(strsplit(s1, '\:'), {s1});

tassert_eq(strsplit('tiger fish cat'), {'tiger', 'fish', 'cat'});
tassert_eq(strsplit('tiger,fish,cat', ','), {'tiger', 'fish', 'cat'});
tassert_eq(strsplit('tiger, fish , cat', ','), {'tiger', ' fish ', ' cat'});
tassert_eq(strsplit('tiger, fish , cat', '\s*,\s*'), {'tiger', 'fish', 'cat'});


%% strformat

function tf_strformat()

tassert_eq( ...
    strformat('#{1:%s}, #{2:%d}, #{3:%g}, and #{4:%x}', 'abc', 13, 4.56, 123), ...
    'abc, 13, 4.56, and 7b');

tassert_eq( ...
    strformat('#{1:%-5.2f}, #{1:%+5.2f}, #{1:%05.2f}, #{2:%6s}, #{2:%-6s}', 1.23, 'abcd'), ...
    '1.23 , +1.23, 01.23,   abcd, abcd  ');

tassert_eq( ...
    strformat('#{1:%s} of version #{2:%g} is good.', 'MATLAB', 7.4), ...
    'MATLAB of version 7.4 is good.');

tassert_eq( ...
    strformat('#{1:%.1f}, #{1:%.2f}, #{1:%.3f}.', pi), ...
    '3.1, 3.14, 3.142.');

tassert_eq( ...
    strformat('#{1:%s} of version #{2:%g}', {'MATLAB', 7.4}), ...
    'MATLAB of version 7.4');


tassert_eq( ...
    cellfun(@(c) strformat('#{1:%s} [v #{2:%g}]', c), ...
        {{'MATLAB', 7.4}, {'Java', 1.6}, {'C#', 2.0}}, 'UniformOutput', false), ...
    {'MATLAB [v 7.4]', 'Java [v 1.6]', 'C# [v 2]'});

tassert_eq( ...
    cellfun(@(fmt) strformat(fmt, {'MATLAB', 7.4}), ...
        {'#{1:%s} of version #{2:%g}', '#{1:%s} #{2:%g}', '#{1:%s} (v#{2:%g})'}, ...
        'UniformOutput', false), ...
    {'MATLAB of version 7.4', 'MATLAB 7.4', 'MATLAB (v7.4)'});

tassert_eq( ...
    strformat('#{name:%s} of version #{ver:%g}', struct('name', 'MATLAB', 'ver', 7.4)), ...
    'MATLAB of version 7.4');


%% strsubs

function tf_strsubs()

tassert_eq( ...
    strsubs('It is a good thing. He is a good man', 'good', 'fixstr', 'great'), ...
    'It is a great thing. He is a great man');

tassert_eq( ...
    strsubs('MATLAB plays an important role', '\w+', 'conv', @(x) [upper(x(1)), x(2:end)], 'str'), ...
    'MATLAB Plays An Important Role');

tassert_eq( ...
    strsubs('Look at (1, 2) and (3, 4)', '\(\s*(\d+)\s*,\s*(\d+)\s*\)', ...
        'conv', @(x, y) [x, '+', y, '=', num2str(str2double(x) + str2double(y))], 'tokens'), ...
    'Look at 1+2=3 and 3+4=7');

tassert_eq( ...
    strsubs('for i = 1 : n', 'for\s+(?<var>\w+)\s*=\s*(?<init>\w+)\s*\:\s*(?<last>\w+)', ...            
        'conv', @(x) sprintf('for(int %s = %s; %s <= %s; ++%s)', ...
        x.var, x.init, x.var, x.last, x.var), 'tkstruct'), ...
    'for(int i = 1; i <= n; ++i)');

tassert_eq( ...
    strsubs('My IP is 123.456.789.012', '(\d+).(\d+).(\d+).(\d+)', 't-str', 'xxx'), ...
    'My IP is xxx.xxx.xxx.xxx');

tassert_eq( ...
    strsubs('start abc completed  start xyz completed', '(start)\s*\w+\s*(completed)', ...
        't-str', {'begin', 'end'}), ...
    'begin abc end  begin xyz end');

tassert_eq( ...
    strsubs('Here are 1+2 and 4+5', '(\d+)\+(\d+)', 't-conv', @(x) ['a', x]), ...
    'Here are a1+a2 and a4+a5');

tassert_eq( ...
    strsubs('abc.name1, xyz.field2', '(\w+)\.(\w+)', 't-conv', {@(x)['[', x, ']'], @(x)['(', x, ')']}), ...
    '[abc].(name1), [xyz].(field2)');


%% strsubsfmt

function tf_strsubsfmt()

tassert_eq( ...
    strsubsfmt('I use MATLAB 7.4 and Java 1.6', '(\w+)\s+(\d+\.\d+)', '#{1:%s} of version #{2:%s}'), ...
    'I use MATLAB of version 7.4 and Java of version 1.6');

tassert_eq( ...
    strsubsfmt('I use MATLAB 7.4 and Java 1.6', '(?<name>\w+)\s+(?<ver>\d+\.\d+)', ...
               '#{name:%s} of version #{ver:%s}', 'named'), ...
    'I use MATLAB of version 7.4 and Java of version 1.6');

