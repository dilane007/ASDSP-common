function [res, par, sta, sys] = runef(par,sta,sys) 
% DESCRIPTION [res, par, sta, sys] = runef(par,sta,sys)
%   The basic rune dynamic function.
% INPUT  (all inputs are optional
%  par --            BASIC SIMULATION PARAMETERS
%  par.cellradius -- cell radius [m]
%  par.km --         km^2+lm^2+km*lm => the number of sites
%  par.lm --         related to km above
%  par.sps --        number of sectors per site
%  par.gainconst --  gain at 1 meter distance [dB] 
%  par.noise --      thermal noise floor [dBm]
%  par.alpha --      distance attenuation coefficient
%  par.sigma --      standard deviation for the lognormal fading [dB]
%  par.raa --        lognormal correlation down link (typical 0.5)
%  par.corrdist --   lognormal fading correlation distance [m]
%  par.offtraf --    average number of offered calls to a cell [Erlang/cell]     
%  par.mht --        mean holding time [seconds]  
%  par.amean --      acceleration [m/s/s]
%  par.vmean --      speed  [m/s]
%  par.pinit --      init power set to each new link [dBm]
%  par.rbermax --    raw bit error level over which a call is dropped
%  par.sirtarget --  C/I target level for the inner loop [dB] 
%  par.userbr --     user bit rate
%  par.chipr --      chip rate 
%  par.homargin --   gain margin between two bases used at Hand Off 
%  par.reb --        Rebate factor for down link power from own base 
%  par.dt  --        time interval in the simulation loop
%  par.slottime --   time per slot in seconds 
%  par.maxiter --    number of iterations in the main loop 
%  par.nslots --     nomber of slots per frame
%  par.seed --       seed to all random sequencies in the simulation
%
%  sta --            STATE
%  sta.time --       sample time 
%  sta.xym --        position in complex form [m]
%  sta.xyv --        speed imag <=> north real <=> east [m/s] 
%  sta.m --          mobile identity number
%  sta.pumb --        transmitted power up link  [dBm]
%  sta.cumb --        received carrier power up link [dBm]
%  sta.iumb --        interference power up link  [dBm]
%  sta.sirumb --      signal to interference ratio up link [dB]
%  sta.fepum --       frame error probability for each user
%  sta.pdmb --        transmitted power down link  [dBm]
%  sta.cdmb --        carrier downlink [dBm]
%  sta.idmb --        interference down link [dBm]
%  sta.sirdmb --      signal to interference ratio down link [dB]
%  sta.fepdm --       frame error probability for each user
%  sta.mtop --       max mobile number used sofar
%  sta.obk --        the allocation of channels
%  sta.seed --       the seed before next iteration
% 
%  sys --            ALL INTERMEDIATE VALUES NEEDED TO SIMULATE
%  sys.xyb --        base positions [m]
%  sys.fib --        cell center vector [m]
%  sys.rombvec --    stem vectors [m]
%  sys.lobevector -- antenna gain diagram [dB]
%  sys.lognmap --    lognormal map [dB]
%  sys.mapvec --     lognormal map vectors [m]
% OUTPUT
%  res --          cellarray of sta collected for each iteration of the simulation
%  par --          same as input otherwise created within the function
%  sys --          same as input otherwise created within the function  
% TRY 
%  [res, par, sta, sys] = runef 

% by Magnus Almgren 010125 revised 010327	

% set simulation parameter par if not present as an input
if ~exist('par','var')
 par = setpar; % default parameter setting 
end

% Create the sys variable if not present as an input.
if ~exist('sys','var')|isempty(sys)
 % generate base station position and directions 
 clear sys
 [sys.xyb, sys.fib, sys.rombvec] = crecells(par.cellradius,par.sps,par.km,par.lm);
 % Antenna gain for all directions, size == [360 1].
 if all(abs(sys.fib)>0)
  sys.lobevector = sinclobe;    
 else 
  sys.lobevector = omnilobe;
 end
 % Create a rayleigh fading map.
 [sys.raylmap, sys.raylmapvec] = creraylmap(sys.rombvec);
 
 
 % Create a lognormal map.
 if par.sigma > 0  % Is a lognormal map needed (takes a few seconds to generate).
  % The lognormal map is dependent on the seed.
  oseed = setseed(par.seed);  % Set seed of pseudo random generator for the map.
  [sys.lognmap, sys.lognmapvec] = crelognmap(sys.xyb, sys.rombvec, par.corrdist); 
  setseed(oseed);  % Restore seed to original value.
 else
  sys.lognmap = 0; % Give fake arguments to pathgain,
  sys.lognmapvec = 0;  % the values doesn't matter anyway.
 end
end

% init of state variable
% The variables below are altered in the for loop and save after
% each iteration
if ~exist('sta','var')|isempty(sta)
 clear sta
 e = zeros(0,1);
 e1 = zeros(0,size(sys.xyb,2));
 sta.time = 0; sta.m = e; sta.xym = e; sta.xyv = e; 
 sta.pumb   = e1;  sta.cumb   = e1;  sta.iumb   = e1;  sta.sirumb = e1;  sta.fepum = e;
 sta.pdmb   = e1;  sta.cdmb   = e1;  sta.idmb   = e1;  sta.sirdmb = e1;  sta.fepdm = e;
 sta.mtop  = 0; 
 sta.seed  = par.seed;
end

oseed=setseed(sta.seed); % Set seed in random generators.

% The simulation loop. One iteration corresponds to one frame

rxyb = sys.xyb*(sys.raylmapvec(1)/sys.rombvec(1)); % offset for fast fading

for iter = 1:par.maxiter
 % set time 
 dt = par.dt-par.nslots*par.slottime;
 sta.time = sta.time+dt;
 % Terminate some calls and drop calls with bad quality. 
 terones = ~isnan(sta.pumb(:,1))&(rand(size(sta.xym)) < 1-exp(-mdiv(par.dt,par.mht))); % Natural terminated calls.
 drones = sta.fepum > rand(size(sta.fepum)) | sta.fepdm > rand(size(sta.fepdm)); % quality dropping
 keep = ~(drones|terones); % neither drop or terminate
 %keep = 1|keep; % take away later
 % Terminate by setting powers to NaN 
 [sta.pumb, sta.pdmb] = terminate(sta.pumb, sta.pdmb, ~keep);
  
 % Make a realisation of new users.
 nmob = mrequest(par.offtraf * length(sys.xyb), mdiv(par.dt,par.mht));
 % nmob = 2*(iter==1); % take away later
 nt = nans(nmob,1);  % NaN vector used to concatenate with below.
 nt1 = nans(nmob,size(sys.xyb,2));  % Nans vector used to concatenate power matrices.
 mn = sta.mtop+(1:nmob)'; % new mobile id numbers
 sta.mtop = sta.mtop+nmob; % highest mobile id so far 
  
 % Refresh vector structure by removing released calls and adding new ones.
 sta.xym   =[sta.xym(keep);       nt]; 
 sta.xyv   =[sta.xyv(keep);       nt]; 
 sta.m     =[sta.m(keep);         mn]; 
 sta.pumb  =[sta.pumb(keep,:);   nt1]; 
 sta.cumb  =[sta.cumb(keep,:);   nt1]; 
 sta.iumb  =[sta.iumb(keep,:);   nt1]; 
 sta.sirumb=[sta.sirumb(keep,:); nt1];
 sta.fepum =[sta.sirumb(keep);    nt];
 sta.pdmb  =[sta.pdmb(keep,:);   nt1]; 
 sta.cdmb  =[sta.cdmb(keep,:);   nt1]; 
 sta.idmb  =[sta.idmb(keep,:);   nt1]; 
 sta.sirdmb=[sta.sirdmb(keep,:); nt1];
 sta.fepdm =[sta.sirumb(keep);    nt];
 
 % Move old users and initiate a position to newcomers.

 [sta.xym,sta.xyv] = mobmove(sta.xym,sta.xyv,par.amean,par.vmean,dt,sys.rombvec);
 % sta.xym =[0; 500]; sta.xyv = zeros(size(sta.xym)); % take away later
 % Calculate the gain matrix.
 sta.g = pathgain(sta.xym,  sys.xyb, sys.fib, sys.rombvec, ...
  par.gainconst, par.alpha, par.sigma, par.raa, ...
  sys.lobevector, sys.lognmap, sys.lognmapvec);

 % Perform handoff & Allocate new mobiles to a channel if possible.
 [sta.pumb, sta.pdmb] = handoff(sta.pumb, sta.pdmb, sta.g, par.homargin, par.pinit);
 
 % Perform the transmission from the sending to the receiving side,
 % all in dB or dBm.
 
 % The inner Loop Power
 sirumbt = nans([size(sta.g) par.nslots]); sirdmbt = sirumbt; pumb = []; % reserve memory
 for islot = 1:par.nslots*~isempty(sta.pdmb)
  dt = par.slottime;
  sta.time = sta.time+dt;
  % fast power control  
  [sta.pumb, sta.pdmb] = fastpc(sta.pumb, sta.pdmb, sta.sirumb, sta.sirdmb, par.sirtarget);
  
  % compute flat fading gain as a matrix of the same size as sta.g
  rgu = lin2db(abs(useraylmap(mplus(+rxyb,-sta.xym), sys.raylmap, sys.raylmapvec)).^2);
  rgd = lin2db(abs(useraylmap(mplus(-rxyb,-sta.xym), sys.raylmap, sys.raylmapvec)).^2);
  % move users one slot forward
  [sta.xym,sta.xyv] = mobmove(sta.xym,sta.xyv,par.amean,par.vmean,dt,sys.rombvec);
  
  [sta.cumb, sta.iumb, sta.sirumb] = transul(sta.pumb, sta.g+rgu, par.noise); % up link
  [sta.cdmb, sta.idmb, sta.sirdmb] = transdl(sta.pdmb, sta.g+rgd, par.noise, par.reb); % down link
  
  % Collect results.
  sta.seed = setseed;  % the seed before next iteration
  % maximum ratio combining followed by mapping to raw bit error rate
  
  % collect C/I for mobiles,bases,slots
  sirumbt(:,:,islot) = sta.sirumb;
  sirdmbt(:,:,islot) = sta.sirdmb;
  res(iter).pumb(:,islot) = max(sta.pumb,[],2);
 end
 % frame error probability up and down link
 pg = lin2db(par.chipr/par.userbr); % processing gain
 sta.fepum = mean(ci2rber(linsum(sirumbt,2)+pg),3) > par.rbermax;
 sta.fepdm = mean(ci2rber(linsum(sirdmbt,2)+pg),3) > par.rbermax;
 % save some results
 res(iter).fepum = sta.fepum;
 res(iter).m = sta.m;
end
1; % this row is only for breakpoint purposes 