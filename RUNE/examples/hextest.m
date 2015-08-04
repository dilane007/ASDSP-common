function hextest(sps, km, lm, nmob)
% DESCRIPTION
%  hextest(sps, km, lm, nmob)
%  This function essentially plots a system by first defining the cells and
%  then creating the mobiles. Then the whole thing is plotted.
% INPUT
%  sps --    The number of sectors per site. Useful values are 1,3 and 6 although other values work.
%  km --     Used to define the number of cells according to km^2 + lm^2 + km*lm
%  lm --     Used to define the number of cells
%  nmob --   The number of mobiles that should be created
% OUTPUT
%  --        A plot
% 
% TRY hexcell hexcell(1,1,0,0) hexcell(3,1,0,0) hexcell(1,1,1,0) hexcell(3,1,1,0)

% by Magnus Almgren 010215 
if nargin ==0
 sps = 1; % omni cells
 km = 2;  % 7 cells within the system
 lm = 1;
 nmob = 100; % number of mobiles created
end

% create cells positions
cellradius = 100; % a complex vector from cell center to one of the corners
[xyb, fib, rhombvec] = crecells(cellradius,sps,km,lm);

% Create new mobiles
par.amean = 5;         % mean acceleration [m/s/s]
par.vmean = 10;        % mean speed  [m/s]
par.dt = 1;            % time interval in the simulation loop


xym=nans(nmob,1); % template for mobile positions
xyv=nans(nmob,1); % template for mobile speeds
m = (1:nmob).';   % mobile identities (in this case not used)

[xym,xyv]=mobmove(xym,xyv,par.vmean,par.amean,par.dt,rhombvec);

figure(1);
clf
plothex(xyb,fib) % plot hexagonal cells 
ploth(xym,'b*') % plot user position

% $Id: hextest.m,v 1.2 2004/03/11 15:00:54 olav Exp $
