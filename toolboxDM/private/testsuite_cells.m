function tsuite = testsuite_cells()
%TESTSUITE_CELLS Constructs the test suite for the cells module
%
% [ History ]
%   - Created by Dahua Lin, on Jun 30, 2007
%

%% Test Suite

tsuite = testsuite('dmtoolbox::cells', { ...
    testcase('celinclude', @tf_celinclude), ...
    testcase('celall', @tf_celall), ...
    testcase('celany', @tf_celany), ...
    testcase('celcount', @tf_celcount), ...
    testcase('celcount_if', @tf_celcount_if), ...
    testcase('celselect', @tf_celselect), ...
    testcase('celmerge', @tf_celmerge), ...
    testcase('celremove', @tf_celremove), ...
    testcase('celremove_if', @tf_celremove_if), ...    
    testcase('celsplit', @tf_celsplit) ...
    });


%% Test Cases

%% celinclude

function tf_celinclude()

c = {'x', 1, [3 4 5], 'abc'};

tassert(~celinclude({}, []));
tassert(~celinclude({}, 1));

tassert(celinclude(c, 'x'));
tassert(celinclude(c, 1));    
tassert(celinclude(c, [3 4 5]));
tassert(celinclude(c, 'abc'));

tassert(~celinclude(c, []));
tassert(~celinclude(c, 3));
tassert(~celinclude(c, [3 4 6]));

tassert_eq(celinclude({1, 2, 3}, 1), true);
tassert_eq(celinclude({1, 2, 3}, 4), false);
tassert_eq(celinclude({1, 2, 3; 4, 5, 6}, 5), true);

tassert_eq(celinclude({[1 2], [3 4], [5 6]}, [3 4]), true);
tassert_eq(celinclude({[1 2], [3 4], [5 6]}, [1 3]), false);


%% celall

function tf_celall()

tassert(celall({}, @(x) true));
tassert(celall({}, @(x) false));

tassert_eq(celall({'abcd', 'matlab', 'tiger'}, @(x) length(x) > 3), true);
tassert_eq(celall({'abcd', 'mat', 'tiger'}, @(x) length(x) > 3), false);


%% celany

function tf_celany()

tassert(~celany({}, @(x) true));
tassert(~celany({}, @(x) false));

tassert_eq(celany({'ab', 'm', 'tig'}, @(x) length(x) > 3), false);
tassert_eq(celany({'ab', 'mat', 'tiger'}, @(x) length(x) > 3), true);


%% celcount

function tf_celcount()

tassert_eq(celcount({}, 1), 0);
tassert_eq(celcount({}, []), 0);

tassert_eq(celcount({1, 2, 2, 3, 5}, 1), 1);
tassert_eq(celcount({1, 2, 2, 3, 5}, 2), 2);
tassert_eq(celcount({1, 2, 2, 3, 5}, 3), 1);
tassert_eq(celcount({1, 2, 2, 3, 5}, 5), 1);
tassert_eq(celcount({1, 2, 2, 3, 5}, 6), 0);

tassert_eq(celcount({'a', 'b', 'x', 'a', 'a'}, 'a'), 3);
tassert_eq(celcount({'a', 'b', 'x', 'a', 'a'}, 'b'), 1);
tassert_eq(celcount({'a', 'b', 'x', 'a', 'a'}, 'x'), 1);
tassert_eq(celcount({'a', 'b', 'x', 'a', 'a'}, 'm'), 0);
tassert_eq(celcount({'a', 'b', 'x', 'a', 'a'}, ''), 0);
tassert_eq(celcount({'a', 'b', 'x', 'a', 'a'}, 1), 0);

%% celcount_if

function tf_celcount_if()

tassert_eq(celcount_if({}, @(x) true), 0); 
tassert_eq(celcount_if({}, @(x) false), 0);

tassert_eq(celcount_if({'a', 'matlab', 'b', 'c1'}, @(x) length(x) < 3), 3);
tassert_eq(celcount_if({'a', 'matlab', 'b', 'c1'}, @(x) length(x) > 10), 0);
tassert_eq(celcount_if({'a', 'matlab', 'b', 'c1'}, @(x) ~isempty(x)), 4);


