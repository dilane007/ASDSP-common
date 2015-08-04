function par = setpar
% DESCRIPTION par = setpar
%  Sets the structured parameter par that is the input to runef.
%  This file is intended to use as a template. Rename and change
%  its content to your desire.
% OUTPUT      
%  par --  input parameter to rune
% TRY
%  setpar
% SEE ALSO
%  runef

% by Magnus Almgren 000530

par.cellradius = 3000; % cell radius [m]
par.km = 2;            % km^2+lm^2+km*lm => the number of sites
par.lm = 1;            % related to km above
par.sps = 1;           % Number of sectors per site
par.gainconst = -28;   % gain at 1 meter distance 
par.noise = -103;      % thermal noise floor -118 dBm
par.alpha = 3.5;       % distance attenuation coefficient
par.sigma = 6;         % standard deviation for the log-normal fading in dB
par.raa = 0.5;         % lognormal correlation down link (typical 0.5)
par.corrdist = 110;    % lognormal fading correlation distance [m]
par.offtraf = 10;      % average number of offered calls to a cell     
par.mht = 20;          % mean holding time [seconds]  
par.amean = 0.2;       % mean acceleration [m/s/s]
par.vmean = 1;         % mean speed  [m/s]
par.pinit = -10;       % init power set to each new link [dBm]
par.rbermax = 1;       % raw bit error level over which a frame is lost 
par.sirtarget = -22;   % C/I target level for the inner loop [dB]   
par.userbr = 12200;    % user bit rate
par.chipr = 1228800;   % chip rate 
par.homargin = 3;      % gain margin between two bases used at Hand Off 
par.reb = 0.5;         % Rebate factor for down link power from own base 
par.dt = 1;            % time interval in the simulation loop
par.slottime = 1/800 ; % time per slot in seconds 
par.maxiter = 3;        % number of iterations in the main loop 
par.nslots  = 16;      % nomber of slots per frame
par.seed = 1;          % seed to all random sequencies in the simulation
