function par = setparc
% DESCRIPTION
% par = setparc
%  Sets the structured parameter par that is the input to runefc.
%  This file is intended to use as a template.
% OUTPUT      
%  par --  input parameter to rune
% SEE ALSO
%  runefc
% TRY
%  setparc

% by Magnus Almgren 040213

% Set up the default for the gain part
par=setparg;

% Simulation specific paramters
par.nframes = 5;       % number of iterations in the main loop 
par.seed = 1;          % seed to all random sequencies in the simulation
		       
% Propagation specific paramters
par.gainconst = -28;   % gain at 1 meter distance 
par.noise = -103;      % thermal noise floor -103 dBm 5 MHZ wide receiver 3 dB NF
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

% specifics for UMTS, dedicated channels
par.frametime = 0.01;  % time interval between simulated frames. (10ms)
par.nslots  = 15;      % nomber of slots per frame
par.slottime = 0.01/15;    % time per slot 
par.sirtarget = -18;   % C/I target level for the inner loop [dB]   
par.userbr = 12200;    % user bit rate
par.chipr = 3840000;   % chip rate 
par.reb = 0.5;         % Rebate factor for down link power from own base 

% $Id: setparc.m,v 1.5 2004/03/15 14:59:05 olav Exp $
