function tsuite = testsuite_structs()
%TESTSUITE_STRUCTS Constructs the test suite for structs module
%
% [ History ]
%   - Created by Dahua Lin, on Jun 30, 2007
%

%% Test Suite

tsuite = testsuite('dmtoolbox::structs', {...
    testcase('setopts', {@tf_setopts_f1, @tf_setopts_f2, @tf_setopts_f3}), ...
    testcase('celosf', @tf_celosf), ...
    testcase('dealfields', @tf_dealfields), ...
    testcase('fields2cell', @tf_fields2cell), ...
    testcase('fields2mat', @tf_fields2mat), ...   
    testcase('struct2tuples', @tf_struct2tuples), ...
    testcase('tuples2struct', @tf_tuples2struct), ...
    testcase('sortstructs', {@tf_sortstructs_f1, @tf_sortstructs_f2}) ...    
    });

%% Test cases

%% setopts

function tf_setopts_f1()

opts = setopts([], 'timeout', 30, 'method', 'auto', 'acts', {'open', 'edit', 'close'});

tassert(isscalar(opts) && isstruct(opts));
tassert_eq(fieldnames(opts), {'timeout', 'method', 'acts'}');

tassert_eq({opts.timeout, opts.method, opts.acts}, {30, 'auto', {'open', 'edit', 'close'}});

opts = setopts(opts, 'timeout', 50, 'acts', {'open', 'edit', 'submit', 'close'}, 'info', 'something');

tassert(isscalar(opts) && isstruct(opts));
tassert_eq(fieldnames(opts), {'timeout', 'method', 'acts', 'info'}');

tassert_eq({opts.timeout, opts.method, opts.acts, opts.info}, ...
           {50, 'auto', {'open', 'edit', 'submit', 'close'}, 'something'});
       
function tf_setopts_f2()

p1 = {'timeout', 30, 'method', 'auto'};
p2 = {'info', [1 2], 'timeout', 50};
p3 = {'keys', {'a', 'b'}, 'info', [10 20]};

opts = setopts([], [p1, p2, p3]);

tassert(isscalar(opts) && isstruct(opts));
tassert_eq(fieldnames(opts), {'timeout', 'method', 'info', 'keys'}');

tassert_eq({opts.timeout, opts.method, opts.info, opts.keys}, ...
    {50, 'auto', [10, 20], {'a', 'b'}});

function tf_setopts_f3()

s0 = struct('handle', 1, 'width', 10, 'height', 20);
su = struct('width', 15, 'height', 25);
s1 = setopts(s0, su);

tassert(isscalar(s1) && isstruct(s1));
tassert_eq(fieldnames(s1), {'handle', 'width', 'height'}');

tassert_eq({s1.handle, s1.width, s1.height}, {1, 15, 25});


%% celosf

function tf_celosf()

tassert_eq(celosf([], 'a'), {});

S = struct('a', {1, 2, 3; 4, 5, 6}, 'b', {'a', 'b', 'c'; 'x', 'y', 'z'});

tassert_eq(celosf(S, 'a'), {1 2 3; 4 5 6});
tassert_eq(celosf(S, 'b'), {'a', 'b', 'c'; 'x', 'y', 'z'});


%% dealfields

function tf_dealfields()

C0 = dealfields([], 'a');
tassert_eq(C0, []);

[C1, C2] = dealfields([], 'a', 'b');
tassert_eq({C1, C2}, {[], []});

S = struct('name', {'x', 'y', 'z'; 'a', 'b', 'c'}, ...
           'v1', {1, 2, 3; 4, 5, 6}, ...
           'v2', {2.4, 1.8, 3.6; 5.2, 6.1, 7.3} );
[Cn, Cv1] = dealfields(S, 'name', 'v1');            

tassert_eq(Cn, {'x', 'y', 'z'; 'a', 'b', 'c'});
tassert_eq(Cv1, {1, 2, 3; 4, 5, 6});


%% fields2cell

function tf_fields2cell()

s = struct('name', 'abc', 'id', 1, 'value', 'xyz');

tassert_exc([], @() fields2cell([]));
tassert_eq(fields2cell(s), {'abc'; 1; 'xyz'});
tassert_eq(fields2cell(s, {'name'}), {'abc'});
tassert_eq(fields2cell(s, {'id', 'name'}), {1, 'abc'});
tassert_eq(fields2cell(s, {'name', 'value', 'value'}), {'abc', 'xyz', 'xyz'});
tassert_eq(fields2cell(s, {}), {});


%% fields2mat

function tf_fields2mat()

tassert_eq(fields2mat([], 'a'), []);

S = struct('name', {'x', 'y', 'z'; 'a', 'b', 'c'}, ...
           'v1', {1, 2, 3; 4, 5, 6}, ...
           'v2', {2.4, 1.8, 3.6; 5.2, 6.1, 7.3});
       
tassert_eq(fields2mat(S, 'v1'), [1 2 3; 4 5 6]);

[V2, V1] = fields2mat(S, 'v2', 'v1');
tassert_eq(V1, [1 2 3; 4 5 6]);
tassert_eq(V2, [2.4 1.8 3.6; 5.2 6.1 7.3]);


%% struct2tuples

function tf_struct2tuples()

tassert_eq(struct2tuples([]), {});

S = struct('a', {1, 2, 3}, 'b', {'x', 'y', 'z'});

tassert_eq(struct2tuples(S), {{1; 'x'}, {2; 'y'}, {3; 'z'}});
tassert_eq(struct2tuples(S, {'a'}), {{1}, {2}, {3}});
tassert_eq(struct2tuples(S, {'b', 'a'}), {{'x', 1}, {'y', 2}, {'z', 3}});
tassert_eq(struct2tuples(S, {'a', 'b'; 'b', 'a'}), ...
    {{1, 'x'; 'x', 1}, {2, 'y'; 'y', 2}, {3, 'z'; 'z', 3}});

%% tuples2struct

function tf_tuples2struct()

tassert_eq(tuples2struct({}, 1, {'a', 'b'}), struct([]));

s = tuples2struct({{1, 10}, {2, 'x'}, {3, [30, 1]}}, [1, 2], {'a', 'b'});
tassert_eq(s, struct('a', {1, 2, 3}, 'b', {10, 'x', [30 1]}));


%% sort_structs

function tf_sortstructs_f1()

S = struct('a', {3, 5, 1}, 'b', {'z3', 'z1', 'a'});

tassert_eq( ...
    sortstructs(S, 'a', 'numeric'), ...
    struct('a', {1, 3, 5}, 'b', {'a', 'z3', 'z1'}) );

tassert_eq( ...
    sortstructs(S, 'a', 'numeric', 'descend'), ...
    struct('a', {5, 3, 1}, 'b', {'z1', 'z3', 'a'}) );

tassert_eq( ...
    sortstructs(S, 'b', 'string', 'ascend'), ...
    struct('a', {1, 5, 3}, 'b', {'a', 'z1', 'z3'}) );

tassert_eq( ...
    sortstructs(S, 'b', 'string', 'descend'), ...
    struct('a', {3, 5, 1}, 'b', {'z3', 'z1', 'a'}) );

function tf_sortstructs_f2()

S = struct('a', {2, 3, 5}, 'b', {4, 1, 2});
[T, V] = sortstructs(S, @(s) s.a + s.b, 'numeric');

tassert_eq(T, struct('a', {3, 2, 5}, 'b', {1, 4, 2}));
tassert_eq(V, [4 6 7]);
    

