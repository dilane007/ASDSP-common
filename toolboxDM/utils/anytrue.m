function b = anytrue(V)
%ANYTRUE Judges whether there exists an elements that is true
%
% [ Syntax ]
%   - b = anytrue(V)
%
% [ Arguments ]
%   - V:        the logical array to be tested
%   - b:        whether there are some values in V that are true
%
% [ Description ]
%   - b = anytrue(V) gets whether there are some values in the logical
%     array V that are true.
%
% [ Remarks ]
%   - Compared to the built-in any function. anytrue returns 
%     one logical scalar despite the size and dimensions of the 
%     array V. It is sometimes more convient to use anytrue to 
%     manipulate arrays with multiple dimensions or unknown number
%     of dimensions.
%
% [ History ]
%   - Created by Dahua Lin, on Jun 27, 2007
%

b = anytrue_cimp(V);