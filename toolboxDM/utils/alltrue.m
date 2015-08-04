function b = alltrue(V)
%ALLTRUE Judges whether all elements are true
%
% [ Syntax ]
%   - b = alltrue(V)
%
% [ Arguments ]
%   - V:        the logical array to be tested
%   - b:        whether all values in V are true
%
% [ Description ]
%   - b = alltrue(V) gets whether all values in the logical
%     array V are true.
%
% [ Remarks ]
%   - Compared to the built-in all function. alltrue returns 
%     one logical scalar despite the size and dimensions of the 
%     array V. It is sometimes more convient to use alltrue to 
%     manipulate arrays with multiple dimensions or unknown number
%     of dimensions.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

b = alltrue_cimp(V);
