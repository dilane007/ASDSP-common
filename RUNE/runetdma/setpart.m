function par = setpart
% DESCRIPTION par = setpart
%  Sets the structured parameter par that is the input to runeft.
%  This file is intended to use as a template.
% INPUT
%  none
% OUTPUT      
%  par --  input parameter to rune
% SEE ALSO
%  runeft
% TRY
%  setpart

% by Magnus Almgren 040213

% Set up the default values for the runegain part
par=setparg;

% Simulation specific paramters
par.frametime = 1;     % time interval between simulated frames. Could be nslots*sltottime 
par.nframes = 5;       % number of iterations in the main loop 
par.slottime = 1/8;    % time per slot 
par.nslots  = 8;       % nomber of slots per frame
par.seed = 1;          % seed to all random sequencies in the simulation

% Propagation specific paramters
par.gainconst = -28;   % gain at 1 meter distance 
par.noise = -118;      % thermal noise floor -118 dBm
par.alpha = 3.5;       % distance attenuation coefficient
par.sigma = 6;         % standard deviation for the log-normal fading in dB
par.raa = 0.5;         % lognormal correlation down link (typical 0.5)
par.corrdist = 110;    % lognormal fading correlation distance [m]

% Transmission specific parameters 
par.homargin = 3;      % gain margin between two bases used at Hand Off
par.pinit = 20;        % init power set to each new link
par.pmax  =  33;       % max transmit link power [dBm]
par.rbermax = 1;       % raw bit error level over which a frame is lost
par.usefastf = 1;      % make use of fast fading

% specifics for TDMA
par.kn = 1;            % kn^2+ln^2+kn*ln => the number of cluster per system
par.ln = 1;            % related to kn above
par.kpc = 2;           % channnels per cell
par.usefh = 0;         % reselection of frequency every slot if 1

% $Id: setpart.m,v 1.3 2004/03/15 14:59:54 olav Exp $
