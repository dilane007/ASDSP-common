function [gmb, xym, xyb] = gaintest
% function [g, xym, xyb] = gaintest
% will generate a gain matrix for a number of mobiles
% in a small system

% by Magnus Almgren 010214

% Create the base stations
par.cellradius = 1000; % cell radius [m]
par.km = 2;            % km^2+lm^2+km*lm => the number of sites
par.lm = 1;            % related to km above
par.sps = 1;           % Number of sectors per site

% xyb -- base antenna positon
% fib -- relative vector pointing from bsae to center of cell. 0 if omincell
% rombvec -- vectors that will span the system (used for wrap around)
[xyb,fib,rombvec]=crecells(par.cellradius,par.sps,par.km,par.lm);

% Create new mobiles
par.amean = 5;         % mean acceleration [m/s/s]
par.vmean = 10;        % mean speed  [m/s]
par.dt = 10;           % time interval in the simulation loop [s]

nmob=30;          % number of users
xym=nans(nmob,1); % template for position (complex entity)
xyv=nans(nmob,1); % template for speed 
m = (1:nmob).';   % userid 

% xym -- user position 
% xyv -- user speed
[xym,xyv]=mobmove(xym,xyv,par.vmean,par.amean,par.dt,rombvec);

% Create the antenna lobe
lobevector=zeros(360,1); % omni

% Calculate the gain between bases and mobiles
par.gainconst = 21;    % gain at 1 meter distance 
par.noise = -118;      % thermal noise floor -118 dBm
par.alpha = 3.5;       % distance attenuation coefficient
par.sigma = 6;         % standard deviation for the log-normal fading in dB
par.raa = 0.5;         % lognormal correlation down link (typical 0.5)
par.corrdist = 110;    % lognormal fading correlation distance [m]
par.seed = 1;          % seed to the random generator

% generate the lognormal shadow fading map
[lognmap, lognmapvec] = crelognmap(xyb, rombvec, par.corrdist);

% calculate the path gain matrix in dB between users (along first dimension, row)
% and bases (along second dimension, column)
gmb = pathgain(xym, xyb, fib, rombvec, ...
 par.gainconst, par.alpha, par.sigma, par.raa, lobevector, lognmap, lognmapvec);

% Plot the system
figure(1);
clf   % clear plot
plothex(xyb,fib);  % Cell pattern
hold on;
plot(xym,'b*');  % users
hold off;
