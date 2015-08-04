function [res, par, sta, sys] = runeft(par, sta, sys) 
% DESCRIPTION [res, par, sta, sys] = runeft(par, sta, sys)
% The basic rune dynamic function for TDMA.
% A number of time instances are simulated over time in the following way:
% A number of "frames" are simulated. How many and the time between them
% are determined by the frametime and nframes parameters. In each frame
% several slots are simulated determined by the slottime and nslots
% parameters.
% 
% In each frame new calls arrive and terminate and calls are
% handed over if necessary. The traffic is the same for all slots in a
% frame, but since the mobiles move slightly they are exposed to fast
% (rayleigh) fading (controlled by the usefastf parameter) and possibly
% changing interference conditions due to frequency hopping (parameter
% usefh).
% 
% Mobiles move between all time instants
% 
% INPUT  (all inputs are optional
%  par --                BASIC SIMULATION PARAMETERS
%  par.frametime -- time interval in the simulation loop
%  par.nframes--         number of iterations in the main loop 
%  par.slottime --       time per slot in seconds 
%  par.nslots --         number of slots per frame
%  par.seed --           seed to all random sequencies in the simulation
%  par.cellradius --     cell radius [m]
%  par.km --             km^2+lm^2+km*lm => the number of sites
%  par.lm --             related to km above
%  par.sps --            number of sectors per site
%  par.gainconst --      gain at 1 meter distance [dB] 
%  par.alpha --          distance attenuation coefficient
%  par.noise --          thermal noise floor [dBm]
%  par.sigma --          standard deviation for the lognormal fading [dB]
%  par.raa --            lognormal correlation down link (typical 0.5)
%  par.corrdist --       lognormal fading correlation distance [m]
%  par.offtraf --        average number of offered calls to a cell [Erlang/cell]     
%  par.mht --            mean holding time [seconds]  
%  par.amean --          average acceleration [m/s/s]
%  par.vmean --          average speed  [m/s]
%  par.homargin --       gain margin between two bases used at Hand Off
%  par.pinit --          initial power assigned to one transmitter
%  par.rbermax --        raw bit error level over which a frame is lost 
%  par.usefastf --       make use of fast fading
%
%  par.kn --             kn^2+ln^2+kn*ln => the number of clusters
%  par.ln --             related to kn above
%  par.kpc --            number of allocated channels per cell
%  par.usefh --          reselection of frequency every slot if 1
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
%  sta.m --             mobile identity number
%  sta.b --             base station index
%  sta.k --             channel number
%  sta.mtop --          max mobile number used sofar
%  sta.pul --           transmitted power up link  [dBm]
%  sta.cul --           received carrier power up link [dBm]
%  sta.iul --           interference power up link  [dBm]
%  sta.sirul --         signal to interference ratio up link [dB]
%  sta.fepul --         frame error probability for each user
%  sta.pdl --           transmitted power down link  [dBm]
%  sta.cdl --           carrier downlink [dBm]
%  sta.idl --           interference down link [dBm]
%  sta.sirdl --         signal to interference down link [dB]
%  sta.fepdl --         frame error probability for each user
%  sta.obk --           the allocation of channels
%
%  sys --               ALL INTERMEDIATE VALUES NEEDED TO SIMULATE
%  sys.xyb --           base positions [m]
%  sys.fib --           cell center vector [m]
%  sys.rhombvec --      system vectors [m]
%  sys.raylmap --       rayleigh map [dB]
%  sys.raylmapvec --    rayleigh map vectors [m]
%  sys.lognmap --       lognormal map [dB]
%  sys.lognmapvec --    lognormal map vectors [m]
%
%  sys.iniobk --     channel plan
%
% OUTPUT
%  res --            cellarray of sta collected for each iteration of the simulation
%  par --            same as input otherwise created within the function
%  sta --            same structure as input otherwise created within the function          
%  sys --            same as input otherwise created within the function  
% SEE ALSO
%  setpart
% TRY 
%  [res, par, sta, sys] = runeft 

% by Magnus Almgren 040211	

% set simulation parameter par if not present as an input
if ~exist('par','var'), par = setpart; end % default parameter setting
oseed = setseed(par.seed); % Set the seed in random generators

% Create the sys variable if not present as an input.
if ~exist('sys','var') | isempty(sys)
 % generate base station position and directions 
 clear sys
 [sys.xyb, sys.fib, sys.rhombvec] = crecells(par.cellradius,par.sps,par.km,par.lm,...
 par.kn,par.ln);

 % Create a lognormal map. The lognormal map is dependent on the seed.
 oseed1 = setseed(par.seed);  % Set seed of pseudo random generator for the map.
 [sys.lognmap, sys.lognmapvec] = crelognmap(sys.xyb, sys.rhombvec, par.corrdist); 
 
 % Create a rayleigh fading map if par.usefastf = 1.
 [sys.raylmap, sys.raylmapvec] = creraylmap(sys.rhombvec,[],par.usefastf);
 sys.xyboffsrayl = irandn(size(sys.xyb))*sys.rhombvec(1); % offset for fast fading

 setseed(oseed1);  % Restore seed to original value.

 % Create a channel plan for the system.
 % Number of channels that is used in each cluster.
 nclusters = par.kn^2+par.ln^2+par.kn*par.ln;
 nk = length(sys.xyb)/nclusters*par.kpc;   	
 sys.iniobk  = crechanplan(length(sys.xyb),nk,nclusters);  % Allocate channels to cells
end

% Init of state variable
% The variables below are altered in the for loop and saved after each iteration
if ~exist('sta','var') | isempty(sta)
 clear sta
 e = zeros(0,1);
 e1 = zeros(0,size(sys.xyb,2));
 sta.seed  = par.seed; sta.time = 0; sta.m = e; sta.mtop  = 0; sta.xym = e; sta.xyv = e; sta.gmb = e1;

 sta.m     = e;  sta.b     = e;  sta.k     = e; sta.mtop  = 0; 
 sta.pul   = e;  sta.cul   = e;  sta.iul   = e;  sta.sirul = e;  sta.fepul = e;
 sta.pdl   = e;  sta.cdl   = e;  sta.idl   = e;  sta.sirdl = e;  sta.fepdl = e;
 sta.obk   = sys.iniobk;
end
setseed(sta.seed); % Set seed in random generators.

% The simulation loop. One iteration corresponds to one frame
for iframe = 1:par.nframes
 dt = par.frametime-par.nslots*par.slottime;
 sta.time = sta.time+dt; % Timestamp
 
 % Terminate some calls due to hang up.
 terones = isfinite(sta.k) & (rand(size(sta.xym)) < 1-exp(-mdiv(par.frametime,par.mht))); % Toss one biased Coin per active user
 drones = sta.fepul | sta.fepdl; % quality dropping

 % Terminate by setting b and k to NaN and release channel by setting obk to 1
 [sta.b,sta.k,sta.obk] = terminate(sta.b,sta.k,sta.obk,terones | drones);

 % Make a realisation of new users. 
 % At first iteration full traffic is generated
 incr = 1 - (sta.time~=dt).*exp(-mdiv(par.frametime,par.mht));
 % Average number of users to create
 nmobavg = par.offtraf .* size(sys.xyb,2).* incr; 
 veclength = round(max(100, 10*nmobavg)); % At least a pool of 100 idle users to draw from 
 nmob = sum(rand(veclength,1) < nmobavg/veclength); % Tosse all the Coins

 % Refresh vector structure by removing released calls and adding new ones.
 nt1 = nans(nmob,1);  % NaN vector used as concatenation of xym xyb etc.
 ntb = nans(nmob,size(sys.xyb,2));  % Nans vector used to concatenate gmb pumb etc.
 sta.mtop = sta.mtop+nmob; % highest mobile id so far 
  
 keep = isfinite(sta.k);  % Clean out all users with k == nan
 % Several of these updates are not necessary but is done in order to ease debugging
 sta.xym   =[sta.xym(keep);       nt1]; 
 sta.xyv   =[sta.xyv(keep);       nt1]; 
 sta.m     =[sta.m(keep); sta.mtop+(1:nmob)']; 
 sta.gmb   =[sta.gmb(keep,:);     ntb]; 

 sta.b     =[sta.b(keep);         nt1]; 
 sta.k     =[sta.k(keep);         nt1]; 
 
 sta.pul   =[sta.pul(keep);       nt1]; 
 sta.cul   =[sta.cul(keep);       nt1]; 
 sta.iul   =[sta.iul(keep);       nt1]; 
 sta.sirul =[sta.sirul(keep);     nt1];
 sta.fepul =[sta.fepul(keep);     nt1];
 
 sta.pdl   =[sta.pdl(keep);       nt1]; 
 sta.cdl   =[sta.cdl(keep);       nt1]; 
 sta.idl   =[sta.idl(keep);       nt1]; 
 sta.sirdl =[sta.sirdl(keep);     nt1];
 sta.fepdl =[sta.fepdl(keep);     nt1];
 
 % Move old users and initiate a position to newcomers.
 [sta.xym,sta.xyv] = mobmove(sta.xym,sta.xyv,par.amean,par.vmean,dt,sys.rhombvec);

 % Calculate the gain matrix. Size is terminals  by bases
 sta.gmb = pathgain(sta.xym, sys.xyb, sys.fib, par.sps, sys.rhombvec, ...
  par.gainconst, par.alpha, par.sigma, par.raa, ...
  sys.lognmap, sys.lognmapvec);

 % Perform handoff & Allocate new mobiles to a channel if possible.
 [sta.b,sta.k,sta.obk] = handofft(sta.b,sta.k,sta.gmb,sta.obk,par.homargin);
 
 % Try to assign channels to new calls.
 [sta.b,sta.k,sta.obk] = assign(sta.b,sta.k,sta.gmb,sta.obk,par.homargin);
 
 sta.pul(isnan(sta.pul)) = par.pinit; % Set power to new users 
 sta.pdl(isnan(sta.pdl)) = par.pinit;
 
 % Reset power of terminated users.
 sta.pul(isnan(sta.k)) = nan; 
 sta.pdl(isnan(sta.k)) = nan;
 
 % init of variables for the inner loop 
 % The inner Loop Power collected in a matrix of size users by bases by timeslots
 sirumbt = nans([size(sta.gmb,1) par.nslots]); sirdmbt = sirumbt; % reserve memory
 for islot = 1:par.nslots
  dt = par.slottime;
  sta.time = sta.time + dt;
  
  % Move users one slot forward
  [sta.xym,sta.xyv] = mobmove(sta.xym,sta.xyv,par.amean,par.vmean,dt,sys.rhombvec);
  
  if par.usefh % if frequency hopping mode is selected
   % Perform frequency hopping by reselection all channels
   btemp = sta.b;
   btemp(isnan(sta.k)) = NaN;
   [sta.k, sta.obk] = radchanalloc(btemp, sys.iniobk);
  end
  
  % compute flat fading gain as a matrix of the same size as sta.gmb
  sta.rgumb = lin2db(abs(useraylmap(mplus(+sys.xyboffsrayl,-sta.xym), sys.raylmap, sys.raylmapvec)).^2);
  sta.rgdmb = lin2db(abs(useraylmap(mplus(-sys.xyboffsrayl,-sta.xym), sys.raylmap, sys.raylmapvec)).^2);
  
  % Perform the transmission from the sending to the receiving side, all in dB or dBm.
  [sta.cul, sta.iul, sta.sirul] = transmitul(sta.b, sta.k, sta.pul, sta.gmb+sta.rgumb, par.noise); % up link
  [sta.cdl, sta.idl, sta.sirdl] = transmitdl(sta.b, sta.k, sta.pdl, sta.gmb+sta.rgdmb, par.noise); % down link

  % Collect C/I for mobiles,bases and slots
  sirumbt(:,islot) = sta.sirul;
  sirdmbt(:,islot) = sta.sirdl;

  sta.seed = setseed; % Save seed to faciliate simulation from this state
  % Save some results
  res(islot,iframe)= sta;
 end
 
 % Frame Error Probability up and down link
 sta.fepul = mean(ci2rber(linsum(sirumbt,2)),3) > par.rbermax;
 sta.fepdl = mean(ci2rber(linsum(sirdmbt,2)),3) > par.rbermax;
 sta.seed = setseed; % Save seed to faciliate simulation from this state
end
    
setseed(oseed); % Restore seed to original value
% $Id: runeft.m,v 1.2 2004/03/11 22:58:32 olav Exp $
