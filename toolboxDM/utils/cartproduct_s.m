function P = cartproduct_s(fieldnames, varargin)
%CARTPRODUCT_S Computes the Cartesian products between cell arrays and
%makes a struct array to express the results
%
% [ Description ]
%   - P = cartproduct_s(fieldnames, C1, C2, ...)
%
% [ Arguments ]
%   - Ci:           the i-th set of elements
%   - fieldnames:   the fieldnames of the struct array
%   - P:            the cartesian product in form of struct array
%
% [ Description ]
%   - P = cartproduct_s(C1, C2, ...) computes the cartesian product of 
%     C1, C2, ..., which are in form of cell arrays. 
%
%     Suppose C1, C2, ... respectively has n1, n2, ... elements. Then
%     P is an n1 x n2 x ... struct array, such that
%        $ P(i1, i2, ...).(fieldnames{k}) = Ck{ik} $
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

C = cartproduct(varargin{:});
P = tuples2struct(C, 1:length(varargin), fieldnames);
