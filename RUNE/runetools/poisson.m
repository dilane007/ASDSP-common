function pr = poisson(n,lambda)
% DESCRIPTION pr = poisson(n,lambda)
%  poisson probabilty function 
%  the probability of x with lam.
%  Assume an callintensity lambda. The function does calculate
%  The probablity of n calls for a given second
% INPUTS
%  n --      Number of events
%  lambda -- Average number of events
%  Sizes on all inputs are expanded to fit each other
% OUTPUT
%  pr -- probability values. Size is as the combined size of all inputs.
% SEE ALSO
%  binomial
% TRY
%  plot(poisson(1:10,3),'*')

% by Magnus ALmgren 040202

% due to a bug in matlab when more than 2 dimensions of x
loggam = inline('reshape(gammaln(x),size(x))');

[x,lam] = adjsiza(n,lambda);

% Do the computaion in the log domain to keep within the
% doubble floating range
warning off
pr = exp(-lam +x.*log(lam) - loggam(x+1));
warning on

% Clean up
pr(lam==0) = 0;  
pr(isnan(lam) | isnan(x)) = NaN;

% $Id: poisson.m,v 1.1 2004/02/19 17:27:45 bogdant Exp $
