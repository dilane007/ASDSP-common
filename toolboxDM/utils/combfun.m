function varargout = combfun(f, uout, varargin)
%COMBFUN Applies a function to all combinations of parameters
%
% [ Syntax ]
%   - [R1, R2, ...] = combfun(f, uout, C1, C2, ...)
%
% [ Arguments ]
%   - f:        the function handle to apply
%   - uout:     whether the output is uniform and can be grouped
%               without cell array. 
%               This is equivalent to the UniformOutput parameter
%               in arrayfun.
%   - Ci:       the i-th set of parameters (in cell array)
%   - Ri:       the results
%
% [ Description ]
%   - [R1, R2, ...] = combfun(f, uout, C1, C2, ...) extracts all 
%     combinations of parameters from C1, C2, ... respectively and 
%     applies f to them.
%
%     Suppose C1, C2, ... respectively have n1, n2, ... elements. Then,
%     If uout is true, Rp will be an array of size n1 x n2 x ...
%     such that Rp(i1, i2, ...) = the p-th output of f(C1{i1}, C2{i2}, ...)
%     If uout is false, Rp will be a cell array of size n1 x n2 x ...
%     such that Rp{i1, i2, ...} = the p-th output of f(C1{i1}, C2{i2}, ...)
%     
% [ Remarks ]
%   - The number of outputs R1, R2, ... should be equal to the number of
%     outputs produced by each invoking of f. The number of parameter sets
%     C1, C2, ... should be equal to the number of input arguments to f.
%
%   - This function offers a convenient way to run experiments in multiple
%     settings without explicitly writing out all combinations.
%
% [ Examples ]
%   - Apply functions to combination of parameters
%     \{
%         combfun(@(x, y) [x, ' + ', num2str(y)], false, 
%                 {'a', 'b'}, {1, 2, 3})
%         => { 'a + 1', 'a + 2', 'a + 3'; 
%              'b + 1', 'b + 2', 'b + 3' }
%
%         combfun(@(x, y) x + y, true, {10, 20, 30}, {2, 5})
%         => [ 12  15
%              22  25
%              32  35 ]           
%     \}
%
%   - Apply multi-output function to compute addition table and
%     multiplication table:
%     \{
%         [A, M] = combfun(@(x, y) deal(x+y, x*y), true,
%                          {1, 2, 3}, {1, 2, 3, 4, 5})
%
%         A <= [ 2 3 4 5 6
%                3 4 5 6 7
%                4 5 6 7 8 ]
%
%         M <= [ 1  2  3  4  5
%                2  4  6  8 10
%                3  6  9 12 15 ]
%     \}
%
%   - Run a function in all combinations of parameter settings
%     and collect the results
%     \{
%         results = combfun(f, false, params1, params2, ...);
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

%% parse and verify input arguments

error(nargchk(3, inf, nargin));
P = varargin;
np = length(P);
cellfun(@(c) typecheck(c, 'the parameter set must be a cell array', 'cell'), P);

%% main

% generate index-grid
ind_axes = cellfun(@(c) 1:numel(c), P, 'UniformOutput', false);
if np == 1
    Inds{1} = ndgrid(ind_axes{1}, 1);
else
    [Inds{1:np}] = ndgrid(ind_axes{:});
end

% apply function
fi = @(varargin) with_pind(f, P, varargin{:});
[varargout{1:nargout}] = arrayfun(fi, Inds{:}, 'UniformOutput', uout);

function varargout = with_pind(f, P, varargin)

ps = cellfun(@(c, i) c{i}, P, varargin, 'UniformOutput', false);
[varargout{1:nargout}] = f(ps{:});





