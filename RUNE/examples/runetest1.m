% runetest1
% A first example how one can use runefg
% Uses runef to create a system and then plot it.

% by Magnus Almgren 010923
par = setparg; % load default parameter settings
par.sps = 3;
par.offtraf = 3;
sta = [];
sys = [];
[res, par, sta, sys] = runefg(par, sta, sys);
sta

% Concatenate timesamples in third dimension
gmbt  = cat(3,res(:).gmb);
rgumbt  = cat(3,res(:).rgumb);
rgdmbt  = cat(3,res(:).rgdmb);
xym0t = cat(3,res(:).xym);
figure(1)
plothex(sys.xyb,sys.fib)
ploth(xym0t(:),'.')
axis equal

% $Id: runetest1.m,v 1.3 2004/03/15 14:58:03 olav Exp $
