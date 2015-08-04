function [gmb, xym, xyb, fib] = gaintest
% DESCRIPTION
%  [gmb, xym, xyb, fib] = gaintest
%  Generates a gain matrix for a number of mobiles
%  in a small system
% INPUT
%  none
% OUTPUT
%  gmb -- gain matrix in dB. Size is users (mobiles) by basestations
%  xym -- complex user positions. Size is number of users by 1.
%  xyb -- complex basestation positions. Size is 1 by number of bases.
%  fib -- complex basestation direction. Size is 1 by number of bases.
% SEE ALSO
%  mobiletest
% TRY
%  gmb = gaintest

% by Magnus Almgren 040209

% Create vbase stations
par.cellradius = 1000; % cell radius [m]
par.km = 2;            % km^2+lm^2+km*lm => the number of sites
par.lm = 1;            % related to km above
par.sps = 3;           % Number of sectors per site

% xyb --      base antenna positon
% fib --      relative vector pointing from base to center of cell. 0 if omincell
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

% xym -- user position 
% xyv -- user speed not used in this example
[xym, xyv]=mobmove(xym,xyv,par.vmean,par.amean,par.dt,rhombvec);

% Calculate the gain between bases and mobiles
par.gainconst = 21;    % gain at 1 meter distance 
par.noise = -118;      % thermal noise floor -118 dBm
par.alpha = 3.5;       % distance attenuation coefficient
par.sigma = 6;         % standard deviation for the log-normal fading in dB
par.raa = 0.5;         % lognormal correlation down link (typical 0.5)
par.corrdist = 110;    % lognormal fading correlation distance [m]
par.seed = 1;          % seed to the random generator

% generate the lognormal shadow fading map
[lognmap, lognmapvec] = crelognmap(xyb, rhombvec, par.corrdist);

% calculate the path gain matrix in dB between users (along first dimension, row)
% and bases (along second dimension, column)
gmb = pathgain(xym, xyb, fib, par.sps, rhombvec, ...
 par.gainconst, par.alpha, par.sigma, par.raa, lognmap, lognmapvec);

% Plot the system
figure(1);
clf   % clear plot
plothex(xyb,fib);  % Cell pattern
ploth(xym,'b*');  % users

% $Id: gaintest.m,v 1.2 2004/03/11 15:00:54 olav Exp $
