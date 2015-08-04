function ex_mobiles(par)
% DESCRIPTION
%  ex_mobiles(par)
%  generates a cell plot over the system
% INPUT  (all inputs are optional)
%  par --            BASIC SIMULATION PARAMETERS
%  par.cellradius -- cell radius [m]
%  par.km --         km^2+lm^2+km*lm => the number of sites
%  par.lm --         related to km above
%  par.sps --        number of sectors per site
%  par.ncluster --   number of clusters equals ncluster^2
%  par.amean --      acceleration [m/s/s]
%  par.vmean --      speed  [m/s]
%  par.dt --         time interval in the simulation loop [s]
% OUTPUT
%  a plot
% SEE ALSO
%  ex_crecells, ex_reuse, ex_wraparound
% TRY
%  ex_mobiles

% by Magnus Almgren 030825

% Default setiing of parameters
if ~exist('par','var')
 par.cellradius=1000;
 par.km=1;
 par.lm=2;
 par.kn=1;
 par.ln=0;
 par.sps=1;
 par.amean = 1;
 par.vmean = 14;
 par.dt = 1;
end

% Create the base stations
[xyb,fib,rhombvec]=crecells(par.cellradius,par.sps,par.km,par.lm,par.kn,par.ln);

nmob=100;
xym=nans(nmob,1);
xyv=nans(nmob,1);
m=(1:nmob).';

[xym,xyv]=mobmove(xym,xyv,par.vmean,par.amean,par.dt,rhombvec);

% Plot the system
figure(1);
clf
plothex(xyb,fib);
hold on;
plot(xym,'b.');
hold off;

% $Id: ex_mobiles.m,v 1.2 2004/03/11 15:00:54 olav Exp $
