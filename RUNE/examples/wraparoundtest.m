function wraparoundtest
% DESCRIPTION
% wraparoundtest
% Demonstrates wraparound with one cell in the system.
% The plot does show the border where the gain from the cell will
% meet itself.
%
% OUTPUT
%  -- A plot of gain propagation over the system
% SEE ALSO 
%  ex_wraparound, crecells
% TRY 
%  wraparoundtest;

% by Magnus Almgren 040206

% create sys by running runefg once
par = setparg; % load default parameter settings
par.km = 1; % only one sectorized site
par.lm = 2;
par.sps = 3; 

[res, par, sta, sys] = runefg(par); % create a nice init state

% generate a new xym with equally spaced mobiles 
% in both x and y (that is Re and Im)
len = 1.25*abs(sys.rhombvec(1)); % the area to span
siz = 61; % nomber of samples along x and y
v = linspace(-0.5,0.5,siz);
xym = flatten(mplus(v',v*sqrt(-1)))*len +0.4*len; % the new "mobiles"
% calculate gain for all the mobiles
gmb = pathgain(xym,  sys.xyb(1), sys.fib(1), par.sps, sys.rhombvec, ...
  par.gainconst, par.alpha, 0, par.raa, ...
  sys.lognmap, sys.lognmapvec);
 % plot the gain value for one of the three bases and all the mobiles
surf(reshape(min(gmb(:,1),-160),[siz siz]));
 
% $Id: wraparoundtest.m,v 1.3 2004/03/15 14:58:03 olav Exp $
