% FILTER - Implements a 1-D Digital Filter
%
% USAGE
%
% y = filter(b,a,X) filters the data in vector X with the filter described by 
% numerator coefficient vector b and denominator coefficient vector a. If a(1)
% is not equal to 1, filter normalizes the filter coefficients by a(1). If a(1)
% equals 0, filter returns an error.
%
% This is a subset of the functionality of the MATLAB filter.  It only handles
% X as a vector.
%
% Date: 6/11/2014 
% Version: v1.0
% Licensed under the GPL
% Copyright (C) 2014 Jonathan Weaver <jonw0224@aim.com>

function y = filter(b,a,X)

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

	y = conv(b,x);
    y = y(1:length(x));
    ap = [0 -1*a(2:end)];
    a1 = a(1);
    if a1 == 0 
        error('a(1) must be nonzero');
    end
    ya = y;
    for n = 1:(length(x))
        ya = conv(ya,ap);
        ya = ya(1:length(x));
        y = ya + y;
    end
    y = y ./ a1;
    
end