function C = celremove(C, varargin)
%CELREMOVE Removes all the specified elements
%
% [ Syntax ]
%   - C = celremove(C, e)
%   - C = celremove(C, e1, e2, ...)
%
% [ Arguments ]
%   - C:            the cell array
%   - e:            the element to be removed
%
% [ Description ]
%   - C = celremove(C, e) removes all the elements that equal e.
%
%   - C = celremove(C, e1, e2, ...) removes all the elements that
%     equal either one of e1, e2, ...
%
% [ Examples ]
%   - Removes the element 'a' from a cell array
%     \{
%         celremove({'a', 'a', 'b', 'c', 'd', 'a'}, 'a')
%         => {'b', 'c', 'd'}
%     \}
%
%   - Removes the element 'a' and 'b'
%     \{
%         celremove({'a', 'b', 'c', 'b', 'd'}, 'a', 'b')
%         => {'c', 'd'}
%     \}
%
%   - Removes the element contained in the cell array C0
%     \{
%         celremove(C, C0{:})
%     \}
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%


n = numel(varargin);

% when the number of elements is small, hard-coded condition is more
% efficient than celinclude

if n == 1
    e = varargin{1};
    C(cellfun(@(x) isequal(x, e), C)) = [];
elseif n == 2
    e1 = varargin{1};
    e2 = varargin{2};
    C(cellfun(@(x) isequal(x, e1) || isequal(x, e2), C)) = [];
elseif n == 3
    e1 = varargin{1};
    e2 = varargin{2};
    e3 = varargin{3};
    C(cellfun(@(x) isequal(x, e1) || isequal(x, e2) || isequal(x, e3), C)) = [];
elseif n > 3
    s = varargin;
    C(cellfun(@(x) celinclude(s, x), C)) = [];
end

    
