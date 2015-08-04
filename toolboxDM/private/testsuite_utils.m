function tsuite = testsuite_utils()
%TESTSUITE_UTILS Constructs the test suite for the utils module
%
% [ History ]
%   - Created by Dahua Lin, on Jun 30, 2007
%

%% Test suite

tsuite = testsuite('dmtoolbox::utils', {...
    testcase('alltrue', @tf_alltrue); ...
    testcase('anytrue', @tf_anytrue); ...
    testcase('counttrue', @tf_counttrue); ...
    testcase('countfalse', @tf_countfalse); ...
    testcase('countif', @tf_countif); ...
    testcase('arrselect', @tf_arrselect); ...
    testcase('cartproduct', @tf_cartproduct); ...
    testcase('cartproduct_s', @tf_cartproduct_s); ...
    testcase('combfun', @tf_combfun) });

%% Test cases

%% alltrue

function tf_alltrue()

tassert_eq(alltrue([]), true);
tassert_eq(alltrue(true), true);
tassert_eq(alltrue(false), false);

tassert_eq(alltrue(true(1, 3)), true);
tassert_eq(alltrue(false(1, 3)), false);
tassert_eq(alltrue(true(2, 3)), true);
tassert_eq(alltrue(false(2, 3)), false);

tassert_eq(alltrue(logical([1 0 0])), false);
tassert_eq(alltrue(logical([0 1 1])), false);
tassert_eq(alltrue(logical([1 0 1])), false);

tassert_eq(alltrue(logical([1 0 1; 0 1 0])), false);
tassert_eq(alltrue(logical([0 0 0; 1 1 1])), false);
tassert_eq(alltrue(logical([1 1 1; 0 0 0])), false);


%% anytrue

function tf_anytrue()

tassert_eq(anytrue([]), false);
tassert_eq(anytrue(true), true);
tassert_eq(anytrue(false), false);

tassert_eq(anytrue(true(1, 3)), true);
tassert_eq(anytrue(false(1, 3)), false);
tassert_eq(anytrue(true(2, 3)), true);
tassert_eq(anytrue(false(2, 3)), false);

tassert_eq(anytrue(logical([1 0 0])), true);
tassert_eq(anytrue(logical([0 1 1])), true);
tassert_eq(anytrue(logical([1 0 1])), true);

tassert_eq(anytrue(logical([1 0 1; 0 1 0])), true);
tassert_eq(anytrue(logical([0 0 0; 1 1 1])), true);
tassert_eq(anytrue(logical([1 1 1; 0 0 0])), true);


%% counttrue

function tf_counttrue()

tassert_eq(counttrue([]), 0);
tassert_eq(counttrue(true), 1);
tassert_eq(counttrue(false), 0);

tassert_eq(counttrue(true(1, 3)), 3);
tassert_eq(counttrue(false(1, 3)), 0);
tassert_eq(counttrue(true(2, 3)), 6);
tassert_eq(counttrue(false(2, 3)), 0);

tassert_eq(counttrue(logical([1 0 0])), 1);
tassert_eq(counttrue(logical([0 1 1])), 2);
tassert_eq(counttrue(logical([1 0 1])), 2);

tassert_eq(counttrue(logical([1 0 1; 0 1 0])), 3);
tassert_eq(counttrue(logical([0 0 0; 1 1 1])), 3);
tassert_eq(counttrue(logical([1 1 1; 0 0 0])), 3);


%% countfalse

function tf_countfalse()

tassert_eq(countfalse([]), 0);
tassert_eq(countfalse(true), 0);
tassert_eq(countfalse(false), 1);

tassert_eq(countfalse(true(1, 3)), 0);
tassert_eq(countfalse(false(1, 3)), 3);
tassert_eq(countfalse(true(2, 3)), 0);
tassert_eq(countfalse(false(2, 3)), 6);

