function xymm = mobiletest
% DESCRIPTON
%  xymm = mobiletest
%  Generates a gain matrix for a number of mobiles
%  in a small system
% OUTPUT
%  xymm -- complex user positions. Size is number of users by 1.
% SEE ALSO
%  gaintest
% TRY
%  xymm = mobiletest

% by Magnus Almgren 040209

% Create vbase stations
par.cellradius = 1000; % cell radius [m]
par.km = 2;            % km^2+lm^2+km*lm => the number of sites
par.lm = 1;            % related to km above
par.sps = 3;           % Number of sectors per site

% xyb --      base antenna positon
% fib --      relative vector pointing from base to center of cell. 0 if
%             omincell
% rhombvec -- vectors that will span the system (used for wrap around)
[xyb,fib,rhombvec]=crecells(par.cellradius,par.sps,par.km,par.lm);

% Create new mobiles 
% dt, amean and vmean has no meaning in this example 
par.amean = 1;         % mean acceleration [m/s/s]
par.vmean = 10;        % mean speed  [m/s]
par.dt = 1;            % time interval in the simulation loop [s]

nmob = 300;             % number of users
xym=nans(nmob,1);      % template for position (complex entity)
xyv=nans(nmob,1);      % template for speed 
m = (1:nmob).';        % userid 

xymm = ones(nmob,0);      % init variable as empty
par.maxiter = 30;      % number of iteration
for iter = 1:par.maxiter
 [xym,xyv]=mobmove(xym,xyv,par.amean,par.vmean,par.dt,rhombvec);
 xymm  = [xymm xym];
end
clf
plothex(xyb,fib)
ploth(xymm.','.-') % show user position
axis equal

% $Id: mobiletest.m,v 1.2 2004/03/11 15:00:54 olav Exp $
