function hextest(sps, km, lm, nmob)
% function hextest(sps, km, lm, nmob)

% by Magnus Almgren 010215
if nargin ==0
 sps = 1; % omni cells
 km = 2;  % 7 cells within the system
 lm = 1;
 nmob = 100;
end

% create cells positions
[xyb, fib, rombvec] = crecells(100,sps,km,lm);

% Create new mobiles
par.amean = 5;         % mean acceleration [m/s/s]
par.vmean = 10;        % mean speed  [m/s]
par.dt = 1;            % time interval in the simulation loop

xym=nans(nmob,1);
xyv=nans(nmob,1);
m = (1:nmob).';

[xym,xyv]=mobmove(xym,xyv,par.vmean,par.amean,par.dt,rombvec);

figure(1);
clf
plothex(xyb,fib) % plot hexagon cells 
hold on
plot(xym,'b*') % plot user position
hold off
