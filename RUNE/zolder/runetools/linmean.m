function y = linmean(varargin) % calculates the linear mean in the log domain 
% function y = linmean(x,dim)
% The same argument handling as in mean
% lin2db(mean(db2lin(x),dim)
% See also mean
% Try linmean([0 3]), linmean(zeros(2,2),2)

% by Magnus Almgren 011022
y = lin2db(mean(db2lin(varargin{1}),varargin{2:end}));
