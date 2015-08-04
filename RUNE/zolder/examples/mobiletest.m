function mobiletest
% function mobiletest
% mobmove illustration 

% by Magnus Almgren 010215

% Create new mobiles
par.amean = 0.5;         % mean acceleration [m/s/s]
par.vmean = 10;        % mean speed  [m/s]
par.dt = 0.1;            % time interval in the simulation loop
par.maxiter = 100;      % number of iterations in the main loop

rombvec = 10000*exp((0:1)*i*pi*2/3); % size of system

nmob=10;          % number of users
xym=nans(nmob,1); % template for position (complex entity)
xyv=nans(nmob,1); % template for speed 
m = (1:nmob).';   % userid 

xymm = ones(0,1); % init variable as empty
for iter = 1:par.maxiter
 [xym,xyv]=mobmove(xym,xyv,par.amean,par.vmean,par.dt,rombvec);
 xymm(:,iter) = xym;
end
clf
plot(xymm.','*') % show user position
axis equal