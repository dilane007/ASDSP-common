% FINDPEAKS - Finds local maxima
%
% USAGE
%
% pks = findpeaks(data) returns local maxima or peaks, pks, in the input data. 
% data requires a row or column vector with real-valued elements with a 
% minimum length of three. findpeaks compares each element of data to its 
% neighboring values. If an element of data is larger than both of its 
% neighbors or equals Inf, the element is a local peak. If there are no local 
% maxima, pks is an empty vector.
%
% [pks,locs] = findpeaks(data) returns the indices of the local peaks.
%
% This is a subset of the functionality of the MATLAB findpeaks function.
%
% Date: 6/11/2014 
% Version: v1.0
% Licensed under the GPL
% Copyright (C) 2014 Jonathan Weaver <jonw0224@aim.com>

function [pks, loc] = findpeaks(data)

% This file is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

	n = 2:(length(data)-1);
	r = [0 (data(n) > data(n+1) && data(n) > data(n-1)) 0];
	loc = find(r);
	pks = data(loc);
end