tassert_eq(countfalse(logical([1 0 0])), 2);
tassert_eq(countfalse(logical([0 1 1])), 1);
tassert_eq(countfalse(logical([1 0 1])), 1);

tassert_eq(countfalse(logical([1 0 1; 0 1 0])), 3);
tassert_eq(countfalse(logical([0 0 0; 1 1 1])), 3);
tassert_eq(countfalse(logical([1 1 1; 0 0 0])), 3);


%% countif

function tf_countif()

fa1 = @(x) x > 0;
fa2 = @(x) x < 0;

A1 = [-3 0 1];
A2 = [3 1 0; 4 2 -3];
A3 = [1 2; 3 4; 5 6];

tassert_eq(count_if([], fa1), 0);
tassert_eq(count_if(A1, fa1), 1);
tassert_eq(count_if(A1, fa2), 1);
tassert_eq(count_if(A2, fa1), 4);
tassert_eq(count_if(A2, fa2), 1);
tassert_eq(count_if(A3, fa1), 6);
tassert_eq(count_if(A3, fa2), 0);

S = struct('a', {1, 2, 1}, 'b', {3, 4, 5});
tassert_eq(count_if(S, @(s) s.a == 1), 2);
tassert_eq(count_if(S, @(s) s.b > 3), 2);
tassert_eq(count_if(S, @(s) s.a < s.b), 3);
tassert_eq(count_if(S, @(s) s.a > s.b), 0);
tassert_eq(count_if(S, @(s) s.a + s.b > 5), 2);


%% arrselect

function tf_arrselect()

fa1 = @(x) x > 0;
fa2 = @(x) x < 0;

A1 = [-3 0 1];
A2 = [3 1 0; 4 2 -3];
A3 = [1 2; 3 4; 5 6];

