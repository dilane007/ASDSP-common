function tsuite = testsuite_maps()
%TESTSUITE_MAPS Constructs the test suite for the module maps
%
% [ History ]
%   - Created by Dahua Lin, on Jun 30, 2007
%

%% Test suite

tsuite = testsuite('dmtoolbox::maps', { ...
    testcase('scalarmap', @tf_scalarmap), ...
    testcase('stringmap', @tf_stringmap), ...
    testcase('stringmap_a', @tf_stringmap_a), ...
    testcase('pairs2map', @tf_pairs2map) ...
    });


%% Test cases

%% scalarmap

function tf_scalarmap()

tassert_eq(scalarmap(1, [], {}), []);

K = [1124, 1382, 1681];
V = {'C++', 'Java', 'MATLAB'};

tassert_eq(scalarmap(1124, K, V), 'C++');
tassert_eq(scalarmap(1382, K, V), 'Java');
tassert_eq(scalarmap(1681, K, V), 'MATLAB');

tassert_eq(scalarmap(1793, K, V), []);
tassert_eq(scalarmap(1793, K, V, 'none'), 'none');


%% stringmap

function tf_stringmap()

tassert_eq(stringmap('a', {}, {}), []);

tassert_eq(stringmap('ch', {'ch', 'en', 'jp'}, {'Chinese', 'English', 'Japanese'}), 'Chinese');
tassert_eq(stringmap('two', {'one', 'two', 'three'}, {1, 2, 3}), 2);
tassert_eq(stringmap('u', {'x', 'y', 'z'}, {1.2, 2.3, 3.4}), []);

tassert_eq(stringmap('u', {'x', 'y', 'z'}, {1.2, 2.3, 3.4}, 0), 0);

qf = @(x) stringmap(x, {'ch', 'en', 'jp'}, {'Chinese', 'English', 'Japanese'});

tassert_eq({qf('ch'), qf('en'), qf('jp'), qf('xyz')}, {'Chinese', 'English', 'Japanese', []});
tassert_eq( ...
    cellfun(qf, {'ch', 'ch', 'jp', 'en'}, 'UniformOutput', false), ...
    {'Chinese', 'Chinese', 'Japanese', 'English'} );


%% stringmap_a

function tf_stringmap_a()

tassert_eq(stringmap_a('a', {}, []), []);

K = {'one', 'two', 'three'};
V = 1:3;

tassert_eq(stringmap_a('one', K, V), 1);
tassert_eq(stringmap_a('two', K, V), 2);
tassert_eq(stringmap_a('three', K, V), 3);
tassert_eq(stringmap_a('four', K, V), []);
tassert_eq(stringmap_a('four', K, V, 0), 0);


%% pairs2map

function tf_pairs2map()

[K0, V0] = pairs2map({});
tassert_eq(K0, {});
tassert_eq(V0, {});

[K, V] = pairs2map({{'ch', 'Chinese'}, {'en', 'English'}, {'jp', 'Japanese'}});
tassert_eq(K, {'ch', 'en', 'jp'});
tassert_eq(V, {'Chinese', 'English', 'Japanese'});

[K, V] = pairs2map({{'x', 12}, {'y', 24}, {'z', 31}});
tassert_eq(K, {'x', 'y', 'z'});
tassert_eq(V, {12, 24, 31});

[K, V] = pairs2map({{'Chinese', 'ch'}, {'English', 'en'}, {'Japanese', 'jp'}}, 'reverse');
tassert_eq(K, {'ch', 'en', 'jp'});
tassert_eq(V, {'Chinese', 'English', 'Japanese'});






