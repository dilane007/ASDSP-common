function [res, par, sta, sys] = runefc(par, sta, sys) 
% DESCRIPTION
% [res, par, sta, sys] = runefc(par, sta, sys)
% The basic rune dynamic function for CDMA.
% INPUT  (all inputs are optional
%  par --               BASIC SIMULATION PARAMETERS
%  par.frametime --     time interval in the simulation loop
%  par.nframes--        number of iterations in the main loop 
%  par.slottime --      time per slot in seconds 
%  par.nslots --        number of slots per frame
%  par.seed --          seed to all random sequencies in the simulation
%  par.cellradius --    cell radius [m]
%  par.km --            km^2+lm^2+km*lm => the number of sites
%  par.lm --            related to km above
%  par.sps --           number of sectors per site
%  par.gainconst --     gain at 1 meter distance [dB] 
%  par.alpha --         distance attenuation coefficient
%  par.noise --         thermal noise floor [dBm]
%  par.sigma --         standard deviation for the lognormal fading [dB]
%  par.raa --           lognormal correlation down link (typical 0.5)
%  par.corrdist --      lognormal fading correlation distance [m]
%  par.offtraf --       average number of offered calls to a cell [Erlang/cell]     
%  par.mht --           mean holding time [seconds]  
%  par.amean --         average acceleration [m/s/s]
%  par.vmean --         average speed  [m/s]
%  par.pmax --          max transmit link power [dBm]
%  par.rbermax --       raw bit error level over which a call is dropped
%  par.usefastf --       make use of fast fading
%
%  par.sirtarget --     C/I target level for the inner loop [dB] 
%  par.userbr --        user bit rate
%  par.chipr --         chip rate 
%  par.reb --           Rebate factor for down link power from own base 
%
%  sta --               STATE variable that is changed at every iteration
%  sta.seed --          the seed before next iteration
%  sta.time --          sample time 
%  sta.m --             mobile identity number
%  sta.mtop --          max mobile number used sofar
%  sta.xym --           position in complex form [m]
%  sta.xyv --           speed imag <=> north real <=> east [m/s] 
%  sta.gmb --           the gain matrix (slow part) 
%  sta.rgumb --         rayleigh fading gain for the uplink
%  sta.rgdmb --         rayleigh fading gain for the downlink
%
%  sta.pumb --          transmitted power up link  [dBm]
%  sta.cumb --          received carrier power up link [dBm]
%  sta.iumb --          interference power up link  [dBm]
%  sta.rgumb --         rayleigh gain uplink
%  sta.sirumb --        signal to interference ratio up link [dB]
%  sta.fepum --         frame error probability for each user
%  sta.pdmb --          transmitted power down link  [dBm]
%  sta.cdmb --          carrier downlink [dBm]
%  sta.idmb --          interference down link [dBm]
%  sta.rgdmb --         rayleigh gain downlink
%  sta.sirdmb --        signal to interference ratio down link [dB]
%  sta.fepdm --         frame error probability for each user
%
%  sys --               ALL INTERMEDIATE VALUES NEEDED TO SIMULATE
%  sys.xyb --           base positions [m]
%  sys.fib --           cell center vector [m]
%  sys.rhombvec --      system vectors [m]
%  sys.raylmap --       rayleigh map [dB]
%  sys.raylmapvec --    rayleigh map vectors [m]
%  sys.lognmap --       lognormal map [dB]
%  sys.lognmapvec --    lognormal map vectors [m]
% OUTPUT
%  res --               cellarray of sta collected for each iteration of the simulation
%  par --               same as input otherwise created within the function
%  sta --               same structure as input otherwise created within the function          
%  sys --               same as input otherwise created within the function  
% TRY 
%  [res, par, sta, sys] = runefc 
% SEE ALSO
%

% by Magnus Almgren 040211

% set simulation parameter par if not present as an input
if ~exist('par','var'), par = setparc; end % default parameter setting
oseed = setseed(par.seed); % Set the seed in random generators

% Create the sys variable if not present as an input.
if ~exist('sys','var') || isempty(sys)
 % generate base station position and directions 
 clear sys
 [sys.xyb, sys.fib, sys.rhombvec] = crecells(par.cellradius,par.sps,par.km,par.lm);
 
 % Create a lognormal map. The lognormal map is dependent on the seed.
 oseed1 = setseed(par.seed);  % Set seed of pseudo random generator for the map.
 [sys.lognmap, sys.lognmapvec] = crelognmap(sys.xyb, sys.rhombvec, par.corrdist); 
 
 % Create a rayleigh fading map if par.usefastf = 1.
 [sys.raylmap, sys.raylmapvec] = creraylmap(sys.rhombvec,[],par.usefastf);
 sys.xyboffsrayl = irandn(size(sys.xyb))*sys.rhombvec(1); % offset for fast fading
 
 setseed(oseed1);  % Restore seed to original value.
end

% Init of state variable
% The variables below are altered in the for loop and saved after each iteration
if ~exist('sta','var') || isempty(sta)
 clear sta
 e = zeros(0,1);
 e1 = zeros(0,size(sys.xyb,2));
 sta.seed  = par.seed; sta.time = 0; sta.m = e; sta.mtop  = 0; sta.xym = e; sta.xyv = e; sta.gmb = e1;
 sta.pumb = e1; sta.cumb = e1; sta.iumb = e1; sta.rgumb = e1; sta.sirumb = e1; sta.fepum = e;
 sta.pdmb = e1; sta.cdmb = e1; sta.idmb = e1; sta.rgdmb = e1; sta.sirdmb = e1; sta.fepdm = e;
end
setseed(sta.seed); % Set seed in random generators.
 
% The simulation loop. One iteration corresponds to one frame
for iframe = 1:par.nframes
 dt = par.frametime-par.nslots*par.slottime; 
 sta.time = sta.time+dt; % Timestamp
 
 % Terminate some calls due to hang up.
 terones = (rand(size(sta.xym)) < 1-exp(-mdiv(par.frametime,par.mht))); % Toss one biased Coin per active user
 drones = sta.fepum | sta.fepdm; % quality dropping
 
 % Make a realisation of new users. 
 % At first iteration full traffic is generated
 incr = 1 - (sta.time~=dt).*exp(-mdiv(par.frametime,par.mht));
 % Average number of users to create
 nmobavg = par.offtraf .* size(sys.xyb,2).* incr; 
 veclength = round(max(100, 10*nmobavg)); % At least a pool of 100 idle users to draw from 
 nmob = sum(rand(veclength,1) < nmobavg/veclength); % Tosse all the Coins
 
 % Refresh vector structure by removing released calls and adding new ones.
 nt1 = nans(nmob,1);  % NaN vector used as concatenation of xym xyb etc.
 ntb = nans(nmob,size(sys.xyb,2));  % NaN matrix used to concatenate gmb pumb etc. 
 
 keep = ~terones | ~drones;  % Clean out terminated and dropped users
 % Several of these updates are not necessary but is done in order to ease debugging
 sta.xym   =[sta.xym(keep);       nt1]; 
 sta.xyv   =[sta.xyv(keep);       nt1]; 
 sta.m     =[sta.m(keep); sta.mtop+(1:nmob)']; 
 sta.gmb   =[sta.gmb(keep,:);    ntb]; 
 
 sta.pumb  =[sta.pumb(keep,:);   ntb]; 
 sta.cumb  =[sta.cumb(keep,:);   ntb]; 
 sta.iumb  =[sta.iumb(keep,:);   ntb]; 
 sta.rgumb =[sta.rgumb(keep,:);  ntb]; 
 sta.sirumb=[sta.sirumb(keep,:); ntb];
 sta.fepum =[sta.fepum(keep);    nt1];
 
 sta.pdmb  =[sta.pdmb(keep,:);   ntb]; 
 sta.cdmb  =[sta.cdmb(keep,:);   ntb]; 
 sta.idmb  =[sta.idmb(keep,:);   ntb]; 
 sta.rgdmb =[sta.rgdmb(keep,:);  ntb]; 
 sta.sirdmb=[sta.sirdmb(keep,:); ntb];
 sta.fepdm =[sta.fepdm(keep);    nt1];
 
 sta.mtop = sta.mtop+nmob; % highest mobile id so far
 
 % Move old users and initiate a position to new users.
 [sta.xym,sta.xyv] = mobmove(sta.xym,sta.xyv,par.amean,par.vmean,dt,sys.rhombvec);
 
 % Calculate the gain matrix. Size is terminals  by bases
 sta.gmb = pathgain(sta.xym, sys.xyb, sys.fib, par.sps, sys.rhombvec, ...
  par.gainconst, par.alpha, par.sigma, par.raa, ...
  sys.lognmap, sys.lognmapvec);
 
 % Perform handoff & Allocate new users to a channel.
 [sta.pumb, sta.pdmb] = handoffc(sta.pumb, sta.pdmb, sta.gmb, par.homargin, par.pinit);
 
 % init of variables for the inner loop 
 % The inner Loop Power collected in a matrix of size users by bases by timeslots
 sirumbt = nans([size(sta.gmb) par.nslots]); sirdmbt = sirumbt; % reserve memory
 
 for islot = 1:par.nslots
   dt = par.slottime;
   sta.time = sta.time + dt;
  
   % Move users one slot forward
   [sta.xym,sta.xyv] = mobmove(sta.xym,sta.xyv,par.amean,par.vmean,dt,sys.rhombvec);
  
   % compute flat fading gain as a matrix of the same size as sta.gmb
   sta.rgumb = lin2db(abs(useraylmap(mplus(+sys.xyboffsrayl,-sta.xym), sys.raylmap, sys.raylmapvec)).^2);
   sta.rgdmb = lin2db(abs(useraylmap(mplus(-sys.xyboffsrayl,-sta.xym), sys.raylmap, sys.raylmapvec)).^2);
   
   % Fast power control
   [sta.pumb, sta.pdmb] = fastpc(sta.pumb, sta.pdmb, sta.sirumb, sta.sirdmb, par.sirtarget, par.pmax);
  
   % Perform the transmission from the sending to the receiving side, all in dB or dBm.
   [sta.cumb, sta.iumb, sta.sirumb] = transul(sta.pumb, sta.gmb+sta.rgumb, par.noise); % up link
   [sta.cdmb, sta.idmb, sta.sirdmb] = transdl(sta.pdmb, sta.gmb+sta.rgdmb, par.noise, par.reb); % down link
   
   % Collect C/I for mobiles,bases and slots
   sirumbt(:,:,islot) = sta.sirumb;
   sirdmbt(:,:,islot) = sta.sirdmb;
   
   % Save some results
   res(islot,iframe)= sta;
 end
 
 % Frame Error Probability up and down link
 pg = lin2db(par.chipr/par.userbr); % processing gain
 sta.fepum = mean(ci2rber(linsum(sirumbt,2)+pg),3) > par.rbermax;
 sta.fepdm = mean(ci2rber(linsum(sirdmbt,2)+pg),3) > par.rbermax;
 sta.seed = setseed; % Save seed to faciliate simulation from this state
end
setseed(oseed); % Restore seed to original value
% $Id: runefc.m,v 1.4 2004/03/15 09:35:30 bogdant Exp $
