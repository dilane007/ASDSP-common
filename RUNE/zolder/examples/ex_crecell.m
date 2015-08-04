function [xys, clv] = ex_crecell(km,lm)
% DESCRIPTION [xys, clv] = ex_crecell(km,lm)
%  Creates a cluster and draws two plots.
%  Figure no 1 shows one cluster, which
%  contains two rombs with the side km resp. lm
%  and a parallellogram with sides km and lm.
%  The number of sites inside the cluster is
%  km^2+lm^2+km*lm.
%  Figure no 2 illustrates how clusters can be fitted together.
% INPUT 
%  km --  See below.
%  lm --  Intergers setting the clustersize to km^2+lm^2+km*lm. 
% OUTPUT
% xys -- centerpoint of each cell
% clv -- displacement vectors used for wrap around 

%  A plot showing the principle of cluster construction.
% TRY 
%  ex_crecluster;
%  ex_crecluster(4,10);
% SEE ALSO 
%  crecluster, crecells

% by Magnus Almgren 010215

if nargin <2 % If input-argument <2, set km and lm to defaultvalues.
 km = 5;
 lm = 2;
end
[xys, clv] = crecluster(km,lm);
c = [zeros(1,km.^2)+0.2 zeros(1,lm.^2)+0.4 zeros(1,km*lm)+0.6];
figure(1)
plotdot(xys,0.52i,c,6)
title('A cluster with km^2+lm^2+km*lm sites.')

figure(2)
clm = mplus(xys, clv(1)*flatten(-1:1,3), clv(2)*flatten(-1:1,4));
cc = adjsiza(c,clm);
plotdot(clm, 0.52i, cc,6)
title('Nine clusters fit to each other')

figure(1)