function res = percentile(a, proc)
% DESCRIPTION res = percentile(a, proc)
%  Calculates cdf values columnwise 
%  for all a values and for each percentvalue.
%  Example cdfperc(randn(1000,1), [10 90]) yields ~ [-1.27 1.28]'
% INPUT 
%  a --     A matrix with observations along each column
%  proc --  Percent values for which percentiles are calculate.
% OUTPUT
%  res --   One percentile value for each 
%           element of proc and for each column of a.
% TRY
%  percentile(rand(1000,1),25), percentile(randn(1000,2),[25; 50; 75])
% SEE ALSO
%  cdfplotlow

% by Magnus Almgren 000530

sa = size(a,1);
if sa < 1
 res = [];
else
 b = sort(a, 1);
 res = b(max(1, min(sa, round(proc/100*sa))),:);
end