%% celselect

function tf_celselect()

tassert_eq(celselect({}, @(x) true), {});
tassert_eq(celselect({}, @(x) false), {});

C1 = {'a', 'matlab', 'is', 'abcd', 'sample'};
tassert_eq(celselect(C1, @(x) length(x) > 3), {'matlab', 'abcd', 'sample'});
tassert_eq(celselect(C1, @(x) ~isempty(x)), C1);
tassert_empty(celselect(C1, @(x) isempty(x)));

C2 = {'a', 1, 2, {3, 5}, [4 7], 'xy'};
tassert_eq(celselect(C2, @isnumeric), {1, 2, [4 7]});


%% celmerge

function tf_celmerge()

tassert_eq(celmerge({}), {});
tassert_eq(celmerge({}, {}), {});
tassert_eq(celmerge({[]}), {{[]}});
tassert_eq(celmerge({[]}, {[]}), {{[], []}});

C1 = {'xyz', 'abc', 'uv'};
C2 = {3, 6, 8};
C3 = {[1 2], [3 4], [8 7]};

tassert_eq(celmerge(C1, C2, C3), ...
    {{'xyz', 3, [1 2]}, {'abc', 6, [3 4]}, {'uv', 8, [8 7]}});


%% celremove

function tf_celremove()

tassert_eq(celremove({}, []), {});
tassert_eq(celremove({}, 1), {});
tassert_eq(celremove({}, 1, 2), {});

tassert_eq(celremove({1, 2, 3}, 4), {1, 2, 3});

tassert_eq(celremove({'a', 'a', 'b', 'c', 'd', 'a'}, 'a'), {'b', 'c', 'd'});
tassert_eq(celremove({'a', 'a', 'b', 'c', 'd', 'a'}, 'b'), {'a', 'a', 'c', 'd', 'a'});
tassert_eq(celremove({'a', 'a', 'b', 'c', 'd', 'a'}, 'c'), {'a', 'a', 'b', 'd', 'a'});
tassert_eq(celremove({'a', 'a', 'b', 'c', 'd', 'a'}, 'd'), {'a', 'a', 'b', 'c', 'a'});
tassert_eq(celremove({'a', 'a', 'b', 'c', 'd', 'a'}, 'a', 'b'), {'c', 'd'});

tassert_eq(celremove({'a', 'b', 'c', 'b', 'd'}, 'a', 'b'), {'c', 'd'});


%% celremove_if

function tf_celremove_if()

tassert_eq(celremove({}, @(x) true), {});
tassert_eq(celremove({}, @(x) false), {});

tassert_eq(celremove_if({-1 -2, 1, 0, 2, 3}, @(x) x < 0), {1, 0, 2, 3});
tassert_eq(celremove_if({-1 -2, 1, 0, 2, 3}, @(x) x > 0), {-1, -2, 0});
tassert_eq(celremove_if({-1 -2, 1, 0, 2, 3}, @(x) x > 3), {-1, -2, 1, 0, 2, 3});
tassert_empty(celremove_if({-1 -2, 1, 0, 2, 3}, @(x) x < 10));

tassert_eq(celremove_if({'abcd', 'a', 'matlab', 'b'}, @(x) length(x) < 3), ...
    {'abcd', 'matlab'});

%% celsplit

function tf_celsplit()

tassert_eq(celsplit({}, 1), {});

tuples = {{'a', 1, 0.2}, {'xy', 3, 4.7}, {'uv', 8, 3.1}};
[C1, C2, C3] = celsplit(tuples, 1:3);
tassert_eq(C1, {'a', 'xy', 'uv'});
tassert_eq(C2, {1, 3, 8});
tassert_eq(C3, {0.2, 4.7, 3.1});

[A, B, C] = celsplit(tuples, [1 2 1]);
tassert_eq(A, {'a', 'xy', 'uv'});
tassert_eq(B, {1, 3, 8});
tassert_eq(C, {'a', 'xy', 'uv'});


