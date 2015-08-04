function ex_crecells(par)
% DESCRIPTION
%  ex_crecells(par)
%  generates a cell plot over the system
% INPUT  (all inputs are optional)
%  par --            BASIC SIMULATION PARAMETERS
%  par.cellradius -- cell radius [m]
%  par.km --         km^2+lm^2+km*lm => number of sites per sector
%  par.lm --         related to km above
%  par.kn --         kn^2+lm^2+kn*ln => the number of clusters
%  par.ln --         related to kn above
%  par.sps --        number of sectors per site
%  par.ncluster --   number of clusters equals ncluster^2
% OUTPUT
%  a plot
% SEE ALSO
%  ex_crecell,ex_reuse, ex_wraparound
% TRY
%  ex_crecells

% by Magnus Almgren 040206

% Default setiing of parameters
% seven three sector sites in one cluster
if ~exist('par','var')
 par.cellradius=1000; 
 par.km = 1; % km^2+lm^2+km*lm sites per cluster
 par.lm = 2;
 par.kn = 1; % kn^2+ln^2+kn*ln cluster in the system
 par.ln = 0;
 par.sps = 3; % sectors per site 
end

% Create the base stations
[xyb,fib,rhombvec]=crecells(par.cellradius,par.sps,par.km,par.lm,par.kn,par.ln);

% Plot the system
figure(1);
clf
plothex(xyb,fib);

% $Id: ex_crecells.m,v 1.2 2004/03/11 15:00:54 olav Exp $
