function xys = ex_crecell(km,lm)
% DESCRIPTION
%  xys = ex_crecell(km,lm)
%  Creates a cluster and draws two plots.
%  Figure no 1 shows one cluster, which
%  contains two rhombs with the side km resp. lm
%  and a parallellogram with sides km and lm.
%  The number of sites inside the cluster is
%  km^2+lm^2+km*lm.
%  Figure no 2 illustrates how clusters can be fitted together.
% INPUT 
%  km --  See below.
%  lm --  Intergers setting the clustersize to km^2+lm^2+km*lm. 
% OUTPUT
%  xys -- centerpoint of each cell
%  -- A plot showing the principle of cluster construction.
% TRY 
%  ex_crecluster;
%  ex_crecluster(4,10);
% SEE ALSO 
%  crecluster, crecells

% by Magnus Almgren 010215 revised 040206 MA

if nargin <2 % If input-argument <2, set km and lm to defaultvalues.
 km = 5;
 lm = 2;
end

% colors to use by plotdot
c = [zeros(1,lm.^2)+0.2 zeros(1,km.^2)+0.4 zeros(1,km*lm)+0.6];

figure(1)
clf
% Cellclöusters fit into each others
xysc = reshape(crecells(1,1,km,lm,0,3),[1 km^2+lm^2+km*lm, 3  3])
plotdot(xysc,0.9,c,6)
title('Nine clusters fit to each other')

figure(2)
clf
xys = crecells(1,1,km,lm); % complex psoitions for omni cells within a cluster
plotdot(xys,0.9,c,6)
title('A cluster with km^2+lm^2+km*lm sites.')


% $Id: ex_crecell.m,v 1.2 2004/03/11 15:00:54 olav Exp $
