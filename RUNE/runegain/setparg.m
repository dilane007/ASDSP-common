function par = setparg
% DESCRIPTION
%  par = setparg
%  Sets the structured parameter par that is the input to runefg.
%  This file is intended to use as a template.
% INPUT
%  none
% OUTPUT      
%  par --  input parameter to rune
% SEE ALSO
%  runefg
% TRY
%  setparg

% by Magnus Almgren 040213

% Simulation specific paramters
par.frametime = 1;     % time interval between simulated frames. Could be nslots*sltottime 
par.nframes = 5;       % number of iterations in the main loop 
par.slottime = 1/8;    % time per slot 
par.nslots  = 8;       % nomber of slots per frame
par.seed = 1;          % seed to all random sequencies in the simulation

% Site specific paramters
par.cellradius = 3000; % cell radius [m]
par.km = 1;            % km^2+lm^2+km*lm => the number of sites per cluster
par.lm = 2;            % related to km above
par.kn = 0;            % kn^2+ln^2+kn*ln => the number of cluster per system
par.ln = 1;            % related to kn above
par.sps = 1;           % Number of sectors per site

% Propagation specific paramters
par.gainconst = -28;   % gain at 1 meter distance 
par.noise = -103;      % thermal noise floor -118 dBm
par.alpha = 3.5;       % distance attenuation coefficient
par.sigma = 6;         % standard deviation for the log-normal fading in dB
par.raa = 0.5;         % lognormal correlation down link (typical 0.5)
par.corrdist = 110;    % lognormal fading correlation distance [m]

% Traffic generation specific parameters
par.offtraf = 10;      % average number of offered calls to a cell     
par.mht = inf;         % mean holding time [seconds]  

% Mobility specific parameters
par.amean = 0.2;       % mean acceleration [m/s/s]
par.vmean = 1;         % mean speed  [m/s]

% $Id: setpar.m,v 1.2 2004/03/11 15:01:31 olav Exp $
