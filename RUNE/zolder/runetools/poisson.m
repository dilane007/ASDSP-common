function n = poisson(navg)
% DESCRIPTION n = mrequest(navg)
% an aproximation of a poisson distribution
% TRY poisson(10),poisson(0:10),poisson(ones(2,2,2))

% by Magnus Almgren 000803

siz = size(navg);
navg = shiftdim(navg,-1); % free first dimension by shifting them to the right
veclength = round(max(100, 10*max(navg(:)))); 
n = sum(mplus(rand([veclength siz]),-navg/veclength) < 0,1); % make a realisation
n = shiftdim(n,1); % move back again
