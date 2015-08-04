% wraparoundtest
% one can see the gain declining in the system

% by Magnus Almgren 011009

% create sys by running runef once
par = setpar; % load default parameter settings
par.km =0; % only one sectorized site
par.sps = 3; 
sta = []; % reset state variable 
% avoid to recreate the system variable each time this script is called
if ~exist('sys','var') % use previosly created system variable if it exists
 sys = [];
end
[res, par, sta, sys] = runef(par, sta, sys); % create a nice init state

% generate a new xym with equally spaced mobiles 
% in both x and y (that is Re and Im)
len = .8; % the area to span
siz = 51; % nomber of samples along x and y
v = linspace(-len,len,siz)*abs(sys.rombvec(1));
xym = flatten(mplus(v',v*sqrt(-1))); % the new "mobiles"
% calculate gain for all the mobiles
gmb = pathgain(xym,  sys.xyb, sys.fib, sys.rombvec, ...
  par.gainconst, par.alpha, 0, par.raa, ...
  sys.lobevector, sys.lognmap, sys.lognmapvec);
 % plot the gain value for one of the three bases and all the mobiles
surf(reshape(min(gmb(:,1),-120),[siz siz]));
 