tassert_eq(arrselect([], fa1), []);
tassert_eq(arrselect(A1, fa1), 1);
tassert_eq(arrselect(A1, fa2), -3);
tassert_eq(arrselect(A2, fa1), [3 4 1 2]');
tassert_eq(arrselect(A2, fa2), -3);
tassert_eq(arrselect(A3, fa1), [1 3 5 2 4 6]');
tassert_empty(arrselect(A3, fa2));

S = struct('a', {1, 2, 1}, 'b', {3, 4, 5});
tassert_eq(arrselect(S, @(s) s.a == 1), S([1 3]));
tassert_eq(arrselect(S, @(s) s.b > 3), S([2 3]));
tassert_eq(arrselect(S, @(s) s.a < s.b), S([1 2 3]));
tassert(isempty(arrselect(S, @(s) s.a > s.b)));
tassert_eq(arrselect(S, @(s) s.a + s.b > 5), S([2 3]));


%% cartproduct

function tf_cartproduct()

C0 = {};
C1 = {1, 2, 3};
C2 = {'a', 'b'};

R_1 = {{1}, {2}, {3}}';
R_2 = {{'a'}, {'b'}}';
R_1_2 = {{1, 'a'}, {1, 'b'}; {2, 'a'}, {2, 'b'}; {3, 'a'}, {3, 'b'}};
R_2_1 = {{'a', 1}, {'a', 2}, {'a', 3}; {'b', 1}, {'b', 2}, {'b', 3}};
R_2_1_2 = cat(3, ...
    {{'a', 1, 'a'}, {'a', 2, 'a'}, {'a', 3, 'a'}; {'b', 1, 'a'}, {'b', 2, 'a'}, {'b', 3, 'a'}}, ...
    {{'a', 1, 'b'}, {'a', 2, 'b'}, {'a', 3, 'b'}; {'b', 1, 'b'}, {'b', 2, 'b'}, {'b', 3, 'b'}});


tassert_empty(cartproduct(C0));
tassert_eq(cartproduct(C1), R_1);
tassert_eq(cartproduct(C2), R_2);
tassert_empty(cartproduct(C0, C1));
tassert_empty(cartproduct(C0, C2));
tassert_eq(cartproduct(C1, C2), R_1_2);
tassert_eq(cartproduct(C2, C1), R_2_1);
tassert_eq(cartproduct(C2, C1, C2), R_2_1_2);


%% cartproduct_s

function tf_cartproduct_s()

C0 = {};
C1 = {1, 2, 3};
C2 = {'a', 'b'};

fns = {'x', 'y', 'z'};

R_0 = struct([]);
R_1 = struct('x', C1');
R_2 = struct('x', C2');
R_0_1 = struct([]);
R_0_2 = struct([]);
R_1_2 = struct('x', {1 1; 2 2; 3 3}, 'y', {'a', 'b'; 'a', 'b'; 'a', 'b'});
R_2_1 = struct('x', {'a', 'a', 'a'; 'b', 'b', 'b'}, 'y', {1 2 3; 1 2 3});
R_2_1_2 = struct( ...
    'x', cat(3, {'a', 'a', 'a'; 'b', 'b', 'b'}, {'a', 'a', 'a'; 'b', 'b', 'b'}), ...
    'y', cat(3, {1, 2, 3; 1, 2, 3}, {1, 2, 3; 1, 2, 3}), ...
    'z', cat(3, {'a', 'a', 'a'; 'a', 'a', 'a'}, {'b', 'b', 'b'; 'b', 'b', 'b'}));

tassert_eq(cartproduct_s(fns(1), C0), R_0);
tassert_eq(cartproduct_s(fns(1), C1), R_1);
tassert_eq(cartproduct_s(fns(1), C2), R_2);
tassert_eq(cartproduct_s(fns(1:2), C0, C1), R_0_1);
tassert_eq(cartproduct_s(fns(1:2), C0, C2), R_0_2);
tassert_eq(cartproduct_s(fns(1:2), C1, C2), R_1_2);
tassert_eq(cartproduct_s(fns(1:2), C2, C1), R_2_1);
tassert_eq(cartproduct_s(fns(1:3), C2, C1, C2), R_2_1_2);


%% combfun

function tf_combfun()

C0 = {};
C1 = {1, 2, 3};
C2 = {'a', 'b'};
C3 = {1, 2, 3, 4, 5};

tassert_empty(combfun(@(x) x, false, C0));
tassert_empty(combfun(@(x) x, true, C0));
tassert_eq(combfun(@(x) x, false, C1), {1 2 3}');
tassert_eq(combfun(@(x) x, true, C1), [1 2 3]');

tassert_eq(combfun(@(x) x * 2, false, C1), {2, 4, 6}');
tassert_eq(combfun(@(x) [x, '+'], false, C2), {'a+', 'b+'}');
tassert_eq(combfun(@(x, y) [num2str(x), '+', y], false, C1, C2), ...
    {'1+a', '1+b'; '2+a', '2+b'; '3+a', '3+b'});
tassert_eq(combfun(@(x, y) [x, '-', num2str(y)], false, C2, C1), ...
    {'a-1', 'a-2', 'a-3'; 'b-1', 'b-2', 'b-3'});


S13a = [2 3 4 5 6; 3 4 5 6 7; 4 5 6 7 8];
P13a = [1 2 3 4 5; 2 4 6 8 10; 3 6 9 12 15];
S13c = num2cell(S13a);
P13c = num2cell(P13a);

tassert_eq(combfun(@(x, y) x+y, true, C1, C3), S13a);
tassert_eq(combfun(@(x, y) x+y, false, C1, C3), S13c);

[R1a, R2a] = combfun(@(x, y) deal(x+y, x*y), true, C1, C3);
tassert_eq(R1a, S13a);
tassert_eq(R2a, P13a);

[R1c, R2c] = combfun(@(x, y) deal(x+y, x*y), false, C1, C3);
tassert_eq(R1c, S13c);
tassert_eq(R2c, P13c);

